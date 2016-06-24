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
	// System.out.println("0");
	String colId = session.getAttribute("colId").toString();
	// System.out.println("1");
	String featurename = request.getParameter("featurename").toString();
	// System.out.println("2");
	String fieldname = request.getParameter("fieldname").toString();
	// System.out.println("3");

	
	String openarg = "{";
	String data = "\"featurename\":\""+featurename+"\",\"fieldname\":\""+fieldname+"\"";
	String closearg = "}";
	String args = openarg + data + closearg;
	// System.out.println(args);
	
	String hostname = request.getServerName();
	String[][] addField = new FieldRequest(hostname).deleteFieldMapping(colId, token, args);
	
	String redirectURL = "../facet_map.jsp";
	response.sendRedirect(redirectURL);
%>