<%@ page import="org.apache.commons.lang3.StringEscapeUtils, apiRequest.*" %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="etc/header.jsp"/>
<%
	String token = "";
	try {
		token = session.getAttribute("token").toString();
	}
	catch (Exception e) {
		token = "";
	}
	// System.out.println(token);
	
	String colId = "";
	try {
	colId = session.getAttribute("colId").toString();
	}
	catch (Exception e) {
		colId = request.getParameter("colId");
	}
	String displayname = request.getParameter("displayname");
	String useragent = request.getParameter("useragent");
	String url = request.getParameter("url");
	String type = request.getParameter("optionsRadios");
	String keyword = request.getParameter("keyword");
	String header_input = "";
	String user_input = "";
	String postid_input = "";
	String postidpattern_input = "";
	String replacepostid_input = "";
	String content_input = "";
	String date_input = "";
	String dateformat = "";
	String replacedate = "";
	String replace_header_input = "";
	String replace_user_input = "";
	String replace_content_input = "";
	String attribute_input = "";
	String prog = "";
	String progsince = "";
	try {
		header_input = request.getParameter("header_input");
	}
	catch (Exception e) {
	}
	
	try {
		 user_input = request.getParameter("user_input");
	}
	catch (Exception e) {
	}
	
	try {
		content_input = request.getParameter("content_input");
	}
	catch (Exception e) {
	}
	
	try {
		date_input = request.getParameter("date_input");
	}
	catch (Exception e) {
	}
	
	try {
		dateformat = request.getParameter("dateformat_input");
	}
	catch (Exception e) {
	}
	
	try {
		replacedate = request.getParameter("replacedate_input");
	}
	catch (Exception e) {
	}
	
	try {
		postid_input = StringEscapeUtils.escapeHtml4(request.getParameter("postid_input"));
	}
	catch (Exception e) {
	}
	try {
		postidpattern_input = StringEscapeUtils.escapeHtml4(request.getParameter("postidpattern_input"));
	}
	catch (Exception e) {
	}
	try {
		replacepostid_input = StringEscapeUtils.escapeHtml4(request.getParameter("replacepostid_input"));
	}
	catch (Exception e) {
	}
	try {
		replace_header_input = StringEscapeUtils.escapeHtml4(request.getParameter("replace_header_input"));
	}
	catch (Exception e) {
	}
	try {
		replace_user_input = StringEscapeUtils.escapeHtml4(request.getParameter("replace_user_input"));
	}
	catch (Exception e) {
	}
	try {
		replace_content_input = StringEscapeUtils.escapeHtml4(request.getParameter("replace_content_input"));
	}
	catch (Exception e) {
	}
	try {
		attribute_input = StringEscapeUtils.escapeHtml4(request.getParameter("attribute_input"));
	}
	catch (Exception e) {
	}
	try {
		prog = request.getParameter("prog");
	}
	catch (Exception e) {
	}
	try {
		progsince = request.getParameter("progsince");
	}
	catch (Exception e) {
	}
	
	// System.out.println("colId:" + colId);
	// System.out.println("displayname:" + displayname);
	// System.out.println("useragent:" + useragent);
	// System.out.println("url:" + url);
	// System.out.println("type:" + type);
	// System.out.println("keyword:" + type);
	// System.out.println("header_input:" + header_input);
	// System.out.println("user_input:" + user_input);
	// System.out.println("postid_input:" + postid_input);
	// System.out.println("postidpattern_input:" + postidpattern_input);
	// System.out.println("replacepostid_input:" + replacepostid_input);
	// System.out.println("content_input:" + content_input);
	// System.out.println("date_input:" + date_input);
	// System.out.println("dateformat:" + dateformat);
	// System.out.println("replacedate:" + replacedate);
	// System.out.println("replace_header_input:" + replace_header_input);
	// System.out.println("replace_user_input:" + replace_user_input);
	// System.out.println("replace_user_input:" + replace_user_input);
	// System.out.println("attribute_input:" + attribute_input);
	// System.out.println("prog:" + prog);
	// System.out.println("progsince:" + progsince);
	
