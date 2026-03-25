<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản Lý Đơn Mua - Admin Shopee</title>
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
            <i class="fa-solid fa-file-invoice-dollar"></i> Quản lý Đơn mua hệ thống
        </div>
    </div>

    <table class="admin-table">
        <thead>
            <tr>
                <th>Mã Đơn (Bill ID)</th>
                <th>Tên Khách Hàng</th>
                <th>Ngày Mua</th>
                <th>Tổng Tiền</th>
                <th>Trạng Thái</th>
                <th style="text-align: center;">Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${listOrders}" var="o">
                <tr>
                    <td>#${o.id}</td>
                    <td>${o.userName} <br><small style="color: #888;">ID: ${o.userId}</small></td>
                    <td><fmt:formatDate value="${o.date}" pattern="dd/MM/yyyy HH:mm" /></td>
                    <td>
                        <strong style="color: var(--primary-color);">
                            <fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/>đ
                        </strong>
                    </td>
                    <td>
                        <form action="admin-order" method="GET" style="display: inline;">
                            <input type="hidden" name="action" value="updateStatus">
                            <input type="hidden" name="id" value="${o.id}">
                            <select name="status" onchange="this.form.submit()" 
                                    style="padding: 5px; border-radius: 2px; border: 1px solid #ccc; font-size: 1.3rem; cursor: pointer;">
                                <option value="Chờ xác nhận" ${o.status == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác nhận</option>
                                <option value="Đang giao" ${o.status == 'Đang giao' ? 'selected' : ''}>Đang giao</option>
                                <option value="Hoàn thành" ${o.status == 'Hoàn thành' ? 'selected' : ''}>Hoàn thành</option>
                                <option value="Đã hủy" ${o.status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                        </form>
                    </td>
                    <td style="text-align: center;">
                        <a href="admin-order-detail?id=${o.id}" class="btn-action btn-action--edit" title="Xem chi tiết các món hàng">
                            <i class="fa-solid fa-eye"></i> Xem chi tiết
                        </a>
                    </td>
                </tr>
            </c:forEach>
            
            <c:if test="${empty listOrders}">
                <tr>
                    <td colspan="6" style="text-align: center; padding: 20px;">Hệ thống chưa có đơn hàng nào.</td>
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