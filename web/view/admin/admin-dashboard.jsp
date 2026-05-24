<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Khu Vực Staff - Shopee</title>
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
                                    <div class="admin-sidebar__user-name">${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'Nhân viên bán hàng'}</div>
                                    
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

                                <c:if test="${sessionScope.user.roleID == 1}">
                                    <li class="admin-sidebar__menu-item">
                                        <a href="admin-account?action=view" class="admin-sidebar__menu-link">
                                            <i class="admin-sidebar__menu-icon icon-green fa-solid fa-users"></i> Quản Lý Tài Khoản
                                        </a>
                                    </li>
                                </c:if>

                                <li class="admin-sidebar__menu-item">
                                    <a href="admin-order?action=view" class="admin-sidebar__menu-link">
                                        <i class="admin-sidebar__menu-icon icon-red fa-solid fa-clipboard-list"></i> Quản Lý Đơn Mua
                                    </a>
                                </li>
                            </ul>
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
