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
	String displayname = request.getParameter("crawlername");
	String type = request.getParameter("type");
	String depthlink = "";
	String thread = "";
	String useragent = "";
	String linktofollow = "";
	String url = "";
	String newsconfigloc = "";
	String linktoforbid = "";
	String forumconfigloc = "";
	String query = "";
	String contenttype = "";
	String datesince = "";
	String dateuntil = "";
	String count = "";
	String lang = "";
	String apptoken = "";
	String prog = "";
	String progsince = "";
	String vst = "";
	String vkcf = "";
	String keyword = "";
	
	try {
		prog = request.getParameter("prog");
		if (prog.equalsIgnoreCase("null")) prog = "";
	}
	catch (Exception e) {
		prog = "";
	}
	try {
		progsince = request.getParameter("progsince");
		if (progsince.equalsIgnoreCase("null")) progsince = "";
	}
	catch (Exception e) {
		progsince = "";
	}
	
	//modifying progressive
	if (!progsince.equalsIgnoreCase("")) {
		prog = progsince;
	}
	
	String args = "";
	
	if (type.equalsIgnoreCase("general") || type.equalsIgnoreCase("news") || type.equalsIgnoreCase("forum")) {
		depthlink = request.getParameter("depthlink");
		thread = request.getParameter("thread");
		useragent = request.getParameter("useragent");
		linktofollow = request.getParameter("allowurl");
		String urlbase = StringEscapeUtils.escapeHtml4(request.getParameter("url"));
		String httpstart = "http://";
		
		if(urlbase != null){
			if (urlbase.startsWith("http")) {
				url = urlbase;
			}
			else {
				url = httpstart + urlbase;
			}
		}
		
		linktoforbid = request.getParameter("forbidurl");
		newsconfigloc = request.getParameter("newsconfigloc");
		forumconfigloc = request.getParameter("forumconfigloc");
		try { keyword = request.getParameter("keyword"); if (keyword.equalsIgnoreCase("null")) keyword = ""; } catch (Exception e) { keyword = ""; }
		args ="{\"displayname\":\""+displayname+"\",\"type\":\""+type+"\",\"depthlink\":\""+depthlink+"\",\"thread\":\""+thread+"\",\"useragent\":\""+useragent+"\",\"linktofollow\":\""+linktofollow+"\",\"url\":\""+url+"\",\"linktoforbid\":\""+linktoforbid+"\",\"newsconfigloc\":\""+newsconfigloc+"\",\"forumconfigloc\":\""+forumconfigloc+"\",\"keyword\":\""+keyword+"\",\"progressive\":\""+prog+"\"}";
		// System.out.println(args);
	}
	else if (type.equalsIgnoreCase("facebook")) {
		query = request.getParameter("query");
		contenttype = request.getParameter("contenttype");
		apptoken = request.getParameter("apptoken");
		
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",\"query\":\""+query+"\",\"type\":\""+type+"\",\"token\":\""+apptoken+"\"";
// 		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
// 		if (!datesince.equals("")) argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		String closearg = "}";
		try { dateuntil = request.getParameter("dateuntil").toString(); if (dateuntil.equals("null")) dateuntil = ""; } catch (Exception e) {dateuntil = ""; }
		try { datesince = request.getParameter("datesince").toString(); if (datesince.equals("null")) datesince = ""; } catch (Exception e) {datesince = ""; }
// 		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
// 		if (!datesince.equals("")) argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
	}
	else if (type.equalsIgnoreCase("twitter")) {
		query = request.getParameter("query");
		try { dateuntil = request.getParameter("dateuntil").toString(); if (dateuntil.equals("null")) dateuntil = ""; } catch (Exception e) {dateuntil = ""; }
		try { datesince = request.getParameter("datesince").toString(); if (datesince.equals("null")) datesince = ""; } catch (Exception e) {datesince = ""; }
		count = request.getParameter("count");
		lang = request.getParameter("lang");
		apptoken = request.getParameter("apptoken");
		
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",  \"query\":\""+query+"\",\"type\":\""+type+"\",\"count\":\""+count+"\",  \"lang\":\""+lang+"\",\"token\":\""+apptoken+"\"";
// 		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		String closearg = "}";
// 		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
// 		if (!datesince.equals("")) argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
	}
	else if (type.equalsIgnoreCase("twitter_bluemix")) {
		query = request.getParameter("query");
		try { dateuntil = request.getParameter("dateuntil").toString(); if (dateuntil.equals("null")) dateuntil = ""; } catch (Exception e) {dateuntil = ""; }
		try { datesince = request.getParameter("datesince").toString(); if (datesince.equals("null")) datesince = ""; } catch (Exception e) {datesince = ""; }
		count = request.getParameter("count");
		lang = request.getParameter("lang");
		apptoken = request.getParameter("apptoken");
		
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",  \"query\":\""+query+"\",\"type\":\""+type+"\",\"count\":\"100\",\"token\":\""+apptoken+"\",\"delaybetweenrequest\":\"1000\"";
// 		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		String closearg = "}";
// 		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
// 		if (!datesince.equals("")) argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		argproperties = argproperties + ",\"since\":\""+datesince+"\"";	
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
	}
	else if (type.equalsIgnoreCase("youtube")) {
		try { keyword = request.getParameter("keyword"); if (keyword.equalsIgnoreCase("null")) keyword = ""; } catch (Exception e) { keyword = ""; }
		try { vst = request.getParameter("vst"); if (vst.equalsIgnoreCase("null")) vst = ""; } catch (Exception e) { vst = ""; }
		try { vkcf = request.getParameter("vkcf"); if (vkcf.equalsIgnoreCase("null")) vkcf = ""; } catch (Exception e) { vkcf = ""; }
		try { apptoken = request.getParameter("apptoken"); if (apptoken.equalsIgnoreCase("null")) apptoken = ""; } catch (Exception e) { apptoken = ""; }
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",\"type\":\""+type+"\",\"videosearchtype\":\""+vst+"\",\"keyword\":\""+keyword+"\",\"progressive\":\""+prog+"\",\"videokeywordascommentfilter\":\""+vkcf+"\",\"key\":\""+apptoken+"\"";
	// 	if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		String closearg = "}";
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
	//		out.println(args);
		// System.out.println();
	}
	
	System.out.println(args);
	String hostname = request.getServerName();
	String[][] edit = new CrawlerRequest(hostname).editCrawler(colId, crawlerId, args, token);
	
	String redirectURL = "../index.jsp";
    response.sendRedirect(redirectURL);
%>