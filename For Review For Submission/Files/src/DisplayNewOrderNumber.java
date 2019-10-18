/**MNR Canine Goods
 * DisplayNewOrderNumber
 * Author @MitchellSaunders
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DisplayNewOrderNumber")
public class DisplayNewOrderNumber extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// database URL
	static final String DB_URL = "jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC";

	// Database credentials
	static final String USER = "root";
	static final String PASS = "MysqlPassword!2";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// SQL statements
		// This sql statement will be inserting a new entry into the order header.
		// This insert statement also takes a copy of the customer's billing and shipping addresses
		// just in case the address table is ever updated, a record of where it was sent and billed to can be maintained.
		String sql1 = "INSERT INTO order_header " + 
				"	(total_order_value, customer_id, ship_address, ship_zip_code, " + 
				"		ship_state, ship_phone,	bill_address, bill_zip_code, bill_state, bill_phone) " + 
				"SELECT " + 
				"	0, ?, " + 
				"    s.address, s.zip_code, s.state, s.phone, " + 
				"    b.address, b.zip_code, b.state, b.phone " + 
				"FROM " + 
				"    customer_addresses s JOIN customer_addresses b " + 
				"		ON s.customer_id = b.customer_id " + 
				"WHERE " + 
				"    s.address_type = 'SHIP' " + 
				"		AND b.address_type = 'BILL' " + 
				"        AND s.customer_id = 1 " + 
				"        AND b.customer_id = 1";
		// This sql statement will contain the most recently created order number, which will be the order number
		// that was created by the above insert statement.
		String sql2= "SELECT MAX(order_number) as most_recently_created_order_number " + 
				"FROM order_header";

		// Set response content type
		response.setContentType("text/html"); 
		PrintWriter out = response.getWriter();
		
		// get input data from form
		String customerId = request.getParameter("custId");

		try ( Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) 
		{
			PreparedStatement pstmt1 = conn.prepareStatement(sql1);
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt1.setString(1, customerId); 
			pstmt1.executeUpdate();
			//Wait a moment before running the second select statement, just in case it needs a moment to properly insert into the database
			Thread.sleep(500);
			ResultSet rs = pstmt2.executeQuery();

			//start html output
			out.println("<!DOCTYPE HTML><html><head>"
					+ "<title>New Order Number</title>"
					+ "</head><body>");
			out.println("<h1>Your Order Has Been Created</h1>");
			out.println("<h3>Your new order number is:");
			while (rs.next()) 
			{
				out.println(rs.getString("most_recently_created_order_number"));
			}
			out.println("</h3><p>Use this number to add order lines to this order.</p>");
			out.println("<p><a target=\"_blank\" rel=\"noopener noreferrer\" href=\"AddOrderLines.html\">Click Here to Add Items to an Order</a></p>");
			out.println("</body></html>");
			pstmt1.close();
			pstmt2.close();
			
		} catch (SQLException e) {
			// Handle errors
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}  
	}
}
