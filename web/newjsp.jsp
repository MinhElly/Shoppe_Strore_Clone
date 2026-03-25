<%@page import="java.util.Vector"%>
<%@page import="dal.UserDAO"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UserDAO dao = new UserDAO();
    String action = request.getParameter("action");
%>

<html>
<head>
    <title>Test UserDAO</title>
</head>
<body>

<h1>Test UserDAO</h1>

<hr>

<!-- INSERT -->
<h3>Insert User</h3>
<form method="post">
    <input type="hidden" name="action" value="insert">
    userID: <input type="text" name="userID"><br>
    fullName: <input type="text" name="fullName"><br>
    username: <input type="text" name="username"><br>
    password: <input type="text" name="password"><br>
    roleID: <input type="text" name="roleID"><br>
    address: <input type="text" name="address"><br>
    phone: <input type="text" name="phone"><br>
    email: <input type="text" name="email"><br>
    activate: <input type="text" name="activate"><br>
    <input type="submit" value="Insert">
</form>

<hr>

<!-- SEARCH -->
<h3>Search User</h3>
<form method="get">
    <input type="hidden" name="action" value="search">
    userID: <input type="text" name="userID">
    <input type="submit" value="Search">
</form>

<hr>

<!-- LOGIN -->
<h3>Login Test</h3>
<form method="post">
    <input type="hidden" name="action" value="login">
    username: <input type="text" name="username"><br>
    password: <input type="text" name="password"><br>
    <input type="submit" value="Login">
</form>

<hr>

<!-- CHECK USERNAME -->
<h3>Check Username Exist</h3>
<form method="get">
    <input type="hidden" name="action" value="check">
    username: <input type="text" name="username">
    <input type="submit" value="Check">
</form>

<hr>

<%
if(action != null){

    if(action.equals("insert")){
        User u = new User(
            request.getParameter("userID"),
            request.getParameter("fullName"),
            request.getParameter("username"),
            request.getParameter("password"),
            Integer.parseInt(request.getParameter("roleID")),
            request.getParameter("address"),
            request.getParameter("phone"),
            request.getParameter("email"),
            Boolean.parseBoolean(request.getParameter("activate"))
        );

        int n = dao.insertUser(u);
        out.println("Insert result: " + n);
    }

    if(action.equals("search")){
        String id = request.getParameter("userID");
        User u = dao.searchUser(id);

        if(u != null){
            out.println("Found: " + u.getFullName());
        }else{
            out.println("User not found");
        }
    }

    if(action.equals("login")){
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User u = dao.loginUser(username,password);

        if(u != null){
            out.println("Login success: " + u.getFullName());
        }else{
            out.println("Login fail");
        }
    }

    if(action.equals("check")){
        String username = request.getParameter("username");

        boolean exist = dao.isExistUserName(username);

        if(exist){
            out.println("Username already exists");
        }else{
            out.println("Username available");
        }
    }
}
%>

<hr>

<h3>All Users</h3>

<table border="1">
<tr>
    <th>ID</th>
    <th>Name</th>
    <th>Username</th>
    <th>Password</th>
    <th>Role</th>
</tr>

<%
Vector<User> list = dao.getAllUser();

for(User u : list){
%>

<tr>
    <td><%=u.getUserID()%></td>
    <td><%=u.getFullName()%></td>
    <td><%=u.getUsername()%></td>
    <td><%=u.getPassword()%></td>
    <td><%=u.getRoleID()%></td>
</tr>

<%
}
%>

</table>

</body>
</html>