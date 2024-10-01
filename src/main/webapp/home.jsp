<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Initialize session and check if user is logged in
    HttpSession s = request.getSession(false);
    String loggedInUser = (s != null) ? (String) s.getAttribute("username") : null;

    // If the user is not logged in (no session), redirect to register page
    if (loggedInUser == null) {
        response.sendRedirect("register.jsp");
        return;
    }

    // Otherwise, proceed with loading the home page
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Database connection details
        String dbUrl = "jdbc:mysql://localhost:3306/sms";
        String dbUser = "root";
        String dbPassword = "root";

        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

        // Query to check if the user is registered
        String query = "SELECT * FROM registration WHERE Username = ?";
        ps = con.prepareStatement(query);
        ps.setString(1, loggedInUser);

        rs = ps.executeQuery();

        if (!rs.next()) {
            // If user not found in the database, redirect to register page
            response.sendRedirect("register.html");
            return;
        }
        
        // If user is found, continue to load the home page content
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Society Nexus</title>
    <link rel="stylesheet" href="style1.css">
</head>
<body>
    <div class="page">
        <h1>Welcome to Society Nexus, <%= loggedInUser %>!</h1>
        <p>This is your home page.</p>
        <a href="logout.jsp">Logout</a>
    </div>
</body>
</html>

<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
    }
%>
