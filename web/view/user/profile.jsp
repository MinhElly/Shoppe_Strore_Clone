<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - Shopee</title>
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
                        <li class="admin-sidebar__menu-item admin-sidebar__menu-item--active">
                            <a href="profile" class="admin-sidebar__menu-link"><i class="admin-sidebar__menu-icon fa-regular fa-user"></i> Hồ sơ</a>
                        </li>
                        <c:if test="${sessionScope.user.roleID == 2}">
                            <li class="admin-sidebar__menu-item">
                                <a href="user-purchase" class="admin-sidebar__menu-link"><i class="admin-sidebar__menu-icon fa-solid fa-clipboard-list"></i> Đơn Mua</a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.roleID == 1 || sessionScope.user.roleID == 3}">
                            <li class="admin-sidebar__menu-item">
                                <a href="admin-dashboard" class="admin-sidebar__menu-link"><i class="admin-sidebar__menu-icon fa-solid fa-store"></i> Kênh bán hàng</a>
                            </li>
                        </c:if>
                    </ul>
                </div>

                <div class="col l-10 m-12 c-12">
                    <div class="admin-data-card">
                        <div class="admin-data-card__header">
                            <div class="admin-data-card__header-title">
                                <i class="fa-regular fa-user"></i> Hồ sơ cá nhân
                            </div>
                        </div>

                        <c:if test="${not empty message}">
                            <div style="background:#f0fff4;color:#16833a;border:1px solid #b7ebc6;padding:12px 16px;margin-bottom:16px;font-size:1.4rem;">${message}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div style="background:#fff4f2;color:#d0011b;border:1px solid #ffd1c8;padding:12px 16px;margin-bottom:16px;font-size:1.4rem;">${error}</div>
                        </c:if>

                        <form action="profile" method="POST" enctype="multipart/form-data" style="display:grid;grid-template-columns:180px 1fr;gap:24px;align-items:start;">
                            <div style="text-align:center;">
                                <img src="${avatarSrc}" alt="Avatar" style="width:120px;height:120px;border-radius:50%;object-fit:cover;border:1px solid #eee;margin-bottom:12px;">
                                <input type="file" name="avatar" accept="image/*" style="font-size:1.3rem;width:100%;">
                            </div>

                            <div>
                                <label style="display:block;font-size:1.4rem;margin-bottom:6px;">Tên đăng nhập</label>
                                <input type="text" value="${profileUser.username}" disabled style="width:100%;padding:10px;border:1px solid #ddd;margin-bottom:14px;font-size:1.4rem;background:#f7f7f7;">

                                <label style="display:block;font-size:1.4rem;margin-bottom:6px;">Họ và tên</label>
                                <input type="text" name="fullName" value="${profileUser.fullName}" required style="width:100%;padding:10px;border:1px solid #ddd;margin-bottom:14px;font-size:1.4rem;">

                                <label style="display:block;font-size:1.4rem;margin-bottom:6px;">Email</label>
                                <input type="email" name="email" value="${profileUser.email}" style="width:100%;padding:10px;border:1px solid #ddd;margin-bottom:14px;font-size:1.4rem;">

                                <label style="display:block;font-size:1.4rem;margin-bottom:6px;">Số điện thoại</label>
                                <input type="text" name="phone" value="${profileUser.phone}" style="width:100%;padding:10px;border:1px solid #ddd;margin-bottom:14px;font-size:1.4rem;">

                                <label style="display:block;font-size:1.4rem;margin-bottom:6px;">Địa chỉ</label>
                                <textarea name="address" rows="3" style="width:100%;padding:10px;border:1px solid #ddd;margin-bottom:18px;font-size:1.4rem;">${profileUser.address}</textarea>

                                <button type="submit" class="btn btn--primary" style="display:inline-flex;">Lưu thay đổi</button>
                            </div>
                        </form>
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
