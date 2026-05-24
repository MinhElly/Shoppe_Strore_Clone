package service;

import dal.ProductDAO;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Item;
import model.Product;

public class CartService {

    public int addToCart(List<Item> cart, String productIdRaw, String quantityRaw) {
        int productId = parsePositiveInt(productIdRaw, "Product is invalid.");
        int quantity = parsePositiveInt(quantityRaw, "Quantity must be greater than 0.");

        Product product = new ProductDAO().findById(productId);
        if (product == null || product.getStatus() != 1) {
            throw new IllegalArgumentException("Product is not available.");
        }

        Item existingItem = findItem(cart, productId);
        int currentQuantity = existingItem == null ? 0 : existingItem.getQuantity();
        int newQuantity = currentQuantity + quantity;

        if (newQuantity > product.getQuantity()) {
            throw new IllegalArgumentException("Requested quantity is greater than current stock.");
        }

        if (existingItem == null) {
            cart.add(new Item(product, quantity));
        } else {
            existingItem.setQuantity(newQuantity);
            existingItem.setProduct(product);
        }

        return productId;
    }

    public void removeFromCart(List<Item> cart, String productIdRaw) {
        int productId = parsePositiveInt(productIdRaw, "Product is invalid.");
        cart.removeIf(item -> item.getProduct().getProductID() == productId);
    }

    public List<Item> prepareCheckoutItems(List<Item> cart, String[] selectedProducts, Map<Integer, Integer> quantities) {
        if (selectedProducts == null || selectedProducts.length == 0) {
            throw new IllegalArgumentException("Please select at least one product to checkout.");
        }

        Set<Integer> selectedIds = new HashSet<>();
        List<Item> checkoutItems = new ArrayList<>();

        for (String productIdRaw : selectedProducts) {
            int productId = parsePositiveInt(productIdRaw, "Product is invalid.");
            if (!selectedIds.add(productId)) {
                continue;
            }

            Item cartItem = findItem(cart, productId);
            if (cartItem == null) {
                throw new IllegalArgumentException("Selected product is no longer in your cart.");
            }

            int quantity = quantities.getOrDefault(productId, cartItem.getQuantity());
            if (quantity <= 0) {
                throw new IllegalArgumentException("Quantity must be greater than 0.");
            }

            Product latestProduct = new ProductDAO().findById(productId);
            if (latestProduct == null || latestProduct.getStatus() != 1) {
                throw new IllegalArgumentException("Product is not available.");
            }

            if (quantity > latestProduct.getQuantity()) {
                throw new IllegalArgumentException("Requested quantity is greater than current stock.");
            }

            checkoutItems.add(new Item(latestProduct, quantity));
        }

        return checkoutItems;
    }

    public void removePurchasedItems(List<Item> cart, List<Item> purchasedItems) {
        Set<Integer> purchasedIds = new HashSet<>();
        for (Item item : purchasedItems) {
            purchasedIds.add(item.getProduct().getProductID());
        }
        cart.removeIf(item -> purchasedIds.contains(item.getProduct().getProductID()));
    }

    private Item findItem(List<Item> cart, int productId) {
        for (Item item : cart) {
            if (item.getProduct().getProductID() == productId) {
                return item;
            }
        }
        return null;
    }

    private int parsePositiveInt(String rawValue, String errorMessage) {
        try {
            int value = Integer.parseInt(rawValue);
            if (value <= 0) {
                throw new NumberFormatException("Value is not positive.");
            }
            return value;
        } catch (NumberFormatException ex) {
            throw new IllegalArgumentException(errorMessage);
        }
    }
}
