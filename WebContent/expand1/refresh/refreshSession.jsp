<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*, java.util.*" %>

<% String token = ""; %>
<% try { token = session.getAttribute("token").toString(); } catch (Exception e) { token = "";} %>
<%
	String hostname = request.getServerName();
	String[] checkSession = new LoginRequest(hostname).checkSession(token);
	
	int indicator = 0;
	
	if (checkSession[1].equalsIgnoreCase("1")) {
		// System.out.println("Session Expired");
		session.removeAttribute("token");
		session.setAttribute("message", checkSession[0]);
		indicator = 0;
	}
	else {
		token = session.getAttribute("token").toString();
		// System.out.println("token (header):"+token);
		indicator = 1;
	}

	// System.out.println(indicator);
	out.print(indicator);
%>