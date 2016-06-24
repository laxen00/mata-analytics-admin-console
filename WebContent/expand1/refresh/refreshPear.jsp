<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*" %>
<%@ page import="java.util.*, org.json.*" %>
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

	String hostname = request.getServerName();
	String[] pearStatus = new PearRequest(hostname).getPearStatus(colId, token)[0].trim().split(" ");
	
	int percentage = 0;
	String percentageString = "";
	
	try{
		percentage = Integer.parseInt(pearStatus[1]);
		
		if(percentage == 100){
			String[] currentPear = new PearRequest(hostname).currentPear(colId, token);
			if (currentPear[1].equalsIgnoreCase("0")) {
				if(currentPear[0].contains(":")){
					String[] currentPearParts = currentPear[0].split(":");
					percentageString = currentPearParts[0].trim() + " (" + currentPearParts[1].trim() + ")"; 
				}
			}
		}else{
			percentageString = pearStatus[0] + " " + pearStatus[1];
		}
	}catch(Exception e){
		
	}
	
	out.print(percentageString);
%>