package dal;

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
                + "ORDER BY o.[date] DESC";

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
        String sql = "UPDATE [dbo].[Order] SET [status] = ? WHERE [id] = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
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
                + "ORDER BY [date] DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, userID);
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

    public int createOrder(String userId, List<Item> boughtItems) throws SQLException {
        if (boughtItems == null || boughtItems.isEmpty()) {
            throw new SQLException("Order must have at least one item.");
        }

        boolean oldAutoCommit = connection.getAutoCommit();
        String insertOrderSql = "INSERT INTO [dbo].[Order] ([userId], [date], [totalMoney], [status]) "
                + "VALUES (?, GETDATE(), ?, ?)";
        String insertDetailSql = "INSERT INTO [dbo].[OrderDetail] ([orderID], [productID], [quantity], [price]) "
                + "VALUES (?, ?, ?, ?)";
        String updateStockSql = "UPDATE [dbo].[Product] "
                + "SET [quantity] = [quantity] - ?, [soldQuantity] = [soldQuantity] + ? "
                + "WHERE [productID] = ? AND [quantity] >= ? AND [status] = 1";

        try {
            connection.setAutoCommit(false);

            int orderId;
            try (PreparedStatement orderStatement = connection.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStatement.setString(1, userId);
                orderStatement.setDouble(2, calculateTotal(boughtItems));
                orderStatement.setString(3, "Chờ xác nhận");
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
}
