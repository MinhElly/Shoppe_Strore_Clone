package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.User;

public class UserDAO extends DBContext {

    PreparedStatement ps;
    ResultSet rs;

    // ================= GET ALL =================
    public Vector<User> getAllUser() {
        Vector<User> list = new Vector<>();
        String sql = "SELECT * FROM [User]";

        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User(
                        rs.getString("userID"),
                        rs.getString("fullName"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("roleID"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getBoolean("activate")
                );
                list.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= SEARCH BY ID =================
    public User searchUser(String userID) {
        String sql = "SELECT * FROM [User] WHERE userID = ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, userID);

            rs = ps.executeQuery();

            if (rs.next()) {
                return new User(
                        rs.getString("userID"),
                        rs.getString("fullName"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("roleID"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getBoolean("activate")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // ================= INSERT =================
    public int insertUser(User u) {

        String sql = "INSERT INTO [User] "
                + "(userID, fullName, username, password, roleID, address, phone, email, activate) "
                + "VALUES (?,?,?,?,?,?,?,?,?)";

        try {
            ps = connection.prepareStatement(sql);

            ps.setString(1, u.getUserID());
            ps.setString(2, u.getFullName());
            ps.setString(3, u.getUsername());
            ps.setString(4, u.getPassword());
            ps.setInt(5, u.getRoleID());
            ps.setString(6, u.getAddress());
            ps.setString(7, u.getPhone());
            ps.setString(8, u.getEmail());
            ps.setBoolean(9, u.isActivate());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ================= UPDATE =================
    public int updateUser(User u) {

        String sql = "UPDATE [User] SET "
                + "fullName=?, username=?, password=?, roleID=?, address=?, phone=?, email=?, activate=? "
                + "WHERE userID=?";

        try {

            ps = connection.prepareStatement(sql);

            ps.setString(1, u.getFullName());
            ps.setString(2, u.getUsername());
            ps.setString(3, u.getPassword());
            ps.setInt(4, u.getRoleID());
            ps.setString(5, u.getAddress());
            ps.setString(6, u.getPhone());
            ps.setString(7, u.getEmail());
            ps.setBoolean(8, u.isActivate());
            ps.setString(9, u.getUserID());

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ================= DELETE =================
    public int deleteUser(String userID) {

        String sql = "DELETE FROM [User] WHERE userID = ?";

        try {

            ps = connection.prepareStatement(sql);
            ps.setString(1, userID);

            return ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ================= CHECK USERNAME =================
    public boolean isExistUserName(String username) {

        String sql = "SELECT [username] FROM [User] WHERE username = ?";

        try {

            ps = connection.prepareStatement(sql);
            ps.setString(1, username);

            rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= LOGIN =================
    public User loginUser(String username, String password) {

        String sql = "SELECT * FROM [User] "
                + "WHERE username = ? AND password = ?";

        try {

            ps = connection.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {

                return new User(
                        rs.getString("userID"),
                        rs.getString("fullName"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("roleID"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getBoolean("activate")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public String generateUserID() {

        String newID = "U001";

        String sql = "SELECT TOP 1 userID FROM [User] "
                + "ORDER BY CAST(SUBSTRING(userID,2,LEN(userID)) AS INT) DESC";

        try {

            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {

                String lastID = rs.getString("userID"); // ví dụ U005
                int number = Integer.parseInt(lastID.substring(1));
                number++;

                newID = String.format("U%03d", number);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return newID;
    }
    // ================= COUNT TOTAL USERS (Phục vụ phân trang) =================
    public int getTotalUsers(String keyword) {
        String sql = "SELECT COUNT(*) FROM [User] WHERE [username] LIKE ? OR [email] LIKE ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    // ================= SEARCH & PAGING USERS =================
    public Vector<User> searchAndPagingUsers(String keyword, int page, int recordsPerPage) {
        Vector<User> list = new Vector<>();
        // Dùng OFFSET và FETCH NEXT của SQL Server để phân trang
        String sql = "SELECT * FROM [User] "
                   + "WHERE [username] LIKE ? OR [email] LIKE ? "
                   + "ORDER BY userID "
                   + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            // Công thức tính vị trí bắt đầu lấy dữ liệu
            ps.setInt(3, (page - 1) * recordsPerPage); 
            ps.setInt(4, recordsPerPage);
            
            rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User(
                        rs.getString("userID"),
                        rs.getString("fullName"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("roleID"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getBoolean("activate")
                );
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    // ================= BAN / LOCK USER (Xóa mềm) =================
    public boolean banUser(String userID) {
        // Chuyển trạng thái activate = 0 (false) để khóa tài khoản
        String sql = "UPDATE [User] SET activate = 0 WHERE userID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
