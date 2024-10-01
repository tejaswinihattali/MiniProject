<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%
    HttpSession s = request.getSession(true); // Get the current session

    // Redirect to login if user is not logged in
    if (s.getAttribute("loggedin") == null || !((Boolean) s.getAttribute("loggedin"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database connection variables
    String dbURL = "jdbc:mysql://localhost:3306/sms"; // Update your database name
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    PreparedStatement ps = null;

    // Handle the form submission
    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            // Connect to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
            String title = request.getParameter("ptitle");
            String flat = request.getParameter("pflat");
            String amount = request.getParameter("pamount");

            // Insert the payment record
            String query = "INSERT INTO payrecords (title, flat, amount, status) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, flat);
            ps.setString(3, amount);
            ps.setString(4, "Success");

            int result = ps.executeUpdate();
            if (result > 0) {
                out.println("<script>alert('Payment Received...!!'); window.location.href = 'Welcome.jsp';</script>");
            } else {
                out.println("<script>alert('Please try again'); window.location.href = 'payment.jsp';</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('Database error: " + e.getMessage() + "'); window.location.href = 'payment.jsp';</script>");
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Payment</title>
    <link rel="stylesheet" href="dashstyle.css">
    <script src="https://kit.fontawesome.com/2edfbc5391.js" crossorigin="anonymous"></script>
    <style>
        .contact-box {
            max-width: 850px;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            justify-content: center;
            align-items: center;
            text-align: center;
            background-color: #fff;
            box-shadow: 0px 0px 19px 5px rgba(0,0,0,0.19);
        }
        .right {
            padding: 25px 40px;
        }
        h2 {
            position: relative;
            padding: 0 180px 10px;
            margin-bottom: 45px;
            font-size: 35px;
        }
        .field {
            width: 50%;
            border: 2px solid rgba(0, 0, 0, 0);
            outline: none;
            background-color: white;
            padding: 0.5rem 1rem;
            font-size: 1.1rem;
            margin-bottom: 22px;
            transition: .3s;
        }
        .field:hover {
            background-color: #f5f5f7;
        }
        .btn-pay {
            width: 45%;
            padding: 0.5rem 1rem;
            background-color: #19B3D3;
            color: #fff;
            font-size: 1.1rem;
            border: none;
            outline: none;
            cursor: pointer;
            margin-left: 28px;
            transition: .3s;
        }
        .btn-pay:hover {
            background-color: #0B87A6;
        }
        .paycontainer {
            height: 450px;
            width: 550px;
            margin-left: 250px;
            background-color: #8cabf5;
        }
        .paycontent {
            margin-left: 200px;
            padding-top: 10px;
        }
        .payform {
            margin-left: 70px;
            padding-top: 10px;
        }
    </style>
</head>
<body>
    <input type="checkbox" id="check">
    <header>
        <label for="check">
            <i class="fas fa-bars" id="sidebar_btn"></i>
        </label>
        <div class="left_area">
            <h3>Society<span>HUB</span></h3>
        </div>
        <div class="right_area">
            <a href="logout.jsp" class="logout_btn">Logout</a>
        </div>
    </header>
    <div class="sidebar">
        <center>
            <img src="Images/download.png" class="profile_image" alt="">
            <h4><%= session.getAttribute("username") %></h4>
        </center>
        <a href="Welcome.jsp"><i class="fas fa-desktop"></i><span>Dashboard</span></a>
        <a href="noticebrd.jsp"><i class="fas fa-bullhorn"></i><span>Notice Board</span></a>
        <a href="complaint.jsp" class="active"><i class="fas fa-envelope-open-text"></i><span>Register Complaint</span></a>
        <a href="payment.jsp"><i class="fas fa-file-invoice-dollar"></i><span>Maintenance Payment</span></a>
        <a href="userphoto.jsp"><i class="fas fa-camera-retro"></i><span>Photo Gallery</span></a>
    </div>
    <div class="content"><br><br><br>
        <div class="container">
            <div class="contact-box">
                <div class="right">
                    <h2>Make Your Maintenance Payment</h2>
                    <div class="paycontainer">
                        <div class="paycontent">
                            <h3>Payment Details</h3>
                        </div>
                        <form action="payment.jsp" method="POST">
                            <div class="payform">
                                <p>Accepted Cards</p>
                                <img src="Images/card1.png" width="100">
                                <img src="Images/card2.png" width="50">
                                <br><br>
                                <input type="text" class="field" name="ptitle" placeholder="Enter Your Name" required>
                                <input type="text" class="field" name="pflat" placeholder="Enter Your Flat. No" required>
                                <input type="text" class="field" name="pamount" placeholder="$ Enter Your Amount" required><br>
                                <button class="btn-pay" name="ppaymnet">Confirm Payment</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
