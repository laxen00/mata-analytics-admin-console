<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="checker.JsoupChecker, java.util.*, org.apache.commons.lang3.StringEscapeUtils" %>  
  
<%
//	String url = request.getParameter("url");
	String colId = request.getParameter("colId");
	String crawlerId = request.getParameter("crawlerId");
	String displayname = request.getParameter("displayname");
	String useragent = request.getParameter("useragent");
	String url = request.getParameter("url");
	String crawlertype = request.getParameter("optionsRadios");
	String keyword = request.getParameter("keyword");
	String prog = request.getParameter("prog");
	String progsince = request.getParameter("progsince");
	
	session.setAttribute("colId", colId);
	session.setAttribute("crawlerId", crawlerId);
	session.setAttribute("displayname", displayname);
	session.setAttribute("useragent", useragent);
	session.setAttribute("url", url);
	session.setAttribute("type", crawlertype);
	session.setAttribute("keyword", keyword);
	session.setAttribute("prog", prog);
	session.setAttribute("progsince", progsince);
	
	String urltest = "";
	
	try {
		urltest = request.getParameter("urltest_input");
		session.setAttribute("urltest_input", urltest);
	}
	catch (Exception e) {
//		 e.printStackTrace();
	}
	String data = "";

	try {
		String header_input = request.getParameter("header_input");
		session.setAttribute("header_input", header_input);
		String replace_header_input = request.getParameter("replace_header_input");
		session.setAttribute("replace_header_input", replace_header_input);
		String	type = "header";
		String pattern = header_input;
		String header = JsoupChecker.checker(urltest,type,pattern, replace_header_input, "", "");
		data = data + "<b>Header:</b> <br />" + header + "<br /><br />";
 	}
 	catch (Exception e) {
//  		 e.printStackTrace();
 	}
 
	try {
		String user_input = request.getParameter("user_input");
		session.setAttribute("user_input", user_input);
		String replace_user_input = request.getParameter("replace_user_input");
		session.setAttribute("replace_user_input", replace_user_input);
		String	type = "user";
		String pattern = user_input;
		String user = JsoupChecker.checker(urltest,type,pattern, replace_user_input, "", "");
		data = data + "<b>Users:</b> <br />" + user + "<br />";
	}
 	catch (Exception e) {
//  		 e.printStackTrace();
 	}
 
	try {
		String content_input = request.getParameter("content_input");
		session.setAttribute("content_input", content_input);
		String pattern = content_input;
		String content = JsoupChecker.checker(urltest, "content", pattern, "", "", "");
		
		data = data + "<b>Content:</b> <br />" + content + "<br />";
	 }
 	catch (Exception e) {
 		 e.printStackTrace();
 	}
	
	try {
		String date = request.getParameter("date_input");
		String dateformat = request.getParameter("dateformat_input");
		String replacedate = request.getParameter("replacedate_input");
		String attribute_input = request.getParameter("attribute_input");
		session.setAttribute("date_input", date);
		session.setAttribute("dateformat_input", dateformat);
		session.setAttribute("replacedate_input", replacedate);
		session.setAttribute("attribute_input", attribute_input);
		String	type = "date";
		String pattern = date;
		String date_new = JsoupChecker.checker(urltest,type,pattern, replacedate, dateformat, attribute_input);
		data = data + "<b>Date:</b> <br />" + date_new + "<br />";
	}
 	catch (Exception e) {
//  		 e.printStackTrace();
 	}
	
	try {
		String postid = request.getParameter("postid_input");
		String postidpattern = request.getParameter("postidpattern_input");
		String replacepostid = request.getParameter("replacepostid_input");
		session.setAttribute("postid_input", postid);
		session.setAttribute("postidpattern_input", postidpattern);
		session.setAttribute("replacepostid_input", replacepostid);
		String	type = "postid";
		String pattern = postid;
		String postid_out = JsoupChecker.checker(urltest,type,pattern, replacepostid, postidpattern, "");
		data = data + "<b>Post ID:</b> <br />" + postid_out + "<br />";
		/*postid = StringEscapeUtils.escapeHtml4(postid);
		postidpattern = StringEscapeUtils.escapeHtml4(postidpattern);
		replacepostid = StringEscapeUtils.escapeHtml4(replacepostid);
		session.setAttribute("postid_input", postid);
		session.setAttribute("postidpattern_input", postidpattern);
		session.setAttribute("replacepostid_input", replacepostid);*/
	}
 	catch (Exception e) {
//  		 e.printStackTrace();
 	}
 
 	session.setAttribute("result", data);
 	session.setAttribute("pathcheck", "1");
 	// System.out.println(session.getAttribute("colId"));
 	// System.out.println(session.getAttribute("crawlerId"));
 	// System.out.println(session.getAttribute("displayname"));
 	// System.out.println(session.getAttribute("useragent"));
 	// System.out.println(session.getAttribute("url"));
 	// System.out.println(session.getAttribute("type"));
 	// System.out.println(session.getAttribute("keyword"));
 	// System.out.println(session.getAttribute("prog"));
 	// System.out.println(session.getAttribute("progsince"));
//  	// System.out.println(session.getAttribute("postid_input"));
//  	// System.out.println(session.getAttribute("postidpattern_input"));
//  	// System.out.println(session.getAttribute("replacepostid_input"));
	String redirectURL = "../dynamiccrawl_edit.jsp"; 
    response.sendRedirect(redirectURL);
%>