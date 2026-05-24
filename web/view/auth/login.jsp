<%-- 
    Document   : login
    Created on : Mar 16, 2026, 1:25:32 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Shopee</title>
    <link rel="icon" href="${pageContext.request.contextPath}/assets/img/shopee-logo.png" type="image/x-icon" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/grid.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/responsive.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth-page.css">
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/fonts/fontawesome-free-6.1.1/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap$subset=vietnamese" rel="stylesheet" />
</head>
<body>
    <header class="header-auth">
        <div class="grid wide">
            <div class="header-auth__inner">
                <div class="header-auth__logo-wrap">
                    <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/assets/img/shopee-logo-orange.png" alt="Shopee Logo" class="header-auth__logo"></a>
                    <h1 class="header-auth__title">Đăng nhập</h1>
                </div>
                <a href="#" class="header-auth__help">Bạn cần giúp đỡ?</a>
            </div>
        </div>
    </header>

    <div class="auth-content">  
        <div class="grid wide">
            <div class="row auth-content__row">
                <div class="col l-7 m-6 c-0">
                    <div class="auth-content__branding">
                        <img src="${pageContext.request.contextPath}/assets/img/shoppe-logo-white.png" alt="Shopee Logo" class="auth-content__logo-big">
                        <h2 class="auth-content__slogan">Nền tảng thương mại điện tử<br>yêu thích ở Đông Nam Á & Đài Loan</h2>
                    </div>
                </div>

                <div class="col l-5 m-6 c-12">
                    <div class="auth-form auth-form--page">
                        <div class="auth-form__container">
                            <h3 class="auth-form__heading">Đăng nhập</h3>
                             
                            <form autocomplete="off" action="authen?action=login" method="POST">
                                
                                <div style="color: red; font-size: 1.3rem; margin-bottom: 15px; text-align: center;">
                                    ${error}
                                </div>
                                 
                                <input type="text" class="auth-form__input" placeholder="Tên đăng nhập" name="username" required style="margin-bottom: 16px;">
                                
                                <div class="auth-form__input-wrapper">
                                    <input type="password" class="auth-form__input" placeholder="Mật khẩu" id="password" name="password" required style="margin-bottom: 16px;">
                                    <i class="fas fa-eye-slash auth-form__eye-icon" id="togglePassword" style="z-index: 10;"></i>
                                </div>
                                
                                <button type="submit" class="btn btn--primary auth-form__control-btn">ĐĂNG NHẬP</button>
                            </form>
                            <div class="auth-form__help" style="justify-content: flex-start; margin-bottom: 30px; margin-top: 15px;">
                                <a href="#" class="auth-form__help-link">Quên mật khẩu</a>
                            </div>
                            
                        </div>
                        
                        <div class="auth-form__footer">
                            <span class="auth-form__footer-text-suggest">Bạn mới biết đến Shopee?</span>
                            <a href="authen?action=register" class="auth-form__footer-switch-btn" style="text-decoration: none;">Đăng ký</a>
                        </div>
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
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#password');

            if(togglePassword && password) {
                togglePassword.addEventListener('click', function () {
                    const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                    password.setAttribute('type', type);
                    
                    this.classList.toggle('fa-eye');
                    this.classList.toggle('fa-eye-slash');
                });
            }
        });
    </script>
</body>
</html>