<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="p1.DbConnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<% 
DbConnect.connect();
String uname = request.getParameter("uname");
String pwd = request.getParameter("psw");

try {
    PreparedStatement st2 = DbConnect.con.prepareStatement("select * from users where username = ? and password = ?");
    st2.setString(1, uname);
    st2.setString(2, pwd);
    ResultSet rs = st2.executeQuery();

    if (rs.next()) {
        // User exists, redirect to exm.html
        HttpSession Session = request.getSession();
        session.setAttribute("username", uname);
        response.sendRedirect("exm.html");
    } else {
        // User does not exist, handle accordingly
        out.println("Invalid username or password");
    }

    rs.close();
    st2.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>
</body>
</html>
