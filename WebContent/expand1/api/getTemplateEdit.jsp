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

// 	String url = request.getParameter("url");
	String colId = request.getParameter("colId");
	String displayname = request.getParameter("displayname");
	String useragent = request.getParameter("useragent");
	String url = request.getParameter("url");
	String crawlertype = request.getParameter("optionsRadios");
	String keyword = request.getParameter("keyword");
	String prog = request.getParameter("prog");
	String progsince = request.getParameter("progsince");
	
	session.setAttribute("colId", colId);
	session.setAttribute("displayname", displayname);
	session.setAttribute("useragent", useragent);
	session.setAttribute("url", url);
	session.setAttribute("type", crawlertype);
	session.setAttribute("keyword", keyword);
	session.setAttribute("prog", prog);
	session.setAttribute("progsince", progsince);

	String crawlerId = "";
	
	try {
		crawlerId = request.getParameter("crawlerId").toString();
		if (!crawlerId.equalsIgnoreCase("null") || !crawlerId.equalsIgnoreCase("")) session.setAttribute("crawlerId", crawlerId);
	}
	catch (Exception e) {
	}
	
	String templateName = request.getParameter("templateName");
	
	
	String hostname = request.getServerName();
	String[] template = new CrawlerRequest(hostname).getTemplate(crawlertype, templateName, token);
	
		session.setAttribute("replace_content_input", template[1]);
		session.setAttribute("content_input", template[0]);
	//		session.setAttribute("crawlname_unused", template[2]);
		session.setAttribute("date_input", template[3]);
		session.setAttribute("dateformat_input", template[4]);
		session.setAttribute("attribute_input", template[6]);
		session.setAttribute("replacedate_input", template[5]);
		session.setAttribute("user_input", template[7]);
		session.setAttribute("replace_user_input", template[8]);
		session.setAttribute("replace_header_input", template[9]);
		session.setAttribute("header_input", template[10]);
		
	if (template.length > 11) {
		session.setAttribute("postid_input", template[11]);
		session.setAttribute("replacepostid_input", template[12]);
		session.setAttribute("postidpattern_input", template[13]);	
	}
	
	session.setAttribute("pathcheck", "1");
	String redirectURL = "../dynamiccrawl_edit.jsp";
	response.sendRedirect(redirectURL);
%>