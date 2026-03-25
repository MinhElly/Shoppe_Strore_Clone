package controller.admin;

import dal.ProductDAO;
import model.Product;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Category;

@WebServlet(name = "ProductAdminServlet", urlPatterns = {"/admin-product"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminProductController extends HttpServlet {

    ProductDAO pdao = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        // ================= CHỨC NĂNG XÓA =================
        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                pdao.deleteProduct(Integer.parseInt(idStr));
            }
            response.sendRedirect("admin-product?action=view&status=1"); // Xóa xong quay lại trang Đang bán
            return;
        }
        
        // ================= CHỨC NĂNG KHÔI PHỤC =================
        if ("restore".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                pdao.restoreProduct(Integer.parseInt(idStr));
            }
            response.sendRedirect("admin-product?action=view&status=0"); // Khôi phục xong quay lại Thùng rác
            return;
        }

        // ================= HIỂN THỊ DANH SÁCH & TÌM KIẾM =================
        if ("view".equals(action)) {
            String keyword = request.getParameter("keyword");
            if (keyword == null) keyword = "";

            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try { page = Integer.parseInt(pageStr); } catch (Exception e) {}
            }

            // LẤY TRẠNG THÁI TỪ URL (Mặc định là 1 - Đang bán)
            int statusFilter = 1;
            String statusStr = request.getParameter("status");
            if (statusStr != null && !statusStr.isEmpty()) {
                try { statusFilter = Integer.parseInt(statusStr); } catch (Exception e) {}
            }

            // GỌI HÀM DAO MỚI CHO ADMIN
            List<Product> listProduct = pdao.getAdminProducts(keyword, statusFilter, page);
            int totalRecords = pdao.countAdminProducts(keyword, statusFilter);
            
            int recordsPerPage = constant.Constant.RECORD_PER_PAGE; 
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            // Truyền Categories vào để Modal Sửa lấy Dropdown
            dal.CategoryDAO cdao = new dal.CategoryDAO();
            request.setAttribute("listCategories", cdao.findAll());

            // Gửi dữ liệu sang JSP
            HttpSession session = request.getSession();
            session.setAttribute("listAdminProduct", listProduct);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("keyword", keyword);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("currentStatus", statusFilter); // Truyền trạng thái hiện tại sang JSP

            request.getRequestDispatcher("/view/admin/admin-product.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Chống lỗi font Tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("edit".equals(action)) {
            editProduct(request, response);
        }
        
        // Làm xong quay lại bảng danh sách
        response.sendRedirect("admin-product?action=view");
    }

    // ================= HÀM 1: THÊM SẢN PHẨM =================
    private void addProduct(HttpServletRequest request, HttpServletResponse response) {
        try {
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String describe = request.getParameter("describe");
            String categoryID = request.getParameter("categoryID"); 

            // Upload ảnh
            Part part = request.getPart("imageFile");
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String pathOfFile = "";

            if (fileName != null && !fileName.trim().isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/assets/img/product");
                File dir = new File(uploadPath);
                if (!dir.exists()) dir.mkdirs();
                
                part.write(uploadPath + File.separator + fileName);
                pathOfFile = fileName; 
            }

            Product pro = new Product();
            pro.setProductName(productName);
            pro.setPrice(price);
            pro.setQuantity(quantity);
            pro.setDescribe(describe);
            pro.setCategoryID(categoryID);
            pro.setImage(pathOfFile);
            pro.setStatus(1); 

            pdao.insertProduct(pro);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= HÀM 2: SỬA SẢN PHẨM =================
    private void editProduct(HttpServletRequest request, HttpServletResponse response) {
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String describe = request.getParameter("describe");
            String categoryID = request.getParameter("categoryID");

            // Xử lý Ảnh
            Part part = request.getPart("imageFile");
            String fileName = (part != null && part.getSubmittedFileName() != null) ? Paths.get(part.getSubmittedFileName()).getFileName().toString() : "";
            String pathOfFile = request.getParameter("oldImage"); 

            if (fileName != null && !fileName.trim().isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/assets/img/product");
                File dir = new File(uploadPath);
                if (!dir.exists()) dir.mkdirs();
                
                part.write(uploadPath + File.separator + fileName);
                pathOfFile = fileName; 
            }

            Product pro = pdao.findById(productID);
            if (pro != null) {
                pro.setProductName(productName);
                pro.setPrice(price);
                pro.setQuantity(quantity);
                pro.setDescribe(describe);
                pro.setCategoryID(categoryID);
                pro.setImage(pathOfFile); 

                // LƯU Ý Ở ĐÂY: Nếu DAO của bạn là updateProduct thì sửa lại cho đúng nhé
                pdao.editProduct(pro); 
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}