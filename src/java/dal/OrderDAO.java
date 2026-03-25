package dal;

import model.Order;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Item;

public class OrderDAO extends DBContext {
    PreparedStatement ps;
    ResultSet rs;

    // Lấy toàn bộ danh sách đơn hàng cho Admin
    public List<Order> getAllOrdersAdmin() {
        List<Order> list = new ArrayList<>();
        // Câu lệnh SQL lấy thông tin đơn hàng và tên người mua
        String sql = "SELECT o.id, o.date, o.totalMoney, o.status, u.userID, u.fullName " +
                     "FROM [Order] o JOIN [User] u ON o.userId = u.userID " +
                     "ORDER BY o.date DESC";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setDate(rs.getDate("date"));
                o.setTotalMoney(rs.getDouble("totalMoney"));
                o.setStatus(rs.getString("status"));
                o.setUserId(rs.getString("userID"));
                o.setUserName(rs.getString("fullName")); // Tên hiển thị thay cho ID
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật trạng thái đơn hàng (Ví dụ: Đang giao, Hoàn thành...)
    public void updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE [Order] SET status = ? WHERE id = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Order> getOrdersByUserId(String userID) {
    List<Order> list = new ArrayList<>();
    // Câu lệnh SQL lấy đơn hàng của riêng User này, sắp xếp đơn mới nhất lên đầu
    String sql = "SELECT * FROM [Order] WHERE userId = ? ORDER BY date DESC";
    try {
        ps = connection.prepareStatement(sql);
        ps.setString(1, userID);
        rs = ps.executeQuery();
        while (rs.next()) {
            Order o = new Order();
            o.setId(rs.getInt("id"));
            o.setDate(rs.getDate("date"));
            o.setTotalMoney(rs.getDouble("totalMoney"));
            o.setStatus(rs.getString("status"));
            o.setUserId(rs.getString("userId"));
            list.add(o);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    public void insertOrder(String userId, double totalMoney, List<Item> boughtItems) {
    try {
        // 1. Tạo đơn hàng mới trong bảng Order
        // Lưu ý: Sửa lại tên bảng và tên cột cho khớp với Database của bạn
        String sqlOrder = "INSERT INTO [Order] (UserID, Date, TotalMoney, Status) VALUES (?, GETDATE(), ?, N'Chờ xác nhận')";
        
        // Dùng RETURN_GENERATED_KEYS để lấy ID đơn hàng tự tăng vừa tạo
        PreparedStatement st = connection.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);
        st.setString(1, userId);
        st.setDouble(2, totalMoney);
        st.executeUpdate();

        // 2. Lấy ra OrderID vừa được tạo
        ResultSet rs = st.getGeneratedKeys();
        if (rs.next()) {
            int orderId = rs.getInt(1);

            // 3. Lưu từng sản phẩm vào bảng OrderDetail
            for (Item item : boughtItems) {
                String sqlDetail = "INSERT INTO [OrderDetail] (OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";
                PreparedStatement st2 = connection.prepareStatement(sqlDetail);
                st2.setInt(1, orderId);
                st2.setInt(2, item.getProduct().getProductID());
                st2.setInt(3, item.getQuantity());
                st2.setDouble(4, item.getProduct().getPrice());
                st2.executeUpdate();
            }
        }
    } catch (Exception e) {
        System.out.println("Lỗi insertOrder: " + e.getMessage());
    }
    }
}