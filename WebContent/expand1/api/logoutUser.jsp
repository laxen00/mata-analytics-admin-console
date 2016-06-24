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
	String hostname = request.getServerName();
	String[] logout = new LoginRequest(hostname).logout(token);
	session.removeAttribute("message");
	session.removeAttribute("token");
	session.removeAttribute("username");
	%>
	<script>window.top.location.href="../../index.jsp";</script>
	<%
%>