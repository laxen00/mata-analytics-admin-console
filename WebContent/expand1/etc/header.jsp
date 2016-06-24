<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*" %>
    <%
		String token = "";
		try {
			token = session.getAttribute("token").toString();
		}
		catch(Exception e) {
			token = "";
			session.removeAttribute("token");
			response.sendRedirect("redirect.jsp");
		}
		if (token.equalsIgnoreCase("")) {
			session.removeAttribute("token");
			session.removeAttribute("message");
			response.sendRedirect("redirect.jsp");
		}
		String hostname = request.getServerName();
		String[] checkSession = new LoginRequest(hostname).checkSession(token);
		if (checkSession[1].equalsIgnoreCase("1")) {
			// System.out.println("Session Expired, redirecting...");
			session.removeAttribute("token");
			session.setAttribute("message", checkSession[0]);
			response.sendRedirect("redirect.jsp");
		}
		else {
			token = session.getAttribute("token").toString();
			// System.out.println("token (header):"+token);
		}
	%>