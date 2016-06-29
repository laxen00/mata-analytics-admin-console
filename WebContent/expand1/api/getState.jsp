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
	String colId = request.getParameter("colId").toString();
	String crawlerId = request.getParameter("crawlId").toString();
	String hostname = request.getServerName();
	String state = new CrawlerRequest(hostname).getState(colId, crawlerId, token)[0];
	
	int indicator = 0;
	
	if (state.equals("running")) indicator = 1;
	else indicator = 0;

	// System.out.println(indicator);
	out.print(indicator);
%>