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
	String hostname = request.getServerName();
	String colId = request.getParameter("colId");
	String displayname = request.getParameter("displayname");
	String useragent = request.getParameter("useragent");
	String depthlink = "5";
	String thread = "3";
	String urlbase = StringEscapeUtils.escapeHtml4(request.getParameter("url"));
	String url = "";
	String httpstart = "http://";
	
	if(urlbase != null){
		if (urlbase.startsWith("http")) {
			url = urlbase;
		}
		else {
			url = httpstart + urlbase;
		}
	}
	
	String type = request.getParameter("optionsRadios");
	String keyword = request.getParameter("keyword");
	String apptoken = "";
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
	String query = "";
	String datesince = "";
	String dateuntil = "";
	String replace_header_input = "";
	String replace_user_input = "";
	String replace_content_input = "";
	String linktofollow = StringEscapeUtils.escapeHtml4(request.getParameter("linktofollow"));
	String linktoforbid = StringEscapeUtils.escapeHtml4(request.getParameter("linktoforbid"));
	String prog = "";
	String progsince = "";
	String vst = "";
	String vkcf = "";
	String count = "";
	
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
		query = request.getParameter("query");
		if (query.equalsIgnoreCase("null")) query = "";
	}
	catch (Exception e) {
		query = "";
	}
	
	try {
		datesince = request.getParameter("datesince").toString();
		if (datesince.equals("null")) datesince = "";
	}
	catch (Exception e) {
	}
	try {
		dateuntil = request.getParameter("dateuntil").toString();
		if (dateuntil.equals("null")) dateuntil = "";
	}
	catch (Exception e) {
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
	
	try {
		apptoken = request.getParameter("apptoken");
		if (apptoken.equalsIgnoreCase("null")) apptoken = "";
	}
	catch (Exception e) {
		apptoken = "";
	}
	
	try {
		vst = request.getParameter("vst");
		if (vst.equalsIgnoreCase("null")) vst = "";
	}
	catch (Exception e) {
		vst = "";
	}
	
	try {
		vkcf = request.getParameter("vkcf");
		if (vkcf.equalsIgnoreCase("null")) vkcf = "";
	}
	catch (Exception e) {
		vkcf = "";
	}
	
	try {
		if (linktofollow.equalsIgnoreCase("null")) linktofollow = "";
	}	
	catch (Exception e) {
		linktofollow = "";
	}
	
	try {
		if (linktoforbid.equalsIgnoreCase("null")) linktoforbid = "";
	}
	catch (Exception e) {
		linktoforbid = "";
	}
	
	try {
		if (useragent.equalsIgnoreCase("null")) useragent = "";
	}
	catch (Exception e) {
		useragent = "";
	}
	
	try {
		if (keyword.equalsIgnoreCase("null")) keyword = "";
	}
	catch (Exception e) {
		keyword = "";
	}
	
	try {
		count = request.getParameter("count");
		if (count.equalsIgnoreCase("null")) count = "";
	}
	catch (Exception e) {
		count = "";
	}
	
	//modifying progressive
	if (!progsince.equalsIgnoreCase("")) {
		prog = progsince;
	}
	
	//escaping json properties
	query = StringEscapeUtils.escapeJson(query);
	keyword = StringEscapeUtils.escapeJson(keyword);
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
	
	// System.out.println();
	// System.out.println("colId:" + colId);
	// System.out.println("displayname:" + displayname);
	// System.out.println("useragent:" + useragent);
	// System.out.println("url:" + url);
	// System.out.println("type:" + type);
	// System.out.println("keyword:" + keyword);
	// System.out.println("apptoken:" + apptoken);
	// System.out.println("header_input:" + header_input);
	// System.out.println("user_input:" + user_input);
	// System.out.println("postid_input:" + postid_input);
	// System.out.println("postidpattern_input:" + postidpattern_input);
	// System.out.println("replacepostid_input:" + replacepostid_input);
	// System.out.println("content_input:" + content_input);
	// System.out.println("date_input:" + date_input);
	// System.out.println("dateformat:" + dateformat);
	// System.out.println("attribute_input:" + attribute_input);
	// System.out.println("replacedate:" + replacedate);
	// System.out.println("query:" + query);
	// System.out.println("datesince:"+ datesince);
	// System.out.println("dateuntil:"+ dateuntil);
	// System.out.println("replace_header_input:" + replace_header_input);
	// System.out.println("replace_user_input:" + replace_user_input);
	// System.out.println("replace_content_input:" + replace_content_input);
	// System.out.println("linktofollow:" + linktofollow);
	// System.out.println("linktoforbid:" + linktoforbid);
	// System.out.println("prog:" + prog);
	// System.out.println("vst:" + vst);
	// System.out.println("vkcf:" + vkcf);
	// System.out.println("count:" + count);
	
	String[] create = null;
	
	if (type.equalsIgnoreCase("general")) {
	
		String args ="{\"displayname\":\""+displayname+"\",\"useragent\":\""+useragent+"\",\"depthlink\":\""+depthlink+"\",\"thread\":\""+thread+"\",\"url\":\""+url+"\",\"type\":\""+type+"\",\"linktofollow\":\""+linktofollow+"\",\"linktoforbid\":\""+linktoforbid+"\",\"keyword\":\""+keyword+"\",\"progressive\":\""+prog+"\"}";
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		// System.out.println();
		create = new CrawlerRequest(hostname).createCrawler(colId, args, token);
	}
	
	if (type.equalsIgnoreCase("facebook")) {
		
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",\"query\":\""+query+"\",\"type\":\""+type+"\",\"token\":\""+apptoken+"\"";
		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		if (!datesince.equals("")) argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		String closearg = "}";
		String args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		// System.out.println();
		create = new CrawlerRequest(hostname).createCrawler(colId, args, token);
	}
	
	if (type.equalsIgnoreCase("twitter_bluemix")) {
		
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",  \"query\":\""+query+"\",\"type\":\""+type+"\",\"count\":\""+count+"\",\"token\":\""+apptoken+"\",\"delaybetweenrequest\":\"1000\"";
		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		if (!datesince.equals("")) argproperties = argproperties + ",\"since\":\""+datesince+"\"";
		String closearg = "}";
		String args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		// System.out.println();
		create = new CrawlerRequest(hostname).createCrawler(colId, args, token);
	}
	
	if (type.equalsIgnoreCase("twitter")) {
		
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",  \"query\":\""+query+"\",\"type\":\""+type+"\",\"count\":\"100\",  \"lang\":\"id\",\"token\":\""+apptoken+"\"";
		if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		String closearg = "}";
		String args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		// System.out.println();
		create = new CrawlerRequest(hostname).createCrawler(colId, args, token);
	}

	if (type.equalsIgnoreCase("youtube")) {
		
		String openarg = "{";
		String argproperties ="\"displayname\":\""+displayname+"\",\"type\":\""+type+"\",\"videosearchtype\":\""+vst+"\",\"keyword\":\""+keyword+"\",\"progressive\":\""+prog+"\",\"videokeywordascommentfilter\":\""+vkcf+"\",\"key\":\""+apptoken+"\"";
	// 	if (!dateuntil.equals("")) argproperties = argproperties + ",\"until\":\""+dateuntil+"\"";
		String closearg = "}";
		String args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
	//		out.println(args);
		// System.out.println();
		create = new CrawlerRequest(hostname).createCrawler(colId, args, token);
	}
	
	if (type.equalsIgnoreCase("news")) {
		
		String args ="{\"displayname\":\""+displayname+"\",\"useragent\":\""+useragent+"\",\"depthlink\":\""+depthlink+"\",\"thread\":\""+thread+"\",\"url\":\""+url+"\",\"type\":\""+type+"\",\"linktofollow\":\""+linktofollow+"\",\"linktoforbid\":\""+linktoforbid+"\",\"keyword\":\""+keyword+"\",\"progressive\":\""+prog+"\"}";
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		// System.out.println();
		create = new CrawlerRequest(hostname).createCrawler(colId, args, token);
		
		try {
		    Thread.sleep(5000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
		
		String openarg = "{";
		String argproperties ="\"properties\": {    \"body\": {        \"xpathpost\": \""+content_input+"\",        \"replacepost\": \""+replace_content_input+"\"    },    \"source\": {\"crawlname\": \""+displayname+"\"},    \"date\": {        \"xpathdates\": \""+date_input+"\",        \"dateformat\": \""+dateformat+"\",        \"replacedates\": \""+replacedate+"\", \"attribute\": \""+attribute_input+"\"    },    \"user\": {        \"xpathusers\": \""+user_input+"\",        \"replaceusers\": \""+replace_user_input+"\"    },    \"header\": {        \"replaceheader\": \""+replace_header_input+"\",        \"xpathheader\": \""+header_input+"\"    }	}";
		String closearg = "}";
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		
		String crawlerId = null;
		// System.out.println();
		String[][] crawlers = new CrawlerRequest(hostname).getCrawlers(colId, token);
		for (String[] crawler : crawlers) {
// 			out.println(displayname + "\t" + crawler[1]);
			if (crawler[1].equals(displayname)) {
				crawlerId = crawler[0];
				break;
			}
		}
		// System.out.println();
		String[][] createXML = new CrawlerRequest(hostname).createXML(colId, crawlerId, args, token);
		
		try {
		    Thread.sleep(5000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
	}
	
	if (type.equalsIgnoreCase("forum")) {
		String args ="{\"displayname\":\""+displayname+"\",\"useragent\":\""+useragent+"\",\"depthlink\":\""+depthlink+"\",\"thread\":\""+thread+"\",\"url\":\""+url+"\",\"type\":\""+type+"\",\"linktofollow\":\""+linktofollow+"\",\"linktoforbid\":\""+linktoforbid+"\",\"keyword\":\""+keyword+"\",\"progressive\":\""+prog+"\"}";
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		// System.out.println();
		create = new CrawlerRequest(hostname).createCrawler(colId, args, token);
		
		try {
		    Thread.sleep(5000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
		
		String openarg = "{";
		String argproperties ="\"properties\": {    \"id\": {        \"xpathpostids\": \""+postid_input+"\",        \"replacepostids\": \""+replacepostid_input+"\",        \"patternpostids\": \""+postidpattern_input+"\"    },    \"source\": {\"crawlname\": \""+displayname+"\"},    \"body\": {        \"xpathpostcontents\": \""+content_input+"\",        \"replacepostcontents\": \""+replace_content_input+"\"    },    \"date\": {        \"xpathdates\": \""+date_input+"\",        \"dateformat\": \""+dateformat+"\",        \"replacedates\": \""+replacedate+"\", \"attribute\": \""+attribute_input+"\"    },    \"user\": {        \"xpathusers\": \""+user_input+"\",        \"replaceusers\": \""+replace_user_input+"\"    },    \"header\": {        \"replaceheader\": \""+replace_header_input+"\",        \"xpathheader\": \""+header_input+"\"    }}";
		String closearg = "}";
		args = openarg + argproperties + closearg;
		// System.out.println();
		// System.out.println(args);
// 		out.println(args);
		
		String crawlerId = null;
		// System.out.println();
		String[][] crawlers = new CrawlerRequest(hostname).getCrawlers(colId, token);
		for (String[] crawler : crawlers) {
// 			out.println(displayname + "\t" + crawler[1]);
			if (crawler[1].equals(displayname)) {
				crawlerId = crawler[0];
				break;
			}
		}
		// System.out.println();
		String[][] createXML = new CrawlerRequest(hostname).createXML(colId, crawlerId, args, token);
		
		try {
		    Thread.sleep(5000);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		    Thread.currentThread().interrupt();
		}
	}

	if (!create[0].equalsIgnoreCase("0")) session.setAttribute("bannerMessage", create[1]);
	
	String redirectURL = "../index.jsp";
    response.sendRedirect(redirectURL);
%>