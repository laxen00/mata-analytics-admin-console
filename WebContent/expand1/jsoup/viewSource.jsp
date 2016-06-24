<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="checker.JsoupChecker, org.apache.commons.lang3.StringEscapeUtils" %>
<html>
<head>
<script src="../js/quine.js" defer="defer"></script>
<link rel="stylesheet" type="text/css" href="../css/sunburst.css">
<%
	String docsrc = "";
	String[] charToReplace = {"<",">"};
	String[] replacementChar = {"&lt;","&gt;"};
	try {
		String testurl = request.getParameter("urltest_input");
		docsrc = JsoupChecker.viewJsoupSource(testurl);
		docsrc = StringEscapeUtils.escapeHtml4(docsrc);
		// System.out.println(docsrc);
	}
	catch (Exception e) {
		docsrc = "";
	}
	String front = StringEscapeUtils.escapeJava("<?prettify lang=html linenums=true?><pre class=\'prettyprint\' id=\'quine\' style=\'padding:12px;word-wrap:break-word;height:400px;overflow:auto\'>");
	String back = StringEscapeUtils.escapeJava("</pre>");
	String fullsrc = front+docsrc+back;
%>
</head>
<body style="width:750px;height:400px;word-wrap:break-word">
	<?prettify lang=html linenums=true?>
<pre class="prettyprint" id="quine"><% out.print(docsrc); %></pre>
</body>
</html>