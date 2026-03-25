<%-- 
    Document   : nav
    Created on : Mar 8, 2026, 12:48:08 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<%@ page import="constant.Constant" %>
<nav class="header__navbar hide-on-mobile-tablet">
    <ul class="header__navbar-list">
        <li class="header__navbar-item header__navbar-item-separate">
            Kênh người bán
        </li>
        <a
            href="#"
            class="header__navbar-item header__navbar-item-separate"
            >Trở thành người bán Shopee</a
        >
        <li
            class="header__navbar-item header__navbar-item--has-qr header__navbar-item-separate"
            >
            Tải ứng dụng

            <!-- start: QR code -->
            <div class="header__qr">
                <img
                    src="${pageContext.request.contextPath}/assets/img/qr_code.png"
                    alt="qr code"
                    class="header__qr-img"
                    />
                <div class="header__qr-apps">
                    <a
                        href="https://apps.apple.com/vn/app/id959841449"
                        target="_blank"
                        class="header__qr-link"
                        >
                        <img
                            src="${pageContext.request.contextPath}/assets/img/app_store.png"
                            alt="App Store"
                            class="header__qr-download-img"
                            />
                    </a>
                    <a
                        href="https://play.google.com/store/apps/details?id=com.shopee.vn&referrer=af_tranid%3Drsx9V4J79OX3NH5LwyqLcw%26pid%3DOrganicA%26c%3Dlp_home_and1"
                        target="_blank"
                        class="header__qr-link"
                        >
                        <img
                            src="${pageContext.request.contextPath}/assets/img/google_play.png"
                            alt="Google Play"
                            class="header__qr-download-img"
                            />
                    </a>
                    <a
                        href="https://appgallery.huawei.com/app/C101433653?sharePrepath=ag&channelId=web&detailType=0"
                        target="_blank"
                        class="header__qr-link"
                        >
                        <img
                            src="${pageContext.request.contextPath}/assets/img/app_gallery.png"
                            alt="App Gallery"
                            class="header__qr-download-img"
                            />
                    </a>
                </div>
            </div>
            <!-- end: QR code -->
        </li>
        <li class="header__navbar-item">
            <span class="header__navbar-title--no-pointer">Kết nối</span>
            <a
                href="https://www.facebook.com/nqminh710"
                target="_blank"
                class="header__navbar-icon-link"
                >
                <i class="header__navbar-icon fa-brands fa-facebook"></i>
            </a>
            <a
                href="https://www.instagram.com"
                target="_blank"
                class="header__navbar-icon-link"
                >
                <i class="header__navbar-icon fa-brands fa-instagram"></i>
            </a>
        </li>
    </ul>
    <ul class="header__navbar-list">
        <li class="header__navbar-item header__navbar-item--has-notify">
            <a href="#" class="header__navbar-item-link">
                <i class="header__navbar-icon fa-regular fa-bell"></i> Thông
                báo
            </a>

            <!-- start: Header Notification-->
            <div class="header__notify">
                <div class="header__notify-main">
                    <img
                        src="${pageContext.request.contextPath}/assets/img/notification.png"
                        alt="Notification"
                        class="header__notify-main-img"
                        />
                    <span class="header__notify-main-suggest">
                        Đăng nhập để xem Thông báo
                    </span>
                </div>
                <div class="header__notify-footer">
                    <a href="#" class="header__notify-footer-item"> Đăng ký </a>
                    <a href="#" class="header__notify-footer-item">
                        Đăng nhập
                    </a>
                </div>
            </div>
            <!-- end: Header Notification-->
        </li>
        <li class="header__navbar-item">
            <a href="#" class="header__navbar-item-link">
                <i
                    class="header__navbar-icon fa-regular fa-circle-question"
                    ></i>
                Hỗ trợ
            </a>
        </li>
        <li class="header__navbar-item header__navbar-item--has-lang">
            <i class="header__navbar-icon fa-solid fa-globe"></i>
            <span class="header__navbar-title">Tiếng Việt</span>

            <!-- start: Header Language -->
            <div class="header__lang">
                <span class="header__lang-item">Tiếng Việt</span>
                <span class="header__lang-item">English</span>
            </div>
            <!-- end: Header Language -->
            <i
                class="header__navbar-icon fa-solid fa-angle-down"
                style="font-size: 12px"
                ></i>
        </li>  
        <c:choose>
            <%-- TRƯỜNG HỢP CHƯA ĐĂNG NHẬP (KHÁCH) --%>
            <c:when test="${sessionScope[Constant.SESSION_USER] == null}">
                <li class="header__navbar-item header__navbar-item--strong header__navbar-item--separate">
                    <a href="authen?action=register" class="header__navbar-item-link">Đăng Ký</a>
                </li>
                <li class="header__navbar-item header__navbar-item--strong">
                    <a href="authen?action=login" class="header__navbar-item-link">Đăng Nhập</a>
                </li>
            </c:when>

            <%-- TRƯỜNG HỢP ĐÃ ĐĂNG NHẬP --%>
            <c:otherwise>
                <li class="header__navbar-item header__navbar-user">

                    <div class="user-wrapper">
                        <span class="header__navbar-user-name">
                            ${sessionScope[Constant.SESSION_USER].fullName}
                        </span>

                        <!-- DROPDOWN -->
                        <ul class="user-menu">
                            

                            <c:if test="${sessionScope[Constant.SESSION_USER].roleID == 1}">
                                <li>
                                    <a href="admin-dashboard" style="color:red;font-weight:bold;">
                                        Quản Lý Hệ Thống
                                    </a>
                                </li>
                            </c:if>
                                <c:if test="${sessionScope[Constant.SESSION_USER].roleID == 2}">
                                <li><a href="profile">Tài Khoản Của Tôi</a></li>
                                <li><a href="user-purchase">Đơn Mua</a></li>
                            </c:if>

                            <li class="separate">
                                <a href="authen?action=logout">Đăng Xuất</a>
                            </li>
                        </ul>
                    </div>

                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>

<script>
    function openModal() {
        document.getElementById("userModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("userModal").style.display = "none";
    }

// click ngoài modal để đóng
    window.onclick = function (event) {
        let modal = document.getElementById("userModal");
        if (event.target === modal) {
            modal.style.display = "none";
        }
    }
</script>