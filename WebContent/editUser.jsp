<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.rc.customer.*" %>

<%
boolean valid = true;
int id = -1;
String firstName = "";
String lastName = "";
boolean registered = false;
String dateOfBirth = "";

String validationMessage = "";
boolean finished = false;
String firstNameStyle = "";
String lastNameStyle = "";
String dateOfBirthStyle = "";

UserDb userDb = new UserDb();

if (request.getParameter("submit") == null ||
	request.getParameter("submit").equals("edit")) {
	//	this is the first time through
	id = request.getParameter("id")==null? -1 : 
		Integer.parseInt(request.getParameter("id"));

	User user = userDb.getUser(id);
	if (user == null) {
		finished = true;
	} else {
		firstName = user.getFirstName();
		lastName = user.getLastName();
		registered = user.isRegistered();
		dateOfBirth = user.getDateOfBirth();
	}	
} else {
	//	read the parameters
	id = request.getParameter("id")==null? -1 : 
		Integer.parseInt(request.getParameter("id"));
	
	firstName = request.getParameter("firstName");
	lastName = request.getParameter("lastName");
	registered = request.getParameter("registered")!=null;
	dateOfBirth = request.getParameter("dateOfBirth");
	//	validate the parameters
		//	validate the parameters
	if (firstName == null || firstName.equals("")) {
		//	problem with firstName
		valid = false;
		validationMessage += "please fill in firstName<br>";
		firstNameStyle = "formError";
	}
	if (lastName == null || lastName.equals("")) {
		//	problem with lastName
		valid = false;
		validationMessage += "please fill in lastName<br>";
		lastNameStyle = "formError";
	}
	if (dateOfBirth == null || dateOfBirth.equals("")) {
		//	problem with dateOfBirth
		valid = false;
		validationMessage += "please fill in dateOfBirth<br>";
		dateOfBirthStyle = "formError";
	}

	if (valid) {
		//	do the updates
		
		User user = new User(id, firstName, lastName, registered, dateOfBirth);
		userDb.update(user);
		
		finished = true;
		
	}
	
}



%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<style> 

	.formError {
		background-color: #cc0000;
	}
	
</style>

</head>
<body>

<% if (!finished) { %>
	<h1>Edit User</h1>
	<a href="users.jsp">Home</a><br>
	
	<%=validationMessage%>
	
	<form action="editUser.jsp" method="get">
	
	ID:<input type="test" name="id" id="id" value="<%=id %>" READONLY><br>
	Firstname:<input type="text" name="firstName" id="firstName" value="<%=firstName%>" class="<%=firstNameStyle%>">*<br>
	Lastname:<input type="text" name="lastName" id="lastName" value="<%=lastName%>" class="<%=lastNameStyle%>">*<br>

	Registered:<input type="checkbox" name="registered" id="registered" <%=registered ? "checked" : ""%>><br>
	
	Date of birth:<input type="text" name="dateOfBirth" id="dateOfBirth" value="<%=dateOfBirth%>" class="<%=dateOfBirthStyle%>">*<br>
	
	<br>
	<input type="submit" name="submit" id="submit" value="submit">
	</form>
<% } else {%>
	<h1>User Edited Successfully</h1>
	<a href="users.jsp">Home</a><br>
	
<% } %>

</body>
</html>