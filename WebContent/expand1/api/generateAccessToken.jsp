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
	String type = request.getParameter("type").toString();
	String apiKey = request.getParameter("apiKey").toString();
	String secretKey = request.getParameter("secretKey").toString();
	
	String hostname = request.getServerName();
	
	String accessToken = "";
	if(type.equals("facebook")){
		accessToken = new SecurityRequest(hostname).getFacebookToken(apiKey, secretKey, token);
	}else if(type.equals("twitter")){
		accessToken = new SecurityRequest(hostname).getTwitterToken(apiKey, secretKey, token);
	}else if(type.equals("twitter_bluemix")){
		accessToken = apiKey + ":" + secretKey;
	}else if(type.equals("youtube")){
		accessToken = apiKey;
	}
	
	out.print(accessToken.trim());
%>