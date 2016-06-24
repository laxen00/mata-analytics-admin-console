<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	String colDesc = request.getParameter("colDesc");
	String username = session.getAttribute("username").toString();
	
	String openarg = "{";
	String argproperties = "\"collectionId\":\""+colId+"\",\"username\":\""+username+"\"";
	String closearg = "}";
	String args = openarg + argproperties + closearg;
	// System.out.println(args);
	
	String hostname = request.getServerName();
	String[] create = new CollectionRequest(hostname).createCollection(args, token);
	
	if (!create[0].equalsIgnoreCase("0")) session.setAttribute("createMessage", create[1]);
	
	String redirectURL = "../security_fields.jsp";
	response.sendRedirect(redirectURL);
%>