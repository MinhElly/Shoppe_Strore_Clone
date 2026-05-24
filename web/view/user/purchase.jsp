<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đơn Mua - Shopee</title>
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

        <div class="profile-container" style="padding-top: 140px;">
            <div class="grid wide">
                <div class="row sm-gutter">
                    <div class="col l-2 m-0 c-0">
                        <div class="admin-sidebar__user">
                            <img src="${pageContext.request.contextPath}/assets/img/avatar-default.jpg" class="admin-sidebar__user-avatar">
                            <div class="admin-sidebar__user-info">
                                <div class="admin-sidebar__user-name">${sessionScope.SESSION_USER.fullName}</div>
                                
                            </div>
                        </div>
                        <ul class="admin-sidebar__menu">
                            <li class="admin-sidebar__menu-item">
                                <a href="#" class="admin-sidebar__menu-link"><i class="admin-sidebar__menu-icon fa-regular fa-user"></i> Hồ sơ</a>
                            </li>
                            <li class="admin-sidebar__menu-item admin-sidebar__menu-item--active">
                                <a href="user-purchase" class="admin-sidebar__menu-link"><i class="admin-sidebar__menu-icon fa-solid fa-clipboard-list" style="color:#d0011b;"></i> Đơn Mua</a>
                            </li>
                        </ul>
                    </div>

                    <div class="col l-10 m-12 c-12">
                        <ul class="admin-tabs">
                            <c:forEach items="${['Tất cả', 'Chờ xác nhận', 'Đang giao', 'Hoàn thành', 'Đã hủy']}" var="s">
                                <li class="admin-tabs__item ${activeStatus == s ? 'admin-tabs__item--active' : ''}">
                                    <a href="user-purchase?status=${s}" class="admin-tabs__link">${s}</a>
                                </li>
                            </c:forEach>
                        </ul>

                        <c:forEach items="${listPurchase}" var="o">
                            <div class="admin-order">
                                <div class="admin-order__header">
                                    <div class="admin-order__shop-info">
                                        <span class="admin-order__label">Đơn hàng #${o.id}</span>
                                        <span style="margin-left: 10px; color: #888;">
                                            <fmt:formatDate value="${o.date}" pattern="dd-MM-yyyy HH:mm" />
                                        </span>
                                    </div>
                                    <div class="admin-order__status">${o.status.toUpperCase()}</div>
                                </div>

                                <div class="admin-order__footer">
                                    <div class="admin-order__total">
                                        Thành tiền: <span class="admin-order__total-price"><fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/>đ</span>
                                    </div>
                                    <div class="admin-order__actions">
                                        <span class="admin-order__note">Trạng thái: ${o.status}</span>
                                        <div class="admin-order__btn-group">
                                            <c:if test="${o.status == 'Hoàn thành'}">
                                                <button class="btn btn--primary admin-order__btn">Mua Lại</button>
                                            </c:if>
                                            <button class="btn admin-order__btn admin-order__btn--outline">Xem Chi Tiết</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty listPurchase}">
                            <div style="background:#fff; padding:80px; text-align:center;">
                                <img src="${pageContext.request.contextPath}/assets/img/no_cart.png" style="width:100px; opacity:0.5;">
                                <p style="font-size:1.6rem; color:#888; margin-top:20px;">Chưa có đơn hàng nào khớp với trạng thái này.</p>
                            </div>
                        </c:if>
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