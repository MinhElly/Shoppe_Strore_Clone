/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author  NQMINHH
 */
@WebServlet(name="AuthenticationController", urlPatterns={"/authen"})
public class AuthenticationController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    UserDAO udao = new UserDAO();
    
    

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
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        String url;
        switch (action) {
            case "login":
                url = "view/authentication/login.jsp";
                break;
            case "logout":
                url = logOut(request, response);
                break;
            case "register":
                url = "view/authentication/register.jsp";
                break;
            default:
                url = "home";
        }
        request.getRequestDispatcher(url).forward(request, response);
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
        String action = request.getParameter("action") == null ? "default" : request.getParameter("action");
        String url;
        switch (action) {
            case "login":
                url = loginHandle(request, response);
                break;
            case "register":
                url = registerHandle(request, response);
                break;
            default:
                url = "home";
        }
        request.getRequestDispatcher(url).forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private String loginHandle(HttpServletRequest request, HttpServletResponse response){
        String url = null;
        String username = request.getParameter("username");
        String password= request.getParameter("password");
        if(udao.loginUser(username, password) != null){
            HttpSession session = request.getSession();
            session.setAttribute(constant.Constant.SESSION_USER, udao.loginUser(username, password));
            url = "home";
        }else{
            url="view/authentication/login.jsp";
            request.setAttribute("error", "Tài khoản hoặc Mật khẩu không đúng!");
        }
        return url;
    }
    
    
    private String logOut(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        session.removeAttribute(constant.Constant.SESSION_USER);
        return "home";
    }
    
    private String registerHandle(HttpServletRequest request, HttpServletResponse response){
        String username = request.getParameter("username");
        String password= request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String userID = udao.generateUserID();
        if(udao.isExistUserName(username)){
            request.setAttribute("error", "Tài khoàn đã tồn tại");
            return "view/authentication/register.jsp";
        }
        if (!password.equalsIgnoreCase(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu không khớp. Vui lòng thử lại");
            return "view/authentication/register.jsp";
        }
        User user = new User();
        user.setUserID(userID);
        user.setFullName(fullName);
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setRoleID(2);     // user bình thường
        user.setActivate(true);
        int result = udao.insertUser(user);   // ⭐ lưu DB

        if(result > 0){                       // ⭐ insert thành công
            HttpSession session = request.getSession();
            session.setAttribute(constant.Constant.SESSION_USER, user); // lưu session
            return "home";
        }else{
            request.setAttribute("error", "Đăng ký thất bại");
            return "view/authentication/register.jsp";
        }
    }
}
