import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteUser {

    public static void main(String[] args) {
        // MySQL connection parameters
        String jdbcURL = "jdbc:mysql://localhost:3306/sms"; 
        String username = "root";
        String password = "root"; 

        // Id of the user to be deleted (This would typically come from a request, like an HTML form or API call)
        int userId = 123;  // Example user ID, replace it with the actual ID to be deleted

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

            // SQL query to delete user from registration table based on user Id
            String query = "DELETE FROM registration WHERE Id = ?";

            // Prepare the SQL statement
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);

            // Execute the deletion
            int rowsAffected = preparedStatement.executeUpdate();

            // Check if the deletion was successful
            if (rowsAffected > 0) {
                System.out.println("Data Deleted Successfully..!!");
                // You can add JavaScript redirection logic if needed
            } else {
                System.out.println("Data not deleted, please try again..!!");
                // You can add JavaScript redirection logic if needed
            }

        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Database error occurred.");
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
