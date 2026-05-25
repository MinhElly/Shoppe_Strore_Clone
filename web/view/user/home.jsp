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

                        <!-- start: product  -->
                        <div class="home-product" id="goi-y-hom-nay">
                            <div class="home-product__heading">gợi ý hôm nay</div>
                            <div class="home-product__list">
                                <div class="grid__row" id="homeProductGrid">
                                    <jsp:include page="home-product-items.jsp"></jsp:include>
                                </div>
                                <c:if test="${hasMoreProducts}">
                                    <div id="loadMoreWrapper" style="display:flex;justify-content:center;margin:28px 0 8px;">
                                        <a href="home?limit=${nextLimit}&seed=${randomSeed}#goi-y-hom-nay"
                                           id="loadMoreProducts"
                                           class="btn btn--primary"
                                           data-offset="${nextOffset}"
                                           data-seed="${randomSeed}"
                                           style="min-width:220px;">
                                            Bấm để load thêm
                                        </a>
                                    </div>
                                </c:if>
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
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const grid = document.getElementById('homeProductGrid');
                    const wrapper = document.getElementById('loadMoreWrapper');
                    const button = document.getElementById('loadMoreProducts');

                    if (!grid || !wrapper || !button) {
                        return;
                    }

                    button.addEventListener('click', function (event) {
                        event.preventDefault();
                        if (button.dataset.loading === 'true') {
                            return;
                        }

                        button.dataset.loading = 'true';
                        const oldText = button.textContent;
                        button.textContent = 'Đang tải...';

                        const url = 'home?ajax=products&offset='
                                + encodeURIComponent(button.dataset.offset)
                                + '&seed='
                                + encodeURIComponent(button.dataset.seed);

                        fetch(url, {headers: {'X-Requested-With': 'XMLHttpRequest'}})
                                .then(function (response) {
                                    if (!response.ok) {
                                        throw new Error('Load failed');
                                    }
                                    return response.text();
                                })
                                .then(function (html) {
                                    const temp = document.createElement('div');
                                    temp.innerHTML = html;
                                    const state = temp.querySelector('#load-more-state');

                                    if (state) {
                                        button.dataset.offset = state.dataset.nextOffset;
                                        if (state.dataset.hasMore !== 'true') {
                                            wrapper.remove();
                                        }
                                        state.remove();
                                    }

                                    Array.from(temp.children).forEach(function (node) {
                                        grid.appendChild(node);
                                    });
                                })
                                .catch(function () {
                                    window.location.href = button.href;
                                })
                                .finally(function () {
                                    if (document.body.contains(button)) {
                                        button.dataset.loading = 'false';
                                        button.textContent = oldText;
                                    }
                                });
                    });
                });
            </script>
    </body>
</html>
