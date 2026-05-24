package controller.user;

import constant.Constant;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Item;
import model.User;
import service.CartService;
import service.OrderService;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private final CartService cartService = new CartService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        HttpSession session = request.getSession();
        List<Item> cart = getCart(session);

        try {
            switch (action) {
                case "add_to_cart":
                case "buy_now":
                    int productId = cartService.addToCart(
                            cart,
                            request.getParameter("productId"),
                            request.getParameter("quantity")
                    );
                    saveCart(session, cart);

                    if ("buy_now".equals(action)) {
                        response.sendRedirect("cart?action=view");
                    } else {
                        response.sendRedirect("product-detail?id=" + productId);
                    }
                    break;

                case "delete":
                    cartService.removeFromCart(cart, request.getParameter("id"));
                    saveCart(session, cart);
                    response.sendRedirect("cart?action=view");
                    break;

                case "checkout":
                    User user = (User) session.getAttribute(Constant.SESSION_USER);
                    if (user == null) {
                        response.sendRedirect("authen?action=login");
                        return;
                    }
                    if (!Constant.isCustomer(user)) {
                        request.setAttribute("error", "Only customer accounts can checkout.");
                        request.getRequestDispatcher("/view/user/cart.jsp").forward(request, response);
                        return;
                    }

                    orderService.checkout(
                            user,
                            cart,
                            request.getParameterValues("selectedProducts"),
                            getRequestedQuantities(request)
                    );
                    saveCart(session, cart);
                    response.sendRedirect("user-purchase");
                    break;

                case "view":
                default:
                    request.getRequestDispatcher("/view/user/cart.jsp").forward(request, response);
                    break;
            }
        } catch (IllegalArgumentException | IllegalStateException ex) {
            request.setAttribute("error", ex.getMessage());
            saveCart(session, cart);
            request.getRequestDispatcher("/view/user/cart.jsp").forward(request, response);
        }
    }

    @SuppressWarnings("unchecked")
    private List<Item> getCart(HttpSession session) {
        Object currentCart = session.getAttribute("cart");
        if (currentCart instanceof List<?>) {
            return (List<Item>) currentCart;
        }
        return new ArrayList<>();
    }

    private void saveCart(HttpSession session, List<Item> cart) {
        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", cart.size());
    }

    private Map<Integer, Integer> getRequestedQuantities(HttpServletRequest request) {
        Map<Integer, Integer> quantities = new HashMap<>();
        String[] selectedProducts = request.getParameterValues("selectedProducts");
        if (selectedProducts == null) {
            return quantities;
        }

        for (String productIdRaw : selectedProducts) {
            try {
                int productId = Integer.parseInt(productIdRaw);
                int quantity = Integer.parseInt(request.getParameter("quantity_" + productId));
                quantities.put(productId, quantity);
            } catch (NumberFormatException ex) {
                throw new IllegalArgumentException("Quantity must be greater than 0.");
            }
        }
        return quantities;
    }
}
