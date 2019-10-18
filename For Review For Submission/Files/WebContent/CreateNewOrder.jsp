<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
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
	//This html page is designed to allow for new order creation based off of customer id.
	//To aid in the selection of customer ID, a table with all customers is provided at the bottom.
	%>
<!DOCTYPE html>
<html>
   <head>
      <title>New Order Creation</title>
      <style> table,th,td {	
              border: 1px solid black;
		      border-collapse: collapse}
			  th,td{
			  padding: 5px;
			  text-align: center;
      </style>
   </head>
      <body>
      <h1>Create New Order</h1>
         <p>Enter Customer Number to Create a New Order</p>
      
      <form action = "DisplayNewOrderNumber" method = "POST">
         Customer ID: <input type = "text" name = "custId">
            <input type = "submit" value = "Submit" /> 
      </form>
      	<br>
 		
 		<br>
 			<h3>All Customers</h3>
 		<table>
 		<tr>
 			<th>Customer ID</th>
 			<th>Customer Name</th>
 		</tr>
 			
 <%
 //This is using Java Server Pages to handle a simple
 // query on screen to display all customers and their ids. 
	try{
	connection = DriverManager.getConnection(connectionUrl+database, userid, password);
	statement=connection.createStatement();
	String sql ="SELECT * FROM customers";
	resultSet = statement.executeQuery(sql);
	while(resultSet.next()){
	%>
	<tr>
	<td><%=resultSet.getString("customer_id") %></td>
	<td><%=resultSet.getString("customer_name") %></td>
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



