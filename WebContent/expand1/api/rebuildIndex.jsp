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
	String[][] start = new ParseRequest(hostname).rebuildIndex(colId, token);
	
	String[] rebuildStatus = new ParseRequest(hostname).checkRebuildStatus(colId, token);
	
	int indicator = 1;
   	/* do {
   		try {
		    Thread.sleep(30000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
   		String[] rebuildStatus = new ParseRequest(hostname).checkRebuildStatus(colId, token);
    	if (rebuildStatus[0].equalsIgnoreCase("idle")) 
    		indicator = 0;
    	else 
    		indicator = 1;
   	} 
   	while (indicator == 1); */
   	
   	if (rebuildStatus[0].equalsIgnoreCase("idle")) 
   		indicator = 0;
	else 
		indicator = 1; 
   	
   	// System.out.println(indicator);
   	out.print(indicator);
%>