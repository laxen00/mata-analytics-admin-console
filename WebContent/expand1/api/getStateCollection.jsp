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
	
	String hostname = request.getServerName();
	String[][] crawlers = new CrawlerRequest(hostname).getCrawlers(colId, token);
	
	int indicator = 0;
	
	for (int i=0;i<crawlers.length;i++) {
		String crawlerId = crawlers[i][0];
		String state = new CrawlerRequest(hostname).getState(colId, crawlerId, token)[0];
		
		if (state.equals("running")) {
			indicator = 1;
			break;
		}
		else {
			indicator = 0;
			continue;
		}
	}
	// System.out.println(indicator);
	out.print(indicator);
%>