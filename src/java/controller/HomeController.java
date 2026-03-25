/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author admin
 */
@WebServlet(name="HomeController", urlPatterns={"/home"})
public class HomeController extends HttpServlet {
   
    
    ProductDAO productDAO  = new ProductDAO();
    CategoryDAO categoryDAO = new CategoryDAO();
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String pageRaw = request.getParameter("page");
        int page = 1; // Mặc định là trang 1
        if (pageRaw != null && !pageRaw.isEmpty()) {
            page = Integer.parseInt(pageRaw);
        }
        
        List<Product> listProduct = productDAO.pagingProduct(page);
        List<Category> listCategory = categoryDAO.findAll();
        int totalProducts = productDAO.findTotalProducts(); // Đếm tổng tất cả SP
        int totalPages = (totalProducts % constant.Constant.RECORD_PER_PAGE == 0) 
        ? (totalProducts / constant.Constant.RECORD_PER_PAGE) 
        : (totalProducts / constant.Constant.RECORD_PER_PAGE) + 1;
        
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        HttpSession session = request.getSession();
        session.setAttribute(constant.Constant.SESSION_PRODUCT, listProduct);
        session.setAttribute(constant.Constant.SESSION_CATEGORY, listCategory);
        request.getRequestDispatcher("view/homepage/home.jsp").forward(request, response);
    } 

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("home");
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
