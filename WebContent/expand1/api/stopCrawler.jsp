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
   	String[][] stop = new CrawlerRequest(hostname).stopCrawler(colId, crawlerId, token);
   	
   	int indicator = 1;
   	do {
   		try {
		    Thread.sleep(1000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
   		String state = new CrawlerRequest(hostname).getState(colId, crawlerId, token)[0];
    	if (state.equals("not running")) indicator = 0;
    	else indicator = 1;
   	}
   	while (indicator == 1);
   	// System.out.println(indicator);
   	out.print(indicator);
    %>