<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản Lý Tài Khoản - Staff Shopee</title>
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
                                    <div class="admin-sidebar__user-name">${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'Admin'}</div>
                                   
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
                                    <i class="fa-solid fa-users-gear"></i> Danh Sách Tài Khoản
                                </div>

                                <div class="table-controls">
                                    <div class="table-controls__length">
                                        Tổng cộng: <strong>${totalRecords}</strong> tài khoản
                                    </div>
                                    <div class="table-controls__search">
                                        <form action="admin-account" method="GET" style="display: flex; align-items: center;">
                                            <input type="hidden" name="action" value="view">
                                            <label style="display: flex; align-items: center;">Search: 
                                                <input type="text" name="keyword" value="${keyword}" placeholder="Tên đăng nhập, Email..." style="margin-left: 8px;">
                                            </label>
                                            <button type="submit" class="btn btn--primary" style="margin-left: 5px; height: 31px; min-width: 50px; font-size: 1.3rem;">Tìm</button>
                                        </form>
                                    </div>
                                </div>

                                <table class="admin-table">
                                    <thead>
                                        <tr>
                                            <th>ID <i class="fa-solid fa-arrow-down-a-z"></i></th>
                                            <th>Tên đăng nhập <i class="fa-solid fa-arrows-up-down"></i></th>
                                            <th>Họ và Tên</th>
                                            <th>Email <i class="fa-solid fa-arrows-up-down"></i></th>
                                            <th>Vai trò (ID) <i class="fa-solid fa-arrows-up-down"></i></th>
                                            <th>Trạng thái</th>
                                            <th style="text-align: center;">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listAccount}" var="acc">
                                            <tr>
                                                <td>${acc.userID}</td>
                                                <td>${acc.username}</td>
                                                <td>${acc.fullName}</td>
                                                <td>${acc.email}</td>
                                                <td>
                                                    <form action="admin-account" method="POST" style="display:flex;gap:6px;align-items:center;">
                                                        <input type="hidden" name="action" value="updateRole">
                                                        <input type="hidden" name="id" value="${acc.userID}">
                                                        <select name="roleID" style="padding:5px;border:1px solid #ddd;">
                                                            <option value="1" ${acc.roleID == 1 ? 'selected' : ''}>Admin</option>
                                                            <option value="2" ${acc.roleID == 2 ? 'selected' : ''}>Customer</option>
                                                            <option value="3" ${acc.roleID == 3 ? 'selected' : ''}>Staff</option>
                                                        </select>
                                                        <button type="submit" class="btn-action btn-action--edit" style="border:0;">Lưu</button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${acc.activate}"><span style="color:#16833a;font-weight:bold;">Đang hoạt động</span></c:when>
                                                        <c:otherwise><span style="color:#d0011b;font-weight:bold;">Đang bị khóa</span></c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="text-align: center;">
                                                    <c:choose>
                                                        <c:when test="${acc.activate}">
                                                            <a href="admin-account?action=ban&id=${acc.userID}"
                                                               class="btn-action btn-action--delete"
                                                               onclick="return confirm('Bạn có chắc chắn muốn khóa tài khoản này?');">
                                                                <i class="fa-solid fa-lock"></i> Khóa
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="admin-account?action=unban&id=${acc.userID}"
                                                               class="btn-action btn-action--edit"
                                                               onclick="return confirm('Mở khóa tài khoản này?');">
                                                                <i class="fa-solid fa-lock-open"></i> Mở khóa
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
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
                                            <li><a href="admin-account?action=view&keyword=${keyword}&page=${currentPage - 1}">Previous</a></li>
                                            </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="${currentPage == i ? 'active' : ''}">
                                                <a href="admin-account?action=view&keyword=${keyword}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li><a href="admin-account?action=view&keyword=${keyword}&page=${currentPage + 1}">Next</a></li>
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
    </body>
</html>
