<%@ page import="apiRequest.*, java.util.*, java.text.*, org.apache.commons.lang3.StringEscapeUtils" %>
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
<!DOCTYPE html>
<html lang="en">
<%
	String colId = "";
	try {
		colId = session.getAttribute("colId").toString();
	}
	catch(Exception e) {
		colId = request.getParameter("colId");
		session.setAttribute("colId", colId);
	}
	// System.out.println("colId:"+colId);
	
	String crawlerId = "";
	try {
		crawlerId = session.getAttribute("crawlerId").toString();
	}
	catch(Exception e) {
		crawlerId = request.getParameter("crawlerId");
		session.setAttribute("crawlerId", crawlerId);
	}
	// System.out.println("crawlerId:"+crawlerId);
	session.setAttribute("edit", "1");
	String hostname = request.getServerName();
	String[] crawler = new CrawlerRequest(hostname).getCrawler(colId, crawlerId, token);
	String displayname = crawler[1];
	String type = crawler[2];
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
	String since = "";
	String until = "";
	String count = "";
	String lang = "";
	String keyword = "";
	String apptoken = "";
	String progressive = "";
	String prog = "";
	String progsince = "";
	String vst = "";
	String vkcf = "";
	String dbr = "";
	if (type.equalsIgnoreCase("general") || type.equalsIgnoreCase("news") || type.equalsIgnoreCase("forum")) {
		depthlink = crawler[3];
		thread = crawler[4];
		useragent = crawler[5];
		linktofollow = crawler[6];
		url = crawler[7];
		newsconfigloc = crawler[8];
		linktoforbid = crawler[9];
		forumconfigloc = crawler[10];
		keyword = crawler[11];
		progressive = crawler[12];
		if (!progressive.equalsIgnoreCase("true")) {
			prog = "False";
			if (!progressive.equalsIgnoreCase("false")) {
				progsince = progressive;
			}
		}
		else prog = "True";
	}
	else if (type.equalsIgnoreCase("twitter")) {
		query = crawler[6];
		until = crawler[3];
		count = crawler[4];
		lang = crawler[5];
		apptoken = crawler[7];
	}
	else if (type.equalsIgnoreCase("facebook")) {
		query = crawler[6];
		contenttype = crawler[3];
		since = crawler[4];
		until = crawler[5];
		apptoken = crawler[7];
	}
	else if (type.equalsIgnoreCase("twitter_bluemix")) {
		since = crawler[3];
		until = crawler[4];
		count = crawler[5];
		query = crawler[6];
		apptoken = crawler[7];
		dbr = crawler[8];
		
	}
	else if (type.equalsIgnoreCase("youtube")) {
		keyword = crawler[3];
		progressive = crawler[4];
		if (!progressive.equalsIgnoreCase("true")) {
			prog = "False";
			if (!progressive.equalsIgnoreCase("false")) {
				progsince = progressive;
			}
		}
		else prog = "True";
		vst = crawler[5];
		vkcf = crawler[6];
		apptoken = crawler[7];
	}
	
	// System.out.println("progressive: " + progressive);
	// System.out.println("prog: " + prog);
	// System.out.println("progsince: " + progsince);
// 	for (String a : crawler) // System.out.println(a);
	
