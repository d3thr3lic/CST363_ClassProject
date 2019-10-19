// Author Mitchell Saunders
import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddOrderLines")
public class AddOrderLines extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// database URL
	static final String DB_URL = "jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC";

	// Database credentials
	static final String USER = "root";
	static final String PASS = "MysqlPassword!2";

	@SuppressWarnings("static-access")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// SQL statements
		String isql = "INSERT INTO order_lines " + 
				"	(order_number, order_seq, partcode, quantity, line_value) " + 
				"SELECT ?, (	SELECT IFNULL(MAX(order_seq),0) AS highest_seq " + //first ? mark represents the order number that the user will enter 
				"			FROM order_lines " + 
				"			WHERE order_number = ?) + 1, ?, ?, list_price * ? " + //1st ? mark is order number, 2nd is part code, 3rd/4th ? mark is quantity  
				"FROM inventory " + 
				"WHERE partcode = ? "; //-- This ? mark referring to part code
		
		String usql = "UPDATE inventory i " + 
				"INNER JOIN ( " + 
				"	SELECT i.partcode, i.quantity AS available_qty " + 
				"	FROM inventory i " + 
				"	WHERE i.partcode = ? " + //? mark refers to part code  
				") vi ON i.partcode = vi.partcode AND ? <= vi.available_qty " + // ? mark represents quantity to be decreased. 
				"SET i.quantity = i.quantity - ? " + // ? represents quantity to be decreased 
				"WHERE i.partcode = ? "; // ? represents part code
		
		String site = "AddOrderLines.html";
		
		response.setContentType("text/html");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);

		try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
			
			// get data from form and convert to integer values
			int order_number = Integer.parseInt(request.getParameter("order_number"));
			String part_code = request.getParameter("part_code");
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			// prepare SQL select
			PreparedStatement pstmt1 =  conn.prepareStatement(isql);
			pstmt1.setInt(1, order_number);
			pstmt1.setInt(2, order_number);
			pstmt1.setString(3, part_code);
			pstmt1.setInt(4, quantity);
			pstmt1.setInt(5, quantity);
			pstmt1.setString(6, part_code);
			int row_count = pstmt1.executeUpdate();
			// System.out.println("Debug: insert rowcount = " + row_count);

			PreparedStatement pstmt2 = conn.prepareStatement(usql);
			pstmt2 = conn.prepareStatement(usql);
			
			pstmt2.setString(1, part_code);
			pstmt2.setInt(2, quantity);
			pstmt2.setInt(3, quantity);
			pstmt2.setString(4, part_code);
			pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			// Handle errors
			e.printStackTrace();
		}  
	}
}
