<%-- 
    Document   : product-detail
    Created on : Mar 16, 2026, 1:27:10 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm - Shopee</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/shopee-logo.png" type="image/x-icon" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/grid.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">
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
          <!-- start: nav -->
          <jsp:include page="../common/nav.jsp"></jsp:include>
          <!-- end: nav -->

          <!-- start: header with search -->
          <jsp:include page="../common/header__with-search.jsp"></jsp:include>
          <!-- end: header with search -->
        </div>
      </header>
    <div id="container">
        <div class="grid wide">
            <div class="product-detail">
                <div class="row sm-gutter">
                    <div class="col l-5 m-12 c-12">
                        <div class="product-detail__images">
                            <div class="product-detail__img-main"
                                 >
                            </div>

                            <div class="product-detail__img-thumbs">
                                <i class="fas fa-chevron-left product-detail__thumb-arrow"></i>
                                <div class="product-detail__thumb-item product-detail__thumb-item--active"
                                    style="background-image: url('${pageContext.request.contextPath}/assets/img/product/${product.image}');">
                                </div>
                                <div class="product-detail__thumb-item"
                                    style="background-image: url('${pageContext.request.contextPath}/assets/img/product/1_${product.image}');">
                                </div>
                                <div class="product-detail__thumb-item"
                                    style="background-image: url('${pageContext.request.contextPath}/assets/img/product/2_${product.image}');">
                                </div>
                                <div class="product-detail__thumb-item"
                                    style="background-image: url('${pageContext.request.contextPath}/assets/img/product/${product.image}');">
                                </div>
                                <div class="product-detail__thumb-item"
                                    style="background-image: url('${pageContext.request.contextPath}/assets/img/product/${product.image}');">
                                </div>
                                <i class="fas fa-chevron-right product-detail__thumb-arrow"></i>
                            </div>
                        </div>
                    </div>

                    <div class="col l-7 m-12 c-12">
                        <div class="product-detail__info">
                            <h1 class="product-detail__title">
                                <span class="product-detail__mall-label">Mall</span>
                                ${product.productName}
                            </h1>

                            <div class="product-detail__stats">
                                <div class="product-detail__rating">
                                    <span class="product-detail__rating-score">4.9</span>
                                    <div class="product-detail__stars">
                                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i><i class="fas fa-star"></i><i
                                            class="fas fa-star"></i>
                                    </div>
                                </div>
                                <div class="product-detail__stat-separate"></div>
                                <div class="product-detail__sold">Đã Bán <span
                                        class="product-detail__stat-number">${product.soldQuantity}</span></div>
                            </div>

                            <div class="product-detail__price-box">
                                <div class="product-detail__price-current">
                                    <fmt:formatNumber value="${product.price}" pattern="#,###" />đ
                                </div>
                            </div>

                            <form action="cart" method="POST" class="product-detail__form">

                                <input type="hidden" name="productId" value="${product.productID}">

                                <div class="product-detail__quantity">
                                    <label class="product-detail__options-label">Số Lượng</label>
                                    <div class="product-detail__quantity-control">
                                        <button type="button" class="product-detail__quantity-btn"><i
                                                class="fas fa-minus"></i></button>

                                        <input type="number" name="quantity" class="product-detail__quantity-input"
                                            value="1" min="1">

                                        <button type="button" class="product-detail__quantity-btn"><i
                                                class="fas fa-plus"></i></button>
                                    </div>
                                    <div class="product-detail__quantity-available">${product.quantity} sản phẩm có sẵn</div>
                                </div>

                                <div class="product-detail__actions">
                                    <button type="submit" name="action" value="add_to_cart"
                                        class="btn product-detail__btn-cart">
                                        <i class="fas fa-cart-plus"></i>
                                        Thêm Vào Giỏ Hàng
                                    </button>

                                    <button type="submit" name="action" value="buy_now"
                                        class="btn btn--primary product-detail__btn-buy">
                                        Mua Ngay
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-description">
                <div class="product-description__header">MÔ TẢ SẢN PHẨM</div>
                <div class="product-description__content">
                    <p>${product.describe}</p>

                </div>
            </div>

            <div class="product-suggestions">
                <div class="product-suggestions__header">CÓ THỂ BẠN CŨNG THÍCH</div>

                <div class="row sm-gutter" id="suggestion-product-list">
                    <c:forEach items="${relatedProducts}" var="rp">
                        <div class="col l-2 m-4 c-6">
                            <a href="product-detail?id=${rp.productID}" class="home-product__item">
                                <div class="home-product__item-img"
                                     style="background-image: url('${pageContext.request.contextPath}/assets/img/product/${rp.image}');">
                                </div>

                                <h4 class="home-product__item-name">${rp.productName}</h4>
                                <div class="home-product__price-wrapper">
                                    <span class="home-product__item-price">
                                        <fmt:formatNumber value="${rp.price}" pattern="#,###" />đ
                                    </span>
                                    <span class="home-product__item-sold">Đã bán ${rp.soldQuantity}</span>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <div class="product-suggestions__footer">
                    <button class="btn product-suggestions__btn-more">Xem thêm</button>
                </div>
            </div>
        </div>
    </div>
               
          
          
    <script src="${pageContext.request.contextPath}/script/main.js"></script>
    <script>
