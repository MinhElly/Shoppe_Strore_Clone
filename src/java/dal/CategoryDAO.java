/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import dal.DBContext;

/**
 *
 * @author admin
 */
public class CategoryDAO extends DBContext{
    protected PreparedStatement statement;
    protected ResultSet resultSet;
    public List<Category> findAll() {
        // Khởi tạo một danh sách rỗng để lưu trữ các danh mục
        List<Category> list = new ArrayList<>();
        
        // Câu lệnh SQL để chọn tất cả các cột từ bảng Categories
        String sql = "SELECT [categoryID]\n" +
                    "      ,[categoryName]\n" +
                    "      ,[describe]\n" +
                    "  FROM [dbo].[Category]";

        try {
            // Chuẩn bị câu lệnh SQL
            statement = connection.prepareStatement(sql);
            
            // Thực thi câu lệnh và nhận kết quả
            resultSet = statement.executeQuery();

            // Lặp qua từng dòng kết quả trả về
            while (resultSet.next()) {
                // Tạo một đối tượng Category mới từ dữ liệu lấy được
                Category c = new Category(
                        resultSet.getString("categoryID"),
                        resultSet.getString("categoryName"),
                        resultSet.getString("describe")
                );
                
                // Thêm đối tượng Category vào danh sách
                list.add(c);
            }
        } catch (Exception e) {
            // In ra lỗi nếu có ngoại lệ SQL xảy ra
            System.out.println("Error at CategoryDAO.findAll(): " + e.getMessage());
        }
        return list;
}
}
