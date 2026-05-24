/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constant;

/**
 *
 * @author admin
 */
public class Constant {
    public static final int RECORD_PER_PAGE = 24;
    public static final int ROLE_GUEST = 0;
    public static final int ROLE_ADMIN = 1;
    public static final int ROLE_CUSTOMER = 2;
    public static final int ROLE_STAFF = 3;
    public static final String ORDER_PENDING = "Chờ xác nhận";
    public static final String ORDER_SHIPPING = "Đang giao";
    public static final String ORDER_COMPLETED = "Hoàn thành";
    public static final String SESSION_PRODUCT = "listProduct";
    public static final String SESSION_CATEGORY = "listCategory";
    public static final String SESSION_PRODUCT_ADMIN = "listAdminProduct";
    public static final String SESSION_CATEGORY_ADMIN = "listAdminCategory";
    public static final String SESSION_USER = "user";

    public static boolean isStaff(model.User user) {
        return user != null && user.isActivate() && user.getRoleID() == ROLE_STAFF;
    }

    public static boolean isAdmin(model.User user) {
        return user != null && user.isActivate() && user.getRoleID() == ROLE_ADMIN;
    }

    public static boolean canAccessStaffArea(model.User user) {
        return isStaff(user) || isAdmin(user);
    }

    public static boolean isCustomer(model.User user) {
        return user != null && user.isActivate() && user.getRoleID() == ROLE_CUSTOMER;
    }

    public static boolean isOrderStatus(String status) {
        return ORDER_PENDING.equals(status)
                || ORDER_SHIPPING.equals(status)
                || ORDER_COMPLETED.equals(status);
    }
}
