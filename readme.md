# Shoppee_Store

Shoppee_Store là dự án Java Web mô phỏng một sàn thương mại điện tử nhỏ. Dự án dùng mô hình MVC với Servlet, JSP/JSTL, JDBC và SQL Server.

Luồng chính hiện tại gồm guest xem sản phẩm, customer mua hàng, staff quản lý sản phẩm/đơn hàng thuộc shop của mình, và admin quản lý toàn bộ người dùng cùng dữ liệu vận hành.

## Công Nghệ

- Java Servlet, JSP, JSTL
- JDBC
- SQL Server
- Apache Tomcat 10.1
- Ant/NetBeans
- HTML, CSS, JavaScript
- Font Awesome

## Cấu Trúc Dự Án

```text
src/java/
├─ controller/
│  ├─ auth/        # Đăng nhập, đăng ký, đăng xuất
│  ├─ user/        # Trang người dùng, giỏ hàng, đơn mua, profile
│  └─ admin/       # Kênh bán hàng, quản lý account/order/product
├─ service/        # Nghiệp vụ giỏ hàng và đặt hàng
├─ dal/            # DAO, JDBC, truy vấn database
├─ model/          # Entity/model
├─ dto/            # DTO dùng cho view/nghiệp vụ tổng hợp
├─ filter/         # Phân quyền khu vực staff/admin
├─ util/           # Tiện ích dùng chung
└─ constant/       # Hằng số role, session, trạng thái đơn

web/
├─ view/
│  ├─ auth/
│  ├─ user/
│  ├─ admin/
│  └─ common/
├─ assets/
└─ WEB-INF/
```

## Phân Quyền

| Role | Mô tả |
| --- | --- |
| Guest | Khách chưa đăng nhập, có thể xem và tìm kiếm sản phẩm |
| Customer | Người mua hàng, có giỏ hàng, checkout, xem đơn mua và cập nhật profile |
| Staff | Người bán hàng, quản lý sản phẩm và đơn hàng thuộc sản phẩm mình bán |
| Admin | Quản trị hệ thống, quản lý toàn bộ user, role, trạng thái tài khoản và dữ liệu bán hàng |

Role được chuẩn hóa trong `constant.Constant`:

```java
ROLE_GUEST = 0
ROLE_ADMIN = 1
ROLE_CUSTOMER = 2
ROLE_STAFF = 3
```

## Nghiệp Vụ Chính

### Customer

- Xem sản phẩm, danh mục, chi tiết sản phẩm.
- Thêm sản phẩm vào giỏ hàng.
- Mua ngay không làm tăng trùng số lượng nếu sản phẩm đã có trong giỏ.
- Checkout chỉ được thực hiện bởi tài khoản customer đang active.
- Số lượng mua được validate ở server trước khi tạo đơn.
- Trang đơn mua hiển thị từng sản phẩm trong đơn, thông tin đơn hàng, người bán, ngày mua, tổng tiền và trạng thái.
- Tab đơn mua:
  - Tất cả
  - Chờ xác nhận
  - Đang giao
  - Hoàn thành
- Tab “Tất cả” sắp xếp theo thứ tự: Chờ xác nhận -> Đang giao -> Hoàn thành.
- Customer có thể cập nhật họ tên, email, số điện thoại, địa chỉ và avatar.

### Staff

- Truy cập kênh bán hàng qua khu vực `/admin-*`.
- Chỉ nhìn thấy và quản lý sản phẩm do chính mình bán.
- Có thể thêm, sửa, xóa mềm và khôi phục sản phẩm trong shop của mình.
- Chỉ nhìn thấy các dòng đơn hàng liên quan đến sản phẩm của mình.
- Có thể cập nhật trạng thái từng sản phẩm trong đơn:
  - Chờ xác nhận
  - Đang giao
  - Hoàn thành
- Không được quản lý tài khoản người dùng.
- Có thể cập nhật profile và avatar như customer.

### Admin

