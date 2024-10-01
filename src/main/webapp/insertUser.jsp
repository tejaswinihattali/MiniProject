<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Checking if the request method is POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String flatno = request.getParameter("flatno");
        String mobileNo = request.getParameter("mobno");
        String familyMem = request.getParameter("fammem");
        String password = request.getParameter("password");

        // Database connection details
        String jdbcURL = "jdbc:mysql://localhost:3306/sms"; // Make sure the database URL is correct
        String dbUsername = "root";
        String dbPassword = "root";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Open a connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

            // SQL query to insert data into registration table
            String sql = "INSERT INTO registration (Username, Email, Flatno, MobileNo,  no_of_family_members, Password) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            // Set the values
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, flatno);
            stmt.setString(4, mobileNo);
            stmt.setString(5, familyMem);
            stmt.setString(6, password);

            // Execute the query
            int result = stmt.executeUpdate();

            if (result > 0) {
%>
                <script>
                    alert('Member added Successfully..!!');
                    window.location.href = 'managemem.jsp'; // Redirect to management page
                </script>
<%
            } else {
%>
                <script>
                    alert('Not Saved...Please try again.!!');
                    window.location.href = 'insertUser.jsp'; // Redirect back to the form
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
            // Close resources
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add member</title>
    <!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> -->
    <style>
        .Add_btn{
    padding: 5px;
    background: #0B87A6;
    text-decoration: none;
    /* float: right; */
    margin-top: -1px;
    margin-right: 2px;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 600;
    color: #fff;
    transition: 0.5s;
    transition-property: background;
  }
  
  .Add_btn:hover{
    background: #19B3D3;
  }
  .container{
    background:#b7f7d7;
    width: 550px;
    height: 420px;
    margin-top: 90px;
    margin-left: 400px;
    position: relative;
    text-align: center;
    padding: 20px 0;
    /* margin: auto; */
    box-shadow: 0 0 20px 0px rgba(0,0,0,0.1);
    overflow: hidden;
}
.container form{
    max-width: 400px;
    padding: 0 70px;
    position: absolute;
    top: 100px;
    transition: transform 1s;
}
form input{
    width: 100%;
    height: 40px;
    margin-top: 0px;
    margin-bottom: 10px;
    padding: 0 10px;
    border: 1px solid #ccc;
}
  
  
    </style>
</head>
<body>
    <div class="container">
        <h1>Add Member</h1>
        <form action="insertUser.jsp" method="POST" >
            <input type="text" placeholder="Username" name="username" required>
            <input type="email" placeholder="E-mail" name="email" required>
            <input type="text" placeholder="Flat-No." name="flatno" required>
            <input type="tel" placeholder="Mobile Number" name="mobno" required>
            <input type="text" placeholder="Number of Family members" name="fammem" required>
            <input type="password" placeholder="Password" name="password" required>
            <button type="submit" class="Add_btn" >Save data</button>
        </form>
    </div>
</body>
</html>


