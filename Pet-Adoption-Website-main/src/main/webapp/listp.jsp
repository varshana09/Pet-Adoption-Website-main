<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="p1.DbConnect" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Pet</title>
</head>
<body>
<%
DbConnect.connect();
String petName = request.getParameter("petName");
String petType = request.getParameter("petType");
String age = request.getParameter("age");
String description = request.getParameter("description");
String contact = request.getParameter("contact");

HttpSession Session = request.getSession();
String uname = (String) session.getAttribute("username");

try {
    PreparedStatement insertStmt = DbConnect.con.prepareStatement("INSERT INTO pets (pet_name, pet_type, age, description, contact_number, username) VALUES (?, ?, ?, ?, ?, ?)");
    insertStmt.setString(1, petName);
    insertStmt.setString(2, petType);
    insertStmt.setString(3, age);
    insertStmt.setString(4, description);
    insertStmt.setString(5, contact);
    insertStmt.setString(6, uname);
    
    // Set image as needed
    

    int rowsInserted = insertStmt.executeUpdate();
   
    if (rowsInserted > 0) {
        out.println("Pet listed successfully!");
        response.sendRedirect("exm.html"); // Redirect to home page after listing
    } else {
        out.println("Pet listing failed. Please try again.");
    }
    
    insertStmt.close();
} catch (SQLException e) {
    e.printStackTrace();
}
%>
</body>
</html>
