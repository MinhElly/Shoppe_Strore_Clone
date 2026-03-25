    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <fmt:setLocale value="vi_VN" />

    <!DOCTYPE html>
    <html lang="vi">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Danh mục sản phẩm</title>
            <link rel="icon" href="${pageContext.request.contextPath}/assets/img/shopee-logo.png" type="image/x-icon" />
            <link
                rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"
                />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/grid.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/category.css">

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
            <header id="header">
                <div class="grid wide">
                    <jsp:include page="../common/nav.jsp"></jsp:include>
                    <jsp:include page="../common/header__with-search.jsp"></jsp:include>
                    </div>
                </header>
                <div class="app">
                    <div id="container">
                        <div class="grid wide">
                            <div class="row sm-gutter">

                                <div class="col l-2 m-0 c-0">

                                    <div class="filter-panel">
                                        <h3 class="category__heading" style="padding-left:0; font-weight: 700;">
                                            <i class="fas fa-filter category__heading-icon"></i> BỘ LỌC TÌM KIẾM
                                        </h3>

                                        <form action="category" method="GET">
                                            <input type="hidden" name="cid" value="${tag}">
                                                <input type="hidden" name="keyword" value="${keyword}">
                                        <input type="hidden" name="sort" value="${currentSort}">

                                        <div class="filter-group">
                                            <h4 class="filter-group__heading">Khoảng Giá</h4>
                                            <div class="filter-price">
                                                <input type="number" name="minPrice" class="filter-price__input" placeholder="₫ TỪ" value="${minPrice}" min="0">

                                                <div class="filter-price__line"></div>

                                                <input type="number" name="maxPrice" class="filter-price__input" placeholder="₫ ĐẾN" value="${maxPrice}" min="0">
                                            </div>

                                            <button type="submit" class="btn btn--primary filter-btn-apply">ÁP DỤNG</button>
                                        </div>
                                    </form>

                                    <div class="filter-group">
                                        <a href="category?cid=${tag}&keyword=${keyword}" class="btn btn--primary filter-btn-apply" style="margin-top: 20px; text-decoration: none; text-align: center; display: block; line-height: 34px;">XÓA TẤT CẢ</a>
                                    </div>
                                </div>  
                            </div>

                            <div class="col l-10 m-12 c-12">

                                <div class="home-filter hide-on-mobile-tablet">
                                    <span class="home-filter__label">Sắp xếp theo</span>

                                    <a href="category?keyword=${keyword}&cid=${tag}&sort=pop&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                       class="btn home-filter__btn ${currentSort == 'pop' || empty currentSort ? 'btn--primary' : ''}">Phổ Biến</a>

                                    <a href="category?keyword=${keyword}&cid=${tag}&sort=new&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                       class="btn home-filter__btn ${currentSort == 'new' ? 'btn--primary' : ''}">Mới Nhất</a>

                                    <a href="category?keyword=${keyword}&cid=${tag}&sort=bestseller&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                       class="btn home-filter__btn ${currentSort == 'bestseller' ? 'btn--primary' : ''}">Bán Chạy</a>

                                    <div class="home-filter__select">
                                        <span class="home-filter__select-label">
                                            ${currentSort == 'priceAsc' ? 'Giá: Thấp đến Cao' : (currentSort == 'priceDesc' ? 'Giá: Cao đến Thấp' : 'Giá')}
                                        </span>
                                        <i class="fas fa-chevron-down"></i>

                                        <ul class="home-filter__select-list">
                                            <li class="home-filter__select-item">
                                                <a href="category?keyword=${keyword}&cid=${tag}&sort=priceAsc&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                                   class="home-filter__select-link ${currentSort == 'priceAsc' ? 'home-filter__select-link--active' : ''}">
                                                    Giá: Thấp đến Cao
                                                </a>
                                            </li>
                                            <li class="home-filter__select-item">
                                                <a href="category?keyword=${keyword}&cid=${tag}&sort=priceDesc&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                                   class="home-filter__select-link ${currentSort == 'priceDesc' ? 'home-filter__select-link--active' : ''}">
                                                    Giá: Cao đến Thấp
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="home-product">
                                    <div class="row sm-gutter">

                                        <c:forEach items="${listP}" var="p">
                                            <div class="col l-2 m-4 c-6">
                                                <a class="home-product__item" href="product-detail?id=${p.productID}">
                                                    <div class="home-product__item-img" style="background-image: url('${pageContext.request.contextPath}/assets/img/product/${p.image}');"></div>
                                                    <h4 class="home-product__item-name">${p.productName}</h4>
                                                    <div class="home-product__price-wrapper">
                                                        <span class="home-product__item-price">
                                                            <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
                                                        </span>
                                                        <span class="home-product__item-sold">Đã bán ${p.soldQuantity}</span>
                                                    </div>
                                                </a>
                                            </div>
                                        </c:forEach>

                                    </div>
                                </div>

                                <ul class="pagination home-product__pagination">
                                    <li class="pagination-item">
                                        <a href="${currentPage > 1 ? 'category?cid=' += tag += '&page=' += (currentPage - 1) : '#'}" class="pagination-item__link">
                                            <i class="fas fa-angle-left"></i>
                                        </a>
                                    </li>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="pagination-item ${currentPage == i ? 'pagination-item--active' : ''}">
                                            <a href="category?cid=${tag}&page=${i}" class="pagination-item__link">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <li class="pagination-item">
                                        <a href="${currentPage < totalPages ? 'category?cid=' += tag += '&page=' += (currentPage + 1) : '#'}" class="pagination-item__link">
                                            <i class="fas fa-angle-right"></i>
                                        </a>
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <footer id="footer">
                <div class="grid wide">
                    <jsp:include page ="../common/footer_header.jsp"></jsp:include>
                    </div>

                <jsp:include page="../common/footer_bottom.jsp"></jsp:include>
            </footer>
        </body>
    </html>