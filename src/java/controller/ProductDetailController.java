/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 *
 * @author admin
 */
@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Lấy ID sản phẩm từ URL (tham số ?id=...)
            String idRaw = request.getParameter("id");
            int productId = Integer.parseInt(idRaw);
            
            // 2. Gọi DAO để tìm sản phẩm theo ID
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId); // Hàm này bạn đã có sẵn trong DAO
            
            // Nếu không tìm thấy sản phẩm (ví dụ ai đó gõ id bậy bạ lên URL)
            if (product == null) {
                response.sendRedirect("home"); // Đá về trang chủ
                return;
            }
            // Truyền ID danh mục và ID sản phẩm hiện tại vào hàm
            List<Product> relatedProducts = productDAO.getRelatedProducts(product.getCategoryID(), productId);
            request.setAttribute("relatedProducts", relatedProducts); // Đẩy sang JSP
            
            // 3. Đẩy dữ liệu sản phẩm sang trang JSP
            request.setAttribute("product", product);
            
            // Tùy chọn: Nếu bạn có làm bảng ProductImage như mình gợi ý ở câu trước thì gọi DAO lấy ảnh phụ ở đây
            // List<String> extraImages = productDAO.getProductImages(productId);
            // request.setAttribute("extraImages", extraImages);
            
            // 4. Forward sang trang product-detail.jsp
            request.getRequestDispatcher("view/homepage/product-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            // Xử lý lỗi nếu id truyền vào không phải là số
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
