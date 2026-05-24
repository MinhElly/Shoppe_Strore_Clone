package controller.admin;

import constant.Constant;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.User;

@WebServlet(name = "AdminAccountController", urlPatterns = {"/admin-account"})
public class AdminAccountController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute(Constant.SESSION_USER);
        if (!Constant.isAdmin(currentUser)) {
            response.sendRedirect(request.getContextPath() + "/home?error=access_denied");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        UserDAO udao = new UserDAO();

        switch (action) {
            case "view":
                showAccounts(request, response, udao);
                break;
            case "ban":
                updateActivate(request, response, udao, false);
                break;
            case "unban":
                updateActivate(request, response, udao, true);
                break;
            case "updateRole":
                updateRole(request, response, udao);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin-account?action=view");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        doGet(request, response);
    }

    private void showAccounts(HttpServletRequest request, HttpServletResponse response, UserDAO udao)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int recordsPerPage = 10;
        List<User> listAccount = udao.searchAndPagingUsers(keyword, page, recordsPerPage);
        int totalRecords = udao.getTotalUsers(keyword);
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("listAccount", listAccount);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("totalRecords", totalRecords);
        request.getRequestDispatcher("/view/admin/admin-account.jsp").forward(request, response);
    }

    private void updateActivate(HttpServletRequest request, HttpServletResponse response, UserDAO udao, boolean activate)
            throws IOException {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            udao.setUserActivate(id, activate);
        }
        response.sendRedirect(request.getContextPath() + "/admin-account?action=view");
    }

    private void updateRole(HttpServletRequest request, HttpServletResponse response, UserDAO udao)
            throws IOException {
        String id = request.getParameter("id");
        String roleRaw = request.getParameter("roleID");
        if (id != null && roleRaw != null) {
            try {
                int roleID = Integer.parseInt(roleRaw);
                if (roleID == Constant.ROLE_ADMIN || roleID == Constant.ROLE_CUSTOMER || roleID == Constant.ROLE_STAFF) {
                    udao.updateUserRole(id, roleID);
                }
            } catch (NumberFormatException ignored) {
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin-account?action=view");
    }
}
