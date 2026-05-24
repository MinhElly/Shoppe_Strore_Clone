<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - Shopee</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/shopee-logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/grid.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart-page.css">
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-free-6.1.1/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap&subset=vietnamese" rel="stylesheet" />
</head>
<body>
    <header class="header-cart">
        <div class="grid wide">
            <div class="header-cart__inner">
                <div class="header-cart__logo-wrap">
                    <a href="${pageContext.request.contextPath}/home">
                        <img src="${pageContext.request.contextPath}/assets/img/shopee-logo-orange.png" alt="Shopee Logo" class="header-cart__logo" >
                    </a>
                    <h1 class="header-cart__title">Giỏ Hàng</h1>
                </div>
                
                <form action="category" method="GET" class="header-cart__search">
                    <input type="text" name="keyword" value="${keyword}" class="header-cart__search-input" placeholder="Tìm kiếm sản phẩm...">
                    <button type="submit" class="header-cart__search-btn">
                        <i class="fas fa-search header__search-icon"></i>
                    </button>
                </form>
            </div>
        </div>
    </header>

    <div id="container" class="cart-container">
        <div class="grid wide">
            <div class="cart-page">
                
                <c:choose>
                    <%-- TRƯỜNG HỢP 1: GIỎ HÀNG TRỐNG --%>
                    <c:when test="${empty sessionScope.cart}">
                        <div class="cart-empty" style="text-align: center; padding: 80px 0; background-color: var(--white-color); border-radius: 2px; box-shadow: 0 1px 1px 0 rgba(0,0,0,.05);">
                            <img src="${pageContext.request.contextPath}/assets/img/no_cart.png" alt="Empty Cart" style="width: 150px;">
                            <p style="font-size: 1.6rem; color: #757575; margin-top: 15px;">Giỏ hàng của bạn còn trống</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn--primary" style="margin-top: 20px; display: inline-flex; width: 180px; text-decoration: none;">MUA SẮM NGAY</a>
                        </div>
                    </c:when>
                    
                    <%-- TRƯỜNG HỢP 2: CÓ SẢN PHẨM TRONG GIỎ --%>
                    <c:otherwise>
                        <form action="cart" method="POST" id="cart-form">
                            <input type="hidden" name="action" value="checkout">
                            
                            <div class="cart-header">
                                <div class="cart-cell cart-cell--checkbox"><input type="checkbox" class="cart-checkbox" id="check-all-top"></div>
                                <div class="cart-cell cart-cell--product">Sản Phẩm</div>
                                <div class="cart-cell cart-cell--price">Đơn Giá</div>
                                <div class="cart-cell cart-cell--quantity">Số Lượng</div>
                                <div class="cart-cell cart-cell--total">Số Tiền</div>
                                <div class="cart-cell cart-cell--action">Thao Tác</div>
                            </div>

                            <div class="cart-shop">
                                <c:forEach items="${sessionScope.cart}" var="item">
                                    <div class="cart-item">
                                        <div class="cart-cell cart-cell--checkbox">
                                            <input type="checkbox" name="selectedProducts" value="${item.product.productID}" class="cart-checkbox">
                                        </div>
                                        
                                        <div class="cart-cell cart-cell--product">
                                            <div class="cart-item__img" style="background-image: url('${pageContext.request.contextPath}/assets/img/product/${item.product.image}');"></div>
                                            <div class="cart-item__info">
                                                <a href="product-detail?id=${item.product.productID}" class="cart-item__name">${item.product.productName}</a>
                                            </div>
                                        </div>
                                        
                                        <div class="cart-cell cart-cell--price">
                                            <span class="cart-item__price"><fmt:formatNumber value="${item.product.price}" pattern="#,###"/>đ</span>
                                        </div>
                                        
                                        <div class="cart-cell cart-cell--quantity">
                                            <div class="quantity-control">
                                                <button type="button" class="quantity-btn"><i class="fas fa-minus"></i></button>
                                                <input type="text" name="quantity_${item.product.productID}" class="quantity-input" value="${item.quantity}">
                                                <button type="button" class="quantity-btn"><i class="fas fa-plus"></i></button>
                                            </div>
                                        </div>
                                        
                                        <div class="cart-cell cart-cell--total">
                                            <span class="cart-item__total-price"><fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,###"/>đ</span>
                                        </div>
                                        
                                        <div class="cart-cell cart-cell--action">
                                            <a href="cart?action=delete&id=${item.product.productID}" class="cart-item__del-btn" style="text-decoration: none;">Xóa</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="cart-bottom">
                                <div class="cart-bottom__left">
                                    <input type="checkbox" class="cart-checkbox" id="check-all">
                                    <label for="check-all" class="cart-bottom__select-all">Chọn Tất Cả</label>
                                </div>
                                <div class="cart-bottom__right">
                                    <div class="cart-bottom__total-wrap">
                                        <span class="cart-bottom__total-label">Tổng thanh toán (0 sản phẩm):</span>
                                        <span class="cart-bottom__total-price">0đ</span>
                                    </div>
                                    <button type="button" class="btn btn--primary cart-bottom__checkout-btn" id="btn-show-modal">Mua Hàng</button>
                                </div>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="modal" id="success-modal" style="display: none;">
        <div class="modal__overlay"></div>
        <div class="modal__body">
            <div class="success-popup">
                <i class="fas fa-check-circle success-popup__icon"></i>
                <h3 class="success-popup__title">Đặt Hàng Thành Công!</h3>
                <p class="success-popup__desc">Vui lòng chờ admin kiểm tra đơn hàng</p>
                <button type="button" class="btn btn--primary success-popup__btn" id="close-success-btn">OK</button>
            </div>
        </div>
    </div>
    
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const checkAllBtn = document.getElementById('check-all');
        const checkAllTopBtn = document.getElementById('check-all-top');
        const itemCheckboxes = document.querySelectorAll('.cart-item .cart-checkbox');
        const totalDisplay = document.querySelector('.cart-bottom__total-price');
        const totalItemDisplay = document.querySelector('.cart-bottom__total-label');
        const cartForm = document.getElementById('cart-form');
        
        // Modal elements
        const checkoutBtn = document.getElementById('btn-show-modal');
        const successModal = document.getElementById('success-modal');
        const closeSuccessBtn = document.getElementById('close-success-btn');

        // Hàm chuyển đổi tiền tệ: "169.000đ" -> 169000
        function parsePrice(priceStr) {
            return parseInt(priceStr.replace(/\./g, '').replace('đ', ''));
        }

        // Hàm format số thành tiền: 169000 -> "169.000đ"
        function formatPrice(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + "đ";
        }

        // HÀM TÍNH TỔNG TIỀN VÀ CẬP NHẬT GIAO DIỆN
        function calculateTotal() {
            let totalMoney = 0;
            let totalItems = 0;

            const cartItems = document.querySelectorAll('.cart-item');
            cartItems.forEach(item => {
                const checkbox = item.querySelector('.cart-checkbox');
                const priceText = item.querySelector('.cart-item__price').innerText;
                const quantityInput = item.querySelector('.quantity-input');
                
                if(quantityInput) {
                    const price = parsePrice(priceText);
                    const quantity = parseInt(quantityInput.value);

                    // Luôn cập nhật lại Cột Số Tiền (Đơn giá x Số lượng) cho item đó
                    item.querySelector('.cart-item__total-price').innerText = formatPrice(price * quantity);

                    // Nếu được check thì cộng vào Tổng bill
                    if (checkbox.checked) {
                        totalMoney += (price * quantity);
                        totalItems += 1;
                    }
                }
            });

            if(totalDisplay && totalItemDisplay) {
                totalDisplay.innerText = formatPrice(totalMoney);
                totalItemDisplay.innerText = `Tổng thanh toán (${totalItems} sản phẩm):`;
            }

            // Đồng bộ nút Check All
            const allChecked = itemCheckboxes.length > 0 && Array.from(itemCheckboxes).every(cb => cb.checked);
            if(checkAllBtn) checkAllBtn.checked = allChecked;
            if(checkAllTopBtn) checkAllTopBtn.checked = allChecked;
        }

        // CHỌN TẤT CẢ
        function handleCheckAll(e) {
            const isChecked = e.target.checked;
            itemCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            if(checkAllBtn) checkAllBtn.checked = isChecked;
            if(checkAllTopBtn) checkAllTopBtn.checked = isChecked;
            calculateTotal();
        }
        
        if(checkAllBtn) checkAllBtn.addEventListener('change', handleCheckAll);
        if(checkAllTopBtn) checkAllTopBtn.addEventListener('change', handleCheckAll);

        // BẮT SỰ KIỆN TỪNG CHECKBOX
        itemCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', calculateTotal);
        });

        // CHỨC NĂNG TĂNG GIẢM SỐ LƯỢNG
        const quantityControls = document.querySelectorAll('.quantity-control');
        quantityControls.forEach(control => {
            const minusBtn = control.querySelector('.quantity-btn:first-child');
            const plusBtn = control.querySelector('.quantity-btn:last-child');
            const input = control.querySelector('.quantity-input');

            minusBtn.addEventListener('click', function() {
                let currentValue = parseInt(input.value);
                if (currentValue > 1) {
                    input.value = currentValue - 1;
                    calculateTotal();
                }
            });

            plusBtn.addEventListener('click', function() {
                let currentValue = parseInt(input.value);
                input.value = currentValue + 1;
                calculateTotal();
            });

            input.addEventListener('change', function() {
                let currentValue = parseInt(input.value);
                if (isNaN(currentValue) || currentValue < 1) {
                    input.value = 1;
                }
                calculateTotal();
            });
        });

        // XỬ LÝ NÚT MUA HÀNG VÀ MODAL
        if(checkoutBtn) {
            checkoutBtn.addEventListener('click', function() {
                const checkedItems = document.querySelectorAll('.cart-item .cart-checkbox:checked');
                
                if (checkedItems.length === 0) {
                    alert("Bạn vẫn chưa chọn sản phẩm nào để mua.");
                    return; 
                }
                
                // Hiện popup
                successModal.style.display = 'flex';
            });
        }

        if(closeSuccessBtn) {
            closeSuccessBtn.addEventListener('click', function() {
                // Submit form lên Servlet sau khi bấm OK ở popup
                if(cartForm) {
                    cartForm.submit(); 
                }
            });
        }

        // Tính toán lại lần đầu khi mới mở trang
        calculateTotal();
    });
    </script>
</body>
</html>