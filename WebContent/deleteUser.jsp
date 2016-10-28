<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.rc.customer.*, java.util.ArrayList" %>

<%



%>
<%
boolean showForm = false;
boolean showAreYouSure = false;
boolean cancelled = false;
UserDb userDb = new UserDb();
ArrayList<User> users = null;
int id = request.getParameter("id") == null ? -1 : Integer.parseInt(request.getParameter("id"));

//	if its the first time then 
if (request.getParameter("submit") == null) {
	//	this is the first time
	//	show the form
	showForm = true;
	//	read all the users
	users = userDb.getAll();
	
//	else if its the second time then 
} else if (request.getParameter("submit").equals("delete")) {
	//	this is the second time
	//	display the Are You Sure form
	showAreYouSure = true;
	
} else if (request.getParameter("submit").equals("yes")) {
	//	this is the third time and they selected yes
	//	do the delete
	userDb.delete(id);
	cancelled = false;

} else if (request.getParameter("submit").equals("no")) {
	//	this is the third time and they selected no
	//	do nothing
	cancelled = true;
}
%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% if (showForm) { %>
<h3>Delete User</h3>
<a href="users.jsp">Home</a><br>

<form action="deleteUser.jsp" method="get">

	<select name="id" id="id" size="6">
	<% for (User user : users) { %>
	
		<option value="<%=user.getId()%>">
			<%=user.getFirstName() + " " + user.getLastName() %>
		</option>
	<% } %>
	</select>
	<input type="submit" name="submit" value="delete">
</form>

<% } else if (showAreYouSure) { %>
<h3>Are You Sure?</h3>
<a href="users.jsp">Home</a><br>
<form action="deleteUser.jsp" method="get">

Delete user <%=id%>?<br>

<input type="hidden" name="id" id="id" value="<%=id%>"><br>


<input type="submit" name="submit" value="yes">
<input type="submit" name="submit" value="no">
</form>

<% } else { %>
<h3>Finished</h3>
<a href="users.jsp">Home</a><br>
	<% if (cancelled) { %>
		<p>Operation was cancelled</p>	
	<% }else { %>
		<p>Delete completed successfully</p>
	<% } %>

<% } %>



</body>
</html>