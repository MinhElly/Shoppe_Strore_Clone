package controller;

import dal.OrderDAO;
import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Item;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.User;

@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

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
            action = "view"; // Mặc định là vào xem giỏ hàng
        }

        HttpSession session = request.getSession();
        List<Item> cart = (List<Item>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // 1. XỬ LÝ KHI BẤM "THÊM VÀO GIỎ" HOẶC "MUA NGAY"
        if ("add_to_cart".equals(action) || "buy_now".equals(action)) {

            // Sửa thành "productId" cho khớp với file JSP
            String pidStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            // Xử lý an toàn tránh lỗi parse
            if (pidStr != null && quantityStr != null) {
                int pid = Integer.parseInt(pidStr);
                int quantity = Integer.parseInt(quantityStr);

                // Kiểm tra xem sản phẩm đã có trong giỏ chưa
                boolean isExist = false;
                for (Item i : cart) {
                    if (i.getProduct().getProductID() == pid) {
                        i.setQuantity(i.getQuantity() + quantity); // Có rồi thì cộng dồn
                        isExist = true;
                        break;
                    }
                }
                if (!isExist) {
                    Product p = new ProductDAO().findById(pid);
                    System.out.println("Ten san pham lay tu DB la:" + p.getProductName());
                    cart.add(new Item(p, quantity)); // Chưa có thì thêm mới
                    
                }

                session.setAttribute("cart", cart);
                session.setAttribute("cartCount", cart.size()); // Cập nhật số đỏ trên Header

                // Điều hướng tùy theo nút được bấm
                if ("buy_now".equals(action)) {
                    response.sendRedirect("cart?action=view");
                } else {
                    response.sendRedirect("product-detail?id=" + pid);
                }
            } else {
                response.sendRedirect("home");
            }

            // 2. XÓA SẢN PHẨM KHỎI GIỎ HÀNG
        } else if ("delete".equals(action)) {
            String pidStr = request.getParameter("id");
            if (pidStr != null) {
                ProductDAO pdao = new ProductDAO();
                int pid = Integer.parseInt(pidStr);
                
                cart.removeIf(item -> item.getProduct().getProductID() == pid);
                
                session.setAttribute("cart", cart);
                session.setAttribute("cartCount", cart.size());
            }
            response.sendRedirect("cart?action=view");

            // 3. HIỂN THỊ GIỎ HÀNG
        } else if ("view".equals(action)) {
            request.getRequestDispatcher("/view/user/cart/cart.jsp").forward(request, response);
            // 4. XỬ LÝ THANH TOÁN (MUA HÀNG)
        // 4. XỬ LÝ THANH TOÁN (MUA HÀNG)
        } else if ("checkout".equals(action)) {
            // Lấy user đang đăng nhập
            User user = (User) session.getAttribute(constant.Constant.SESSION_USER);
            if (user == null) {
                response.sendRedirect("authen?action=login");
                return;
            }

            String[] selectedProducts = request.getParameterValues("selectedProducts");
            ProductDAO pDao = new ProductDAO();
            OrderDAO oDao = new OrderDAO();
            
            // List chứa các sản phẩm khách hàng thực sự chốt mua
            List<Item> boughtItems = new ArrayList<>();
            double totalMoney = 0;
            
            if (selectedProducts != null) {
                for (String pidStr : selectedProducts) {
                    int pid = Integer.parseInt(pidStr);
                    String finalQtyStr = request.getParameter("quantity_" + pid);
                    String adminCheck = request.getParameter("check");
                    if (finalQtyStr != null) {
                        int finalQuantity = Integer.parseInt(finalQtyStr);

                        // Tìm sản phẩm trong giỏ để lấy giá tiền và đưa vào danh sách mua
                        for (Item item : cart) {
                            if (item.getProduct().getProductID() == pid) {
                                // Cập nhật đúng số lượng khách nhập lúc thanh toán
                                item.setQuantity(finalQuantity);
                                boughtItems.add(item);
                                
                                // Cộng dồn tổng tiền
                                totalMoney += (item.getProduct().getPrice() * finalQuantity);

                                // Trừ tồn kho trong DB
                                if(adminCheck == null){
                                    break;
                                }else{
                                    pDao.updateStockAfterCheckout(pid, finalQuantity);
                                }
                                
                                break;
                            }
                        }
                    }
                }

                // THỰC THI LƯU XUỐNG DATABASE
                if (!boughtItems.isEmpty()) {
                    oDao.insertOrder(user.getUserID(), totalMoney, boughtItems);
                }

                // Sau khi mua xong, xóa các sản phẩm đó khỏi Session Giỏ hàng
                for (String pidStr : selectedProducts) {
                    int pid = Integer.parseInt(pidStr);
                    cart.removeIf(item -> item.getProduct().getProductID() == pid);
                }
            }

            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", cart.size());

            // Chuyển hướng về trang Đơn mua
            response.sendRedirect("user-purchase");
        }
    }
}
