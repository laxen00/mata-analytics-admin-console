<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="
	java.util.*,
	java.io.*,
	apiRequest.*
"%>
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

	String colId = session.getAttribute("colId").toString();
	// System.out.println(colId);
	
	String hostname = request.getServerName();
	String[][] installPear = new PearRequest(hostname).uninstallPear(colId, token);
	
	String redirectURL = "../annotators.jsp";
    response.sendRedirect(redirectURL);
%>