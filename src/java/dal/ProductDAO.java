package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

/**
 *
 * @author admin
 */
public class ProductDAO extends GenericDAO<Product> {

    protected PreparedStatement statement;
    protected ResultSet resultSet;

    private void closeResources() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
        } catch (Exception e) {
            System.err.println(" Lỗi khi đóng tài nguyên ProductDAO: " + e.getMessage());
        }
    }

    public Product findById(int id) {
        String sql = "SELECT p.*, u.[fullName] AS sellerName "
                + "FROM [dbo].[Product] p "
                + "LEFT JOIN [dbo].[User] u ON p.[sellerID] = u.[userID] "
                + "WHERE p.[productID] = ?";

        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id); // Truyền ID vào câu lệnh SQL
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Tận dụng luôn hàm map ở dưới cho gọn code
                return mapResultSetToProduct(resultSet);
            }
        } catch (Exception e) {
            System.out.println("Error at ProductDAO.findById(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return null;
    }

    public int findTotalProducts() {
        String sql = "SELECT COUNT(*) FROM [dbo].[Product] WHERE [status] = 1";
        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (Exception e) {
            System.out.println("Error at ProductDAO.findTotalProducts(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    public List<Product> findAllProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, u.[fullName] AS sellerName "
                + "FROM [dbo].[Product] p "
                + "LEFT JOIN [dbo].[User] u ON p.[sellerID] = u.[userID]";

        try {
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                list.add(mapResultSetToProduct(resultSet));
            }
        } catch (Exception e) {
            System.out.println("Error at ProductDAO.findAllProduct(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return list;
    }

    public void insertProduct(Product pro) {
        String sql = "INSERT INTO [dbo].[Product] ([productName], [image], [price], [quantity], [soldQuantity], [describe], [categoryID], [importDate], [usingDate], [status], [sellerID]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            statement = connection.prepareStatement(sql);

            statement.setString(1, pro.getProductName());
            statement.setString(2, pro.getImage());
            statement.setDouble(3, pro.getPrice());
            statement.setInt(4, pro.getQuantity());
            statement.setInt(5, pro.getSoldQuantity());
            statement.setString(6, pro.getDescribe());
            statement.setString(7, pro.getCategoryID());
            statement.setDate(8, pro.getImportDate() != null ? new java.sql.Date(pro.getImportDate().getTime()) : null);
            statement.setDate(9, pro.getUsingDate() != null ? new java.sql.Date(pro.getUsingDate().getTime()) : null);
            statement.setInt(10, pro.getStatus());
            statement.setString(11, pro.getSellerId());

            statement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error at ProductDAO.insertProduct(): " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void editProduct(Product pro) {
        String sql = "UPDATE [dbo].[Product] SET "
                + "[productName] = ?, "
                + "[image] = ?, "
                + "[price] = ?, "
                + "[quantity] = ?, "
                + "[soldQuantity] = ?, "
                + "[describe] = ?, "
                + "[categoryID] = ?, "
                + "[importDate] = ?, "
                + "[usingDate] = ?, "
                + "[status] = ?, "
                + "[sellerID] = ? "
                + "WHERE productID = ?";
        try {

            statement = connection.prepareStatement(sql);

            statement.setString(1, pro.getProductName());
            statement.setString(2, pro.getImage());
            statement.setDouble(3, pro.getPrice());
            statement.setInt(4, pro.getQuantity());
            statement.setInt(5, pro.getSoldQuantity());
            statement.setString(6, pro.getDescribe());
            statement.setString(7, pro.getCategoryID());
            statement.setDate(8, pro.getImportDate() != null ? new java.sql.Date(pro.getImportDate().getTime()) : null);
            statement.setDate(9, pro.getUsingDate() != null ? new java.sql.Date(pro.getUsingDate().getTime()) : null);
            statement.setInt(10, pro.getStatus());
            statement.setString(11, pro.getSellerId());
            statement.setInt(12, pro.getProductID());

            statement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Error at ProductDAO.editProduct(): " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Hàm tiện ích để map dữ liệu từ ResultSet vào Product (Tránh code lặp)
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductID(rs.getInt("productID"));
        p.setProductName(rs.getString("productName"));
        p.setImage(rs.getString("image"));
        p.setPrice(rs.getDouble("price"));
        p.setQuantity(rs.getInt("quantity"));
        p.setSoldQuantity(rs.getInt("soldQuantity"));
        p.setDescribe(rs.getString("describe"));
        p.setCategoryID(rs.getString("categoryID"));
        p.setImportDate(rs.getDate("importDate"));
        p.setUsingDate(rs.getDate("usingDate"));
        p.setStatus(rs.getInt("status"));
        p.setSellerId(rs.getString("sellerID"));
        try {
            p.setSellerName(rs.getString("sellerName"));
        } catch (SQLException ignored) {
            // sellerName is only present in JOIN queries.
        }
        return p;
    }
    // Lấy danh sách sản phẩm theo trang cho trang chủ

    public List<Product> pagingProduct(int page) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, u.[fullName] AS sellerName "
                + "FROM [dbo].[Product] p "
                + "LEFT JOIN [dbo].[User] u ON p.[sellerID] = u.[userID] "
                + "WHERE p.[status] = 1 "
                + "ORDER BY p.[productID] "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            statement = connection.prepareStatement(sql);
            // Tận dụng luôn Constant của bạn
            statement.setInt(1, (page - 1) * constant.Constant.RECORD_PER_PAGE);
            statement.setInt(2, constant.Constant.RECORD_PER_PAGE);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                // Tận dụng hàm mapResultSetToProduct cực kỳ gọn gàng
                list.add(mapResultSetToProduct(resultSet));
            }
        } catch (Exception e) {
            System.out.println("Error at ProductDAO.pagingProduct(): " + e.getMessage());
        } finally {
            closeResources(); // Đóng tài nguyên đúng cách
        }
        return list;
    }
    // Lấy danh sách 6 sản phẩm cùng danh mục (loại trừ sản phẩm hiện tại)

    public List<Product> getRelatedProducts(String categoryID, int currentProductID) {
        List<Product> list = new ArrayList<>();
        // Dùng TOP 6 của SQL Server để lấy đúng 6 sản phẩm hiển thị trên 1 hàng
        String sql = "SELECT TOP 6 p.*, u.[fullName] AS sellerName "
                + "FROM [dbo].[Product] p "
                + "LEFT JOIN [dbo].[User] u ON p.[sellerID] = u.[userID] "
                + "WHERE p.[categoryID] = ? AND p.[productID] != ? AND p.[status] = 1";
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, categoryID);
            statement.setInt(2, currentProductID);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                list.add(mapResultSetToProduct(resultSet)); // Tận dụng lại hàm map cực tiện
            }
        } catch (Exception e) {
            System.out.println("Lỗi ở ProductDAO.getRelatedProducts(): " + e.getMessage());
        } finally {
            closeResources(); // Nhớ đóng tài nguyên đúng cách (không đóng connection)
        }
        return list;
    }

    @Override
    public List<Product> findAll() {
        return queryGenericDAO(Product.class);
    }

    @Override
    public int insert(Product t) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // 1. Hàm lấy danh sách sản phẩm động
    public List<Product> filterAndSortProduct(String keyword, String categoryID, Double minPrice, Double maxPrice, String sortType, int page) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, u.[fullName] AS sellerName FROM [dbo].[Product] p LEFT JOIN [dbo].[User] u ON p.[sellerID] = u.[userID] WHERE p.[status] = 1 ");

        // Lọc theo Từ khóa (Search) - Tìm kiếm gần đúng với LIKE
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND p.[productName] LIKE ? ");
        }
        // Lọc theo Category
        if (categoryID != null && !categoryID.isEmpty()) {
            sql.append(" AND p.[categoryID] = ? ");
        }
        // Lọc theo Giá
        if (minPrice != null) {
            sql.append(" AND p.[price] >= ? ");
        }
        if (maxPrice != null) {
            sql.append(" AND p.[price] <= ? ");
        }

        // Sắp xếp
        if (sortType != null && !sortType.isEmpty()) {
            switch (sortType) {
                case "new":
                    sql.append(" ORDER BY p.[importDate] DESC, p.[productID] DESC ");
                    break; // Mới nhất
                case "bestseller":
                    sql.append(" ORDER BY p.[soldQuantity] DESC ");
                    break; // Bán chạy
                case "priceAsc":
                    sql.append(" ORDER BY p.[price] ASC ");
                    break; // Giá thấp đến cao
                case "priceDesc":
                    sql.append(" ORDER BY p.[price] DESC ");
                    break; // Giá cao xuống thấp
                default:
                    sql.append(" ORDER BY p.[productID] ASC ");
                    break; // Phổ biến (Mặc định)
            }
        } else {
            sql.append(" ORDER BY p.[productID] ASC ");
        }

        // Phân trang
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            statement = connection.prepareStatement(sql.toString());
            int index = 1;
            // Truyền tham số cho từ khóa (Nhớ thêm 2 dấu % ở hai đầu)
            if (keyword != null && !keyword.trim().isEmpty()) {
                statement.setString(index++, "%" + keyword.trim() + "%");
            }

            // Set param tương ứng với chuỗi SQL đã build
            if (categoryID != null && !categoryID.isEmpty()) {
                statement.setString(index++, categoryID);
            }
            if (minPrice != null) {
                statement.setDouble(index++, minPrice);
            }
            if (maxPrice != null) {
                statement.setDouble(index++, maxPrice);
            }

            statement.setInt(index++, (page - 1) * constant.Constant.RECORD_PER_PAGE);
            statement.setInt(index++, constant.Constant.RECORD_PER_PAGE);

            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(mapResultSetToProduct(resultSet));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

