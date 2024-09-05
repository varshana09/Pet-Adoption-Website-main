<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="p1.DbConnect" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Pets</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f6fc;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .card {
            width: 300px;
            margin: 20px;
            padding: 15px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .card h3 {
            margin-top: 10px;
            margin-bottom: 5px;
        }

        .card p {
            margin-top: 5px;
            color: #666;
        }
    </style>
</head>
<body>
    <h1>Available Pets for Adoption</h1>
    <div class="container">
        <% 
        DbConnect.connect();
        try {
            PreparedStatement st = DbConnect.con.prepareStatement("SELECT * FROM pets");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String petName = rs.getString("pet_name");
                String petType = rs.getString("pet_type");
                int age = rs.getInt("age");
                String description = rs.getString("description");
                String contact = rs.getString("contact_number");

                %>
                <div class="card">
                    <img src="placeholder.jpg" alt="Pet Image">
                    <h3><%= petName %></h3>
                    <p><strong>Type:</strong> <%= petType %></p>
                    <p><strong>Age:</strong> <%= age %> years</p>
                    <p><strong>Description:</strong> <%= description %></p>
                    <p><strong>Contact:</strong> <%= contact %></p>
                </div>
                <%
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        %>
    </div>
</body>
</html>
