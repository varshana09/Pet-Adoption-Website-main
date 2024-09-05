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
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String contact = request.getParameter("contact");
String email = request.getParameter("email");
String uname = request.getParameter("uname");
String psw = request.getParameter("psw");

try {
   
    PreparedStatement checkStmt = DbConnect.con.prepareStatement("SELECT * FROM users WHERE username = ?");
    checkStmt.setString(1, uname);
    ResultSet rs = checkStmt.executeQuery();
    
    if (rs.next()) {
        
        out.println("Username already exists, please choose another username.");
    } else {
        
        PreparedStatement insertStmt = DbConnect.con.prepareStatement("INSERT INTO users (first_name, last_name, contact_number, email, username, password) VALUES (?, ?, ?, ?, ?, ?)");
        insertStmt.setString(1, fname);
        insertStmt.setString(2, lname);
        insertStmt.setString(3, contact);
        insertStmt.setString(4, email);
        insertStmt.setString(5, uname);
        insertStmt.setString(6, psw);
        
        int rowsInserted = insertStmt.executeUpdate();
        
        if (rowsInserted > 0) {
            out.println("Registration successful!");
            response.sendRedirect("login.html");
        } else {
            out.println("Registration failed. Please try again.");
        }
        
        insertStmt.close();
    }

    rs.close();
    checkStmt.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>
</body>
</html>
