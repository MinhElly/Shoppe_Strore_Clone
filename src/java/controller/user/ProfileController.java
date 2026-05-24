package controller.user;

import constant.Constant;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;
import model.User;

@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)
public class ProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getSessionUser(request, response);
        if (user == null) {
            return;
        }
        request.setAttribute("profileUser", user);
        request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = getSessionUser(request, response);
        if (user == null) {
            return;
        }

        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));

        String avatar = saveAvatar(request);
        if (avatar != null) {
            user.setAvatar(avatar);
        }

        UserDAO dao = new UserDAO();
        if (dao.updateProfile(user)) {
            User refreshed = dao.searchUser(user.getUserID());
            if (refreshed != null) {
                refreshed.setPassword(null);
                request.getSession().setAttribute(Constant.SESSION_USER, refreshed);
                request.setAttribute("profileUser", refreshed);
            }
            request.setAttribute("message", "Cập nhật hồ sơ thành công.");
        } else {
            request.setAttribute("error", "Cập nhật hồ sơ thất bại.");
            request.setAttribute("profileUser", user);
        }

        request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
    }

    private User getSessionUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute(Constant.SESSION_USER);
        if (user == null) {
            response.sendRedirect("authen?action=login");
            return null;
        }
        return user;
    }

    private String saveAvatar(HttpServletRequest request) throws IOException, ServletException {
        Part part = request.getPart("avatar");
        if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
            return null;
        }

        String originalName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String extension = "";
        int dot = originalName.lastIndexOf('.');
        if (dot >= 0) {
            extension = originalName.substring(dot).toLowerCase();
        }
        String fileName = UUID.randomUUID().toString() + extension;
        String uploadPath = request.getServletContext().getRealPath("/assets/img/avatar");
        File dir = new File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        part.write(uploadPath + File.separator + fileName);
        return fileName;
    }
}
