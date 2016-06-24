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
	String colId = request.getParameter("create_colId");
	String dictName = request.getParameter("create_dictName");
	String body = "{"
			+ "\"custom\":["
			+ "{\"dictionary\":\"\"}"
			+ "]"
			+ "}";
	String hostname = request.getServerName();
	JSONObject create = new DictRequest(hostname).createDict(colId, dictName, body, token);
		if (!create.getString("value").equalsIgnoreCase("0")) session.setAttribute("createMessage", create.getString("message"));
	
 	String redirectURL = "../user_dict.jsp?colId="+colId;
 	response.sendRedirect(redirectURL);
%>