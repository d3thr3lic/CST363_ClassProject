<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost/";
	// be sure to change these to the proper database/user/passwd
	String database = "mydb?serverTimezone=UTC";
	String userid = "root";
	String password = "MysqlPassword!2";
	
	try {
	Class.forName(driver);
	} catch (ClassNotFoundException e) {
	e.printStackTrace();
	}
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	//This page is a simple HTML page that takes in an input for the Java servlet
	// that is handled when redirected.
	// The intention is to view existing orders made, so it needs to display existing
	// orders. So JSP was used to do this as standard HTML can't handle this alone.
	%>
<!DOCTYPE html>
<html>
   <head>
      <title>Invoice Order Number</title>
      <style> table,th,td {	
              border: 1px solid black;
		      border-collapse: collapse}
			  th,td{
			  padding: 5px;
			  text-align: center;
      </style>
   </head>
      <body>
      <h1>Display Invoice Information</h1>
         <p>Enter Order Number to from recent orders list below</p>
      
      <form action = "DisplayInvoice" method = "POST">
         Order Number: <input type = "text" name = "name">
            <input type = "submit" value = "Submit" /> 
      </form>
      	<br>
      	
 		<a href="DisplayInventory.jsp">Inventory</a>
 		<br>
 			<h3>Recent Orders</h3>
 		<table>
 		<tr>
 			<th>Customer</th>
 			<th>Order Number</th>
 			<th>Date</th>
 		</tr>
 			
 <%
 //This is using Java Server Pages to handle a simple
 // query on screen for the order history. 
	try{
	connection = DriverManager.getConnection(connectionUrl+database, userid, password);
	statement=connection.createStatement();
	String sql ="SELECT c.customer_name , oh.order_number, oh.order_date " +
	        "FROM order_header oh JOIN customers c " +
	        "ON oh.customer_id = c.customer_id " +
	        "ORDER BY order_date;";
	resultSet = statement.executeQuery(sql);
	while(resultSet.next()){
	%>
	<tr>
	<td><%=resultSet.getString("customer_name") %></td>
	<td><%=resultSet.getString("order_number") %></td>
	<td><%=resultSet.getString("order_date") %></td>
	</tr>
	<%
	}
	connection.close();
	} catch (Exception e) {
	e.printStackTrace();
	}
	%>
	</table>
   </body>
</html>



