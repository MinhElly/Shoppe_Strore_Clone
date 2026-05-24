package dal;

import constant.Constant;
import dto.OrderItemDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Item;
import model.Order;

public class OrderDAO extends DBContext {

    public List<Order> getAllOrdersAdmin() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.[id], o.[date], o.[totalMoney], o.[status], o.[userId], u.[fullName] "
                + "FROM [dbo].[Order] o "
                + "JOIN [dbo].[User] u ON o.[userId] = u.[userID] "
                + "ORDER BY CASE o.[status] "
                + "WHEN N'" + Constant.ORDER_PENDING + "' THEN 1 "
                + "WHEN N'" + Constant.ORDER_SHIPPING + "' THEN 2 "
                + "WHEN N'" + Constant.ORDER_COMPLETED + "' THEN 3 "
                + "ELSE 4 END, o.[date] DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        if (!isAllowedStatus(status)) {
            return false;
        }

        boolean oldAutoCommit;
        try {
            oldAutoCommit = connection.getAutoCommit();
            connection.setAutoCommit(false);
            try (PreparedStatement ps = connection.prepareStatement("UPDATE [dbo].[OrderDetail] SET [status] = ? WHERE [orderID] = ?")) {
                ps.setString(1, status);
                ps.setInt(2, orderId);
                ps.executeUpdate();
            }
            refreshOrderStatus(orderId);
            connection.commit();
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ignored) {
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ignored) {
            }
        }
    }

    public boolean updateOrderDetailStatus(int detailId, String status, String sellerId, boolean isAdmin) {
        if (!isAllowedStatus(status)) {
            return false;
        }

        int orderId = getOrderIdByDetailId(detailId);
        if (orderId == 0) {
            return false;
        }

        StringBuilder sql = new StringBuilder("UPDATE od SET od.[status] = ? "
                + "FROM [dbo].[OrderDetail] od "
                + "JOIN [dbo].[Product] p ON od.[productID] = p.[productID] "
                + "WHERE od.[detailID] = ? ");
        if (!isAdmin) {
            sql.append("AND p.[sellerID] = ?");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setString(index++, status);
            ps.setInt(index++, detailId);
            if (!isAdmin) {
                ps.setString(index, sellerId);
            }
            boolean updated = ps.executeUpdate() > 0;
            if (updated) {
                refreshOrderStatus(orderId);
            }
            return updated;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Order> getOrdersByUserId(String userID) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT [id], [date], [totalMoney], [status], [userId] "
                + "FROM [dbo].[Order] "
                + "WHERE [userId] = ? "
                + "ORDER BY CASE [status] "
                + "WHEN ? THEN 1 WHEN ? THEN 2 WHEN ? THEN 3 ELSE 4 END, [date] DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userID);
            ps.setString(2, Constant.ORDER_PENDING);
            ps.setString(3, Constant.ORDER_SHIPPING);
            ps.setString(4, Constant.ORDER_COMPLETED);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapOrder(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderItemDTO> getPurchaseItemsByUserId(String userID, String status) {
        List<OrderItemDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(baseOrderItemSql()
                + "WHERE o.[userId] = ? ");
        if (isAllowedStatus(status)) {
            sql.append("AND od.[status] = ? ");
        }
        sql.append(orderItemSortSql());

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setString(index++, userID);
            if (isAllowedStatus(status)) {
                ps.setString(index, status);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapOrderItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderItemDTO> getOrderItemsForStaff(String sellerId, boolean isAdmin, String status) {
        List<OrderItemDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(baseOrderItemSql() + "WHERE 1 = 1 ");
        if (!isAdmin) {
            sql.append("AND p.[sellerID] = ? ");
        }
        if (isAllowedStatus(status)) {
            sql.append("AND od.[status] = ? ");
        }
        sql.append(orderItemSortSql());

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (!isAdmin) {
                ps.setString(index++, sellerId);
            }
            if (isAllowedStatus(status)) {
                ps.setString(index, status);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapOrderItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int createOrder(String userId, List<Item> boughtItems) throws SQLException {
        if (boughtItems == null || boughtItems.isEmpty()) {
            throw new SQLException("Order must have at least one item.");
        }

        boolean oldAutoCommit = connection.getAutoCommit();
        String insertOrderSql = "INSERT INTO [dbo].[Order] ([userId], [date], [totalMoney], [status]) "
                + "VALUES (?, GETDATE(), ?, ?)";
        String insertDetailSql = "INSERT INTO [dbo].[OrderDetail] ([orderID], [productID], [quantity], [price], [status]) "
                + "VALUES (?, ?, ?, ?, ?)";
        String updateStockSql = "UPDATE [dbo].[Product] "
                + "SET [quantity] = [quantity] - ?, [soldQuantity] = [soldQuantity] + ? "
                + "WHERE [productID] = ? AND [quantity] >= ? AND [status] = 1";

        try {
            connection.setAutoCommit(false);

            int orderId;
            try (PreparedStatement orderStatement = connection.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStatement.setString(1, userId);
                orderStatement.setDouble(2, calculateTotal(boughtItems));
                orderStatement.setString(3, Constant.ORDER_PENDING);
                orderStatement.executeUpdate();

                try (ResultSet generatedKeys = orderStatement.getGeneratedKeys()) {
                    if (!generatedKeys.next()) {
                        throw new SQLException("Could not get generated order id.");
                    }
                    orderId = generatedKeys.getInt(1);
                }
            }

            for (Item item : boughtItems) {
                int productId = item.getProduct().getProductID();
                int quantity = item.getQuantity();

                try (PreparedStatement stockStatement = connection.prepareStatement(updateStockSql)) {
                    stockStatement.setInt(1, quantity);
                    stockStatement.setInt(2, quantity);
                    stockStatement.setInt(3, productId);
                    stockStatement.setInt(4, quantity);
                    if (stockStatement.executeUpdate() == 0) {
                        throw new SQLException("Product stock is not enough for product id " + productId);
                    }
                }

                try (PreparedStatement detailStatement = connection.prepareStatement(insertDetailSql)) {
                    detailStatement.setInt(1, orderId);
                    detailStatement.setInt(2, productId);
                    detailStatement.setInt(3, quantity);
                    detailStatement.setDouble(4, item.getProduct().getPrice());
                    detailStatement.setString(5, Constant.ORDER_PENDING);
                    detailStatement.executeUpdate();
                }
            }

            connection.commit();
            return orderId;
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(oldAutoCommit);
        }
    }

    public void insertOrder(String userId, double totalMoney, List<Item> boughtItems) {
        try {
            createOrder(userId, boughtItems);
        } catch (SQLException e) {
            System.out.println("Error at OrderDAO.insertOrder(): " + e.getMessage());
        }
    }

    private String baseOrderItemSql() {
        return "SELECT o.[id] AS orderId, o.[date] AS orderDate, o.[totalMoney] AS orderTotal, "
                + "o.[userId] AS customerId, buyer.[fullName] AS customerName, "
                + "od.[detailID], od.[price], od.[quantity], od.[status] AS detailStatus, "
                + "p.[productID], p.[productName], p.[image], p.[sellerID], seller.[fullName] AS sellerName "
                + "FROM [dbo].[OrderDetail] od "
                + "JOIN [dbo].[Order] o ON od.[orderID] = o.[id] "
                + "JOIN [dbo].[Product] p ON od.[productID] = p.[productID] "
                + "JOIN [dbo].[User] buyer ON o.[userId] = buyer.[userID] "
                + "LEFT JOIN [dbo].[User] seller ON p.[sellerID] = seller.[userID] ";
    }

    private String orderItemSortSql() {
        return "ORDER BY CASE od.[status] "
                + "WHEN N'" + Constant.ORDER_PENDING + "' THEN 1 "
                + "WHEN N'" + Constant.ORDER_SHIPPING + "' THEN 2 "
                + "WHEN N'" + Constant.ORDER_COMPLETED + "' THEN 3 "
                + "ELSE 4 END, o.[date] DESC, od.[detailID] DESC";
    }

    private int getOrderIdByDetailId(int detailId) {
        String sql = "SELECT [orderID] FROM [dbo].[OrderDetail] WHERE [detailID] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, detailId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("orderID");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private void refreshOrderStatus(int orderId) throws SQLException {
        String sql = "UPDATE [dbo].[Order] SET [status] = ("
                + "SELECT TOP 1 [status] FROM [dbo].[OrderDetail] "
                + "WHERE [orderID] = ? "
                + "ORDER BY CASE [status] "
                + "WHEN ? THEN 1 WHEN ? THEN 2 WHEN ? THEN 3 ELSE 4 END"
                + ") WHERE [id] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setString(2, Constant.ORDER_PENDING);
            ps.setString(3, Constant.ORDER_SHIPPING);
            ps.setString(4, Constant.ORDER_COMPLETED);
            ps.setInt(5, orderId);
            ps.executeUpdate();
        }
    }

    private boolean isAllowedStatus(String status) {
        return Constant.isOrderStatus(status);
    }

    private double calculateTotal(List<Item> items) {
        double total = 0;
        for (Item item : items) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
        return total;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setDate(rs.getTimestamp("date"));
        order.setTotalMoney(rs.getDouble("totalMoney"));
        order.setStatus(rs.getString("status"));
        order.setUserId(rs.getString("userId"));
        try {
            order.setUserName(rs.getString("fullName"));
        } catch (SQLException ignored) {
            // fullName is only available in admin JOIN queries.
        }
        return order;
    }

    private OrderItemDTO mapOrderItem(ResultSet rs) throws SQLException {
        OrderItemDTO item = new OrderItemDTO();
        item.setOrderId(rs.getInt("orderId"));
        item.setOrderDate(rs.getTimestamp("orderDate"));
        item.setOrderTotal(rs.getDouble("orderTotal"));
        item.setCustomerId(rs.getString("customerId"));
        item.setCustomerName(rs.getString("customerName"));
        item.setDetailId(rs.getInt("detailID"));
        item.setProductId(rs.getInt("productID"));
        item.setProductName(rs.getString("productName"));
        item.setProductImage(rs.getString("image"));
        item.setPrice(rs.getDouble("price"));
        item.setQuantity(rs.getInt("quantity"));
        item.setStatus(rs.getString("detailStatus"));
        item.setSellerId(rs.getString("sellerID"));
        item.setSellerName(rs.getString("sellerName"));
        return item;
    }
}
