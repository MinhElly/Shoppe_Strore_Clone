# 🛒 Shoppe_Store - Java Web Shopping

## 📌 Giới thiệu

**Shoppe_Store** là website bán hàng được xây dựng theo mô hình MVC sử dụng Java Web clone lại giao diện của trang web bán hàng Shopee.

Project hỗ trợ người dùng mua sắm online và admin quản lý sản phẩm.

---

## ✨ Chức năng chính

### 👤 User

* Đăng ký / Đăng nhập
* Xem danh sách sản phẩm
* Tìm kiếm sản phẩm
* Xem chi tiết sản phẩm
* Thêm vào giỏ hàng
* Thanh toán

### 🔑 Admin

* Quản lý sản phẩm
* Quản lý người dùng
* Quản lý đơn hàng

---

## 🧱 Cấu trúc project

### 📂 Web Pages

* `assets/` → CSS, JS, hình ảnh
* `view/`

  * `admin/` → trang admin
  * `authentication/` → login/register
  * `homepage/` → trang chính
  * `user/` → chức năng user
  * `common/` → header, footer
* `index.html`, `newjsp.jsp` -> test Database

---

### 📂 Source Packages

* `controller/` → xử lý request user
* `controller.admin/` → xử lý admin
* `dal/` → kết nối database (JDBC)
* `model/` → object (Product, User,...)
* `filter/` → filter (login, auth,...)
* `constant/` → hằng số

---

## ⚙️ Công nghệ sử dụng

* Java Servlet + JSP
* JSTL
* JDBC
* MySQL
* Apache Tomcat

---

## 🚀 Hướng dẫn chạy project

### 1. Clone project từ GitHub

```bash
git clone https://github.com/your-username/Shoppe_Store.git
```

---

### 2. Import vào NetBeans

* File → Open Project
* Chọn folder project

---

### 3. Cấu hình database

#### Thiết lập DB:

* Chạy file 'Shoppe_DB.sql'

#### Sửa file:

```
ConnectDB.properties
```

```java
url=jdbc:sqlserver://localhost:1433;databaseName=Shopee;trustServerCertificate=true
userID= 'Your userID'
password= 'Your password'
```

---

### 4. Chạy project

* Deploy bằng Tomcat
* Truy cập: (lưu ý số cổng do mình config trong Tomcat)

```
http://localhost:(your_port)/Shoppe_Store
```

---

## 📷 Demo
Giao diện trang home. Dùng được chức năng danh mục, gợi ý sản phẩm và phân trang
* ![home](images/home.png)
* ![home](images/home-1.png)
* ![home](images/home-2.png)
* ![home](images/home-3.png)

Đăng nhập & Đăng ký
* ![login](images/login.png)
* ![login](images/register.png)

Chi tiết sản phẩm
* ![product](images/product.png)
* ![product](images/product-1.png)

Danh mục cho từng loại sản phẩm
* ![cate](images/cate.png)

Quản lý - Admin
* ![admin](images/admin-1.png)
* ![admin](images/admin-2.png)
* ![admin](images/admin-3.png)

User - Người dùng 
* ![user](images/user.png)

Cart - Giỏ Hàng
    * ![cart](images/cart.png)
    * ![cart](images/cart-1.png)
    * ![cart](images/cart-2.png)

## ❗Thông tin thêm

* Dự án thuộc khuôn khổ môn học PRJ301 thuộc trường đại học FPT Hà Nội
* Sử dụng:
  * Apache NetBeans IDE 17
  * Apache Tomcat 10.1
  * JDK 17
  * SQL Server
  * Thư viện:
    * jakarta.servlet.jsp.jstl-2.0.0.jar
    * jakarta.servlet.jsp.jstl-api-2.0.0.jar
    * jaxb-api-2.1.jar
    * mssql-jdbc-13.2.0.jre11.jar
    * sqljdbc42.jar

---

## 👨‍💻 Tác giả

* Nguyễn Quang Minh
