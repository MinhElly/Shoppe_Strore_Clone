package controller.admin;

import constant.Constant;
import dal.OrderDAO;
import dto.OrderItemDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.User;

@WebServlet(name = "AdminOrderController", urlPatterns = {"/admin-order"})
public class AdminOrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute(Constant.SESSION_USER);
        if (!Constant.canAccessStaffArea(user)) {
            response.sendRedirect(request.getContextPath() + "/home?error=access_denied");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        OrderDAO odao = new OrderDAO();
        boolean isAdmin = Constant.isAdmin(user);

        if ("updateStatus".equals(action)) {
            int detailId = Integer.parseInt(request.getParameter("detailId"));
            String status = request.getParameter("status");
            odao.updateOrderDetailStatus(detailId, status, user.getUserID(), isAdmin);
            response.sendRedirect("admin-order?action=view");
            return;
        }

        String status = request.getParameter("status");
        List<OrderItemDTO> list = odao.getOrderItemsForStaff(user.getUserID(), isAdmin, status);
        request.setAttribute("listOrderItems", list);
        request.setAttribute("activeStatus", Constant.isOrderStatus(status) ? status : "Tất cả");
        request.getRequestDispatcher("/view/admin/admin-order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
