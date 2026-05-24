<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Đơn Mua - Staff Shopee</title>
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
                        <c:choose>
                            <c:when test="${empty sessionScope.user.avatar}">
                                <c:set var="avatarSrc" value="${pageContext.request.contextPath}/assets/img/avatar-default.jpg" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="avatarSrc" value="${pageContext.request.contextPath}/assets/img/avatar/${sessionScope.user.avatar}" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${avatarSrc}" alt="Avatar" class="admin-sidebar__user-avatar">
                        <div class="admin-sidebar__user-info">
                            <div class="admin-sidebar__user-name">${sessionScope.user.fullName}</div>
                        </div>
                    </div>

                    <ul class="admin-sidebar__menu">
                        <li class="admin-sidebar__menu-item">
                            <a href="profile" class="admin-sidebar__menu-link">
                                <i class="admin-sidebar__menu-icon fa-regular fa-user"></i> Hồ sơ
                            </a>
                        </li>
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
                        <c:if test="${sessionScope.user.roleID == 1}">
                            <li class="admin-sidebar__menu-item">
                                <a href="admin-account?action=view" class="admin-sidebar__menu-link">
                                    <i class="admin-sidebar__menu-icon icon-green fa-solid fa-users"></i> Quản Lý Tài Khoản
                                </a>
                            </li>
                        </c:if>
                        <li class="admin-sidebar__menu-item admin-sidebar__menu-item--active">
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
                                <i class="fa-solid fa-file-invoice-dollar"></i> Quản lý sản phẩm đã bán
                            </div>
                        </div>

                        <ul class="admin-tabs">
                            <li class="admin-tabs__item ${activeStatus == 'Tất cả' ? 'admin-tabs__item--active' : ''}">
                                <a href="admin-order?action=view" class="admin-tabs__link">Tất cả</a>
                            </li>
                            <li class="admin-tabs__item ${activeStatus == 'Chờ xác nhận' ? 'admin-tabs__item--active' : ''}">
                                <a href="admin-order?action=view&status=Chờ xác nhận" class="admin-tabs__link">Chờ xác nhận</a>
                            </li>
                            <li class="admin-tabs__item ${activeStatus == 'Đang giao' ? 'admin-tabs__item--active' : ''}">
                                <a href="admin-order?action=view&status=Đang giao" class="admin-tabs__link">Đang giao</a>
                            </li>
                            <li class="admin-tabs__item ${activeStatus == 'Hoàn thành' ? 'admin-tabs__item--active' : ''}">
                                <a href="admin-order?action=view&status=Hoàn thành" class="admin-tabs__link">Hoàn thành</a>
                            </li>
                        </ul>

                        <table class="admin-table">
                            <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Sản phẩm</th>
                                <th>Khách hàng</th>
                                <th>Ngày mua</th>
                                <th>SL</th>
                                <th>Thành tiền</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listOrderItems}" var="item">
                                <tr>
                                    <td>#${item.orderId}<br><small>Detail: ${item.detailId}</small></td>
                                    <td>
                                        <div style="display:flex;align-items:center;gap:10px;">
                                            <img src="${pageContext.request.contextPath}/assets/img/product/${item.productImage}" class="admin-table-img" alt="img">
                                            <div>
                                                <strong>${item.productName}</strong><br>
                                                <small>ID: ${item.productId}</small>
                                                <c:if test="${sessionScope.user.roleID == 1}">
                                                    <br><small>Seller: ${item.sellerName}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${item.customerName}<br><small>ID: ${item.customerId}</small></td>
                                    <td><fmt:formatDate value="${item.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>đ</td>
                                    <td>
                                        <form action="admin-order" method="GET" style="display:inline;">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="detailId" value="${item.detailId}">
                                            <select name="status" onchange="this.form.submit()"
                                                    style="padding:5px;border-radius:2px;border:1px solid #ccc;font-size:1.3rem;cursor:pointer;">
                                                <option value="Chờ xác nhận" ${item.status == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
                                                <option value="Đang giao" ${item.status == 'Đang giao' ? 'selected' : ''}>Đang giao</option>
                                                <option value="Hoàn thành" ${item.status == 'Hoàn thành' ? 'selected' : ''}>Hoàn thành</option>
                                            </select>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty listOrderItems}">
                                <tr>
                                    <td colspan="7" style="text-align:center;padding:20px;">Chưa có sản phẩm nào cần xử lý.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
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
</body>
</html>
