<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/sms";
    String user = "root";
    String password = "root";

    Connection connection = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
    } catch (Exception e) {
        out.println("Database connection error: " + e.getMessage());
    }
%>
