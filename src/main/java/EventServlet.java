import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/events")
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        Connection conn = null;
        Statement stmt = null;
        JSONArray eventsArray = new JSONArray();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/usersregister", "root", "");

            stmt = conn.createStatement();
            String sql = "SELECT id, title, start, end FROM events";
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                JSONObject eventObj = new JSONObject();
                eventObj.put("id", rs.getInt("id"));
                eventObj.put("title", rs.getString("title"));
                eventObj.put("start", rs.getString("start"));
                eventObj.put("end", rs.getString("end"));
                eventsArray.put(eventObj);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) conn.close();
            } catch (Exception e) {}
        }

        response.getWriter().print(eventsArray.toString());
    }
}
