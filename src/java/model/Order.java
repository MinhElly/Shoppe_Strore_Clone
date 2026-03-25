package model;

import java.util.Date;

public class Order {
    private int id;         // Khớp với orderID của bạn
    private Date date;       // Khớp với orderDate
    private double totalMoney; // Khớp với total
    private String userId;   // Khớp với userID
    private String status;   // Trạng thái đơn hàng (Chờ xác nhận, Đang giao...)
    
    // THUỘC TÍNH THÊM VÀO ĐỂ HIỂN THỊ TRÊN GIAO DIỆN
    private String userName; // Để lưu fullName của khách hàng khi JOIN bảng User

    public Order() {
    }

    // Constructor đầy đủ cho các thao tác logic
    public Order(int id, Date date, double totalMoney, String userId, String status) {
        this.id = id;
        this.date = date;
        this.totalMoney = totalMoney;
        this.userId = userId;
        this.status = status;
    }

    // Getter và Setter cho các thuộc tính cũ
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public double getTotalMoney() { return totalMoney; }
    public void setTotalMoney(double totalMoney) { this.totalMoney = totalMoney; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // Getter và Setter cho thuộc tính hiển thị thêm
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}