%>
<head>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/regexCheck.js"></script>
    <script src="js/sb-admin-2.js"></script>
	<script>
		function datepick() {
			$( "#datepicker" ).datepicker({
				format: "yyyy-mm-dd"
			});
		};
		
		function testurl() {
			regexCheck();
			document.getElementById('table_test').style.display='block';
		};
		
		function opttype(rad) {
			var val = rad.value;
			var choice1 = "facebook";
			var choice2 = "twitter";
	
			if (val == choice1) {
					document.getElementById('change_ed').innerHTML = 
					'<div class="form-group"><span>* </span><label>Query:</label><input type="text" class="form-control" placeholder="Query" required></input></div><div class="form-group"><label>Since:</label><input type="text" class="form-control" placeholder="since date" id="datepicker" style="cursor:pointer;" readonly></input></div>';
					datepick();
					document.getElementById('crawlerform').action ='expand1/forms.jsp';
	      	}else if (val == choice2) {
					document.getElementById('change_ed').innerHTML = 
					'<div class="form-group"><span>* </span><label>Query:</label><input type="text" class="form-control" placeholder="Query" required></input></div><div class="form-group"><label>Until:</label><input type="text" class="form-control" placeholder="until date" id="datepicker" style="cursor:pointer;" readonly></div>';
					datepick();
					document.getElementById('nextbutton').onclick = 'location.href="expand1/index.jsp"';
	       	}else {
					document.getElementById('change_ed').innerHTML = 
					'<div class="form-group"><span>* </span><label>User agent:</label><input type="text" class="form-control" placeholder="User agent" required></input></div><div class="form-group"><span>* </span><label>Start URL:</label><p class="help-block">Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p><input type="text" class="form-control" placeholder="URL" required></input></div>';
					document.getElementById('nextbutton').onclick = "location.href='expand1/forms.jsp'";
			}
		}
		
		function submitForm(action) {
	        document.getElementById('crawlerformgeneral').action = action;
	        document.getElementById('crawlerformgeneral').submit();
	    }
	</script>
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

    <title>Create Crawler - MAX Administration Console</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/datepicker.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <!--link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet"-->

    <!-- Custom CSS -->
    <link href="css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
    <div id="wrapper">
        <div id="page-wrapper">
        	<div class="row">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
			  		<li><a href="create_crawler.jsp">Create Crawler</a></li>
					<li class="active">Create Rules</li>
				</ul>
			</div>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Rules to Crawl Domains</h1>
					<span>Specify regex pattern that you want to allow or forbid the crawler to crawl.</span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-7">
				
                    <div class="panel-body">
						<form id="crawlerformgeneral" role="form" method="post" action="api/createCrawler.jsp" style="margin-bottom:15px" >
                            <div class="form-group">
                                <label>Allow URL regex pattern:</label>
                                 <textarea name="linktofollow" id="linktofollow" type="text" class="form-control" placeholder="" ></textarea>
                            </div>
							 <div class="form-group">
                                <label>Forbid URL regex pattern:</label>
                                 <textarea name="linktoforbid" id="linktoforbid" type="text" class="form-control" placeholder="" ></textarea>
                            </div>
							<table style="width:100%; padding:0px; margin-bottom:20px; margin-left:-5px;">
								<tr><td colspan="2">
									
										<label>Test specific URLs</label>
										<p class="help-block" style="margin:0px auto 0px auto">URLs to test (type one URL per line and specify the protocol, such as http://):</p>
										</td></tr>
										<tr><td style="width:90%">
											<textarea name="urlregextest" id="urlregextest" type="text" class="form-control" placeholder="www.mataprima.com" ></textarea>
									
								</td>
								<td valign="top" style="width:10%">
								
									<input type="hidden" name="colId" id="colId" value="<% out.print(colId); %>" />
							<input type="hidden" name="displayname" id="displayname" value="<% out.print(displayname); %>" />
							<input type="hidden" name="useragent" id="useragent" value="<% out.print(useragent); %>" />
							<input type="hidden" name="url" id="url" value="<% out.print(url); %>" />
							<input type="hidden" name="optionsRadios" id="type" value="<% out.print(type); %>" />
							<input type="hidden" name="keyword" id="type" value="<% out.print(keyword); %>" />
							<input type="hidden" name="header_input" id="header_input" value="<% out.print(header_input); %>" />
							<input type="hidden" name="user_input" id="user_input" value="<% out.print(user_input); %>" />
							<input type="hidden" name="content_input" id="content_input" value="<% out.print(content_input); %>" />
							<input type="hidden" name="date_input" id="date_input" value="<% out.print(date_input); %>" />
							<input type="hidden" name="dateformat_input" id="dateformat_input" value="<% out.print(dateformat); %>" />
							<input type="hidden" name="replacedate_input" id="replacedate_input" value="<% out.print(replacedate); %>" />
							<input type="hidden" name="postid_input" id="postid_input" value='<% out.print(postid_input); %>' />
							<input type="hidden" name="postidpattern_input" id="postidpattern_input" value='<% out.print(postidpattern_input); %>' />
							<input type="hidden" name="replacepostid_input" id="replacepostid_input" value='<% out.print(replacepostid_input); %>' />
							<input type="hidden" name="replace_header_input" id="replace_header_input" value='<% out.print(replace_header_input); %>' />
							<input type="hidden" name="replace_user_input" id="replace_user_input" value='<% out.print(replace_user_input); %>' />
							<input type="hidden" name="replace_content_input" id="replace_content_input" value='<% out.print(replace_content_input); %>' />
							<input type="hidden" name="attribute_input" id="attribute_input" value='<% out.print(attribute_input); %>' />
							<input type="hidden" name="prog" id="prog" value='<% out.print(prog); %>' />
							<input type="hidden" name="progsince" id="progsince" value='<% out.print(progsince); %>' />
<!-- 									<button type="submit" class="btn btn-default" title="test" style="width:70px" onclick="submitForm('etc/regexCheck.jsp')">Test</button> -->
									<button type="button" class="btn btn-default" title="test" style="width:70px" onclick="testurl()">Test</button>
									
								</td></tr>
							</table>
							<div class="form-group">
                                <label>Allow URL regex pattern:</label>
                                <div name="fortest" id="fortest"></div>
                            </div>
							
							<div id="table_test" class="table_test" style="display:none;">
							</div>
							
							<button type="submit" class="btn btn-default" title="Back" onclick="submitForm('create_crawler.jsp')">Back</button>
							<button id="nextbutton" type="submit" class="btn btn-default disabled" title="Next" >Next</button>
							<button type="submit" class="btn btn-default" title="Finish" onclick="submitForm('api/createCrawler.jsp')">Finish</button>
                            <button type="reset" class="btn btn-default" title="Cancel" onclick="location.href='index.jsp#<% out.print(colId); %>'">Cancel</button>
                        </form>
						
                    </div>
                    <!-- /.panel -->
                </div>
				
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>
