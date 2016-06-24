<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*, java.util.*, org.json.*" %>
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
	String crawlerId = request.getParameter("crawlId");
	
	String hostname = request.getServerName();
	String[] crawler = new CrawlerRequest(hostname).getCrawler(colId, crawlerId, token);
	String type = crawler[2];
	
	String[] urlList = new CrawlerRequest(hostname).getAllCrawled(colId, crawlerId, token);
	
	int allLength = urlList.length;
	if (urlList[0].equals("")) {
		allLength = 0;
	}
	
	if (!urlList[0].equals("") && (type.equals("twitter") || type.equals("facebook") || type.equals("twitter_bluemix"))) {
		int counter = 0;
		for (int i=0;i<urlList.length;i++) {
			int total = Integer.parseInt(urlList[i].split("found: ")[1]);
			counter+=total;
		}
		allLength = counter;
	}
	
	String allLengthString = "";
	
	if (type.equalsIgnoreCase("facebook")) allLengthString = "Post(s) crawled : " + allLength;
	else if (type.equalsIgnoreCase("twitter_bluemix")) allLengthString = "Tweet(s) crawled : " + allLength;
	else if (type.equalsIgnoreCase("twitter")) allLengthString = "Tweet(s) crawled : " + allLength;
	else if (type.equalsIgnoreCase("youtube")) allLengthString = "Comment(s) crawled : " + allLength;
	else allLengthString = "URL(s) crawled : " + allLength;
	
	ArrayList<String> outArrayList = new ArrayList<String>();
	outArrayList.add(allLengthString);
	for (String url : urlList) outArrayList.add(url);
	String[] outArray = outArrayList.toArray(new String[outArrayList.size()]);
	JSONArray jsonArray = new JSONArray(outArray);
	out.print(jsonArray.toString());
%>