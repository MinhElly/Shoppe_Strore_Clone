<%-- 
    Document   : home
    Created on : Mar 8, 2026, 12:20:18 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>
            Shopee Việt Nam | Mua và Bán Trên Ứng Dụng Di Động Hoặc Website
        </title>
        <link rel="icon" href="${pageContext.request.contextPath}/assets/img/shopee-logo.png" type="image/x-icon" />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"
            />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/grid.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/assets/fonts/fontawesome-free-6.1.1/css/all.min.css"
            />
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap$subset=vietnamese"
            rel="stylesheet"
            />
    </head>

    <body>
        <!-- start: app -->
        <div class="app">
            <!-- start: header -->
            <header id="header">
                <div class="grid wide">
                    <!-- start: nav -->
                    <jsp:include page="../common/nav.jsp"></jsp:include>
                        <!-- end: nav -->

                        <!-- start: header with search -->
                    <jsp:include page="../common/header__with-search.jsp"></jsp:include>
                        <!-- end: header with search -->
                    </div>
                </header>
                <!-- end: header -->

                <!-- start: container -->
                <div id="container">
                    <!-- start: container heading -->
                    <div class="container__heading">
                        <div class="grid wide">
                            <!-- start: home-banner -->
                            <div class="home-banner grid__row">
                                <div class="main-banner grid__column-8">
                                    <ul class="main-banner__list">
                                        <li class="main-banner__item">
                                            <a href="#" class="main-banner__item-link">
                                                <img
                                                    src="${pageContext.request.contextPath}/assets/img/main-banner/banner-0.jpg"
                                                alt="Main Banner"
                                                class="main-banner__item-img"
                                                />
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div
                                class="right-banner-wrapper grid__column-4 hide-on-mobile-tablet"
                                >
                                <div class="sub-banner">
                                    <a href="#" class="sub-banner__link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/right-side-banner/banner-0.png"
                                            alt="Right Banner"
                                            class="sub-banner__img"
                                            />
                                    </a>
                                </div>
                                <div class="sub-banner">
                                    <a href="#" class="sub-banner__link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/right-side-banner/banner-1.png"
                                            alt="Right Banner"
                                            class="sub-banner__img"
                                            />
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- end: home-banner -->

                        <!-- start: suggestion category -->
                        <div class="suggestion-category">
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/sale-time.gif"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">
                                    khung giờ săn sale
                                </p>
                            </a>
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/cheap.png"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">
                                    gì cũng rẻ - mua là freeship
                                </p>
                            </a>
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/freeship-xtra.png"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">
                                    thứ 4 freeship - x4 Ưu đãi
                                </p>
                            </a>
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/cashback.png"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">
                                    hoàn xu 6% - lên đến 200K
                                </p>
                            </a>
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/nice-price-good.png"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">
                                    hàng hiệu giá tốt
                                </p>
                            </a>
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/international-goods.png"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">hàng quốc tế</p>
                            </a>
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/digital-product.png"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">
                                    nạp thẻ, hoá đơn & phim
                                </p>
                            </a>
                            <a href="#" class="suggestion-category__item">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/suggestion-category/deal-1k.png"
                                    alt="Icon"
                                    class="suggestion-category__item-icon"
                                    />
                                <p class="suggestion-category__item-content">deal sốc từ 1K</p>
                            </a>
                        </div>
                        <!-- end: suggestion category -->
                    </div>
                    <!-- end: grid -->
                </div>
                <!-- end: container heading -->

                <!-- start: container body -->
                <div class="container__body">
                    <div class="grid wide">
                        <!-- start: welcome banner -->