%>
<% 
String[][] apptokens = new SecurityRequest(hostname).getTokens(session.getAttribute("username").toString(), token); %>
<head>
	<meta http-equiv="Cache-control" content="private">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

    <title>Edit Crawler - MAX Administration Console</title>
	
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/sb-admin-2.js"></script>
    <script>
		function datepick() {
			$( "#datepicker" ).datepicker({
				format: "yyyy-mm-dd"
			});
			$( "#datepicker1" ).datepicker({
				format: "yyyy-mm-dd"
			});
			$( "#datepicker2" ).datepicker({
				format: "yyyy-mm-dd"
			});
			$( "#progsince" ).datepicker({
				format: "yyyy-mm-dd"
			});
		};
		
		function cleardates(){
			//$( "#datepicker" ).datepicker("clearDates");
			//$('#datepicker').val('').datepicker('update');
			document.getElementById('datepicker').value = '';
			$('#datepicker').datepicker('update','');
		}
		
		function cleardates1(){
			//$( "#datepicker1" ).datepicker("clearDates");
			//$('#datepicker').val('').datepicker('update');
			document.getElementById('datepicker1').value = '';
			$('#datepicker1').datepicker('update','');
		}
		
		function cleardates2(){
			//$( "#datepicker2" ).datepicker("clearDates");
			//$('#datepicker').val('').datepicker('update');
			document.getElementById('datepicker2').value = '';
			$('#datepicker2').datepicker('update','');
		}
		
		function clearprogsince(){
			//$( "#progsince" ).datepicker("clearDates");
			//$('#datepicker').val('').datepicker('update');
			document.getElementById('progsince').value = '';
			$('#progsince').datepicker('update','');
		}
		
		function submitForm(action) {
	        document.getElementById('editcrawlerform').action = action;
	        document.getElementById('editcrawlerform').submit();
	    }
		
		function getAppToken() {
			var xmlhttp=new XMLHttpRequest();
			xmlhttp.onreadystatechange=function()
			  {
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			    {
				  	var apptoken = JSON.parse(xmlhttp.responseText);
				  	return apptoken;
			    }
			  }
			xmlhttp.open("GET","api/getAppToken.jsp",false);
			xmlhttp.send();
		}
		
		//function progs(what) {
			
			//if (what.value == 'false') {
				//document.getElementById('_progsince').style.display = 'inline'
				//document.getElementById('progsince').style.marginBottom = '15px'
			//} else if (what.value == 'true') {
				//document.getElementById('_progsince').style.display = 'none'
				//document.getElementById('progsince').value = ''
			//}
		//}
		function progs(){
			var e = document.getElementById('prog');
			var w = document.getElementById('_progsince');
			var progg = e.options[e.selectedIndex].value; 

			if (progg == 'false'){
				w.style.display = 'inline'
				document.getElementById('progsince').style.marginBottom = '15px'
			} else if (progg == 'true'){
				w.style.display = 'none'
			}
		}
		function start1(){
			datepick();
			progs();
		}
		
		function validate(){
	        x=document.crawlerform;
	        try {
	        	txt=x.twitcount.value;
	            if (txt>=1 && txt<=1000) {
	                return true;
	            }else{
	                alert("Must be between 1 and 1000");
	                return false;
	            }
	        }
	        catch(err) {
	        	return true;
	        }
		}
		
		window.onload = start1;
	</script>

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
					<li class="active">Edit Crawler - <% out.print(displayname + " (" + crawlerId + ")"); %></li>
				</ul>
			</div>
            <div class="row maxhead">
                <div class="col-lg-12">
                    <h1 class="page-header">Edit crawler</h1>
					<span>Edit the existing crawler properties.</span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-7">
				
                    <div class="panel-body">
						<form id="editcrawlerform" role="form" method="post" action="api/editCrawler.jsp" onsubmit="return validate()" style="margin-bottom:10px">
						<input type="hidden" id="colId" name="colId" value="<% out.print(colId); %>" />
						<input type="hidden" id="crawlerId" name="crawlerId" value="<% out.print(crawlerId); %>" />
						<input type="hidden" id="type" name="type" value="<% out.print(type); %>" />
                            <fieldset disabled>
							<div class="form-group">
                                <label for="disabledSelect">Website type:</label>
                                <select id="webtype" name="webtype" id="disabledSelect" class="form-control">
                                    <option><% out.print(type); %></option>
                                    
                                </select>
                            </div>
							</fieldset>
							<div class="form-group">
                                <label>Crawler name:</label><p class="help-block"> (Spaces and the characters a-z, A-Z, 0-9, underscore, and hyphen are allowed.)</p>
                                <input id="crawlername" name="crawlername" type="text" class="form-control" placeholder="Crawler name" value="<% out.print(displayname); %>" required></input>
                            </div>
							<% if (type.equalsIgnoreCase("general") || type.equalsIgnoreCase("news") || type.equalsIgnoreCase("forum")) { %>
							<div class="form-group">
							<label>Depth Link:</label>
							 <input id="depthlink" name="depthlink" type="text" class="form-control" placeholder="Depth Link" value="<% out.print(depthlink); %>" required></input>
							</div>
							<div class="form-group">
							<label>Thread:</label>
							 <input id="thread" name="thread" type="text" class="form-control" placeholder="Thread" value="<% out.print(thread); %>" required></input>
							</div>
							
							<div class="form-group">
                                <label>User agent:</label>
                                <input id="useragent" name="useragent" type="text" class="form-control" placeholder="User agent" value="<% out.print(useragent); %>" required></input>
                            </div>
							<div class="form-group">
                                <label>Allow URL pattern:</label>
                                 <textarea id="allowurl" name="allowurl" type="text" class="form-control" placeholder=""><% out.print(linktofollow); %></textarea>
                            </div>
							<div class="form-group">
                                <label>Forbid URL pattern:</label>
                                 <textarea id="forbidurl" name="forbidurl" type="text" class="form-control" placeholder=""><% out.print(linktoforbid); %></textarea>
                            </div>	
							<div class="form-group">
                                <span>* </span><label>Start URL:</label>
								<p class="help-block">Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p>
                                <input id="url" name="url" type="text" class="form-control" placeholder="URL" value="<% out.print(url); %>" required></input>
								
							</div>
							<div class="form-group">
                                <label>Keyword:</label>
								<p class="help-block">Type the keyword.</p>
                                <input id="keyword" name="keyword" type="text" class="form-control" placeholder="URL" value="<% out.print(keyword); %>" ></input>
								
							</div>
							<div class="form-group">
                                <label>Progressive:</label>
								<p class="help-block"></p>
                                <select id="prog" name="prog" class="form-control" onchange="progs()">
                                    <option value="true" <% if (prog.equalsIgnoreCase("true")) out.print("selected"); %>>True</option>
                                    <option value="false"<% if (prog.equalsIgnoreCase("false")) out.print("selected"); %>>False</option>
                                    
                                </select>
								
								
							</div>
							<%
								String progdisplay = "";
								if (prog.equalsIgnoreCase("false")) progdisplay = "inline";
								else progdisplay = "none";
							%>
							<div id="_progsince" class="form-group" style="<% out.print(progdisplay); %>">
                                <label>Since Progresive:</label>
								<p class="help-block"></p>
								
									<div class="form-group input-group">
                                	<input id="progsince" name="progsince" type="text" value="<% out.print(progsince); %>" class="form-control" placeholder="date"  style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd" readonly></input>
									<span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="clearprogsince()" style="margin-bottom:15px"><i class="fa fa-times"></i>
                                                </button>
                                            </span>
                                        </div>
									
								
							</div>
							<script>datepick();</script>
							<input type="hidden" id="newsconfigloc" name="newsconfigloc" value="<% out.print(newsconfigloc); %>" />
							<input type="hidden" id="forumconfigloc" name="forumconfigloc" value="<% out.print(forumconfigloc); %>" />
							<% } %>
							
							<% if (type.equalsIgnoreCase("facebook")) { %>
							<div class="form-group">
								<span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px" required>
								<% for (int i = 0; i < apptokens.length; i++) { %>
								<% if (apptokens[i][0].equalsIgnoreCase("facebook")) %> <option value="<%out.print(apptokens[i][1]);%>" <% if (apptokens[i][1].equalsIgnoreCase(apptoken)) out.print("selected");%>><%out.print(apptokens[i][2]);%></option>
								<% } %>
								</select>
								<span>*</span>
								<label>Query:</label>
								<input name="query" id="query" type="text" class="form-control" placeholder="Query" value="<% out.print(query); %>" required></input>
								</div>
							<div class="form-group">
								<label>Since:</label>
								<div class="form-group input-group">
								<input name="datesince" type="text" class="form-control" placeholder="since date" id="datepicker" style="cursor:pointer;" value="<% out.print(since); %> " pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd" readonly/>
								<span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="cleardates()"><i class="fa fa-times"></i>
                                                </button>
                                            </span>
                                        </div>
								<label>Until:</label>
								<div class="form-group input-group">
								<input name="dateuntil" type="text" class="form-control" placeholder="until date" id="datepicker1" style="cursor:pointer;" value="<% out.print(until); %>" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd" readonly/>
								<span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="cleardates1()"><i class="fa fa-times"></i>
                                                </button>
                                            </span>
                                        </div>
							</div>
							<script>datepick();</script>
							<input name="contenttype" type="hidden" value="<% out.print(contenttype); %>" />
							<% } %>
							<% if (type.equalsIgnoreCase("twitter")) { %>
							<div class="form-group">
								<span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px" required>
								<% for (int i=0; i < apptokens.length; i++) { %>
								<% if (apptokens[i][0].equalsIgnoreCase("twitter")) %> <option value="<%out.print(apptokens[i][1]);%>" <% if (apptokens[i][1].equalsIgnoreCase(apptoken)) out.print("selected");%>><%out.print(apptokens[i][2]);%></option>
								<% } %>
								</select>
								<span>* </span>
								<label>Query:</label>
								<input name="query" id="query" type="text" class="form-control" placeholder="Query" value="<% out.print(query); %>" required />
							</div>
							<div class="form-group">
								<label>Until:</label>
								<div class="form-group input-group">
								<input name="dateuntil" type="text" class="form-control" placeholder="until date" id="datepicker" style="cursor:pointer;" value="<% out.print(until); %>" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd" readonly/>
								<span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="cleardates()"><i class="fa fa-times"></i>
                                                </button>
                                            </span>
                                        </div>
							</div>
							<script>datepick();</script>
							<input name="count" type="hidden" value="<% out.print(count); %>" />
							<input name="lang" type="hidden" value="<% out.print(lang); %>" />
							<%
								}
							%>
							<% if (type.equalsIgnoreCase("twitter_bluemix")) { %>
							<div class="form-group">
								<span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px" required>
								<% for (int i=0; i < apptokens.length; i++) { %>
								<% if (apptokens[i][0].equalsIgnoreCase("twitter_bluemix")) %> <option value="<%out.print(apptokens[i][1]);%>" <% if (apptokens[i][1].equalsIgnoreCase(apptoken)) out.print("selected");%>><%out.print(apptokens[i][2]);%></option>
								<% } %>
								</select>
								<label>Count:</label>
								<input class="form-control" name="count" id="count" type="text" value="<% out.print(count); %>"></input>
								<span>* </span>
								<label>Query:</label>
								<input name="query" id="query" type="text" class="form-control" placeholder="Query" value="<% out.print(query); %>" required />
							</div>
							<div class="form-group">
								<label>Since:</label>
								<div class="form-group input-group">
								<input name="datesince" type="text" class="form-control" placeholder="since date" id="datepicker1" style="cursor:pointer;" value="<% out.print(since); %>" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd" />
								<span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="cleardates1()"><i class="fa fa-times"></i>
                                                </button>
                                            </span>
                                        </div>
							</div>
							<div class="form-group">
								<label>Until:</label>
								<div class="form-group input-group">
								<input name="dateuntil" type="text" class="form-control" placeholder="until date" id="datepicker2" style="cursor:pointer;" value="<% out.print(until); %>" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd" />
								<span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="cleardates2()"><i class="fa fa-times"></i>
                                                </button>
                                            </span>
                                        </div>
							</div>
							<script>datepick();</script>
							<input name="count" type="hidden" value="<% out.print(count); %>" />
							<%
								}
							%>
							<% if (type.equalsIgnoreCase("youtube")) { %>
							<div class="form-group">
								<span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px" required>
								<% for (int i = 0; i < apptokens.length; i++) { %>
								<% if (apptokens[i][0].equalsIgnoreCase("youtube")) %> <option value="<%out.print(apptokens[i][1]);%>" <% if (apptokens[i][1].equalsIgnoreCase(apptoken)) out.print("selected");%>><%out.print(apptokens[i][2]);%></option>
								<% } %>
								</select>
							</div>
							<div class="form-group">
								<label>Video Search Type:</label>
								<select class="form-control" id="vst" name="vst">
									<option value="relevance">Relevance</option>
									<option value="date">Date</option>
								</select>
							</div>
							<div class="form-group">
								<label>keyword:</label>
								<input name="keyword" id="keyword" type="text" class="form-control" placeholder="Query" value="<% out.print(keyword); %>" />
							</div>
							<div class="form-group">
                                <label>Progressive:</label>
								<p class="help-block"></p>
                                <select id="prog" name="prog" class="form-control" onchange="progs()">
                                    <option value="true" <% if (prog.equalsIgnoreCase("true")) out.print("selected"); %>>True</option>
                                    <option value="false"<% if (prog.equalsIgnoreCase("false")) out.print("selected"); %>>False</option>
                                    
                                </select>
							</div>
							<%
								String progdisplay = "";
								if (prog.equalsIgnoreCase("false")) progdisplay = "inline";
								else progdisplay = "none";
							%>
							<div id="_progsince" class="form-group" style="<% out.print(progdisplay); %>">
                                <label>Since Progresive:</label>
								<p class="help-block"></p>
								<div class="form-group input-group">
                                <input id="progsince" name="progsince" type="text" value="<% out.print(progsince); %>" class="form-control" placeholder="date"  style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd" readonly></input>
								<span class="input-group-btn">
                                                <button class="btn btn-default" type="button" onclick="clearprogsince()" style="margin-bottom:15px"><i class="fa fa-times"></i>
                                                </button>
                                            </span>
                                        </div>
							</div>
							
							<script>datepick();</script>
							<div class="form-group">
							<label>Video Keywords as Comment Filter</label>
							<select class="form-control" id="vkcf" name="vkcf">
								<option value="true" <% if (vkcf.equalsIgnoreCase("true")) out.print("selected"); %>>True</option>
                                <option value="false"<% if (vkcf.equalsIgnoreCase("false")) out.print("selected"); %>>False</option>
							</select>
							</div>
							<input name="count" type="hidden" value="<% out.print(count); %>" />
							<input name="lang" type="hidden" value="<% out.print(lang); %>" />
							<%
								}
							%>
							<button type="submit" class="btn btn-default" title="Save">Save</button>
                            <%
                            	String displayXML = "none";
                            	if (type.equalsIgnoreCase("news") || type.equalsIgnoreCase("forum")) displayXML = "inline";
                            %>
                            <button type="submit" class="btn btn-default" title="editxml" onclick="submitForm('dynamiccrawl_edit.jsp')" style="display:<% out.print(displayXML); %>;">Edit XML</button>
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
