<%@ page import="java.sql.*, java.io.*" %>

<%
    // Initialize database connection variables
    Connection con = null;
    PreparedStatement ps = null;
    String dbUrl = "jdbc:mysql://localhost:3306/sms";
    String dbUser = "root";
    String dbPassword = "root";

    // Retrieve form data
    String unm = request.getParameter("t1");
    String email = request.getParameter("t2");
    int flatno = 0;
    long mob = 0;
    String pass = request.getParameter("t5");
    int fammem = 0;

    // Try to parse flat number, mobile number, and family members
    try {
        flatno = Integer.parseInt(request.getParameter("t3"));
        mob = Long.parseLong(request.getParameter("t4"));
        fammem = Integer.parseInt(request.getParameter("t6"));
    } catch (NumberFormatException e) {
        flatno = -1; // Invalid flat number
        mob = -1; // Invalid mobile number
        fammem = -1; // Invalid family members count
    }

    // Initialize response
    String message = "";

    if (unm != null && email != null && pass != null && flatno > 0 && mob > 0 && fammem > 0) {
        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish connection to database
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
            
            // Prepare SQL insert statement
            String query = "INSERT INTO registration(Username, Email, Flatno, MobileNo, Password, no_of_family_members) VALUES(?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, unm);
            ps.setString(2, email);
            ps.setInt(3, flatno);
            ps.setLong(4, mob);
            ps.setString(5, pass);
            ps.setInt(6, fammem);
            
            // Execute insert statement
            int result = ps.executeUpdate();
            
            if (result > 0) {
                message = "Registration successful! You may now <a href='login.jsp'>login</a>.";
            } else {
                message = "Registration failed. Please try again.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (con != null) try { con.close(); } catch (SQLException ignore) {}
        }
    } else {
        message = "Please fill in all required fields correctly.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Society Nexus</title>
    <link rel="stylesheet" href="style1.css">
    <script src="https://kit.fontawesome.com/2edfbc5391.js" crossorigin="anonymous"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }
        .page {
            height: 110vh;
            width: 100%;
            background-image: linear-gradient(rgb(211, 203, 241), rgb(205, 232, 241));
            background-position: center;
            background-size: cover;
            padding-left: 5%;
            padding-right: 5%;
            box-sizing: border-box;
            overflow-x: hidden;
            position: relative;
        }
        .navbar {
            width: 150%;
            height: 15vh;
            margin: auto;
            display: flex;
            align-items: center;
        }
        .logo {
            height: 80px;
            width: 80px;
            cursor: pointer;
            border-radius: 60px;
        }
        nav {
            flex: 1;
            padding-left: 100px;
        }
        nav ul li {
            display: inline-block;
            list-style: none;
            margin: 0px 25px;
            position: relative;
        }
        nav ul {
            padding-left: 246px;
        }
        nav ul li::after {
            content: "";
            height: 3px;
            width: 0%;
            background: rgb(5, 85, 85);
            position: absolute;
            left: 0px;
            bottom: -5px;
            transition: 0.5s;
        }
        nav ul li:hover::after {
            width: 100%;
        }
        nav ul li a {
            text-decoration: none;
            font-size: 24px;
            color: rgb(5, 85, 85);
        }
        .navbar h1 {
            padding-top: 10px;
            margin-left: 8px;
            font-size: 30px;
            font-family: 'Mate', serif;
            color: rgb(51, 123, 133);
            cursor: pointer;
        }
        .row {
            display: flex;
            flex-wrap: wrap;
            margin-top: 5%;
            justify-content: space-between;
        }
        .col-1 {
            flex-basis: 40%;
            min-width: 200px;
            margin-bottom: 40px;
        }
        .col-1 img {
            width: 115%;
            height: 110%;
            border-radius: 40px;
            cursor: pointer;
        }
        .active::after {
            content: "";
            height: 3px;
            width: 100%;
            background: rgb(5, 85, 85);
            position: absolute;
            left: 0px;
            bottom: -5px;
        }
        .btn {
            margin-left: 1083px;
            color: rgb(5, 85, 85);
            font-weight: 500;
            border: 2px solid rgb(5, 56, 77);
            padding: 6px 25px;
            border-radius: 60px;
            text-decoration: none;
            position: absolute;
            transition: 0.5s;
        }
        .btn:hover {
            background: #fff;
        }
        .form-container {
            background: #fff;
            width: 300px;
            height: 400px;
            position: relative;
            text-align: center;
            padding: 10px 0;
            margin: auto;
            box-shadow: 0 0 20px 0px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .col-2 {
            padding-right: 150px;
            padding-top: 32px;
        }
        .form-container span {
            font-weight: bold;
            padding: 0 10px;
            color: #555;
            cursor: pointer;
            width: 50px;
            display: inline-block;
        }
        .form-btn {
            display: inline-block;
            padding-top: 21px;
        }
        .form-container form {
            max-width: 300px;
            position: absolute;
            top: 130px;
            transition: transform 1s;
        }
        form input {
            width: 80%;
            height: 30px;
            margin-top: 0px;
            margin-bottom: 10px;
            padding: 0 10px;
            border: 1px solid #ccc;
        }
        #Loginform {
            left: -300px;
            top: 110px;
        }
        #Regform {
            left: 0;
            top: 90px;
        }
        form a {
            font-size: 18px;
            display: block;
        }
        #indicator {
            width: 65px;
            border: none;
            background: rgb(5, 85, 85);
            height: 3px;
            margin-top: 8px;
            transform: translateX(80px);
            transition: transform 1s;
        }
        .btn-losi {
            width: 75%;
            font-weight: bold;
            padding: 10px 10px;
            cursor: pointer;
            display: block;
            margin: 14px 40px 0px;
            background: linear-gradient(to right, #a7cceb, #95b1bd);
            border: 0;
            outline: none;
            border-radius: 30px;
        }
        .btn-losi:hover {
            background: rgb(109, 159, 201);
        }
        #rules {
            height: 80vh;
            width: 100%;
            background-size: cover;
            box-sizing: border-box;
            overflow-x: hidden;
            position: relative;
        }
        #rules h1 {
            padding-top: 15px;
            padding-bottom: 15px;
            padding-left: 523px;
            color: rgb(5, 85, 85);
            background-color: aliceblue;
        }
        #rules li {
            list-style: number;
            list-style-position: outside;
            text-indent: -1em;
            font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
            font-weight: bold;
            padding-top: 15px;
            padding-left: 28px;
            font-size: 18px;
        }
        footer {
            position: relative;
            width: 100%;
            background: rgb(27, 78, 87);
            font-family: 'Poppins', sans-serif;
            color: #d9d9d9;
            box-sizing: border-box;
        }
        .main-content {
            display: flex;
        }
        .main-content .box {
            flex-basis: 50%;
            padding: 10px 20px;
        }
        .box h2 {
            font-size: 1.125rem;
            font-weight: 600;
            text-transform: uppercase;
            padding-top: 15px;
        }
        .box h2:hover {
            color: rgb(39, 159, 228);
        }
        .box .content {
            margin: 20px 0 0 0;
        }
        .left .content p {
            text-align: justify;
        }
        .content p {
            line-height: 20px;
        }
        .place {
            padding-bottom: 10px;
        }
        .phone {
            padding-bottom: 10px;
        }
        ul li {
            list-style-type: none;
            padding-top: 20px;
        }
        ul li a {
            color: #fff;
            text-decoration: none;
        }
        .adjust ul li a:hover {
            color: rgb(17, 195, 201);
        }
        .cen {
            padding-left: 100px;
        }
        .copyright h3 {
            font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
            background-color: #416d74;
            text-align: center;
            font-size: 15px;
            height: 23px;
        }
    </style>
