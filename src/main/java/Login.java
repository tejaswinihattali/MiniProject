import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class Login extends HttpServlet{
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	public void init() throws ServletException
	{
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
			ps = con.prepareStatement("select * from registration where username=? and password=?");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void destroy()
	{
		try {
			ps.close();
			con.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		
		
		String unm , pw, email;
		int flatno;
		unm = request.getParameter("s1");
		email = request.getParameter("s2");
		flatno = Integer.parseInt(request.getParameter("s3"));
		pw= request.getParameter("s4");
		out.println("<html>");
		out.println("<body bgcolor=wheat1>");
		try
		{
			ps.setString(1,unm);
			ps.setString(2, pw);
			ps.setInt(3, flatno);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				out.println("<h1>Welcome user to our website!!</h1>");
			}
			else {
				out.println("<h3>Sorry login failed</h3><br><br>");
				out.println("<h3><a href = login.html>Login again</a>");
			}
			rs.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		out.println("</body></html>");
		out.close();
	}

}