document.addEventListener("DOMContentLoaded", function() {
    
    const mainImg = document.querySelector('.product-detail__img-main');
    const thumbs = document.querySelectorAll('.product-detail__thumb-item');
    const prevBtn = document.querySelector('.product-detail__thumb-arrow:first-child');
    const nextBtn = document.querySelector('.product-detail__thumb-arrow:last-child');
    
    let currentIndex = 0;

    // === MỚI THÊM: KHỞI TẠO ẢNH TO BẰNG ẢNH NHỎ ĐẦU TIÊN ===
    if(thumbs.length > 0) {
        mainImg.style.backgroundImage = thumbs[0].style.backgroundImage;
    }

    // Hàm cập nhật ảnh chính
    function updateMainImage(index) {
        document.querySelector('.product-detail__thumb-item--active').classList.remove('product-detail__thumb-item--active');
        thumbs[index].classList.add('product-detail__thumb-item--active');
        
        mainImg.style.backgroundImage = thumbs[index].style.backgroundImage;
        currentIndex = index;
    }

    // Gắn sự kiện click cho các ảnh nhỏ
    thumbs.forEach((thumb, index) => {
        thumb.addEventListener('click', function() {
            updateMainImage(index);
        });
    });

    // Nút Prev
    prevBtn.addEventListener('click', function() {
        let newIndex = currentIndex - 1;
        if (newIndex < 0) {
            newIndex = thumbs.length - 1; 
        }
        updateMainImage(newIndex);
    });

    // Nút Next
    nextBtn.addEventListener('click', function() {
        let newIndex = currentIndex + 1;
        if (newIndex >= thumbs.length) {
            newIndex = 0; 
        }
        updateMainImage(newIndex);
    });

    // === CODE ZOOM ẢNH ĐÃ FIX LỖI JSP ===
    mainImg.addEventListener('mousemove', function(e) {
        // e.offsetX và e.offsetY lấy chính xác tọa độ chuột bên trong khung ảnh
        let x = (e.offsetX / this.offsetWidth) * 100;
        let y = (e.offsetY / this.offsetHeight) * 100;

        // Bỏ cú pháp để không bị JSP biên dịch lỗi
        this.style.backgroundPosition = x + '% ' + y + '%';
        this.style.backgroundSize = '250%'; // (Khuyên dùng 200% - 250% để ảnh không bị vỡ hạt)
    });

    mainImg.addEventListener('mouseleave', function() {
        this.style.backgroundSize = 'cover';
        this.style.backgroundPosition = 'center';
    });
    // === XỬ LÝ TĂNG GIẢM SỐ LƯỢNG ===
const btns = document.querySelectorAll('.product-detail__quantity-btn');
const minusBtn = btns[0];
const plusBtn = btns[1];
const inputQty = document.querySelector('.product-detail__quantity-input');

// Lấy số lượng từ JSP (fix lỗi null)
const maxQty = Number("${product.quantity}");

if (minusBtn && plusBtn && inputQty) {

    minusBtn.addEventListener('click', function () {
        let current = parseInt(inputQty.value) || 1;
        if (current > 1) {
            inputQty.value = current - 1;
        }
    });

    plusBtn.addEventListener('click', function () {
        let current = parseInt(inputQty.value) || 1;

        if (maxQty <= 0) {
            alert("Sản phẩm đã hết hàng!");
            return;
        }

        if (current < maxQty) {
            inputQty.value = current + 1;
        } else {
            alert("Số lượng đã đạt giới hạn trong kho!");
        }
    });

    inputQty.addEventListener('change', function() {
        let current = parseInt(this.value);

        if (isNaN(current) || current < 1) {
            this.value = 1;
        } else if (current > maxQty) {
            this.value = maxQty;
            alert("Chỉ còn " + maxQty + " sản phẩm trong kho!");
        }
    });
}

});
</script>
</body>

</html> 