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
@WebServlet(name="CategoryController", urlPatterns={"/category"})
public class CategoryController extends HttpServlet {
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    String keyword = request.getParameter("keyword");   
    // Lấy các tham số từ URL
    String categoryID = request.getParameter("cid");
    String sortType = request.getParameter("sort"); // pop, new, bestseller, priceAsc, priceDesc
    
    // Xử lý giá
    String minPriceRaw = request.getParameter("minPrice");
    String maxPriceRaw = request.getParameter("maxPrice");
    Double minPrice = null;
    Double maxPrice = null;
    try {
        if (minPriceRaw != null && !minPriceRaw.isEmpty()) minPrice = Double.parseDouble(minPriceRaw);
        if (maxPriceRaw != null && !maxPriceRaw.isEmpty()) maxPrice = Double.parseDouble(maxPriceRaw);
    } catch (NumberFormatException e) {
        System.out.println("Lỗi parse giá");
    }

    // Xử lý trang
    String pageRaw = request.getParameter("page");
    int page = 1;
    if (pageRaw != null && !pageRaw.isEmpty()) {
        page = Integer.parseInt(pageRaw);
    }
    
    ProductDAO dao = new ProductDAO();
    
    // 1. Gọi hàm lọc động
    List<Product> listP = dao.filterAndSortProduct(keyword,categoryID, minPrice, maxPrice, sortType, page);
    
    // 2. Phân trang
    int totalProducts = dao.countFilterAndSort(keyword,categoryID, minPrice, maxPrice);
    int totalPages = (totalProducts % constant.Constant.RECORD_PER_PAGE == 0) 
            ? (totalProducts / constant.Constant.RECORD_PER_PAGE) 
            : (totalProducts / constant.Constant.RECORD_PER_PAGE) + 1;
            
    // 3. Set attribute để gửi lại cho JSP giữ trạng thái (để lúc bấm sang trang 2 không bị mất filter)
    request.setAttribute("listP", listP);       
    request.setAttribute("currentPage", page);  
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("keyword", keyword);
    request.setAttribute("tag", categoryID);    
    request.setAttribute("currentSort", sortType); // Giữ trạng thái nút sắp xếp
    request.setAttribute("minPrice", minPriceRaw); // Giữ số trong ô input Từ
    request.setAttribute("maxPrice", maxPriceRaw); // Giữ số trong ô input Đến

    request.getRequestDispatcher("/view/homepage/cate-detail.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
