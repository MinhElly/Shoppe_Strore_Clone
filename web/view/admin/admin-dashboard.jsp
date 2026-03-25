<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Khu Vực Quản Trị - Shopee</title>
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
                                    <div class="admin-sidebar__user-name">${sessionScope.SESSION_USER.fullName != null ? sessionScope.SESSION_USER.fullName : 'Admin Nguyễn Văn A'}</div>
                                    
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

<!--                        <div class="col l-10 m-12 c-12">

                            <ul class="admin-tabs">
                                <li class="admin-tabs__item admin-tabs__item--active"><a href="#" class="admin-tabs__link">Tất cả</a></li>
                                <li class="admin-tabs__item"><a href="#" class="admin-tabs__link">Chờ thanh toán</a></li>
                                <li class="admin-tabs__item"><a href="#" class="admin-tabs__link">Vận chuyển</a></li>
                                <li class="admin-tabs__item"><a href="#" class="admin-tabs__link">Chờ giao hàng</a></li>
                                <li class="admin-tabs__item"><a href="#" class="admin-tabs__link">Hoàn thành</a></li>
                                <li class="admin-tabs__item"><a href="#" class="admin-tabs__link">Đã hủy</a></li>
                                <li class="admin-tabs__item"><a href="#" class="admin-tabs__link">Trả hàng/Hoàn tiền</a></li>
                            </ul>

                            <div class="admin-search">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                <input type="text" placeholder="Bạn có thể tìm kiếm theo tên Shop, ID đơn hàng hoặc Tên Sản phẩm">
                            </div>

                            <div class="admin-order">
                                <div class="admin-order__header">
                                    <div class="admin-order__shop-info">
                                        <span class="admin-order__label">Yêu thích</span> Linh Kiện Điện Tử ViNa
                                    </div>
                                    <div class="admin-order__status">
                                        <i class="fa-solid fa-truck" style="color:#00bfa5; margin-right:5px;"></i> <span style="color:#00bfa5;">Giao hàng thành công</span> | HOÀN THÀNH
                                    </div>
                                </div>
                                <div class="admin-order__body">
                                    <img src="${pageContext.request.contextPath}/assets/img/product/lcd1.jpg" alt="Product" class="admin-order__img">
                                    <div class="admin-order__detail">
                                        <h4 class="admin-order__name">Màn hình LCD 1602 2004 5V xanh lá/xanh dương Có Đèn Nền - Kèm I2C</h4>
                                        <p class="admin-order__variant">Phân loại hàng: LCD X.Lá + I2C Đã Hàn</p>
                                        <p class="admin-order__qty">x1</p>
                                    </div>
                                    <div class="admin-order__price">51.972đ</div>
                                </div>
                                <div class="admin-order__footer">
                                    <div class="admin-order__total">
                                        Thành tiền: <span class="admin-order__total-price">51.972đ</span>
                                    </div>
                                    <div class="admin-order__actions">
                                        <span class="admin-order__note">Đánh giá sản phẩm trước 31-03-2026<br><span style="color:var(--primary-color);">Đánh giá ngay và nhận 200 Xu</span></span>
                                        <div class="admin-order__btn-group">
                                            <button class="btn btn--primary admin-order__btn">Xác Nhận Đơn</button>
                                            <button class="btn admin-order__btn admin-order__btn--outline">Liên Hệ Người Mua</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="admin-order">
                                <div class="admin-order__header">
                                    <div class="admin-order__shop-info">
                                        <span class="admin-order__label">Yêu thích</span> Thế Giới Linh Kiện LiKi
                                    </div>
                                    <div class="admin-order__status admin-order__status--cancel">ĐÃ HỦY</div>
                                </div>
                                <div class="admin-order__body">
                                    <img src="${pageContext.request.contextPath}/assets/img/product/lcd2.jpg" alt="Product" class="admin-order__img">
                                    <div class="admin-order__detail">
                                        <h4 class="admin-order__name">Màn Hình LCD 1602 Xanh Lá, Xanh Dương, Mạch chuyển đổi I2C</h4>
                                        <p class="admin-order__variant">Phân loại hàng: X.lá + I2c Đã Hàn</p>
                                        <p class="admin-order__qty">x1</p>
                                    </div>
                                    <div class="admin-order__price">51.972đ</div>
                                </div>
                                <div class="admin-order__footer">
                                    <div class="admin-order__total">
                                        Thành tiền: <span class="admin-order__total-price">51.972đ</span>
                                    </div>
                                    <div class="admin-order__actions">
                                        <span class="admin-order__note">Đã hủy bởi bạn</span>
                                        <div class="admin-order__btn-group">
                                            <button class="btn btn--primary admin-order__btn">Xem Chi Tiết</button>
                                            <button class="btn admin-order__btn admin-order__btn--outline">Xem Thông Tin Hủy</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>-->
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