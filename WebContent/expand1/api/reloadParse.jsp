<%@ page import="apiRequest.*, java.util.*, org.json.*" %>

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
	out.print("start");
	// System.out.println(colId);
	
	String hostname = request.getServerName();
	String[] reload = new ParseRequest(hostname).reloadParse(colId, token);
   	
   	// System.out.println(reload[1]);
   	out.print(reload[1]);
%>