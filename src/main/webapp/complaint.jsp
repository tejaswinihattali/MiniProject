<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    // Session check (Equivalent to PHP's session_start and checking login status)
    HttpSession s = request.getSession(false);
    String loggedInUser = (s != null) ? (String) s.getAttribute("username") : null;

    if (loggedInUser == null) {
        // Redirect to login page if user is not logged in
        response.sendRedirect("register.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register complaint</title>
    <link rel="stylesheet" href="dashstyle.css">
    <script src="https://kit.fontawesome.com/2edfbc5391.js"crossorigin="anonymous"></script>
    <style>
        .contact-box {
            max-width: 850px;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            justify-content: center;
            align-items: center;
            text-align: center;
            background-color: #fff;
            box-shadow: 0px 0px 19px 5px rgba(0, 0, 0, 0.19);
        }

        .right {
            padding: 25px 40px;
        }

        h2 {
            font-size: 35px;
            padding-bottom: 10px;
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

        textarea {
            min-height: 170px;
        }

        .btn {
            width: 25%;
            padding: 0.5rem 1rem;
            background-color: #19B3D3;
            color: #fff;
            font-size: 1.1rem;
            border: none;
            outline: none;
            cursor: pointer;
            transition: .3s;
        }

        .btn:hover {
            background-color: #0B87A6;
        }

        .field:focus {
            border: 2px solid rgba(30, 85, 250, 0.47);
            background-color: #fff;
        }
    </style>
</head>
<body>
<input type="checkbox" id="check">
    <!--header area start-->
    <header>
      <label for="check">
        <i class="fas fa-bars" id="sidebar_btn"></i>
      </label>
      <div class="left_area">
        <h3>Society<span>NEXUS</span></h3>
      </div>
      <div class="right_area">
        <a href="logout.jsp" class="logout_btn">Logout</a>
      </div>
    </header>
    <!--header area end-->

    <!--sidebar start-->
    <div class="sidebar">
      <center>
        <img src="Images/download.png" class="profile_image" alt="">
        <h4> <%= loggedInUser %> </h4>
      </center>
      <a href="Welcome.jsp"><i class="fas fa-desktop"></i><span>Dashboard</span></a>
      <a href="noticebrd.jsp"><i class="fas fa-bullhorn"></i><span>Notice Board</span></a>
      <a href="complaint.jsp" class="active"><i class="fas fa-envelope-open-text"></i><span>Register Complaint</span></a>
      <a href="payment.jsp"><i class="fas fa-file-invoice-dollar"></i><span>Maintenance Payment</span></a>
      <a href="userphoto.jsp"><i class="fas fa-camera-retro"></i><span>Photo Gallery</span></a>
    </div>
    <!--sidebar end-->

    <!--Complaint Form-->
    <div class="content"><br><br><br>
        <div class="container">
            <div class="contact-box">
                <div class="right">
                    <h2>Register Your Anonymous Complaints</h2>
                    <form action="complaint.jsp" method="POST">
                        <input type="text" class="field" name="ctitle" placeholder="Title" required>
                        <textarea placeholder="Enter Your Complaint" name="nmsg" class="field" required></textarea><br>
                        <button class="btn" name="lcomplaint">Lodge complaint</button>
                        <button class="btn" name="ccancel" type="reset">Cancel</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- JSP Script to handle form submission -->
    <%
        if (request.getParameter("lcomplaint") != null) {
            String complaintTitle = request.getParameter("ctitle");
            String complaintMessage = request.getParameter("nmsg");

            Connection con = null;
            PreparedStatement ps = null;

            try {
                // Database connection
                String dbUrl = "jdbc:mysql://localhost:3306/sms";
                String dbUser = "root";
                String dbPassword = "";

                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

                // Insert query
                String query = "INSERT INTO combox (Title, Message) VALUES (?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, complaintTitle);
                ps.setString(2, complaintMessage);

                int result = ps.executeUpdate();

                if (result > 0) {
                    // Success alert and redirect to Welcome page
                    out.println("<script>alert('Complaint Submitted...!!'); window.location.href = 'Welcome.jsp';</script>");
                } else {
                    out.println("<script>alert('Please try again'); window.location.href = 'complaint.jsp';</script>");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (con != null) try { con.close(); } catch (SQLException ignore) {}
            }
        }
    %>
</body>
</html>
