import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/uploadImage")
@MultipartConfig
public class UploadImageServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/sms"; // Update with your DB details
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root"; // Update with your DB password
    private static final String UPLOAD_DIR = "Images"; // Directory to save images

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("my_image"); // Retrieves <input type="file" name="my_image">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        long fileSize = filePart.getSize();
        
        if (filePart.getSize() > 262144) { // Check for file size limit
            String errorMessage = "Sorry, your file is too large.";
            response.sendRedirect("photo.jsp?error=" + errorMessage);
            return;
        }

        String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        if (!fileExtension.equals("jpg") && !fileExtension.equals("jpeg") && !fileExtension.equals("png")) {
            String errorMessage = "You can't upload files of this type.";
            response.sendRedirect("photo.jsp?error=" + errorMessage);
            return;
        }

        // Generate a unique name for the image
        String newFileName = "IMG-" + System.currentTimeMillis() + "." + fileExtension;
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR + File.separator + newFileName;

        // Save the file on the server
        filePart.write(uploadPath);

        // Save the image URL in the database
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://;ocalhost:3306/sms","root","root")) {
            String sql = "INSERT INTO images (image_url) VALUES (?)";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, newFileName);
                statement.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("picadd.jsp");
    }
}
