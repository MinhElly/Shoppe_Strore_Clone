package service;

import dal.OrderDAO;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import model.Item;
import model.User;

public class OrderService {

    private final CartService cartService = new CartService();

    public int checkout(User user, List<Item> cart, String[] selectedProducts, Map<Integer, Integer> quantities) {
        if (user == null) {
            throw new IllegalArgumentException("Please login before checkout.");
        }
        if (!user.isActivate()) {
            throw new IllegalArgumentException("Your account is locked.");
        }

        List<Item> checkoutItems = cartService.prepareCheckoutItems(cart, selectedProducts, quantities);

        try {
            int orderId = new OrderDAO().createOrder(user.getUserID(), checkoutItems);
            cartService.removePurchasedItems(cart, checkoutItems);
            return orderId;
        } catch (SQLException ex) {
            throw new IllegalStateException("Could not create order. Please try again.", ex);
        }
    }
}
