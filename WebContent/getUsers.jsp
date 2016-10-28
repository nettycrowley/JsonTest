<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.rc.customer.User, com.fasterxml.jackson.core.JsonProcessingException, com.fasterxml.jackson.databind.ObjectMapper" %>
<%

	User[] users = {
			new User(100, "Aidan", "Killeen", false, "13/01/1970"), 
			new User(101, "Fred", "Flintstone", false, "1/1/1980"), 
			new User(102, "Barney", "Rubble", true, "1/1/1960")
			
	};

	

	ObjectMapper objectMapper = new ObjectMapper();
	String json = objectMapper.writeValueAsString(users);
%>
<%=json%>