- Có toàn quyền vào khu vực quản trị.
- Xem toàn bộ user.
- Cập nhật role user.
- Ban/unban user bằng trường `activate`.
- Xem toàn bộ sản phẩm và đơn hàng của mọi staff.
- Cập nhật trạng thái sản phẩm trong đơn khi cần hỗ trợ vận hành.

## Route Chính

| Route | Chức năng |
| --- | --- |
| `/home` | Trang chủ |
| `/authen?action=login` | Đăng nhập |
| `/authen?action=register` | Đăng ký customer |
| `/category` | Danh mục, tìm kiếm, lọc, sắp xếp |
| `/product-detail?id={id}` | Chi tiết sản phẩm |
| `/cart?action=view` | Giỏ hàng |
| `/cart?action=checkout` | Checkout sản phẩm đã chọn |
| `/user-purchase` | Đơn mua của customer |
| `/profile` | Hồ sơ cá nhân và avatar |
| `/admin-dashboard` | Tổng quan kênh bán hàng |
| `/admin-product?action=view` | Quản lý sản phẩm |
| `/admin-order?action=view` | Quản lý đơn hàng |
| `/admin-account?action=view` | Admin quản lý người dùng |

## Database

File schema nằm tại:

```text
Shoppe_DB.sql
```

Các bảng chính:

- `Role`: admin, customer, staff.
- `User`: thông tin tài khoản, role, avatar và trạng thái active/banned.
- `Category`: danh mục sản phẩm.
- `Product`: sản phẩm, tồn kho, số lượng đã bán, trạng thái xóa mềm, `sellerID`.
- `ProductImage`: ảnh sản phẩm.
- `Order`: thông tin tổng của đơn hàng.
- `OrderDetail`: từng sản phẩm trong đơn, số lượng, giá và trạng thái riêng của sản phẩm đó.

Các thay đổi schema quan trọng:

- `User.avatar`: lưu tên file avatar.
- `Product.sellerID`: xác định staff/admin sở hữu sản phẩm.
- `OrderDetail.status`: quản lý trạng thái theo từng sản phẩm trong đơn.

## Cấu Hình Database

Không commit thông tin database thật lên repository.

Tạo file local:

```text
web/WEB-INF/ConnectDB.properties
```

Nội dung tham khảo:

```properties
url=jdbc:sqlserver://localhost:1433;databaseName=Shopee;trustServerCertificate=true
userID=your_sql_server_user
password=your_sql_server_password
```

Nếu cần chia sẻ cấu hình mẫu, chỉ dùng file example hoặc placeholder, không dùng tài khoản thật.

## Chạy Dự Án

1. Mở project bằng Apache NetBeans.
2. Chạy `Shoppe_DB.sql` trên SQL Server.
3. Cấu hình `web/WEB-INF/ConnectDB.properties`.
4. Đảm bảo Tomcat 10.1 và các file `.jar` trong `lib/` đã được cấu hình.
5. Run project trong NetBeans.
6. Truy cập:

```text
http://localhost:8080/Shoppee_Store/home
```

## Ghi Chú Bảo Mật

- Mật khẩu mới được hash bằng PBKDF2 trước khi lưu.
- Login hỗ trợ kiểm tra mật khẩu hash và mật khẩu plain text cũ để dễ chuyển đổi dữ liệu.
- Nên migration toàn bộ mật khẩu plain text cũ sang hash.
- Không đưa `ConnectDB.properties` chứa thông tin thật lên repository.
- Nếu phát triển API/mobile, nên bổ sung JWT.
- Nếu mở rộng đăng nhập web, có thể thêm Google OAuth.

## Trạng Thái Hiện Tại

- Đã tách nghiệp vụ giỏ hàng và đặt hàng sang tầng service.
- Đã validate số lượng mua ở server.
- Đã chuẩn hóa phân quyền theo `SESSION_USER`.
- Đã đổi filter khu vực quản trị sang `@WebFilter`.
- Đã mở rộng role thành guest, customer, staff và admin.
- Đã giới hạn staff theo sản phẩm và đơn hàng của chính staff đó.
- Đã thêm profile và avatar cho customer/staff/admin.
