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
                        <c:choose>
                            <c:when test="${empty sessionScope.user.avatar}">
                                <c:set var="avatarSrc" value="${pageContext.request.contextPath}/assets/img/avatar-default.jpg" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="avatarSrc" value="${pageContext.request.contextPath}/assets/img/avatar/${sessionScope.user.avatar}" />
                            </c:otherwise>
                        </c:choose>
                        <img src="${avatarSrc}" class="admin-sidebar__user-avatar" alt="Avatar">
                        <div class="admin-sidebar__user-info">
                            <div class="admin-sidebar__user-name">${sessionScope.user.fullName}</div>
                        </div>
                    </div>
                    <ul class="admin-sidebar__menu">
                        <li class="admin-sidebar__menu-item">
                            <a href="profile" class="admin-sidebar__menu-link"><i class="admin-sidebar__menu-icon fa-regular fa-user"></i> Hồ sơ</a>
                        </li>
                        <li class="admin-sidebar__menu-item admin-sidebar__menu-item--active">
                            <a href="user-purchase" class="admin-sidebar__menu-link"><i class="admin-sidebar__menu-icon fa-solid fa-clipboard-list" style="color:#d0011b;"></i> Đơn Mua</a>
                        </li>
                    </ul>
                </div>

                <div class="col l-10 m-12 c-12">
                    <ul class="admin-tabs">
                        <li class="admin-tabs__item ${activeStatus == 'Tất cả' ? 'admin-tabs__item--active' : ''}">
                            <a href="user-purchase" class="admin-tabs__link">Tất cả</a>
                        </li>
                        <li class="admin-tabs__item ${activeStatus == 'Chờ xác nhận' ? 'admin-tabs__item--active' : ''}">
                            <a href="user-purchase?status=Chờ xác nhận" class="admin-tabs__link">Chờ xác nhận</a>
                        </li>
                        <li class="admin-tabs__item ${activeStatus == 'Đang giao' ? 'admin-tabs__item--active' : ''}">
                            <a href="user-purchase?status=Đang giao" class="admin-tabs__link">Đang giao</a>
                        </li>
                        <li class="admin-tabs__item ${activeStatus == 'Hoàn thành' ? 'admin-tabs__item--active' : ''}">
                            <a href="user-purchase?status=Hoàn thành" class="admin-tabs__link">Hoàn thành</a>
                        </li>
                    </ul>

                    <c:forEach items="${listPurchaseItems}" var="item">
                        <div class="admin-order">
                            <div class="admin-order__header">
                                <div class="admin-order__shop-info">
                                    <span class="admin-order__label">Đơn hàng #${item.orderId}</span>
                                    <span style="margin-left:10px;color:#888;">
                                        <fmt:formatDate value="${item.orderDate}" pattern="dd-MM-yyyy HH:mm" />
                                    </span>
                                    <span style="margin-left:10px;color:#888;">Người bán: ${item.sellerName}</span>
                                </div>
                                <div class="admin-order__status">${item.status}</div>
                            </div>

                            <div class="admin-order__body">
                                <img src="${pageContext.request.contextPath}/assets/img/product/${item.productImage}" alt="${item.productName}" class="admin-order__img">
                                <div class="admin-order__detail">
                                    <h4 class="admin-order__name">${item.productName}</h4>
                                    <p class="admin-order__variant">Mã sản phẩm: ${item.productId}</p>
                                    <p class="admin-order__qty">x${item.quantity}</p>
                                </div>
                                <div class="admin-order__price">
                                    <fmt:formatNumber value="${item.price}" pattern="#,###"/>đ
                                </div>
                            </div>

                            <div class="admin-order__footer">
                                <div class="admin-order__total">
                                    Thành tiền sản phẩm:
                                    <span class="admin-order__total-price"><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>đ</span>
                                    <span style="margin-left:16px;color:#666;font-size:1.3rem;">Tổng đơn: <fmt:formatNumber value="${item.orderTotal}" pattern="#,###"/>đ</span>
                                </div>
                                <div class="admin-order__actions">
                                    <span class="admin-order__note">Trạng thái sản phẩm: ${item.status}</span>
                                    <div class="admin-order__btn-group">
                                        <c:if test="${item.status == 'Hoàn thành'}">
                                            <button class="btn btn--primary admin-order__btn">Mua Lại</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty listPurchaseItems}">
                        <div style="background:#fff; padding:80px; text-align:center;">
                            <img src="${pageContext.request.contextPath}/assets/img/no_cart.png" style="width:100px; opacity:0.5;">
                            <p style="font-size:1.6rem; color:#888; margin-top:20px;">Chưa có sản phẩm nào khớp với trạng thái này.</p>
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
