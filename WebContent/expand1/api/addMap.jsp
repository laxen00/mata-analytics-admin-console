<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<%@ page import="apiRequest.*" %>

<%
	String colId = session.getAttribute("colId").toString();
	String annoname = request.getParameter("annoname").toString();
	String featurename = request.getParameter("featurename").toString();
	String fieldname = request.getParameter("fieldname").toString();

	if (featurename.equalsIgnoreCase("null") || fieldname.equalsIgnoreCase("null")) {
		session.setAttribute("facet_message", "Must select a feature and a field");
	 	String redirectURL = "../facet_map.jsp";
	 	response.sendRedirect(redirectURL);
	}
	

	
	String openarg = "{";
	String data = "\"name\":\""+annoname+"\",\"feature\":\""+featurename+"\",\"fieldname\":\""+fieldname+"\"";
	String closearg = "}";
	String args = openarg + data + closearg;
	// System.out.println(args);
	
	String hostname = request.getServerName();
	String[][] addField = new FieldRequest(hostname).addFieldMapping(colId, token, args);
	
	String redirectURL = "../facet_map.jsp";
	response.sendRedirect(redirectURL);
%>