<!--                        <div class="welcome-banner">
                            <a href="#" class="welcome-banner__link">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/welcome_banner.png"
                                    alt="Welcome Banner"
                                    class="welcome-banner__img"
                                    />
                            </a>
                        </div>-->
                        <!-- end: welcome banner -->

                        <!-- start: main category -->
                        <div class="main-category">
                            <div class="main-category__heading">danh mục</div>
                            <div class="main-category__list">
                                <c:forEach items="${sessionScope.listCategory}" var="category">
                                    <div class="main-category__item">
                                        <a href="category?cid=${category.categoryID}" class="main-category__item-link">
                                            <img
                                                src="${pageContext.request.contextPath}/assets/img/main-category/${category.categoryName}.png"
                                                alt="Main Category item img"
                                                class="main-category__img"
                                                />
                                            <div class="main-category__content">${category.categoryName}</div>
                                        </a>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                        <!-- end: main category -->

                        <!-- start: flash-sale -->
                        <div class="flash-sale">
                            <div class="flash-sale__header">
                                <img
                                    src="${pageContext.request.contextPath}/assets/img/flash-sale/flash-sale-icon.png"
                                    alt="Flash Sale"
                                    class="flash-sale__header-img"
                                    />
                                <div class="flash-sale__header-countdown">
                                    <div class="flash-sale__countdown-item">
                                        <div class="flash-sale__countdown-item-content">00</div>
                                    </div>
                                    <div class="flash-sale__countdown-item">
                                        <div class="flash-sale__countdown-item-content">00</div>
                                    </div>
                                    <div class="flash-sale__countdown-item">
                                        <div class="flash-sale__countdown-item-content">00</div>
                                    </div>
                                </div>
                                <a href="#" class="flash-sale__view-all">
                                    Xem tất cả
                                    <i
                                        class="flash-sale__view-all-icon fa-solid fa-angle-right"
                                        ></i>
                                </a>
                            </div>
                            <div class="flash-sale__product grid__row">
                                <div class="flash-sale__item grid__column-2">
                                    <a href="#" class="flash-sale__item-link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/flash-sale/selrun.png"
                                            alt="Flash Sale"
                                            class="flash-sale__item-img"
                                            />
                                        <p class="flash-sale__item-price">₫79.000</p>
                                        <div class="flash-sale__item-progress">
                                            <div
                                                class="flash-sale__progress-state"
                                                style="left: 90px"
                                                ></div>
                                            <span class="flash-sale__progress-text"> đã bán 53 </span>
                                        </div>
                                    </a>
                                </div>
                                <div class="flash-sale__item grid__column-2">
                                    <a href="#" class="flash-sale__item-link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/flash-sale/t-shirt.jpg"
                                            alt="Flash Sale"
                                            class="flash-sale__item-img"
                                            />
                                        <p class="flash-sale__item-price">₫259.000</p>
                                        <div class="flash-sale__item-progress">
                                            <div
                                                class="flash-sale__progress-state"
                                                style="left: 55px"
                                                ></div>
                                            <span class="flash-sale__progress-text"> đã bán 5 </span>
                                        </div>
                                    </a>
                                </div>
                                <div class="flash-sale__item grid__column-2">
                                    <a href="#" class="flash-sale__item-link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/flash-sale/rice-cooker.jpg"
                                            alt="Flash Sale"
                                            class="flash-sale__item-img"
                                            />
                                        <p class="flash-sale__item-price">₫1.059.000</p>
                                        <div class="flash-sale__item-progress">
                                            <div
                                                class="flash-sale__progress-state"
                                                style="left: 23px"
                                                ></div>
                                            <span class="flash-sale__progress-text"> đã bán 3 </span>
                                        </div>
                                    </a>
                                </div>
                                <div class="flash-sale__item grid__column-2">
                                    <a href="#" class="flash-sale__item-link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/flash-sale/case.jpg"
                                            alt="Flash Sale"
                                            class="flash-sale__item-img"
                                            />
                                        <p class="flash-sale__item-price">₫1.000</p>
                                        <div class="flash-sale__item-progress">
                                            <div
                                                class="flash-sale__progress-state"
                                                style="left: 120px"
                                                ></div>
                                            <span class="flash-sale__progress-text">
                                                đã bán 189
                                            </span>
                                        </div>
                                    </a>
                                </div>
                                <div class="flash-sale__item grid__column-2">
                                    <a href="#" class="flash-sale__item-link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/flash-sale/oreo.png"
                                            alt="Flash Sale"
                                            class="flash-sale__item-img"
                                            />
                                        <p class="flash-sale__item-price">₫46.000</p>
                                        <div class="flash-sale__item-progress">
                                            <div
                                                class="flash-sale__progress-state"
                                                style="left: 22px"
                                                ></div>
                                            <span class="flash-sale__progress-text"> đã bán 16 </span>
                                        </div>
                                    </a>
                                </div>
                                <div class="flash-sale__item grid__column-2">
                                    <a href="#" class="flash-sale__item-link">
                                        <img
                                            src="${pageContext.request.contextPath}/assets/img/flash-sale/cap.jpg"
                                            alt="Flash Sale"
                                            class="flash-sale__item-img"
                                            />
                                        <p class="flash-sale__item-price">₫1.000</p>
                                        <div class="flash-sale__item-progress">
                                            <div
                                                class="flash-sale__progress-state"
                                                style="left: 14px"
                                                ></div>
                                            <span class="flash-sale__progress-text"> đã bán 4 </span>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <!-- end: flash-sale -->

                        <!-- start: product  -->
                        <div class="home-product">
                            <div class="home-product__heading">gợi ý hôm nay</div>
                            <div class="home-product__list">
                                <div class="grid__row">
                                    <c:forEach items="${listProduct}" var="p">
                                        <div class="grid__column-2">
                                            <a href="product-detail?id=${p.productID}" class="home-product__item">
                                                <div
                                                    class="home-product__item-img"
                                                    style="
                                                    background-image: url(${pageContext.request.contextPath}/assets/img/product/${p.image});
                                                    "
                                                    ></div>
                                                <p class="home-product__item-content">
                                                    ${p.productName}
                                                </p>
                                                <div class="home-product__price-wrapper">
                                                    <span class="home-product__item-price">
                                                        <fmt:formatNumber value="${p.price}" pattern="#,###" /> đ
                                                    </span>
                                                    <span class="home-product__item-sold">Đã bán ${p.soldQuantity}</span>
