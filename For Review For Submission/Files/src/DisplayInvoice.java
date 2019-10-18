/**MNR Canine Goods
 * Invoice displaying Servlet
 * Author @NicholasSaunders
 */

/*
 * Servlets purpose is to take in order customer orders, 
 * displays the order in an invoiced format
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisplayInvoice")
public class DisplayInvoice extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// database URL
	static final String DB_URL = "jdbc:mysql://localhost/mydb?serverTimezone=UTC";

	// Database credentials
	static final String USER = "root";
	static final String PASS = "MysqlPassword!2";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// SQL statements
		String sql = "SELECT * FROM DisplayInvoiceInfo WHERE order_number LIKE ?;";

		String updateSql = "UPDATE order_header SET total_order_value = " +
						   "(SELECT SUM(line_value) FROM order_lines " +
				           "WHERE order_number LIKE ?) ";
		
		// Set response content type
		response.setContentType("text/html"); 
		PrintWriter out = response.getWriter();
		
		// get input data from form
		String name = request.getParameter("name");

		try ( Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) 
		{

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name); 
			ResultSet rs = pstmt.executeQuery();
			
			PreparedStatement ps2 = conn.prepareStatement(updateSql);
			ps2.setString(1, name);
			ps2.executeUpdate();
			ps2.close();

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name); 
			rs = pstmt.executeQuery();
			
			//start html output
			//some basic styling has been applied for ease of readability
			out.println("<!DOCTYPE HTML><html><head>"
					+ "<title>Invoice</title>"
					+ "<style> table,th,td {"
					+ "		border: 1px solid black;"
					+ "		border-collapse: collapse}"
					+ "		th,td{"
					+ "		padding: 5px;"
					+ "		text-align: center;"
					+ "</style></head>"
					+ "<body>");
						
			// begin table and  column headings
			out.println("<h1>Customer Invoice</h1>");

			//order_header table
			out.println("<h3>Order Information</h3>");
			out.println("<table style=\"width:100%\">");
			out.println("<tr>");
			out.println("<th>Customer</th>"
					  + "<th>ID</th>"
					  + "<th>Order Number</th>"
					  + "<th>Date</th>"
					  + "<th>Total Order Value</th>");
			out.println("</tr>");
			   //rs.first is intended to set the data back to the top of the columns.
			   //all data for billing and shipping are contained within each line of the order
			   rs.first();
			out.println("<tr>");
			out.println("<td>" + rs.getString("customer_name") + "</td>"); 
			out.println("<td>" + rs.getString("customer_id") + "</td>"); 
			out.println("<td>" + rs.getString("order_number") + "</td>");
			out.println("<td>" + rs.getString("order_date") + "</td>");
			out.println("<td>" + rs.getString("total_order_value") + "</td>");
			out.println("</tr>");
	           out.println("</table>");
			
			out.println("<h3>Shipping Information</h3>");
			out.println("<table style=\"width:100%\">");
			out.println("<tr>");
			out.println("<th>Address</th>" 
					  + "<th>Zip</th>"
					  + "<th>State</th>"
					  + "<th>Phone</th>");
			out.println("</tr>");

			   rs.first();				
			out.println("<tr>");
			out.println("<td>" + rs.getString("ship_address") + "</td>");
			out.println("<td>" + rs.getString("ship_zip_code") + "</td>");
			out.println("<td>" + rs.getString("ship_state") + "</td>");
			out.println("<td>" + rs.getString("ship_phone") + "</td>");
			out.println("</tr>");
	           out.println("</table>");	
			
			out.println("<h3>Billing Information</h3>");	
			out.println("<table style=\"width:100%\">");
			out.println("<tr>");
			out.println("<th>Address</th>" 
					  + "<th>Zip</th>"
					  + "<th>State</th>"
					  + "<th>Phone</th>");
			out.println("</tr>");
			
			   rs.first();
			out.println("<tr>");
			out.println("<td>" + rs.getString("bill_address") + "</td>");
			out.println("<td>" + rs.getString("bill_zip_code") + "</td>");
			out.println("<td>" + rs.getString("bill_state") + "</td>");
			out.println("<td>" + rs.getString("bill_phone") + "</td>");
			out.println("</tr>");
			   out.println("</table>");
	
			//order lines table starts here
			out.println("<h3>Lines</h3>");
			out.println("<table style=\"width:100%\">");
			out.println("<tr>");
			out.println("<th>Order Seq</th>"
					  + "<th>PartCode</th>"
					  + "<th>Quanity</th>"
					  + "<th>Value</th>");
			out.println("</tr>");
			
			//resets back up to top of data set
			rs.beforeFirst();
			// create row with data for each row from result set
			while (rs.next()) 
			{
				out.println("<tr>");
				out.println("<td>" + rs.getString("order_seq") + "</td>");
				out.println("<td>" + rs.getString("partcode") + "</td>");
				out.println("<td>" + rs.getString("quantity") + "</td>");
				out.println("<td>" + rs.getString("line_value") + "</td>");
				out.println("</tr>"); 
			}
			rs.close();
		
			out.println("</table>");
			//End of tables
			out.println("</body></html>");

			pstmt.close();
			
		} catch (SQLException e) {
			// Handle errors
			e.printStackTrace();
		}  
	}
}
