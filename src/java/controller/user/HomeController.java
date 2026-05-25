package controller.user;

import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import model.Category;
import model.Product;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean ajaxProducts = "products".equals(request.getParameter("ajax"));
        List<Category> listCategory = categoryDAO.findAll();
        int totalProducts = productDAO.findTotalProducts();
        int seed = parsePositiveInt(
                request.getParameter("seed"),
                ThreadLocalRandom.current().nextInt(1, Integer.MAX_VALUE)
        );

        if (ajaxProducts) {
            int offset = parseNonNegativeInt(request.getParameter("offset"), constant.Constant.RECORD_PER_PAGE);
            List<Product> listProduct = productDAO.randomProducts(offset, constant.Constant.RECORD_PER_PAGE, seed);
            int nextOffset = offset + listProduct.size();

            request.setAttribute("listProduct", listProduct);
            request.setAttribute("nextOffset", nextOffset);
            request.setAttribute("hasMoreProducts", nextOffset < totalProducts);
            request.setAttribute("randomSeed", seed);
            request.getRequestDispatcher("view/user/home-product-fragment.jsp").forward(request, response);
            return;
        }

        int currentLimit = parsePositiveInt(request.getParameter("limit"), constant.Constant.RECORD_PER_PAGE);
        currentLimit = Math.max(constant.Constant.RECORD_PER_PAGE, currentLimit);
        currentLimit = Math.min(currentLimit, Math.max(totalProducts, constant.Constant.RECORD_PER_PAGE));
        List<Product> listProduct = productDAO.randomProducts(currentLimit, seed);

        request.setAttribute("listProduct", listProduct);
        request.setAttribute("currentLimit", currentLimit);
        request.setAttribute("nextLimit", currentLimit + constant.Constant.RECORD_PER_PAGE);
        request.setAttribute("nextOffset", currentLimit);
        request.setAttribute("hasMoreProducts", currentLimit < totalProducts);
        request.setAttribute("randomSeed", seed);

        HttpSession session = request.getSession();
        session.setAttribute(constant.Constant.SESSION_PRODUCT, listProduct);
        session.setAttribute(constant.Constant.SESSION_CATEGORY, listCategory);
        request.getRequestDispatcher("view/user/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("home");
    }

    private int parsePositiveInt(String rawValue, int defaultValue) {
        try {
            int value = Integer.parseInt(rawValue);
            return value > 0 ? value : defaultValue;
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }

    private int parseNonNegativeInt(String rawValue, int defaultValue) {
        try {
            int value = Integer.parseInt(rawValue);
            return value >= 0 ? value : defaultValue;
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }
}
