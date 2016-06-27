<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="
apiRequest.*,
org.json.JSONObject,
org.json.JSONArray
" %>

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
	String dictName = request.getParameter("dictName");
	String hostname = request.getServerName();
		JSONArray arr = new DictRequest(hostname).getKeywords(colId, dictName, token);
	
 	out.print(arr.toString());
%>