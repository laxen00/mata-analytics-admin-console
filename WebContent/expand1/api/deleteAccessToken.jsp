<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*, java.util.*" %>
<jsp:include page="../etc/header.jsp"/>
<%
	String token = "";
	try {
		token = session.getAttribute("token").toString();
	}
	catch (Exception e) {
		token = "";
	}
	// System.out.println(token);
	if (token.isEmpty()) {
		%>
	<script>window.top.location.href="../index.jsp";</script>
		<%
	}
%>
<%
	String username = "";
	try {
		username = session.getAttribute("username").toString();
	}
	catch (Exception e) {
		username = "";
	}
	String alias = request.getParameter("alias").toString();
	
	String hostname = request.getServerName();
	String[] deleteResponse = new SecurityRequest(hostname).deleteAccessToken(username, alias, token);
	
	//out.print(deleteResponse[0]);
	String redirectURL = "../security_fields.jsp";
	response.sendRedirect(redirectURL);
%>