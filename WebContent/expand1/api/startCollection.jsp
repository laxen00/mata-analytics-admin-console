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
	//out.print("start");
	//// System.out.println(colId);
	
	String hostname = request.getServerName();
	String[][] start = new ParseRequest(hostname).startParse(colId, token);

	int indicator = 1;
   	do {
   		try {
		    Thread.sleep(1000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
   		
   		String[] collection = new CollectionRequest(hostname).getCollection(colId, token);
    	if (collection.length < 2) indicator = 1;
    	else {
    		indicator = 0;
    		ArrayList<String> outArrayList = new ArrayList<String>();
    		outArrayList.add(collection[1]);
    		outArrayList.add(collection[2]);
    		outArrayList.add(collection[3]);
    		String[] outArray = outArrayList.toArray(new String[outArrayList.size()]);
    		JSONArray jsonArray = new JSONArray(outArray);
    		out.print(jsonArray.toString());
    	}
       	//// System.out.println(indicator);
   	}
   	while (indicator == 1);
%>