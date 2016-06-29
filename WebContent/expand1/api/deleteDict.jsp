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
	String colId = request.getParameter("del_colId");
	String dictName = request.getParameter("del_dictName");
	String hostname = request.getServerName();
	JSONObject delete = new DictRequest(hostname).deleteDict(colId, dictName, token);
		if (!delete.getString("value").equalsIgnoreCase("0")) session.setAttribute("deleteMessage", delete.getString("message"));
	
 	String redirectURL = "../user_dict.jsp?colId="+colId;
 	response.sendRedirect(redirectURL);
%>