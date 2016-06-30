<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="apiRequest.*" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
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
%>

<%
	String editflag = "";
	try {
		editflag = session.getAttribute("edit").toString();
	}
	catch (Exception e) {
		editflag = "0";
	}
	
	String colId = request.getParameter("colId");
	String crawlerId = request.getParameter("crawlerId");
	String displayname = request.getParameter("crawlername");
	String type = request.getParameter("type");
	String url = request.getParameter("url");
	String useragent = request.getParameter("useragent");
	String keyword = request.getParameter("keyword");
	String prog = "";
	String progsince = "";
	
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
	
	if (editflag.equalsIgnoreCase("1")) {
	String args = "";
	String depthlink = request.getParameter("depthlink");
	String thread = request.getParameter("thread");
	String linktofollow = request.getParameter("allowurl");
	String linktoforbid = request.getParameter("forbidurl");
	String newsconfigloc = request.getParameter("newsconfigloc");
	String forumconfigloc = request.getParameter("forumconfigloc");
	if (!progsince.equalsIgnoreCase("")) prog = progsince;
	args ="{\"displayname\":\""+displayname+"\",\"type\":\""+type+"\",\"depthlink\":\""+depthlink+"\",\"thread\":\""+thread+"\",\"useragent\":\""+useragent+"\",\"linktofollow\":\""+linktofollow+"\",\"url\":\""+url+"\",\"linktoforbid\":\""+linktoforbid+"\",\"newsconfigloc\":\""+newsconfigloc+"\",\"forumconfigloc\":\""+forumconfigloc+"\",\"progressive\":\""+prog+"\"}";
	// System.out.println(args);
	String hostname = request.getServerName();
	String[][] edit = new CrawlerRequest(hostname).editCrawler(colId, crawlerId, args, token);
	session.setAttribute("edit", "0");
	}
	
	String pathcheck = "";
	
	try {
		pathcheck = session.getAttribute("pathcheck").toString();
	}
	catch (Exception e) {
		pathcheck = "0";
	}
	
	// System.out.println("pathcheck:" + pathcheck);
	
	if (pathcheck.equals("1")) {
		try {
			// System.out.println("checking previous parameters...");
			// System.out.println(session.getAttribute("colId"));
			// System.out.println(session.getAttribute("crawlerId"));
		 	// System.out.println(session.getAttribute("displayname"));
		 	// System.out.println(session.getAttribute("useragent"));
		 	// System.out.println(session.getAttribute("url"));
		 	// System.out.println(session.getAttribute("type"));
		 	// System.out.println(session.getAttribute("keyword"));
		 	// System.out.println(session.getAttribute("prog"));
		 	// System.out.println(session.getAttribute("progsince"));
			colId = session.getAttribute("colId").toString();
			displayname = session.getAttribute("displayname").toString();
			useragent = session.getAttribute("useragent").toString();
			url = session.getAttribute("url").toString();
			type = session.getAttribute("type").toString();
			keyword = session.getAttribute("keyword").toString();
			prog = session.getAttribute("prog").toString();
			progsince = session.getAttribute("progsince").toString();
			session.removeAttribute("displayname");
			session.removeAttribute("useragent");
			session.removeAttribute("url");
			session.removeAttribute("type");
			session.removeAttribute("keyword");
			session.removeAttribute("prog");
			session.removeAttribute("progsince");
			session.removeAttribute("pathcheck");
		}
		catch (Exception e) {
			
		}
	}
	
	else {
		String hostname = request.getServerName();
		String[] crawler = new CrawlerRequest(hostname).getCrawler(colId, crawlerId, token);
		if (type.equalsIgnoreCase("forum")) {
			session.setAttribute("postid_input", crawler[13]);
			session.setAttribute("replacepostid_input", crawler[14]);
			session.setAttribute("postidpattern_input", crawler[15]);
			session.setAttribute("content_input", crawler[16]);
			session.setAttribute("replace_content_input", crawler[17]);
			session.setAttribute("date_input", crawler[19]);
			session.setAttribute("dateformat_input", crawler[20]);
			session.setAttribute("replacedate_input", crawler[21]);
			session.setAttribute("attribute_input", crawler[22]);
			session.setAttribute("user_input", crawler[23]);
			session.setAttribute("replace_user_input", crawler[24]);
			session.setAttribute("replace_header_input", crawler[25]);
			session.setAttribute("header_input", crawler[26]);
		}
		if (type.equalsIgnoreCase("news")) {
			session.setAttribute("content_input", crawler[13]);
			session.setAttribute("replace_content_input", crawler[14]);
			session.setAttribute("date_input", crawler[16]);
			session.setAttribute("dateformat_input", crawler[17]);
			session.setAttribute("replacedate_input", crawler[18]);
			session.setAttribute("attribute_input", crawler[19]);
			session.setAttribute("user_input", crawler[20]);
			session.setAttribute("replace_user_input", crawler[21]);
			session.setAttribute("replace_header_input", crawler[22]);
			session.setAttribute("header_input", crawler[23]);
		}
// 		// System.out.println("header:" + crawler[21]);
// 		// System.out.println("header:" + session.getAttribute("header_input"));
	}
	
	// System.out.println("colId:" + colId);
	// System.out.println("crawlerId:"+crawlerId);
	// System.out.println("displayname:" + displayname);
	// System.out.println("useragent:" + useragent);
	// System.out.println("url:" + url);
	// System.out.println("type:" + type);
	// System.out.println("keyword:" + keyword);
	// System.out.println("prog:" + prog);
	// System.out.println("progsince" + progsince);