</head>
<body>
    <div class="page">
        <div class="navbar">
            <img src="" class="logo">
            <h1>Society<span style="font-family: 'Merienda', cursive; color:rgb(20, 76, 80);">Nexus</span></h1>
            <nav>
                <ul>
                    <li><a href="" class="active">Home</a></li>
                    <li><a href="#rules">Rules & Regulations</a></li>
                </ul>
            </nav>
            <a href="Adminlogin.jsp" class="btn">Admin Login</a>
        </div>
        <div class="row">
            <div class="col-1">
                <img src="Images/building1.jpg">
            </div>
            <div class="col-2">
                <div class="form-container">
                    <div class="form-btn">
                        <span onclick="login()">Login</span>
                        <span onclick="register()">Register</span>
                        <hr id="indicator">
                    </div>
                    <form action="login.jsp" method="POST" id="Loginform">
                        <input type="text" placeholder="Username" name="s1" required>
                        <input type="email" placeholder="E-mail" name="s2" required>
                        <input type="text" placeholder="Flat-No." name="s3" required>
                        <input type="password" placeholder="Password" name="s4" required>
                        <button type="submit" class="btn-losi">Login</button><br>
                        <a href="">Forget Password...???</a>
                        <a href="register.html">Don't have an account? Register here.</a>
                    </form>
                    <form action="register.jsp" method="POST" id="Regform">
                        <input type="text" placeholder="Username" name="t1" required>
                        <input type="email" placeholder="E-mail" name="t2" required>
                        <input type="text" placeholder="Flat-No." name="t3" required>
                        <input type="tel" placeholder="Mobile Number" name="t4" required>
                        <input type="text" placeholder="Number of Family members" name="t6" required>
                        <input type="password" placeholder="Password" name="t5" required>
                        <button type="submit" class="btn-losi">Register Now</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <hr>
    <div id="rules">
        <h1>Rules and Regulations</h1>
        <hr>
        <ul>
            <li>Members and residents are required to keep their flats/homes and nearby premises clean and habitable.</li>
            <li>The residents should also maintain proper cleanliness etiquette while using common areas, parking lot, etc. and not throw litter from their balconies and windows.</li>
            <li>Members must regularly pay the maintenance charges and all other dues necessitated by the society.</li>
            <li>Keeping pets is allowed after submitting the required NOC to the society. But if pets like dogs are creating any kind of disturbance to other society members then the pets won’t be allowed.</li>
            <li>Every member of the society should park their vehicles in their respective allotted parking spaces only.</li>
            <li>After using the community hall for any event or function, it should be cleaned and no damages should be caused.</li>
            <li>No member can occupy the area near their front doors, corridors, passage for their personal usage.</li>
            <li>Salesmen, vendors or any other sellers are not allowed to enter the premises.</li>
            <li>Wastage and over usage of water is not allowed.</li>
            <li>Smoking in lobbies, passage is not allowed. If any irresponsible person is found smoking in the no smoking zone, he/she shall be charged with penalty.</li>
        </ul>
    </div>
    <hr>
    <footer>
        <div class="main-content">
            <div class="left box">
                <h2>About Us</h2>
                <div class="content">
                    <p>
                        Society is a web app where society members can get all the updates related to their society. The members also get notified with notices and events held in society and can see information about members in society. Members can also post complaints regarding any issue in society.
                    </p>
                </div>
            </div>
            <div class="center box adjust">
                <div class="cen">
                    <h2>Quick Links</h2>
                    <ul>
                        <li><a href="login.html">Home</a></li>
                        <li><a href="#Loginform">Login</a></li>
                        <li><a href="#rules">Rules and Regulations</a></li>
                    </ul>
                </div>
            </div>
            <div class="right box">
                <h2>Address</h2>
                <div class="content">
                    <div class="place">
                        <span class="fas fa-map-marker-alt"></span>
                        <span class="text">Tejan Parkland, Thane-W</span>
                    </div>
                    <div class="phone">
                        <span class="fas fa-phone-alt"></span>
                        <span class="text">+91 7972105600</span>
                    </div>
                    <div class="email">
                        <span class="fas fa-envelope"></span>
                        <span class="text">tejansociety@gmail.com</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="copyright">
            <h3>Copyright @2023 | Designed with HTML, CSS, PHP.</h3>
        </div>
    </footer>
    <script>
        var Loginform = document.getElementById("Loginform");
        var Regform = document.getElementById("Regform");
        var indicator = document.getElementById("indicator");

        function register() {
            Regform.style.transform = "translateX(0px)";
            Loginform.style.transform = "translateX(0px)";
            indicator.style.transform = "translateX(80px)";
        }

        function login() {
            Regform.style.transform = "translateX(300px)";
            Loginform.style.transform = "translateX(300px)";
            indicator.style.transform = "translateX(0px)";
        }
    </script>
</body>
</html> 