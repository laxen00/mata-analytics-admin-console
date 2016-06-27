<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*" %>
<%@ page import="java.util.*, org.json.*" %>
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
	String username = session.getAttribute("username").toString();
	String hostname = request.getServerName();
	String[][] apptoken = new SecurityRequest(hostname).getTokens(username, token);
	JSONArray jsonArray = new JSONArray();
	for (int i=0;i < apptoken.length;i++) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("type", apptoken[i][0]);
		jsonObject.put("token", apptoken[i][1]);
		jsonObject.put("alias", apptoken[i][2]);
		jsonObject.put("keyid", apptoken[i][3]);
		jsonObject.put("secret", apptoken[i][4]);
		jsonArray.put(jsonObject);
	}
	// System.out.println(jsonArray);
	out.print(jsonArray.toString());
%>