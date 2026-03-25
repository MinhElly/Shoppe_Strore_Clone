<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản Lý Sản Phẩm - Admin</title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/shopee-logo.png" type="image/x-icon" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/grid.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile-admin.css" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-free-6.1.1/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap$subset=vietnamese" rel="stylesheet" />
    </head>

    <body>
        <div class="app">
            <header id="header">
                <div class="grid wide">
                    <jsp:include page="../common/nav.jsp"></jsp:include>
                    <jsp:include page="../common/header__with-search.jsp"></jsp:include>
                    </div>
                </header>

                <div class="profile-container">
                    <div class="grid wide">
                        <div class="row sm-gutter">

                            <div class="col l-2 m-0 c-0">
                                <div class="admin-sidebar__user">
                                    <img src="${pageContext.request.contextPath}/assets/img/avatar-default.jpg" alt="Avatar" class="admin-sidebar__user-avatar">
                                <div class="admin-sidebar__user-info">
                                    <div class="admin-sidebar__user-name">${sessionScope.SESSION_USER.fullName != null ? sessionScope.SESSION_USER.fullName : 'Admin Quản Trị'}</div>
                                    
                                </div>
                            </div>

                            <ul class="admin-sidebar__menu">
                                <li class="admin-sidebar__menu-item">
                                    <a href="admin-dashboard" class="admin-sidebar__menu-link">
                                        <i class="admin-sidebar__menu-icon icon-blue fa-regular fa-user"></i> Tổng quan
                                    </a>
                                </li>

                                <li class="admin-sidebar__menu-item">
                                    <a href="admin-product?action=view" class="admin-sidebar__menu-link">
                                        <i class="admin-sidebar__menu-icon icon-orange fa-solid fa-box-open"></i> Quản Lý Sản Phẩm
                                    </a>
                                </li>

                                <li class="admin-sidebar__menu-item">
                                    <a href="admin-account?action=view" class="admin-sidebar__menu-link">
                                        <i class="admin-sidebar__menu-icon icon-green fa-solid fa-users"></i> Quản Lý Tài Khoản
                                    </a>
                                </li>

                                <li class="admin-sidebar__menu-item">
                                    <a href="admin-order?action=view" class="admin-sidebar__menu-link">
                                        <i class="admin-sidebar__menu-icon icon-red fa-solid fa-clipboard-list"></i> Quản Lý Đơn Mua
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <div class="col l-10 m-12 c-12">

                            <div class="admin-data-card">
                                <div class="admin-data-card__header">
                                    <div class="admin-data-card__header-title">
                                        <i class="fa-solid fa-book"></i> Quản lý Sản phẩm
                                    </div>
                                    <a href="#" class="btn-action btn-action--add" onclick="openModal('add', null); return false;">
                                        <i class="fa-solid fa-plus"></i> Thêm mới
                                    </a>
                                </div>

                                <div style="margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px dashed #eee;">
                                    <a href="admin-product?action=view&status=1" class="btn ${currentStatus == 1 ? 'btn--primary' : ''}" style="display:inline-flex; border:1px solid var(--primary-color); margin-right: 10px; ${currentStatus == 0 ? 'background-color: #fff; color: var(--primary-color);' : ''}">
                                        Đang Bán
                                    </a>
                                    <a href="admin-product?action=view&status=0" class="btn ${currentStatus == 0 ? 'btn--primary' : ''}" style="display:inline-flex; border:1px solid var(--primary-color); ${currentStatus == 1 ? 'background-color: #fff; color: var(--primary-color);' : ''}">
                                        Thùng Rác
                                    </a>
                                </div>

                                <div class="table-controls">
                                    <div class="table-controls__length">
                                        Tổng cộng: <strong>${totalRecords}</strong> sản phẩm
                                    </div>
                                    <div class="table-controls__search">
                                        <form action="admin-product" method="GET" style="display: flex; align-items: center;">
                                            <input type="hidden" name="action" value="view">
                                            <label style="display: flex; align-items: center;">Search: 
                                                <input type="text" name="keyword" value="${keyword}" placeholder="Tìm tên sản phẩm..." style="margin-left: 8px;">
                                            </label>
                                            <button type="submit" class="btn btn--primary" style="margin-left: 5px; height: 31px; min-width: 50px; font-size: 1.3rem;">Tìm</button>
                                        </form>
                                    </div>
                                </div>

                                <table class="admin-table">
                                    <thead>
                                        <tr>
                                            <th>Mã SP</th>
                                            <th>Tên SP</th>
                                            <th style="text-align: center;">Ảnh</th>
                                            <th>SL</th>
                                            <th>Giá</th>
                                            <th>Loại</th>
                                            <th>Mô tả</th>
                                            <th style="text-align: center;">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.listAdminProduct}" var="p">
                                            <tr>
                                                <td>${p.productID}</td>
                                                <td>${p.productName}</td>
                                                <td style="text-align: center;">
                                                    <img src="${pageContext.request.contextPath}/assets/img/product/${p.image}" class="admin-table-img" alt="img">
                                                </td>
                                                <td>${p.quantity}</td>
                                                <td><fmt:formatNumber value="${p.price}" pattern="#,###"/>đ</td>
                                                <td>${p.categoryID}</td>
                                                <td class="col-desc">${p.describe}</td>

                                                <td>
                                                    <div class="action-btn-group">
                                                        <c:choose>
                                                            <%-- Nếu đang ở trang "Đang Bán" (status = 1) -> Hiện nút Sửa và Xóa --%>
                                                            <c:when test="${currentStatus == 1}">
                                                                <a href="#" class="btn-action btn-action--edit"
                                                                   data-id="${p.productID}"
                                                                   data-name="${p.productName}"
                                                                   data-price="${p.price}"
                                                                   data-quantity="${p.quantity}"
                                                                   data-category="${p.categoryID}"
                                                                   data-describe="${p.describe}"
                                                                   data-image="${p.image}"
                                                                   onclick="openModal('edit', this); return false;">
                                                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                                                </a>

                                                                <a href="admin-product?action=delete&id=${p.productID}" 
                                                                   class="btn-action btn-action--delete"
                                                                   onclick="return confirm('Chuyển sản phẩm [${p.productName}] vào thùng rác?');">
                                                                    <i class="fa-solid fa-trash-can"></i> Xóa
                                                                </a>
                                                            </c:when>

                                                            <%-- Nếu đang ở "Thùng rác" (status = 0) -> Chỉ hiện nút Khôi phục --%>
                                                            <c:otherwise>
                                                                <a href="admin-product?action=restore&id=${p.productID}" class="btn-action btn-action--edit" style="background-color: #28a745;" onclick="return confirm('Khôi phục sản phẩm này để tiếp tục bán?');">
                                                                    <i class="fa-solid fa-rotate-left"></i> Khôi phục
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>

                                <div class="table-footer">
                                    <div class="table-footer__info">
                                        Hiển thị trang ${currentPage} trên tổng số ${totalPages} trang
                                    </div>
                                    <ul class="table-pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li><a href="admin-product?action=view&keyword=${keyword}&page=${currentPage - 1}">Previous</a></li>
                                            </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="${currentPage == i ? 'active' : ''}">
                                                <a href="admin-product?action=view&keyword=${keyword}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li><a href="admin-product?action=view&keyword=${keyword}&page=${currentPage + 1}">Next</a></li>
                                            </c:if>
                                    </ul>
                                </div>

                            </div> </div>
                    </div>
                </div>
            </div>

            <footer id="footer">
                <div class="grid wide">
                    <jsp:include page="../common/footer_header.jsp"></jsp:include>
                    </div>
                <jsp:include page="../common/footer_bottom.jsp"></jsp:include>
                </footer>
            </div>
            <div class="modal" id="productModal" style="display: none;">
                <div class="modal__overlay" onclick="closeModal()"></div>
                <div class="modal__body" style="width: 600px; padding: 20px;">
                    <h2 id="modalTitle" style="font-size: 2rem; margin-bottom: 20px; color: var(--primary-color);">Thêm Sản Phẩm Mới</h2>

                    <form action="admin-product" method="POST" enctype="multipart/form-data" id="productForm">
                        <input type="hidden" name="action" id="formAction" value="add">
                        <input type="hidden" name="productID" id="productID" value="">
                        <input type="hidden" name="oldImage" id="oldImage" value="">

                        <div style="margin-bottom: 15px;">
                            <label style="font-size: 1.4rem; display: block; margin-bottom: 5px;">Tên Sản Phẩm:</label>
                            <input type="text" name="productName" id="productName" required style="width: 100%; padding: 8px; font-size: 1.4rem; border: 1px solid #ccc;">
                        </div>

                        <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
                            <div style="width: 30%;">
                                <label style="font-size: 1.4rem; display: block; margin-bottom: 5px;">Giá (VNĐ):</label>
                                <input type="number" name="price" id="price" required style="width: 100%; padding: 8px; font-size: 1.4rem; border: 1px solid #ccc;">
                            </div>
                            <div style="width: 30%;">
                                <label style="font-size: 1.4rem; display: block; margin-bottom: 5px;">Số lượng:</label>
                                <input type="number" name="quantity" id="quantity" required style="width: 100%; padding: 8px; font-size: 1.4rem; border: 1px solid #ccc;">
                            </div>
                            <div style="width: 30%;">
                                <label style="font-size: 1.4rem; display: block; margin-bottom: 5px;">Danh mục:</label>
                                <select name="categoryID" id="categoryID" required style="width: 100%; padding: 8px; font-size: 1.4rem; border: 1px solid #ccc; outline: none; background-color: #fff; cursor: pointer;">
                                    <option value="" disabled selected>-- Chọn danh mục --</option>

                                <c:forEach items="${listCategories}" var="c">
                                    <option value="${c.categoryID}">${c.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div style="margin-bottom: 15px;">
                        <label style="font-size: 1.4rem; display: block; margin-bottom: 5px;">Hình Ảnh (Chọn từ máy tính):</label>
                        <input type="file" name="imageFile" id="imageFile" accept="image/*" style="font-size: 1.4rem;">
                        <div id="currentImageDisplay" style="margin-top: 5px; font-size: 1.3rem; color: #888; display: none;">
                            Đang dùng ảnh: <strong id="currentImageText"></strong> <i>(Để trống nếu không muốn đổi ảnh)</i>
                        </div>
                    </div>

                    <div style="margin-bottom: 20px;">
                        <label style="font-size: 1.4rem; display: block; margin-bottom: 5px;">Mô tả:</label>
                        <textarea name="describe" id="describe" rows="4" required style="width: 100%; padding: 8px; font-size: 1.4rem; border: 1px solid #ccc;"></textarea>
                    </div>

                    <div style="text-align: right;">
                        <button type="button" class="btn" style="display: inline-block; background-color: #ccc; margin-right: 10px;" onclick="closeModal()">Hủy</button>
                        <button type="submit" class="btn btn--primary" style="display: inline-block;">Lưu Lưu Sản Phẩm</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Hàm bật form popup
            function openModal(mode, btn) {
                document.getElementById('productModal').style.display = 'flex';
                var form = document.getElementById('productForm');
                var actionInput = document.getElementById('formAction');
                var title = document.getElementById('modalTitle');
                var displayImg = document.getElementById('currentImageDisplay');

                if (mode === 'add') {
                    form.reset(); // Xóa sạch chữ
                    actionInput.value = 'add';
                    title.innerText = 'Thêm Sản Phẩm Mới';
                    displayImg.style.display = 'none';
                } else {
                    actionInput.value = 'edit';
                    title.innerText = 'Cập Nhật Sản Phẩm';

                    // Lấy dữ liệu từ cái nút được bấm để điền vào form
                    document.getElementById('productID').value = btn.getAttribute('data-id');
                    document.getElementById('productName').value = btn.getAttribute('data-name');
                    document.getElementById('price').value = parseInt(btn.getAttribute('data-price'));
                    document.getElementById('quantity').value = btn.getAttribute('data-quantity');
                    document.getElementById('categoryID').value = btn.getAttribute('data-category');
                    document.getElementById('describe').value = btn.getAttribute('data-describe');

                    var oldImg = btn.getAttribute('data-image');
                    document.getElementById('oldImage').value = oldImg;

                    if (oldImg) {
                        displayImg.style.display = 'block';
                        document.getElementById('currentImageText').innerText = oldImg;
                    } else {
                        displayImg.style.display = 'none';
                    }
                }
            }

            // Hàm đóng form
            function closeModal() {
                document.getElementById('productModal').style.display = 'none';
            }
        </script>
    </body>
</html>