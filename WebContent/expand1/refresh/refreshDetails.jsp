<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*" %>
<%@ page import="java.util.*, org.json.*" %>
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

	String hostname = request.getServerName();
	String[] collection = new CollectionRequest(hostname).getCollection(colId, token);
	String colSize = "";
	String numDocs = "";
	String colVersion = "";
	String currentPear = new PearRequest(hostname).currentPear(colId, token)[0];
	if (collection.length > 1) {
		colSize = collection[1];
		numDocs = collection[2];
		colVersion = collection[3];
	}
	else {

	}
	ArrayList<String> outArrayList = new ArrayList<String>();
	outArrayList.add(colSize);
	outArrayList.add(numDocs);
	outArrayList.add(colVersion);
	outArrayList.add(currentPear);
	String[] outArray = outArrayList.toArray(new String[outArrayList.size()]);
	JSONArray jsonArray = new JSONArray(outArray);
	out.print(jsonArray.toString());
%>