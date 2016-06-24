<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*, java.util.*, java.text.*, org.apache.commons.lang3.StringEscapeUtils" %>
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
	String crawlerId = request.getParameter("crawlerId");
	String displayname = request.getParameter("displayname");
	String type = request.getParameter("optionsRadios");
	String header_input = "";
	String user_input = "";
	String postid_input = "";
	String postidpattern_input = "";
	String replacepostid_input = "";
	String content_input = "";
	String date_input = "";
	String dateformat = "";
	String replacedate = "";
	String attribute_input ="";
	String replace_header_input = "";
	String replace_user_input = "";
	String replace_content_input = "";
	
	try {
		header_input = request.getParameter("header_input");
		if (header_input.equalsIgnoreCase("null")) header_input = "";
	}
	catch (Exception e) {
		header_input = "";
	}
	
	try {
		user_input = request.getParameter("user_input");
		if (user_input.equalsIgnoreCase("null")) user_input = "";
	}
	catch (Exception e) {
		user_input = "";
	}
	
	try {
		content_input = request.getParameter("content_input");
		if (content_input.equalsIgnoreCase("null")) content_input = "";
	}
	catch (Exception e) {
		content_input = "";
	}
	
	try {
		date_input = request.getParameter("date_input");
		if (date_input.equalsIgnoreCase("null")) date_input = "";
	}
	catch (Exception e) {
		date_input = "";
	}
	
	try {
		dateformat = request.getParameter("dateformat_input");
		if (dateformat.equalsIgnoreCase("null")) dateformat = "";
	}
	catch (Exception e) {
		dateformat = "";
	}
	
	try {
		replacedate = request.getParameter("replacedate_input");
		if (replacedate.equalsIgnoreCase("null")) replacedate = "";
	}
	catch (Exception e) {
		replacedate = "";
	}
	
	try {
		attribute_input = request.getParameter("attribute_input");
		if (attribute_input.equalsIgnoreCase("null")) attribute_input = "";
	}
	catch (Exception e) {
		attribute_input = "";
	}
	
	try {
		postid_input = request.getParameter("postid_input");
		if (postid_input.equalsIgnoreCase("null")) postid_input = "";
	}
	catch (Exception e) {
		postid_input = "";
	}
	
	try {
		postidpattern_input = request.getParameter("postidpattern_input");
		if (postidpattern_input.equalsIgnoreCase("null")) postidpattern_input = "";
	}
	catch (Exception e) {
		postidpattern_input = "";
	}
	
	try {
		replacepostid_input = request.getParameter("replacepostid_input");
		if (replacepostid_input.equalsIgnoreCase("null")) replacepostid_input = "";
	}
	catch (Exception e) {
		replacepostid_input = "";
	}
	
	try {
		replace_header_input = request.getParameter("replace_header_input");
		if (replace_header_input.equalsIgnoreCase("null")) replace_header_input = "";
	}
	catch (Exception e) {
		replace_header_input = "";
	}
	
	try {
		replace_user_input = request.getParameter("replace_user_input");
		if (replace_user_input.equalsIgnoreCase("null")) replace_user_input = "";
	}
	catch (Exception e) {
		replace_user_input = "";
	}
	
	try {
		replace_content_input = request.getParameter("replace_content_input");
		if (replace_content_input.equalsIgnoreCase("null")) replace_content_input = "";
	}
	catch (Exception e) {
		replace_content_input = "";
	}
	
	//escaping json properties
	header_input = StringEscapeUtils.escapeJson(header_input);
	user_input = StringEscapeUtils.escapeJson(user_input);
	postid_input = StringEscapeUtils.escapeJson(postid_input);
	postidpattern_input = StringEscapeUtils.escapeJson(postidpattern_input);
	replacepostid_input = StringEscapeUtils.escapeJson(replacepostid_input);
	content_input = StringEscapeUtils.escapeJson(content_input);
	date_input = StringEscapeUtils.escapeJson(date_input);
	dateformat = StringEscapeUtils.escapeJson(dateformat);
	attribute_input = StringEscapeUtils.escapeJson(attribute_input);
	replacedate = StringEscapeUtils.escapeJson(replacedate);
	replace_header_input = StringEscapeUtils.escapeJson(replace_header_input);
	replace_user_input = StringEscapeUtils.escapeJson(replace_user_input);
	replace_content_input = StringEscapeUtils.escapeJson(replace_content_input);
	
	String args = "";
	
	if (type.equalsIgnoreCase("forum")) {
		String openarg = "{";
		String argproperties = "\"xpathpostids\": \""+postid_input+"\",	\"replacepostids\":\""+replacepostid_input+"\",	\"patternpostids\": \""+postidpattern_input+"\",	\"xpathpostcontents\": \""+content_input+"\",	\"replacepostcontents\": \""+replace_content_input+"\",	\"crawlname\": \""+displayname+"\",	\"xpathdates\": \""+date_input+"\",	\"dateformat\": \""+dateformat+"\",	\"replacedates\": \""+replacedate+"\",	\"xpathusers\": \""+user_input+"\",	\"replaceusers\": \""+replace_user_input+"\",	\"replaceheader\": \""+replace_header_input+"\",	\"xpathheader\": \""+header_input+"\"";
		String closearg = "}";
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
	}
	
	if (type.equalsIgnoreCase("news")) {
		String openarg = "{";
		String argproperties = "\"xpathpost\": \""+content_input+"\",	\"replacepost\": \""+replace_content_input+"\",	\"crawlname\": \""+displayname+"\",	\"xpathdates\": \""+date_input+"\",	\"dateformat\": \""+dateformat+"\",	\"replacedates\": \""+replacedate+"\", ,	\"attribute\": \""+attribute_input+"\"	\"xpathusers\": \""+user_input+"\",	\"replaceusers\": \""+replace_user_input+"\",	\"replaceheader\": \""+replace_header_input+"\",	\"xpathheader\": \""+header_input+"\"";
		String closearg = "}";
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
	}
	
	// System.out.println();
	String hostname = request.getServerName();
	String[][] edit = new CrawlerRequest(hostname).editCrawler(colId, crawlerId, args, token);
	
	String redirectURL = "../editCrawler.jsp";
    response.sendRedirect(redirectURL);
%>