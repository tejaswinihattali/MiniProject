<%@ page import="java.io.*, java.util.*, java.sql.*, java.nio.file.*" %>
<%
    // Database connection setup
    String dbURL = "jdbc:mysql://localhost:3306/sms"; // Update your database name
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Part filePart = request.getPart("my_image");
        if (filePart != null) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = "C:/Users/CLIENT/eclipse-workspace/Images/" + fileName;

            // Save the file
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Paths.get("C:/Users/CLIENT/eclipse-workspace/Images/"), StandardCopyOption.REPLACE_EXISTING);
                out.println("File uploaded to: " + uploadPath); // Debugging line
            }

            // Save file name to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
            String sql = "INSERT INTO images (image_url) VALUES (?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fileName);
            ps.executeUpdate();
            out.println("File name stored in the database."); // Debugging line

            // Redirect to userphoto.jsp
            response.sendRedirect("userphoto.jsp");
        } else {
            out.println("File part is null."); // Debugging line
        }
    } catch (Exception e) {
        e.printStackTrace(); // Print stack trace to help with debugging
    }
 finally {
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
