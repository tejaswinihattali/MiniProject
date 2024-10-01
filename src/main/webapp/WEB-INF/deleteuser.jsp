<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Database connection variables
    String jdbcURL = "jdbc:mysql://localhost:3306/sms"; // Update this with your DB info
    String dbUsername = "root";
    String dbPassword = "root";
    Connection connection = null;
    PreparedStatement stmt = null;

    if (request.getParameter("delete") != null) {
        String id = request.getParameter("Id");  // Get the ID from the form
        
        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection to the database
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms");

            // SQL query to delete the user
            String query = "DELETE FROM registration WHERE Id = ?";
            stmt = connection.prepareStatement(query);
            stmt.setString(1, id);

            // Execute the query
            int result = stmt.executeUpdate();

            if (result > 0) {
%>
                <script>
                    alert('Data Deleted Successfully..!!');
                    window.location.href = 'managemem.jsp'; // Redirect to manage members page
                </script>
<%
            } else {
%>
                <script>
                    alert('Data not deleted, please try again..!!');
                    window.location.href = 'deleteuser.jsp'; // Redirect back to delete form in case of failure
                </script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>
                alert('Database error: <%= e.getMessage() %>');
            </script>
<%
        } finally {
            // Close the resources
            if (stmt != null) stmt.close();
            if (connection != null) connection.close();
        }
    }
%>
