<%-- 
    Document   : register
    Created on : Mar 16, 2026, 1:25:41 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Shopee</title>
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
                    <h1 class="header-auth__title">Đăng ký</h1>
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
                            <h3 class="auth-form__heading">Đăng ký</h3>
                             
                            <form action="authen?action=register" method="POST" id="registerForm">
                                
                                <div style="color: red; font-size: 1.3rem; margin-bottom: 15px; text-align: center;">
                                    ${error}
                                </div>
                                 
                                <input type="email" class="auth-form__input" placeholder="Email" name="email" required style="margin-bottom: 16px;">
                                <input type="text" class="auth-form__input" placeholder="Họ và tên" name="fullName" required style="margin-bottom: 16px;">
                                <input type="text" class="auth-form__input" placeholder="Tên đăng nhập" name="username" required style="margin-bottom: 16px;">
                                 
                                <div class="auth-form__input-wrapper" style="margin-bottom: 16px;">
                                    <input type="password" class="auth-form__input" placeholder="Mật khẩu" id="password" name="password" required >
                                    <i class="fas fa-eye-slash auth-form__eye-icon" id="togglePassword" style="z-index: 10;"></i>
                                </div>

                                <div class="auth-form__input-wrapper" style="margin-bottom: 8px;">
                                    <input type="password" class="auth-form__input" placeholder="Xác nhận mật khẩu" id="confirmPassword" name="confirmPassword" required >
                                    <i class="fas fa-eye-slash auth-form__eye-icon" id="toggleConfirmPassword" style="z-index: 10;"></i>
                                </div>
                                
                                <div id="passwordError" style="color: red; font-size: 1.2rem; margin-bottom: 20px; margin-top: 8px; display: none;"></div>
                                
                                <button type="submit" class="btn btn--primary auth-form__control-btn" style="margin-top: 16px;">ĐĂNG KÝ</button>
                                 
                            </form>
                            <div class="auth-form__policy-text" style="margin-top: 30px;">
                                 Bằng việc đăng kí, bạn đã đồng ý với Shopee về 
                                <a href="#" class="auth-form__text-link">Điều khoản dịch vụ</a> & 
                                <a href="#" class="auth-form__text-link">Chính sách bảo mật</a>
                            </div>
                        </div>
                        
                        <div class="auth-form__footer">
                            <span class="auth-form__footer-text-suggest">Bạn đã có tài khoản?</span>
                            <a href="authen?action=login" class="auth-form__footer-switch-btn" style="text-decoration: none;">Đăng nhập</a>
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
            // 1. Xử lý ẩn/hiện mật khẩu (Password)
            const togglePassword = document.querySelector('#togglePassword');
            const passwordInput = document.querySelector('#password');

            if (togglePassword && passwordInput) {
                togglePassword.addEventListener('click', function () {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
                    
                    this.classList.toggle('fa-eye');
                    this.classList.toggle('fa-eye-slash');
                });
            }

            // 2. Xử lý ẩn/hiện xác nhận mật khẩu (Confirm Password)
            const toggleConfirmPassword = document.querySelector('#toggleConfirmPassword');
            const confirmPasswordInput = document.querySelector('#confirmPassword');

            if (toggleConfirmPassword && confirmPasswordInput) {
                toggleConfirmPassword.addEventListener('click', function () {
                    const type = confirmPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    confirmPasswordInput.setAttribute('type', type);
                    
                    this.classList.toggle('fa-eye');
                    this.classList.toggle('fa-eye-slash');
                });
            }

            // 3. Validate form đăng ký trước khi submit
            const registerForm = document.getElementById("registerForm");
            const passwordError = document.getElementById("passwordError");

            if (registerForm) {
                registerForm.addEventListener("submit", function(event) {
                    const passValue = passwordInput.value;
                    const confirmPassValue = confirmPasswordInput.value;
                    
                    // Reset lỗi mỗi lần submit lại
                    passwordError.style.display = "none";
                    passwordInput.style.borderColor = "var(--border-color)";
                    confirmPasswordInput.style.borderColor = "var(--border-color)";

                    // Regex: Tối thiểu 10 ký tự, ít nhất 1 hoa, 1 số, 1 đặc biệt
                    const strongRegex = new RegExp("^(?=.*[A-Z])(?=.*[0-9])(?=.*[\\W_]).{10,}$");

                    // Kiểm tra độ mạnh của mật khẩu
                    if (!strongRegex.test(passValue)) {
                        event.preventDefault(); 
                        passwordError.textContent = "Mật khẩu phải dài ít nhất 10 ký tự, bao gồm chữ hoa, chữ số và ký tự đặc biệt.";
                        passwordError.style.display = "block";
                        passwordInput.style.borderColor = "red";
                        return; // Dừng lại, không kiểm tra tiếp
                    } 

                    // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp nhau không
                    if (passValue !== confirmPassValue) {
                        event.preventDefault();
                        passwordError.textContent = "Mật khẩu xác nhận không khớp.";
                        passwordError.style.display = "block";
                        confirmPasswordInput.style.borderColor = "red";
                        return; // Dừng lại
                    }
                });
            }
        });
    </script>
</body>
</html>