<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="home-product-items.jsp"></jsp:include>
<span id="load-more-state" data-next-offset="${nextOffset}" data-has-more="${hasMoreProducts}"></span>
