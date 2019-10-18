//Author Ramon Lucindo

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
 * Servlet implementation class total_cost
 */
@WebServlet("/total_cost")
public class total_cost extends HttpServlet {
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

				
				response.setContentType("text/html"); // Set response content type
				PrintWriter out = response.getWriter();
				
				
				try ( Connection conn = DriverManager.getConnection(DB_URL, USER, PASS) )					
				{
					
					// prepare select
					String query = "SELECT SUM(list_price * quantity) from inventory";

				    // create the java statement
					PreparedStatement stmt = conn.prepareStatement(query);
					
					 // execute the query, and get a java resultset
					ResultSet rs = stmt.executeQuery();	
				       


					// start html output
					out.println("<!DOCTYPE HTML><html><body>");
					rs.next();
					// show output
					out.println("<h1>MNR Canine Goods Inventory</h1>");
					out.println("<p>Total Value of Inventory</p>");
					out.println("<p>" + rs.getString(1) + "</p>");
					String time = new java.util.Date().toString();
					out.println("<p> Current time: " + time + "</p>");
					out.println("<p><a href='main_inventory.html'>Main Inventory Page</a></p>");
					
					out.println("</body></html>");
					
					rs.close();
					stmt.close();
					
				}  catch (SQLException e) {
					// Handle errors
					e.printStackTrace();
				}  
			}
}
