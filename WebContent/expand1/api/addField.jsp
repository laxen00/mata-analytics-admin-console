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
	String fieldname = request.getParameter("fieldname");
	String type = request.getParameter("type");
	String multivalue = request.getParameter("multivalue");
	
	String openarg = "{";
	String data = "\"name\":\""+fieldname+"\",\"type\":\""+type+"\",\"multivalue\":\""+multivalue+"\"";
	String closearg = "}";
	String args = openarg + data + closearg;
	// System.out.println(args);
	
	String hostname = request.getServerName();
	String[][] addField = new FieldRequest(hostname).addField(colId, token, args);
	
	String redirectURL = "../index_fields_ed.jsp";
	response.sendRedirect(redirectURL);
%>