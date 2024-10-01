import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class UserRegistration extends HttpServlet {
	Connection con;
	PreparedStatement ps;
	
	public void init() throws ServletException{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
			
			ps = con.prepareStatement("INSERT INTO registration(Username,Email,Flatno,MobileNo,Password,no_of_family_members) VALUES(?,?,?,?,?,?)");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void destroy() {
		try {
			ps.close();
			con.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		PrintWriter out = response.getWriter();
		
		response.setContentType("text/html");
		
		String unm =request.getParameter("t1");
		String email = request.getParameter("t2");
		int flatno = Integer.parseInt(request.getParameter("t3"));
		long mob =Long.parseLong(request.getParameter("t4"));
		String pass = request.getParameter("t5");
		int fammem =Integer.parseInt(request.getParameter("t6"));
		
		try {
			ps.setString(1,unm);
			ps.setString(2, email);
			ps.setInt(3, flatno);
			ps.setLong(4, mob);
			ps.setString(5, pass);
			ps.setInt(6, fammem);
			
			int result = ps.executeUpdate();  // Executes the insert operation
	        
	        if(result > 0) {
	            // Registration successful
	        	response.getWriter().println("Registration successful! You may <a href='login.jsp'> login.");
	        } else {
	        	response.getWriter().println("Registration failed. Please try again.");
	        }
		}
		catch(Exception e) {
			e.printStackTrace();
			response.getWriter().println("Sorry, we failed to connect: " + e.getMessage());
		}
	}
}

 
