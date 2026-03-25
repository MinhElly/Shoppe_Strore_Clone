package controller;

import dal.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminAccountController", urlPatterns = {"/admin-account"})
public class AdminAccountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Mặc định action là "view" nếu không truyền gì trên URL
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        UserDAO udao = new UserDAO();

        switch (action) {
            case "view":
                // 1. Lấy từ khóa tìm kiếm (Mặc định là chuỗi rỗng để lấy tất cả)
                String keyword = request.getParameter("keyword");
                if (keyword == null) {
                    keyword = "";
                }

                // 2. Xử lý Phân trang (Mặc định ở trang 1)
                int page = 1;
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    try {
                        page = Integer.parseInt(pageStr);
                    } catch (NumberFormatException e) {
                        page = 1; // Nếu người dùng cố tình gõ chữ vào URL thì ép về trang 1
                    }
                }

                // 3. Quy định số lượng tài khoản hiển thị trên 1 trang
                int recordsPerPage = 10; 

                // 4. Lấy dữ liệu động từ Database
                List<User> listAccount = udao.searchAndPagingUsers(keyword, page, recordsPerPage);
                int totalRecords = udao.getTotalUsers(keyword);
                
                // 5. Tính toán tổng số trang (Dùng Math.ceil để làm tròn lên)
                int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

                // 6. Gửi toàn bộ dữ liệu sang file JSP để hiển thị
                request.setAttribute("listAccount", listAccount);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("keyword", keyword);
                request.setAttribute("totalRecords", totalRecords);

                // Điều hướng tới giao diện
                request.getRequestDispatcher("/view/admin/admin-account.jsp").forward(request, response);
                break;

            case "delete":
                // Chức năng này thực chất là Khóa (Ban) tài khoản
                String idRaw = request.getParameter("id");
                if (idRaw != null && !idRaw.isEmpty()) {
                    udao.banUser(idRaw); // Hàm cập nhật activate = 0 đã viết trong DAO
                }
                
                // Xử lý xong thì tự động load lại trang danh sách ban đầu
                response.sendRedirect(request.getContextPath() + "/admin-account?action=view");
                break;
                
            default:
                // Nếu action lạ (không phải view hay delete) thì cũng ép về trang chủ danh sách
                response.sendRedirect(request.getContextPath() + "/admin-account?action=view");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tạm thời các thao tác quản lý tài khoản chỉ dùng GET (Qua URL)
        // Nếu sau này bạn có Form tạo User mới (POST) thì xử lý ở đây
        doGet(request, response);
    }
}