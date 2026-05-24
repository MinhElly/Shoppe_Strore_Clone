package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.User;
import util.PasswordUtil;

public class UserDAO extends DBContext {

    PreparedStatement ps;
    ResultSet rs;

    public Vector<User> getAllUser() {
        Vector<User> list = new Vector<>();
        String sql = "SELECT * FROM [User]";

        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public User searchUser(String userID) {
        String sql = "SELECT * FROM [User] WHERE userID = ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int insertUser(User u) {
        String sql = "INSERT INTO [User] "
                + "(userID, fullName, username, password, roleID, address, phone, email, avatar, activate) "
                + "VALUES (?,?,?,?,?,?,?,?,?,?)";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, u.getUserID());
            ps.setString(2, u.getFullName());
            ps.setString(3, u.getUsername());
            ps.setString(4, securePassword(u.getPassword()));
            ps.setInt(5, u.getRoleID());
            ps.setString(6, u.getAddress());
            ps.setString(7, u.getPhone());
            ps.setString(8, u.getEmail());
            ps.setString(9, u.getAvatar());
            ps.setBoolean(10, u.isActivate());
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int updateUser(User u) {
        String sql = "UPDATE [User] SET "
                + "fullName=?, username=?, password=?, roleID=?, address=?, phone=?, email=?, avatar=?, activate=? "
                + "WHERE userID=?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getUsername());
            ps.setString(3, securePassword(u.getPassword()));
            ps.setInt(4, u.getRoleID());
            ps.setString(5, u.getAddress());
            ps.setString(6, u.getPhone());
            ps.setString(7, u.getEmail());
            ps.setString(8, u.getAvatar());
            ps.setBoolean(9, u.isActivate());
            ps.setString(10, u.getUserID());
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public boolean updateProfile(User u) {
        String sql = "UPDATE [User] SET fullName=?, address=?, phone=?, email=?, avatar=? WHERE userID=?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getAddress());
            ps.setString(3, u.getPhone());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getAvatar());
            ps.setString(6, u.getUserID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

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

    public User loginUser(String username, String password) {
        String sql = "SELECT * FROM [User] WHERE username = ? AND activate = 1";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (!PasswordUtil.verifyPassword(password, storedPassword)) {
                    return null;
                }
                return mapUser(rs);
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
                String lastID = rs.getString("userID");
                int number = Integer.parseInt(lastID.substring(1));
                newID = String.format("U%03d", number + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return newID;
    }

    public int getTotalUsers(String keyword) {
        String sql = "SELECT COUNT(*) FROM [User] "
                + "WHERE [username] LIKE ? OR [email] LIKE ? OR [fullName] LIKE ?";
        try {
            ps = connection.prepareStatement(sql);
            String search = "%" + keyword + "%";
            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Vector<User> searchAndPagingUsers(String keyword, int page, int recordsPerPage) {
        Vector<User> list = new Vector<>();
        String sql = "SELECT * FROM [User] "
                + "WHERE [username] LIKE ? OR [email] LIKE ? OR [fullName] LIKE ? "
                + "ORDER BY userID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            ps = connection.prepareStatement(sql);
            String search = "%" + keyword + "%";
            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setInt(4, (page - 1) * recordsPerPage);
            ps.setInt(5, recordsPerPage);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean banUser(String userID) {
        return setUserActivate(userID, false);
    }

    public boolean unbanUser(String userID) {
        return setUserActivate(userID, true);
    }

    public boolean setUserActivate(String userID, boolean activate) {
        String sql = "UPDATE [User] SET activate = ? WHERE userID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setBoolean(1, activate);
            ps.setString(2, userID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserRole(String userID, int roleID) {
        String sql = "UPDATE [User] SET roleID = ? WHERE userID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roleID);
            ps.setString(2, userID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private User mapUser(ResultSet rs) throws SQLException {
        return new User(
                rs.getString("userID"),
                rs.getString("fullName"),
                rs.getString("username"),
                rs.getString("password"),
                rs.getInt("roleID"),
                rs.getString("address"),
                rs.getString("phone"),
                rs.getString("email"),
                rs.getString("avatar"),
                rs.getBoolean("activate")
        );
    }

    private String securePassword(String password) {
        if (PasswordUtil.isHashedPassword(password)) {
            return password;
        }
        return PasswordUtil.hashPassword(password);
    }
}
