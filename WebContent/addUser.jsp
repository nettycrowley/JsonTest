<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="com.rc.customer.*" %>
<%
String firstName = "";
String lastName = "";
boolean registered = false;
String dateOfBirth = "";
boolean agreeTermsAndConditions = false;

boolean valid = true;
String validationMessage = "";
boolean finished = false;
String firstNameStyle = "";
String lastNameStyle = "";
String dateOfBirthStyle = "";
String agreeTermsAndConditionsStyle = "";

if (request.getParameter("firstName") != null) {
	//	form has been submitted
	
	//	read the parameters
	firstName = request.getParameter("firstName");
	lastName = request.getParameter("lastName");
	registered = request.getParameter("registered")!=null;
	dateOfBirth = request.getParameter("dateOfBirth");
	agreeTermsAndConditions = request.getParameter("agreeTermsAndConditions")!=null;

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
	if (!agreeTermsAndConditions) {
		valid = false;
		validationMessage += "You must agree to the terms and conditions";
		agreeTermsAndConditionsStyle = "formError";
	}
	
	if (valid) {
		//	process the request
		UserDb userDb = new UserDb();
		
		User user = new User(-1, firstName, lastName, 
							 registered, dateOfBirth);
		
		userDb.create(user);
		
		userDb.close();

		finished = true;
	}
	
} else {
	//	this is the first call
}

%>
<!DOCTYPE html>
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
	<h1>Add User</h1>
	<a href="users.jsp">Home</a><br>
	
	<%=validationMessage%>
	
	<form action="addUser.jsp" method="get">
	
	Firstname:<input type="text" name="firstName" id="firstName" value="<%=firstName%>" class="<%=firstNameStyle%>" required>*<br>
	Lastname:<input type="text" name="lastName" id="lastName" value="<%=lastName%>" class="<%=lastNameStyle%>" required>*<br>

	Registered:<input type="checkbox" name="registered" id="registered" <%=registered ? "checked" : ""%>><br>
	
	Date of birth:<input type="date" name="dateOfBirth" id="dateOfBirth" value="<%=dateOfBirth%>" class="<%=dateOfBirthStyle%>">*<br>
	
	<br>
	<div class="<%=agreeTermsAndConditionsStyle%>">
		I Agree To The Terms And Conditions:<input type="checkbox" name="agreeTermsAndConditions" id="agreeTermsAndConditions" required><br>
	</div>
	<input type="submit" name="submit" id="submit" value="submit">
	</form>
<% } else {%>
	<h1>User Added Successfully</h1>
	<a href="users.jsp">Home</a><br>
	
<% } %>

</body>
</html>