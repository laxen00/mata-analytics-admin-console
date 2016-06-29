<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="
	auth.Authentication,
	apiRequest.LoginRequest
"%>

<%
	String username = request.getParameter("username").toLowerCase();
	String password = request.getParameter("password");
	String usernameEncrypt = Authentication.encryptData(username);
	String passwordEncrypt = Authentication.encryptData(password);
	
	String startarg = "{";
	String argdata = "\"username\":\""+usernameEncrypt+"\",\"password\":\""+passwordEncrypt+"\"";
	String endarg = "}";
	String args = startarg + argdata + endarg;
	// System.out.println(args);
	
	int indicator = 0;
	
	do {
		String hostname = request.getServerName();
		String[] login = new LoginRequest(hostname).login(args);
		try {
		    Thread.sleep(1000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
		
		// System.out.println("login length:"+login.length);
		
		if (login.length != 3) {
			session.setAttribute("message", "Wrong username/password");
			response.sendRedirect("../etc/redirect.jsp");
		}
		
		else {
			String[] checkSession = new LoginRequest(hostname).checkSession(login[1]);
			
			if (checkSession[1].equalsIgnoreCase("0")) {
				indicator = 1;
				session.setAttribute("token", login[1]);
				session.setAttribute("username", username);
				// System.out.println(session.getAttribute("token").toString());
				%>
					<script>window.top.location.href="../../index.jsp";</script>
				<%
			}
			else {
				indicator = 0;
			}
		}
	}while (indicator !=1);
%>


