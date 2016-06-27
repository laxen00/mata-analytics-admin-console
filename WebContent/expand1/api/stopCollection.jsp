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
	out.print("start");
	// System.out.println(colId);
	
	String hostname = request.getServerName();
	String[][] stop = new ParseRequest(hostname).stopParse(colId, token);

	int indicator = 1;
   	do {
   		try {
		    Thread.sleep(1000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
   		
   		String[] collection = new CollectionRequest(hostname).getCollection(colId, token);
    	if (collection.length > 1) indicator = 1;
    	else indicator = 0;
   	}
   	while (indicator == 1);
   	// System.out.println(indicator);
   	out.print(indicator);
%>