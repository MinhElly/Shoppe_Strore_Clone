<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:forEach items="${listProduct}" var="p">
    <div class="grid__column-2">
        <a href="product-detail?id=${p.productID}" class="home-product__item">
            <div
                class="home-product__item-img"
                style="background-image: url(${pageContext.request.contextPath}/assets/img/product/${p.image});"
                ></div>
            <p class="home-product__item-content">
                ${p.productName}
            </p>
            <div class="home-product__price-wrapper">
                <span class="home-product__item-price">
                    <fmt:formatNumber value="${p.price}" pattern="#,###" /> đ
                </span>
                <span class="home-product__item-sold">Đã bán ${p.soldQuantity}</span>
            </div>
        </a>
    </div>
</c:forEach>