%>

<head>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/sb-admin-2.js"></script>
	<script>
		function viewSource() {
			var xmlhttp=new XMLHttpRequest();
			var url = document.getElementById("urltest_input").value;
			xmlhttp.onreadystatechange=function()
			  {
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			    {
				  var docsrc = xmlhttp.responseText;
				  document.getElementById("viewSource").innerHTML = docsrc;
			    }
			  };
			xmlhttp.open("GET","jsoup/viewSource.jsp?urltest_input="+url,true);
			xmlhttp.send();
		}
		
		function add1() {
			var element = document.createElement("div");
			var inelement = document.createElement("input");
			var label = document.createElement("Label");
			label.innerHTML = "<input type='text' class='form-control' style='width:100px' placeholder='XML Tag'></input>";
			
			element.setAttribute("class", "form-group");
			
			inelement.setAttribute("type", "text");
			inelement.setAttribute("value", "");
			//inelement.setAttribute("name", "Test Name");
			//inelement.setAttribute("style", "width:200px");
			inelement.setAttribute("class", "form-control");
					
			inelement.setAttribute("placeholder", "HTML Tag");
			
			var nf = document.getElementById("new_form");
			nf.appendChild(element);
			element.appendChild(label);
			element.appendChild(inelement);
			
			var removebutt = document.getElementById("removebutt");
			removebutt.style.display = "inline-block";
		}
		function removediv() {
			var removebut = document.getElementById("removebutt");
			var nf = document.getElementById("new_form");
			nf.removeChild(nf.lastChild);
			if (nf.children.length > 0) {
				removebut.style.display = "inline-block";
			} else {
				removebut.style.display = "none";
			}
			
		}
		function test_ed_1() {
			var nf = document.getElementById("new_form");
			if (nf.children.length > 0) {
				document.getElementById("test_aja").innerHTML = "ada nieh ada";
			} else {
				document.getElementById("test_aja").innerHTML = "uda ga ada T_T";
			}
		}
		
	    function submitForm(action)
	    {
	        document.getElementById('dynamicForm').action = action;
	        document.getElementById('dynamicForm').target = "iframe_a";
	        document.getElementById('dynamicForm').submit();
	    }
	    
	    function submitToFrame(action)
	    {
	    	document.getElementById('dynamicForm').action = action;
	    	document.getElementById('dynamicForm').target = "sourceframe";
	    	document.getElementById('dynamicForm').submit();
	    }
	</script>
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">
	
	<!--script src="js/quine.js" defer="defer"></script-->
	<link href="css/prettify.css" rel="stylesheet" type="text/css">
	<link href="css/sunburst.css" rel="stylesheet" type="text/css">
    <title>Dynamic Crawler - MAX Administration Console</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

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
        	<div class="row maxbreadcrumb">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
					<li><a href="edit_crawler.jsp">Edit Crawler - <% out.print(displayname + " (" + crawlerId + ")"); %></a></li>
					<li class="active">Edit Metadata for Crawler</li>
				</ul>
			</div>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Edit Metadata for Crawler</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Forms
                        </div>
                        <div class="panel-body_dynamic">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form name="dynamicForm" id="dynamicForm" role="form" method="post" action="jsoup/dynamicCheck.jsp">
                                        <div class="form-group">
                                            <label>URL Test</label>
                                            <%
                                            String urltest_input;
                                            try {
                                            	urltest_input = session.getAttribute("urltest_input").toString();
                                            }
                                            catch (Exception e) {
                                            	urltest_input = null;
                                            }
                                            %>
                                            <input name="urltest_input" id="urltest_input" class="form-control" placeholder="URL Test Path" <% if (urltest_input != null) { %> value="<% out.print(urltest_input); } %>">
                                            <% session.removeAttribute("urltest_input"); %>
                                        </div>
										<div class="form-group">
                                            <label style="display:block;">Post ID</label>
                                            <%
                                            String postid_input;
                                            String postidpattern_input;
                                            String replacepostid_input;
                                            try {
                                            	postid_input = session.getAttribute("postid_input").toString();
                                            }
                                            catch (Exception e) {
                                            	postid_input = null;
                                            }
                                            try {
                                            	postidpattern_input = session.getAttribute("postidpattern_input").toString();
                                            }
                                            catch (Exception e) {
                                            	postidpattern_input = null;
                                            }
                                            try {
                                            	replacepostid_input = session.getAttribute("replacepostid_input").toString();
                                            }
                                            catch (Exception e) {
                                            	replacepostid_input = null;
                                            }
                                            
                                          	//escaping html properties
                                            postid_input = StringEscapeUtils.escapeHtml4(postid_input);
                                        	postidpattern_input = StringEscapeUtils.escapeHtml4(postidpattern_input);
                                        	replacepostid_input = StringEscapeUtils.escapeHtml4(replacepostid_input);
                                            
                                            %>
                                            <input name="postid_input" id="postid_input" class="form-control control-t1" placeholder="Post ID Path" <% if (postid_input != null) { %> value="<% out.print(postid_input); } %>">
                                            <% session.removeAttribute("postid_input"); %>
                                            <input name="postidpattern_input" id="postidpattern_input" class="form-control control-t2" placeholder="Post ID Pattern" <% if (postidpattern_input != null) { %> value="<% out.print(postidpattern_input); } %>">
                                            <% session.removeAttribute("postidpattern_input"); %>
                                            <input name="replacepostid_input" id="replacepostid_input" class="form-control" placeholder="Replace Post ID" <% if (replacepostid_input != null) { %> value="<% out.print(replacepostid_input); } %>">
                                            <% session.removeAttribute("replacepostid_input"); %>
                                        </div>
										<div class="form-group">
                                            <label style="display:block;">Header</label>
                                            <%
                                            String header_input;
                                            try {
                                            	header_input = session.getAttribute("header_input").toString();
                                            }
                                            catch (Exception e) {
                                            	header_input = null;
                                            }
                                            
                                            String replace_header_input;
                                            try {
                                            	replace_header_input = session.getAttribute("replace_header_input").toString();
                                            }
                                            catch (Exception e) {
                                            	replace_header_input = null;
                                            }
                                            
                                          	//escaping html properties
                                        	header_input = StringEscapeUtils.escapeHtml4(header_input);
                                        	replace_header_input = StringEscapeUtils.escapeHtml4(replace_header_input);
                                            
                                            %>
                                            <input name="header_input" id="header_input" class="form-control control-t1" placeholder="Header Path" <% if (header_input != null) { %> value="<% out.print(header_input); } %>">
                                            <% session.removeAttribute("header_input"); %>
											<input name="replace_header_input" id="replace_header_input" class="form-control control-t2" placeholder="Replace Header Path" <% if (replace_header_input != null) { %> value="<% out.print(replace_header_input); } %>">
                                            <% session.removeAttribute("replace_header_input"); %>
                                        </div>
										<div class="form-group">
                                            <label style="display:block;">User Name / Author</label>
                                            <%
                                            String user_input;
                                            try {
                                            	user_input = session.getAttribute("user_input").toString();
                                            }
                                            catch (Exception e) {
                                            	user_input = null;
                                            }
                                            
                                            String replace_user_input;
                                            try {
                                            	replace_user_input = session.getAttribute("replace_user_input").toString();
                                            }
                                            catch (Exception e) {
                                            	replace_user_input = null;
                                            }
                                            
                                          	//escaping html properties
                                        	user_input = StringEscapeUtils.escapeHtml4(user_input);
                                        	replace_user_input = StringEscapeUtils.escapeHtml4(replace_user_input);
                                            
                                            %>
                                            <input name="user_input" id="user_input" class="form-control control-t1" placeholder="User Name / Author Path" <% if (user_input != null) { %> value="<% out.print(user_input); } %>">
                                        	<% session.removeAttribute("user_input"); %>
											<input name="replace_user_input" id="replace_user_input" class="form-control control-t2" placeholder="Replace User Name / Author Path" <% if (replace_user_input != null) { %> value="<% out.print(replace_user_input); } %>">
                                        	<% session.removeAttribute("replace_user_input"); %>
                                        </div>
										<div class="form-group">
                                            <label>Content</label>
                                            <%
                                            String content_input;
                                            try {
                                            	content_input = session.getAttribute("content_input").toString();
                                            }
                                            catch (Exception e) {
                                            	content_input = null;
                                            }
                                            
                                            String replace_content_input;
                                            try {
                                            	replace_content_input = session.getAttribute("replace_content_input").toString();
                                            }
                                            catch (Exception e) {
                                            	replace_content_input = null;
                                            }
                                            
                                          	//escaping html properties
                                        	content_input = StringEscapeUtils.escapeHtml4(content_input);
                                        	replace_content_input = StringEscapeUtils.escapeHtml4(replace_content_input);
                                            
                                            %>
                                            <input name="content_input" id="content_input" class="form-control" placeholder="Content Path" <% if (content_input != null) { %> value="<% out.print(content_input); } %>">
                                     		<% session.removeAttribute("content_input"); %>
											
                                        </div>
										<div class="form-group">
                                            <label style="display:block;">Date</label>
                                            <%
	                                            String date_input;
	                                            try {
	                                            	date_input = session.getAttribute("date_input").toString();
	                                            }
	                                            catch (Exception e) {
	                                            	date_input = null;
	                                            }
	
	                                            String dateformat_input;
	                                            try {
	                                            	dateformat_input = session.getAttribute("dateformat_input").toString();
	                                            }
	                                            catch (Exception e) {
	                                            	dateformat_input = null;
	                                            }
	                                            
	                                            String replacedate_input;
	                                            try {
	                                            	replacedate_input = session.getAttribute("replacedate_input").toString();
	                                            }
	                                            catch (Exception e) {
	                                            	replacedate_input = null;
	                                            }
	                                            
	                                            String attribute_input;
	                                            try {
	                                            	attribute_input = session.getAttribute("attribute_input").toString();
	                                            }
	                                            catch (Exception e) {
	                                            	attribute_input = null;
	                                            }
	                                            
	                                          	//escaping html properties
	                                        	date_input = StringEscapeUtils.escapeHtml4(date_input);
	                                        	dateformat_input = StringEscapeUtils.escapeHtml4(dateformat_input);
	                                        	replacedate_input = StringEscapeUtils.escapeHtml4(replacedate_input);
	                                        	attribute_input = StringEscapeUtils.escapeHtml4(attribute_input);
	                                            
                                            %>
                                            <input name="date_input" id="date_input" class="form-control control-t1" placeholder="Date Path" <% if (date_input != null) { %> value='<% out.print(date_input); } %>'>
											<% session.removeAttribute("date_input"); %>
											<input name="dateformat_input" id="dateformat_input" class="form-control control-t2" placeholder="Date Format ex. DD MM YYYY HH:MM" <% if (dateformat_input != null) { %> value='<% out.print(dateformat_input); } %>'>
                                       		<% session.removeAttribute("dateformat_input"); %>
											<input name="replacedate_input" id="replacedate_input" class="form-control control-t1" placeholder="Replace Date" <% if (replacedate_input != null) { %> value='<% out.print(replacedate_input); } %>'>
                                       		<% session.removeAttribute("replacedate_input"); %>
											<input name="attribute_input" id="attribute_input" class="form-control control-t2" placeholder="Attribute" <% if (attribute_input != null) { %> value='<% out.print(attribute_input); } %>'>
                                       		<% session.removeAttribute("attribute_input"); %>
                                        </div>
										<div id="new_form">
										</div>
										<input type="hidden" name="colId" value="<% out.print(colId); %>" />
										<input type="hidden" name="crawlerId" value="<% out.print(crawlerId); %>" />
										<input type="hidden" name="displayname" value="<% out.print(displayname); %>" />
										<input type="hidden" name="useragent" value="<% out.print(useragent); %>" />
										<input type="hidden" name="url" value="<% out.print(url); %>" />
										<input type="hidden" name="optionsRadios" value="<% out.print(type); %>" />
										<input type="hidden" name="keyword" value="<% out.print(keyword); %>" />
										<input type="hidden" name="prog" value="<% out.print(prog); %>" />
										<input type="hidden" name="progsince" value="<% out.print(progsince); %>" />
<!--                                         <button type="button" class="btn btn-default" title="Add" onclick="add1()">Add New Field</button> -->

										<% 
										String hostname = request.getServerName();
										String[] templateList = new CrawlerRequest(hostname).getListTemplate(type, token); %>
										<div class="modal fade" id="template" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									        <div class="modal-dialog" style="width: 350px;height:10px ">
									            <div class="modal-content">
									                <div class="modal-header">
									                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									                        <h4 class="modal-title" id="myModalLabel">Template list</h4>
									                           
									                            <div class="modal-body" style="word-wrap:break-word;height:120px;">
																	<select name="templateName" id="templateName" size="5" class="form-control1" style="height:100px">
																	<% for (String line : templateList) { %>
																		<option style="margin-bottom:5px;" value="<% out.print(line); %>"><% out.print(line); %></option>
																	<% } %>
																	</select>
																</div>
									                            <div class="modal-footer">
									                                <!--button type="button" class="btn btn-primary">Yes</button-->
																	<button type="submit" onclick="submitForm('api/getTemplateEdit.jsp')" class="btn btn-default" data-dismiss="modal">Ok</button>
																	<button type="button" class="btn btn-default" data-dismiss="modal">close</button>
									                            </div>
									                            </div>
									                            </div>
									                                    <!-- /.modal-content -->
									                                </div>
									                                <!-- /.modal-dialog -->
									    </div>

                                        <button id="removebutt" type="button" class="btn btn-default" title="Add" onclick="removediv()" style="display:none;">Remove</button>
                                        <button type="button" onclick="submitForm('jsoup/dynamicEdit.jsp')" class="btn btn-default" title="Run Testing"><img src="images/run.png" width="15px" height="17px"></button>
										<div class="row" style="margin:30px 10px 0px 0px">
											<button type="button" class="btn btn-default" title="back" onclick="location.href='edit_crawler.jsp'">Back</button>
											<button type="button" onclick="submitForm('api/editXML.jsp')" class="btn btn-default" title="finish">Finish</button>
											<button type="reset" class="btn btn-default" onclick="location.href='index.jsp#<% out.print(colId); %>'" title="cancel">Cancel</button>
											
										</div>
                                        
                                        
                                    </form>
                                </div>
                                <!-- /.col-lg-6 (nested) -->
                                
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
						
                    </div>
                    <!-- /.panel -->
                </div>
				<div class="col-lg-6">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Result
                        </div>
                        <div class="panel-body_ed" style="height:400px;">
							<div class="col-lg-12" >
							<%
							String result;
                            	try {
                               		result = session.getAttribute("result").toString();
                              	}
                               	catch (Exception e) {
                               		result = null;
                               	}
	                            if (result != null) out.print(result);
	                            session.removeAttribute("result");
                            %>
							</div>
						</div>
					</div>
				</div>
				<button type="submit" onclick="submitToFrame('jsoup/viewSource.jsp')" class="btn btn-default" data-toggle="modal" data-target="#pagesource" style="margin-left:5px;">View Source</button>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
	<div class="modal fade" id="pagesource" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 850px;height:500px ">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Source page</h4>
                            </div>
                            <div id="viewSource" class="modal-body" style="height:430px">
								<iframe name="sourceframe" frameborder="0" width="100%" height="100%" src="jsoup/viewSource.jsp"></iframe>
							</div>
                            <div class="modal-footer">
                                <!--button type="button" class="btn btn-primary">Yes</button-->
								<button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                            </div>
                            </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
    </div>
	</body>
</html>
