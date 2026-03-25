/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author admin
 */
@WebServlet(name="AdminFilter", urlPatterns={"/admin/*"})
public class AdminFilter implements Filter{
   
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
            
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User account = (User) session.getAttribute("account");
        model.User user = (session != null) ? (model.User) session.getAttribute(constant.Constant.SESSION_USER) : null;
        // Nếu chưa đăng nhập HOẶC role không phải là Admin (1)
        if (account == null || account.getRoleID() != 1) {
            // Đá về trang báo lỗi truy cập hoặc trang chủ
            res.sendRedirect(req.getContextPath() + "/home?error=access_denied");
            return;
        }

        // Nếu đúng là Admin -> Cho phép đi tiếp vào Servlet Admin
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

}
