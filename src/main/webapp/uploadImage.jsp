<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Check if file is uploaded
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String jdbcURL = "jdbc:mysql://localhost:3306/sms";
        String dbUsername = "root";
        String dbPassword = "root";
        Connection conn = null;

        // Directory to store uploaded images
        String uploadPath = application.getRealPath("") + File.separator + "Images";

        // Get the uploaded file
        Part filePart = request.getPart("my_image");

        if (filePart != null) {
            // Get file name and extension
            String fileName = filePart.getSubmittedFileName();
            String filePath = uploadPath + File.separator + fileName;

            try {
                // Save the file to the server
                filePart.write(filePath);

                // Establishing database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

                // Insert file path into the database
                String sql = "INSERT INTO images (image_url) VALUES (?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, fileName);
                ps.executeUpdate();

                response.sendRedirect("photo.jsp");

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("photo.jsp?error=File upload failed");
            } finally {
                if (conn != null) {
                    conn.close();
                }
            }
        } else {
            response.sendRedirect("photo.jsp?error=No file selected");
        }
    }
%>
