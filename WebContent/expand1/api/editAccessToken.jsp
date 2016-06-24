<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*" %>
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
	String alias = request.getParameter("alias");
	String type = request.getParameter("type");
	String apiKey = request.getParameter("apiKey");
	String secretKey = request.getParameter("secretKey");
	String accessToken = request.getParameter("accessToken");
	
	String body = "{"
			+ "\"alias\":\"" + alias + "\","
			+ "\"type\":\"" + type + "\","
			+ "\"keyid\":\"" + apiKey + "\","
			+ "\"secret\":\"" + secretKey + "\","
			+ "\"token\":\"" + accessToken
			+ "\"}";
	
	String hostname = request.getServerName();
	String[] postResponse = new SecurityRequest(hostname).editAccessToken(username, alias, body, token);
	//out.print(postResponse[0]);
	//// System.out.println("Create token response value: " + postResponse[0]);
	
	String redirectURL = "../security_fields.jsp";
	
	/* if(postResponse[0].equals("1")){
		redirectURL = "../create_token.jsp?duplicate=true";
	} */
	
	response.sendRedirect(redirectURL);
%>