// 2. Hàm đếm tổng số sản phẩm (để chia trang) khớp với điều kiện lọc
    public int countFilterAndSort(String keyword, String categoryID, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[Product] WHERE status =1 ");

        // Lọc theo Từ khóa (Search) - Tìm kiếm gần đúng với LIKE
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND productName LIKE ? ");
        }

        if (categoryID != null && !categoryID.isEmpty()) {
            sql.append(" AND categoryID = ? ");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ? ");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ? ");
        }

        try {
            statement = connection.prepareStatement(sql.toString());
            int index = 1;

            // Truyền tham số cho từ khóa (Nhớ thêm 2 dấu % ở hai đầu)
            if (keyword != null && !keyword.trim().isEmpty()) {
                statement.setString(index++, "%" + keyword.trim() + "%");
            }

            if (categoryID != null && !categoryID.isEmpty()) {
                statement.setString(index++, categoryID);
            }
            if (minPrice != null) {
                statement.setDouble(index++, minPrice);
            }
            if (maxPrice != null) {
                statement.setDouble(index++, maxPrice);
            }

            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    public void updateStockAfterCheckout(int productId, int buyQuantity) {
        String sql = "UPDATE [dbo].[Product] "
                + "SET [quantity] = [quantity] - ?, [soldQuantity] = [soldQuantity] + ? "
                + "WHERE [productID] = ? AND [quantity] >= ? AND [status] = 1";
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, buyQuantity);
            statement.setInt(2, buyQuantity);
            statement.setInt(3, productId);
            statement.setInt(4, buyQuantity);
            statement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi updateStockAfterCheckout: " + e.getMessage());
        } finally {
            closeResources();
        }
    }

    public void deleteProduct(int id) {
        String sql = "UPDATE [dbo].[Product] SET [status] = 0 WHERE productID = ?";
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id); // Truyền ID của sản phẩm cần xóa (ẩn)

            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Đã xóa mềm (ẩn) thành công sản phẩm có ID: " + id);
            }
        } catch (Exception e) {
            System.out.println("Lỗi ở ProductDAO.deleteProduct(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(); // Luôn đóng tài nguyên để tránh tràn bộ nhớ
        }
    }

    // 1. Hàm Khôi phục sản phẩm (Đổi status từ 0 về lại 1)
    public void restoreProduct(int id) {
        String sql = "UPDATE [dbo].[Product] SET [status] = 1 WHERE productID = ?";
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    public void deleteProduct(int id, String sellerId, boolean isAdmin) {
        updateProductStatus(id, sellerId, isAdmin, 0);
    }

    public void restoreProduct(int id, String sellerId, boolean isAdmin) {
        updateProductStatus(id, sellerId, isAdmin, 1);
    }

    private void updateProductStatus(int id, String sellerId, boolean isAdmin, int status) {
        StringBuilder sql = new StringBuilder("UPDATE [dbo].[Product] SET [status] = ? WHERE [productID] = ?");
        if (!isAdmin) {
            sql.append(" AND [sellerID] = ?");
        }
        try {
            statement = connection.prepareStatement(sql.toString());
            statement.setInt(1, status);
            statement.setInt(2, id);
            if (!isAdmin) {
                statement.setString(3, sellerId);
            }
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // 2. Lấy danh sách sản phẩm cho Admin (Có lọc theo status 1 hoặc 0)
    public List<Product> getAdminProducts(String keyword, int statusFilter, int page) {
        return getAdminProducts(keyword, statusFilter, page, null, true);
    }

    public List<Product> getAdminProducts(String keyword, int statusFilter, int page, String sellerId, boolean isAdmin) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.*, u.[fullName] AS sellerName "
                + "FROM [dbo].[Product] p "
                + "LEFT JOIN [dbo].[User] u ON p.[sellerID] = u.[userID] "
                + "WHERE p.[productName] LIKE ? AND p.[status] = ? ");
        if (!isAdmin) {
            sql.append("AND p.[sellerID] = ? ");
        }
        sql.append("ORDER BY p.[productID] DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try {
            statement = connection.prepareStatement(sql.toString());
            int index = 1;
            statement.setString(index++, "%" + keyword + "%");
            statement.setInt(index++, statusFilter);
            if (!isAdmin) {
                statement.setString(index++, sellerId);
            }
            statement.setInt(index++, (page - 1) * constant.Constant.RECORD_PER_PAGE);
            statement.setInt(index, constant.Constant.RECORD_PER_PAGE);

            resultSet = statement.executeQuery();
            while (resultSet.next()) {
                list.add(mapResultSetToProduct(resultSet));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    // 3. Đếm tổng số sản phẩm cho Admin (Để phân trang)
    public int countAdminProducts(String keyword, int statusFilter) {
        return countAdminProducts(keyword, statusFilter, null, true);
    }

    public int countAdminProducts(String keyword, int statusFilter, String sellerId, boolean isAdmin) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM [dbo].[Product] WHERE [productName] LIKE ? AND [status] = ? ");
        if (!isAdmin) {
            sql.append("AND [sellerID] = ?");
        }
        try {
            statement = connection.prepareStatement(sql.toString());
            int index = 1;
            statement.setString(index++, "%" + keyword + "%");
            statement.setInt(index++, statusFilter);
            if (!isAdmin) {
                statement.setString(index, sellerId);
            }
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    public List<Product> randomProducts(int limit, int seed) {
        return randomProducts(0, limit, seed);
    }

    public List<Product> randomProducts(int offset, int limit, int seed) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, u.[fullName] AS sellerName "
                + "FROM [dbo].[Product] p "
                + "LEFT JOIN [dbo].[User] u ON p.[sellerID] = u.[userID] "
                + "WHERE p.[status] = 1 "
                + "ORDER BY CHECKSUM(CONCAT(CAST(p.[productID] AS varchar(20)), ?)) "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, seed);
            statement.setInt(2, offset);
            statement.setInt(3, limit);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                list.add(mapResultSetToProduct(resultSet));
            }
        } catch (Exception e) {
            System.out.println("Error at ProductDAO.randomProducts(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return list;
    }
}