<!--                                                    <span class="home-product__item-sold">Số lượng ${p.quantity}</span>-->
                                                </div>

                                            </a>
                                        </div>
                                    </c:forEach>

                                </div>
                                <!-- start: paginations -->
                                <ul class="pagination home-product__pagination">
    
                                    <li class="pagination-item">
                                        <a href="${currentPage > 1 ? 'home?page=' += (currentPage - 1) : '#'}" class="pagination-item__link">
                                            <i class="fa-solid fa-chevron-left"></i>
                                        </a>
                                    </li>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="pagination-item ${currentPage == i ? 'pagination-item--active' : ''}">
                                            <a href="home?page=${i}" class="pagination-item__link">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <li class="pagination-item">
                                        <a href="${currentPage < totalPages ? 'home?page=' += (currentPage + 1) : '#'}" class="pagination-item__link">
                                            <i class="fa-solid fa-chevron-right"></i>
                                        </a>
                                    </li>

                                </ul>
                                <!-- end: paginations -->
                            </div>
                        </div>
                        <!-- end: product  -->
                    </div>
                    <!-- end: grid -->
                </div>
                <!-- end: container body -->
            </div>
            <!-- end: container -->

            <!-- start: footer -->
            <footer id="footer">
                <div class="grid wide">
                    <jsp:include page ="../common/footer_header.jsp"></jsp:include>
                    </div>

                    <!-- start: footer bottom -->
                    <jsp:include page="../common/footer_bottom.jsp"></jsp:include>
                    <!-- end: footer bottom -->
                </footer>
                <!-- end: footer -->
            </div>
            <!-- end: app -->

            
            <script src="${pageContext.request.contextPath}/script/main.js"></script>
    </body>
</html>
