// Author Ramon Lucindo

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class main_inventory
 */
@WebServlet("/main_inventory")
public class main_inventory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    
		// database URL
		static final String DB_URL = "jdbc:mysql://localhost/mydb?serverTimezone=UTC";

		// Database credentials
		static final String USER = "root";
		static final String PASS = "MysqlPassword!2";

		/**
		 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doPost(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {

			// SQL statements
			String sql = "SELECT * from inventory";
			response.setContentType("text/html"); // Set response content type
			PrintWriter out = response.getWriter();
			try ( Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)   ) {
				
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery();

				// start html output
				out.println("<!DOCTYPE HTML><html><body>");
				
				// begin table and  column headings
				out.println("<h1>MNR Canine Goods Inventory</h1>");
				out.println("<table>");
				out.println("<tr>");
				out.println("<th>Item code</th><th>Description</th>");
				out.println("<th>Quantity</th>");
				out.println("<th>List Price</th>");
				out.println("</tr>");
				
				// create row with data for each row from result set
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td>" + rs.getString("partcode") + "</td>");
					out.println("<td>" + rs.getString("description") + "</td>");
					out.println("<td>" + rs.getInt("quantity") + "</td>");
					out.println("<td>" + rs.getDouble("list_price") + "</td>");
					out.println("</tr>");
				}
				rs.close();
				
				// end of table 
				out.println("</table>");
				String time = new java.util.Date().toString();
				out.println("<p> Current time: " + time + "</p>");
				out.println("<p><a href='main_inventory.html'>Main Inventory Page</a></p>");
				out.println("</body></html>");

				pstmt.close();
			} catch (SQLException e) {
				// Handle errors
				e.printStackTrace();
			}  
		}
}
