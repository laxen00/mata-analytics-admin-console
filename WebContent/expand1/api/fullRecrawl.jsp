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
	String colId = request.getParameter("colId");
	String crawlerId = request.getParameter("crawlerId");
	String hostname = request.getServerName();
	String[][] fullRecrawl = new CrawlerRequest(hostname).fullRecrawl(colId, crawlerId, token);
	
	String redirectURL = "../index.jsp";
    response.sendRedirect(redirectURL);
%>