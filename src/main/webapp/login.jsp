<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    // Retrieve form data (POST method)
    String Username = request.getParameter("s1");
    String flatno = request.getParameter("s3");
    
    // Database connection variables
    String dbUrl = "jdbc:mysql://localhost:3306/sms";
    String dbUser = "root";
    String dbPassword = "root";

    // Declare JDBC variables
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String message = "";
    
    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish the connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
        
        // Prepare the SQL query to validate user
        String query = "SELECT * FROM registration WHERE Username = ? AND Flatno = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1, Username);
        ps.setString(2, flatno);
        
        // Execute the query
        rs = ps.executeQuery();
        
        if (rs.next()) {
            // User found, set session attributes
            HttpSession s = request.getSession();
            s.setAttribute("loggedin", true);
            s.setAttribute("username", Username);
            
            // Redirect to welcome page
            out.println("<script>alert('Welcome, You are logged in!'); window.location.href = 'Welcome.jsp';</script>");
        } else {
            // Invalid credentials, redirect back to login page
            out.println("<script>alert('Sorry, Invalid credentials!'); window.location.href = 'register.html';</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('An error occurred: " + e.getMessage() + "'); window.location.href = 'register.html';</script>");
    } finally {
        // Clean up JDBC resources
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

