package controller.user;

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

@WebServlet(name = "PurchaseController", urlPatterns = {"/user-purchase"})
public class PurchaseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute(Constant.SESSION_USER);

        if (user == null) {
            response.sendRedirect("authen?action=login");
            return;
        }
        if (!Constant.isCustomer(user)) {
            response.sendRedirect("home?error=access_denied");
            return;
        }

        String status = request.getParameter("status");
        OrderDAO odao = new OrderDAO();
        List<OrderItemDTO> list = odao.getPurchaseItemsByUserId(user.getUserID(), status);

        request.setAttribute("listPurchaseItems", list);
        request.setAttribute("activeStatus", Constant.isOrderStatus(status) ? status : "Tất cả");
        request.getRequestDispatcher("/view/user/purchase.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
