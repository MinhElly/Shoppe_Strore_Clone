# Shoppee_Store - Java Web Shopping

Shoppee_Store là website bán hàng mô phỏng giao diện và một số luồng nghiệp vụ cơ bản của Shopee. Dự án được xây dựng theo mô hình MVC với Java Servlet, JSP, JSTL, JDBC và SQL Server.

Dự án phù hợp cho bài thực hành Java Web/PRJ301: người dùng có thể xem sản phẩm, tìm kiếm, thêm vào giỏ hàng và đặt mua; admin có thể quản lý sản phẩm, tài khoản và đơn hàng.

## Công nghệ sử dụng

- Java Servlet/JSP với Jakarta EE
- JSTL
- JDBC
- SQL Server
- Apache Tomcat 10.1
- Apache NetBeans IDE
- Ant build
- HTML, CSS, JavaScript
- Font Awesome

## Chức năng chính

### Người dùng

- Đăng ký tài khoản
- Đăng nhập/đăng xuất
- Xem danh sách sản phẩm
- Xem sản phẩm theo danh mục
- Tìm kiếm sản phẩm
- Lọc sản phẩm theo khoảng giá
- Sắp xếp sản phẩm theo mới nhất, bán chạy, giá tăng/giảm
- Xem chi tiết sản phẩm
- Thêm sản phẩm vào giỏ hàng
- Xem, chọn, cập nhật số lượng và xóa sản phẩm trong giỏ hàng
- Thanh toán các sản phẩm đã chọn
- Xem danh sách đơn mua

### Admin

- Xem trang dashboard
- Quản lý sản phẩm
- Thêm sản phẩm mới
- Cập nhật thông tin sản phẩm
- Xóa mềm sản phẩm bằng trạng thái `status`
- Khôi phục sản phẩm đã xóa mềm
- Quản lý tài khoản người dùng
- Khóa tài khoản người dùng
- Quản lý đơn hàng
- Cập nhật trạng thái đơn hàng

## Cấu trúc dự án

```text
Shoppee_Store/
├─ src/java/
│  ├─ controller/
│  │  ├─ auth/             # Servlet xử lý đăng nhập, đăng ký, đăng xuất
│  │  ├─ user/             # Servlet xử lý trang người dùng
│  │  └─ admin/            # Servlet xử lý trang quản trị
│  ├─ service/             # Tầng xử lý nghiệp vụ, chuẩn bị cho mở rộng
│  ├─ dal/                 # DAO và kết nối database bằng JDBC
│  ├─ model/               # Entity/model: User, Product, Order, Category...
│  ├─ dto/                 # Object trung gian giữa tầng xử lý và view/API
│  ├─ filter/              # Filter đăng nhập, phân quyền
│  ├─ util/                # Tiện ích dùng chung
│  └─ constant/            # Hằng số dùng chung
│
├─ web/
│  ├─ view/
│  │  ├─ auth/             # login.jsp, register.jsp
│  │  ├─ user/             # home, category, product detail, cart, purchase
│  │  ├─ admin/            # giao diện quản trị
│  │  └─ common/           # header, nav, footer
│  ├─ assets/              # CSS, ảnh, font, icon
│  ├─ script/              # JavaScript
│  └─ WEB-INF/             # web.xml, cấu hình database
│
├─ lib/                    # Thư viện jar
├─ nbproject/              # Cấu hình NetBeans
├─ build.xml               # Ant build file
└─ Shoppe_DB.sql           # Script tạo database và dữ liệu mẫu
```

## Một số route chính

| Route | Chức năng |
| --- | --- |
| `/home` | Trang chủ |
| `/authen?action=login` | Trang đăng nhập |
| `/authen?action=register` | Trang đăng ký |
| `/category` | Tìm kiếm, lọc, sắp xếp sản phẩm |
| `/product-detail?id={id}` | Chi tiết sản phẩm |
| `/cart?action=view` | Giỏ hàng |
| `/cart?action=checkout` | Thanh toán |
| `/user-purchase` | Đơn mua của người dùng |
| `/admin-dashboard` | Dashboard admin |
| `/admin-product?action=view` | Quản lý sản phẩm |
| `/admin-account?action=view` | Quản lý tài khoản |
| `/admin-order?action=view` | Quản lý đơn hàng |

## Database

Dự án sử dụng SQL Server. File database mẫu nằm ở:

```text
Shoppe_DB.sql
```

Các bảng chính:

- `User`: thông tin tài khoản người dùng
- `Role`: vai trò tài khoản, ví dụ admin/user
- `Category`: danh mục sản phẩm
- `Product`: thông tin sản phẩm
- `ProductImage`: ảnh phụ của sản phẩm
- `Order`: đơn hàng
- `OrderDetail`: chi tiết đơn hàng

Tài khoản mẫu trong script database:

```text
Admin:
username: admin
password: 1
```

## Cấu hình database

Sửa file:

```text
web/WEB-INF/ConnectDB.properties
```

Ví dụ:

```properties
url=jdbc:sqlserver://localhost:1433;databaseName=Shopee;trustServerCertificate=true
userID=sa
password=123
```

Lưu ý: thông tin `userID` và `password` cần đổi theo SQL Server trên máy của bạn.

## Hướng dẫn chạy dự án

### 1. Clone hoặc tải project

```bash
git clone <repository-url>
```

### 2. Mở project bằng NetBeans

- Mở Apache NetBeans
- Chọn `File` -> `Open Project`
- Chọn thư mục `Shoppee_Store`

### 3. Tạo database

- Mở SQL Server Management Studio hoặc công cụ tương đương
- Chạy file `Shoppe_DB.sql`
- Kiểm tra database `Shopee` đã được tạo

### 4. Cấu hình kết nối database

- Mở `web/WEB-INF/ConnectDB.properties`
- Sửa `url`, `userID`, `password` cho đúng môi trường máy bạn

### 5. Cấu hình server

- Sử dụng Apache Tomcat 10.1
- Đảm bảo project đang dùng JDK phù hợp với cấu hình NetBeans
- Các thư viện cần thiết đã nằm trong thư mục `lib/`

### 6. Chạy project

Chạy project trong NetBeans, sau đó truy cập:

```text
http://localhost:<port>/Shoppee_Store/home
```

Ví dụ:

```text
http://localhost:8080/Shoppee_Store/home
```

## Thư viện trong `lib/`

- `jakarta.servlet.jsp.jstl-2.0.0.jar`
- `jakarta.servlet.jsp.jstl-api-2.0.0.jar`
- `jaxb-api-2.1.jar`
- `mssql-jdbc-13.2.0.jre11.jar`
- `sqljdbc42.jar`

## Gợi ý cải thiện tiếp theo

- Đồng bộ lại schema `Order` và `OrderDetail` với `OrderDAO`
- Sửa `AdminFilter` từ `@WebServlet` sang `@WebFilter`
- Chuẩn hóa phân quyền admin theo `SESSION_USER`
- Tách nghiệp vụ giỏ hàng và đơn hàng sang tầng `service`
- Validate số lượng mua ở server, không chỉ ở giao diện
- Hash mật khẩu thay vì lưu plain text
- Không commit thông tin database thật lên repository
- Cân nhắc thêm Google OAuth hoặc JWT nếu phát triển API/mobile

## Tác giả

Nguyễn Quang Minh
