<%@ page import="httpProcess.HttpProcess, apiRequest.*" %>
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
	
	// System.out.println("token (expand1):"+token);
	session.removeAttribute("colId");
	session.removeAttribute("crawlerId");
	session.removeAttribute("edit");

	String hostname = request.getServerName();
	String[][] collections = null;
	try {
		collections = new CollectionRequest(hostname).getCollections(token);
	}
	catch (Exception e) {
		e.printStackTrace();
		collections = null;
	}
	int colCount = 1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Cache-control" content="private">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width">
    <meta name="author" content="PT. Mata Prima Universal">
	
	<title>MAX Administration Console</title>
	
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<link href="css/sb-admin-2.css" rel="stylesheet" type="text/css">
	<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		    var anchor = window.location.hash.replace("#", "");
		    colexpand(anchor);
		});
	</script>
	<script type="text/javascript" src="js/apirequest.js"></script>
	<script type="text/javascript" src="js/refresh.js"></script>
	<script type="text/javascript" src="js/expand1.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
	<script type="text/javascript" src="js/sb-admin-2.js"></script>
</head>
<body>
	<%
		String createMessage = "";
		String displayMessage = "none";
		
		try {
			createMessage = session.getAttribute("createMessage").toString();
		}
		catch (Exception e) {
			createMessage = "";
		}
		
		if (!createMessage.isEmpty()) { 
			displayMessage="block"; 
			session.removeAttribute("createMessage"); 
		}
	%>
	
	
	<div class="wrapper">
	<div class="page-wrapper">
		<div class="row_ed">
			<ul class="breadcrumb">
			  <li><a href="index.jsp">Home</a></li>
			  <li class="active">Collections</li>
			</ul>
		</div>
		<div class="row_ed" style="margin-top:-45px">
			<div class="col-lg-12">
				<h1 class="page-header">Collections</h1>
				<div class="alert alert-danger alert-dismissable" style="display:<%out.print(displayMessage);%>">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					<% out.print(createMessage); %>
				</div>
			</div>
		</div>
		<div class="row_ed">
			<div class="col-lg-12">
				<a href="create_collection.jsp"><button type="button" class="btn btn-default">Create Collection +</button></a>
				<%
					for (int j=0;j<collections.length;j++) {
						String[] collection = collections[j];
						String colId = collection[0];
						String colSize = "";
						String numDocs = "";
						String colVersion = "";
						String colActiveImg = "images/noactive1.png";
						if (collection.length > 1) {
							colSize = collection[1];
							numDocs = collection[2];
							colVersion = collection[3];
							colActiveImg = "images/active1.png";
						}
				%>
				<div id="<% out.print(colId); %>" class="container_ex">
					<div class="panel-heading" style="background-color:#e6e6e6;" >
						<table style="width:100%">
							<tr>
								<td style="width:99%">
									<div style="cursor:pointer" class="panel_ed-heading" onclick="colexpand(<% out.print("'"+colId+"'"); %>)">
										<span><% out.print(colId); %></span>
										<%
											String[][] crawlerList = new CrawlerRequest(hostname).getCrawlers(colId, token);
											String crawlerOverallState = "";
											String crawlerOverallImgsrc = "";
											String crawlerOverallstateText = "";
											for (int i=0;i<crawlerList.length;i++) {
												String crawlerId = crawlerList[i][0];
												String crawlerState = new CrawlerRequest(hostname).getState(colId, crawlerId, token)[0];
												if (crawlerState.equals("running")) {
													crawlerOverallState = "running";
													crawlerOverallImgsrc = "images/stop.png";
													break;
												}
												else {
													crawlerOverallState = "not running";
													crawlerOverallImgsrc = "images/run.png";
												}
											}
										%>
										<img id="index_indicator<%out.print(colCount); %>" src="<% out.print(colActiveImg); %>" title="Parse and Index" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;">
						
										<% if (crawlerOverallState.equals("running")) { %><img id="crawl_indicator<% out.print(colCount); %>" src="images/active1.png" title="Crawl" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;"> <% } %>
										<% if (crawlerOverallState.equals("not running")) { %><img id="crawl_indicator<% out.print(colCount); %>" src="images/noactive1.png" title="Crawl" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;"> <% } %>
										<% if (crawlerOverallState.equals("")) { %><img id="crawl_indicator<% out.print(colCount); %>" src="images/noactive1.png" title="Crawl" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;"> <% } %>
									</div>
								</td>
								<td>
									<div class="dropdown navbar-right">
										<a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color:#000">
											Action
										</a>
										<ul class="dropdown-menu dropdown-tasks">
											<!--li>
												<a href="#" target="iframe_a">
													Edit collection settings
												</a>
											</li>
											<li class="divider"></li>
											<li>
												<a href="#" target="iframe_a">
													View log files
												</a>
											</li>
											<li class="divider"></li-->
											<li>
												<a href="#" data-toggle="modal" data-target="#delconf<%out.print(colCount); %>" data-placement="bottom" title="" data-original-title="Stop the crawler first to delete">
													Delete collection
												</a>
											</li>
											<!--li class="divider"></li>
											<li>
												<a href="#" target="iframe_a">
													Clone collection
												</a>
											</li-->
										</ul>
										<!-- /.dropdown-tasks -->
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="modal fade" id="delconf<%out.print(colCount); %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">Delete Confirmation</h4>
								</div>
									<div class="modal-body">
											Are you sure?
									</div>
									<div class="modal-footer">
										<button type="button" onclick="location.href='api/deleteCollection.jsp?colId=<% out.print(colId); %>'" class="btn btn-primary">Yes</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
										
									</div>
							</div>
									<!-- /.modal-content -->
						</div>
							<!-- /.modal-dialog -->
					</div>
					<div id="content_ed_<% out.print(colId); %>" class="content">
						<div class="panel-body">
							<table>
								<tr>
									<td>
										<div class="panel panel-default_ed">
											<table>
												<tr>
													<td colspan="3"><samp>Crawl</samp></td>
												</tr>
		<!-- 										<tr> -->
		<!-- 										<td style="width:70%"> -->
		<%-- 											<div id="progress-bar-ed-info<%out.print(colCount); %>_1" class="progress no-margin"> --%>
		<%-- 											<div id="progress-bar-ed<%out.print(colCount); %>_1" class=" bar_ed progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" > --%>
		<!-- 												<span class="sr-only">0% Complete</span> -->
		<!-- 											</div> -->
		<!-- 											</div> -->
		<!-- 										</td> -->
		<!-- 										<td style="width:10%"> -->
		<%-- 											<button type="button" id="button<%out.print(colCount); %>_1" class="btn btn-default" onclick="run_prog_all(<% out.print(colCount); %>,1,<% out.print("\'"+crawlerOverallState+"\'"); %>,<%out.print("\'"+colId+"\'"); %>, <% out.print(crawlerList.length);%>)"><img id="<% out.print("buttonrun"+colCount+"_1"); %>" src=<% out.print(crawlerOverallImgsrc); %> width="15px" height="15px" /></button> --%>
		<!-- 										</td> -->
		<!-- 										<td style="width:20%"> -->
		<%-- 											<dfn id="<% out.print("textrun"+colCount+"_1"); %>"><% out.print(crawlerOverallState); %></dfn> --%>
		<!-- 										</td> -->
		<!-- 										</tr> -->
											</table>
											<hr>
											
											<div class="container_ex1">
												<div class="subpanel-heading_ed" style="background-color:#e6e6e6;">
													<table style="width:100%">
														<tr>
															<td style="width:99%">
																<div style="cursor:pointer" class="subpanel_ed-heading_ed" onclick="subcolexpand(<% out.print("'"+colId+"'"); %>, '1')">
																	<b>
																		<samp12>Crawler</samp12>
																	</b>
																</div>
															</td>
														<td><button class="btn btn-default" onclick="location.href='create_crawler.jsp?colId=<% out.print(colId); %>'" style="padding-top:0px; padding-bottom:0px;">+</button></td>
														</tr>
													</table>
												
												</div>
												<div id="subcontent_ed_<% out.print(colId); %>_1" class="content">	
		<%-- 										<div id="crawlCount<%out.print(colCount); %>" style="display: none;"><%out.print(crawlerList.length); %></div> --%>
														<%
															int crawlCount = 6;
															if (crawlerList.length < 1) {
														%>
																No crawler defined.
														<%
															}
															for (int i=0;i<crawlerList.length;i++) {
																String crawlerId = crawlerList[i][0];
																String displayname = crawlerList[i][1];
																String type = crawlerList[i][2];
																String icon = "";
																
// 																if (type.equalsIgnoreCase("general")) icon = "images/icon/domain_c.png"; 
// 																if (type.equalsIgnoreCase("facebook")) icon = "images/icon/fb_c.png"; 
// 																if (type.equalsIgnoreCase("twitter")) icon = "images/icon/twitter_c.png"; 
// 																if (type.equalsIgnoreCase("twitter_bluemix")) icon = "images/icon/twitter_c.png"; 
// 																if (type.equalsIgnoreCase("news")) icon = "images/icon/news.png"; 
// 																if (type.equalsIgnoreCase("forum")) icon = "images/icon/forum_c.png"; 
// 																if (type.equalsIgnoreCase("youtube")) icon = "images/icon/youtube.png"; 
																
																if (type.equalsIgnoreCase("general")) icon = "fa fa-globe"; 
																if (type.equalsIgnoreCase("facebook")) icon = "fa fa-facebook-square"; 
																if (type.equalsIgnoreCase("twitter")) icon = "fa fa-twitter-square"; 
																if (type.equalsIgnoreCase("twitter_bluemix")) icon = "fa fa-twitter-square"; 
																if (type.equalsIgnoreCase("news")) icon = "fa fa-list-alt"; 
																if (type.equalsIgnoreCase("forum")) icon = "fa fa-group"; 
																if (type.equalsIgnoreCase("youtube")) icon = "fa fa-youtube-square";
														%>
														<div id="crawlId<%out.print(colCount+"_"+crawlCount); %>" style="display: none;"><%out.print(crawlerId); %></div>
														<table>
															<tr>
																<td colspan="4">
<%-- 																	<img src="<%out.print(icon);%>" width="15px" height="15px" style="margin-right:5px"/> --%>
																		<i class="<%out.print(icon);%>"></i>
																		<samp12><% out.println(displayname); %></samp12>
																</td>
																<%
																	String state = new CrawlerRequest(hostname).getState(colId, crawlerId, token)[0];
																%>
															</tr>
															<tr>
																<td style="width:70%">
																	<%
																		String classname = "";
																		String 	width = "";
																		if (state.equals("not running")) {
																			classname = "progress no-margin";
																			width = "0%";
																		}
																		if (state.equals("running") || state.equals("starting") || state.equals("stopping")) {
																			classname = "progress no-margin progress-striped active";
																			width = "100%";
																		}
																	%>
																	<div id="<% out.print("progress-bar-ed-info"+colCount+"_"+crawlCount); %>" class='<% out.print(classname); %>'>
																	<div id="<% out.print("progress-bar-ed"+colCount+"_"+crawlCount); %>" class=" bar_ed progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:<% out.print(width);%>">
																		<span class="sr-only">0% Complete</span>
																	</div>
																	</div>
																</td>
																<td style="width:5%">
																	<%
																		String imgsrc = "";
																		String stylecolor = "";
																		String stateText = "";
																		if (state.equals("not running")) {
																			imgsrc = "fa fa-play";
																			stylecolor = "color:green";
																			stateText = "not running";
																		}
																		if (state.equals("running")) {
																			imgsrc = "fa fa-stop";
																			stylecolor = "color:red";
																			stateText = "running";
																		}
																		if (state.equals("starting")) {
																			imgsrc = "fa fa-play";
																			stylecolor = "color:green";
																			stateText = "starting";
																		}
																		if (state.equals("stopping")) {
																			imgsrc = "fa fa-stop";
																			stylecolor = "color:red";
																			stateText = "stopping";
																		}
																	%>
																	<button type="button" id="<% out.print("button"+colCount+"_"+crawlCount); %>" class="btn btn-default" onclick="run_progress_crawler(<% out.print("\'"+colCount+"\'"); %>,<% out.print("\'"+crawlCount+"\'"); %>,<% out.print("\'"+state+"\'"); %>,<% out.print("\'"+colId+"\'"); %>,<% out.print("\'"+crawlerId+"\'"); %>)">
																		<i id="<% out.print("buttonrun"+colCount+"_"+crawlCount); %>" class="<%out.print(imgsrc); %>" style="<%out.print(stylecolor); %>"></i>
																	</button>				
																</td>
																<td style="width:15%">
																	<dfn12 id="<% out.print("textrun"+colCount+"_"+crawlCount); %>"><% out.print(state); %></dfn12>
																</td>
																<td style="width:10%"></td>
															</tr>
															<!-- <tr>
																<td colspan="4"></td>
															</tr> -->
															<tr>
																<td>
																	<samp id="recentlyCrawledStatus<% out.print(colCount + "_" + crawlCount); %>"></samp>
																</td>
															</tr>
															<tr>
																<td colspan="4">
																	<% if (state.equals("not running")) { %> <button id="deletebutton<% out.print(colCount); %>_<% out.print(crawlCount); %>" type="button" class="btn" style="float:right" data-toggle="modal" data-target="#delconf<%out.print(colCount); %>_<%out.print(crawlCount); %>" data-placement="bottom" title="" data-original-title="Stop the crawler first to delete"><i class="fa fa-trash-o"></i></button> <% } %>
																	<% if (state.equals("running") || (state.equals("starting")) || (state.equals("stopping"))) { %> <button id="deletebutton<% out.print(colCount); %>_<% out.print(crawlCount); %>" type="button" class="btn disabled" style="float:right" data-toggle="modal" data-target="#delconf<%out.print(colCount); %>_<%out.print(crawlCount); %>"><i class="fa fa-trash-o"></i></button> <% } %>
																	<button type="button" class="btn" style="float:right" onclick="location.href='url_list.jsp?colId=<% out.print(colId); %>&crawlerId=<% out.print(crawlerId); %>'"><i class="fa fa-eye" ></i></button>
																	<button type="button" class="btn" style="float:right" onclick="location.href='edit_crawler.jsp?colId=<% out.print(colId); %>&crawlerId=<% out.print(crawlerId); %>'"><i class="fa fa-pencil" ></i></button>
																</td>
															</tr>
														</table>
														<div class="modal fade" id="delconf<%out.print(colCount); %>_<% out.print(crawlCount); %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
															<div class="modal-dialog">
																<div class="modal-content">
																	<div class="modal-header">
																		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
																		<h4 class="modal-title" id="myModalLabel">Delete Confirmation</h4>
																	</div>
																		<div class="modal-body">
																				Are you sure?
																		</div>
																		<div class="modal-footer">
																			<button type="button" onclick="location.href='api/deleteCrawler.jsp?colId=<% out.print(colId); %>&crawlerId=<% out.print(crawlerList[i][0]); %>'" class="btn btn-primary">Yes</button>
																			<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
																			
																		</div>
																</div>
																		<!-- /.modal-content -->
															</div>
																<!-- /.modal-dialog -->
														</div>
														<hr>
														<div id="crawlerAutoRefresh<%out.print(colCount+"_"+crawlCount); %>">
															<script type="text/javascript">
																refreshCrawler(<%out.print("'"+colCount+"'");%>,<%out.print("'"+crawlCount+"'");%>,<%out.print("'"+colId+"'");%>,<%out.print("'"+crawlerId+"'");%>);
																refreshRecentlyCrawledHome(<%out.print("'"+colCount+"'");%>,<%out.print("'"+crawlCount+"'");%>,<%out.print("'"+colId+"'");%>,<%out.print("'"+crawlerId+"'");%>);
																
																$(document).ready(function(){
																	var offsetRandom = Math.floor((Math.random() * 20000) + 5000);
																	setInterval(function () {
																		$content = $('#content_ed_' + <%out.print("'"+colId+"'");%>);
																		if($content.is(":visible")){
																			//console.debug("refresh for crawler --> colId:" + <%out.print("'"+colId+"'");%> + "-crawlId:" + <%out.print("'"+crawlerId+"'");%>);
																			refreshCrawler(<%out.print("'"+colCount+"'");%>,<%out.print("'"+crawlCount+"'");%>,<%out.print("'"+colId+"'");%>,<%out.print("'"+crawlerId+"'");%>);
																			refreshRecentlyCrawledHome(<%out.print("'"+colCount+"'");%>,<%out.print("'"+crawlCount+"'");%>,<%out.print("'"+colId+"'");%>,<%out.print("'"+crawlerId+"'");%>);
																		}
																	}, 10000 + offsetRandom);
																});
															</script>
														</div>
														<% crawlCount++; } %>
												</div>
												
											</div>
										</div>
									</td>
									<td >
										<div class="panel panel-default_ed">
											<table>
												<tr>
													<td colspan="3"><samp>Parse and Index</samp></td>
												</tr>
												<tr>
													<%
														String classname = "";
														String 	width = "";
														String img = "";
														String colors = "";
														String textrun = "";
														String state = "";
														if (collection.length > 1) {
															classname = "progress no-margin progress-striped active";
															width = "100%";
															img = "fa fa-stop";
															colors = "color:red";
															textrun = "running";
															state = "running";
														}
														else {
															classname = "progress no-margin";
															width = "0%";
															img = "fa fa-play";
															colors = "color:green";
															textrun = "not running";
															state = "not running";
														}
													%>
													<td style="width:70%">
														<div id="<%out.print("progress-bar-ed-info"+colCount+"_2"); %>" class="<% out.print(classname); %>">
														<div id="<%out.print("progress-bar-ed"+colCount+"_2"); %>" class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:<% out.print(width); %>" >
															<span class="sr-only">0% Complete</span>
														</div>
														</div>
													</td>
													<td style="width:10%">
														<button id="<% out.print("button"+colCount+"_2"); %>" type="button" class="btn btn-default" onclick="run_progress_collection(<% out.print(colCount); %>,2,'<% out.print(state); %>','<% out.print(colId); %>','na')"><i id="<% out.print("buttonrun"+colCount+"_2"); %>" class="<%out.print(img); %>" style="<%out.print(colors); %>" ></i></button>
													</td>
													<td style="width:20%">
														<dfn id="<% out.print("textrun"+colCount+"_2"); %>"><%out.print(textrun); %></dfn>
													</td>
												</tr>
												<tr>
													<td><samp id="collectionStatus<% out.print(colCount); %>"></samp></td>
												</tr>
											</table>
											<hr>
											<div class="panel-body_ed5">
												<div class="dropdown navbar-right" style="display:block" >
													<a class="dropdown-toggle" data-toggle="dropdown" href="#" >
														<i class="fa fa-pencil" width="16px" height="18px"></i>
													</a>
													<ul class="dropdown-menu dropdown-tasks">
														<li>
														<p class="config_ed">
															Configure..
														</p>
														</li>
														<li class="divider"></li>
														<li>
															<a href="index_fields_ed.jsp?colId=<%out.print(colId); %>" target="iframe_a">
																Index fields
															</a>
														</li>
																			
														<li>
															<a href="facet_map.jsp?colId=<%out.print(colId); %>" target="iframe_a">
																Facet tree
															</a>
														</li>
														<li>
															<a href="user_dict.jsp?colId=<%out.print(colId); %>" target="iframe_a">
																User Dictionary
															</a>
														</li>
														<li id="<%out.print("annotatorMenu"+colCount); %>" class="enabled" title="">
															<a href="annotators.jsp?colId=<%out.print(colId);%>" target="iframe_a">
																Annotators
															</a>
														</li>
																			
																			
													</ul>
													<!-- /.dropdown-tasks -->
												</div>
											</div>
											<div class="container_ex1">
												<div class="subpanel-heading_ed" style="background-color:#e6e6e6;" >
													<table style="width:100%">
														<tr><td><div style="cursor:pointer" class="subpanel_ed-heading_ed" onclick="subcolexpand(<%out.print("'"+colId+"'");%>, '2')"><b><samp12>Analytic Resources</samp12></b></div>
														</td></tr>
														
													</table>
												
												</div>
												<div id="subcontent_ed_<%out.print(colId);%>_2" class="content">	
													<%
															String[] rebuildStatus = new CollectionRequest(hostname).getCollectionStatus(colId, token);
															if (rebuildStatus[0].equalsIgnoreCase("idle")) {
																classname = "progress no-margin";
																width = "0%";
																img = "fa fa-play";
																colors = "color:green";
																textrun = "not running";
																state = "not running";
															}
															else if(rebuildStatus[0].equalsIgnoreCase("rebuildindex")){
																classname = "progress no-margin progress-striped active";
																width = "20%";
																img = "fa fa-stop";
																colors = "color:red";
																textrun = "rebuilding";
																state = "running";
															}
														%>
														
														<table >
															<tr>
																<td colspan="4"><samp12b>Rebuild Index</samp12b></td>
															</tr>
															<tr>
																<td style="width:70%">
																	<div id="<%out.print("progress-bar-ed-info"+colCount+"_3"); %>" class="<%out.print(classname);%>">
																	<div id="<% out.print("progress-bar-ed"+colCount+"_3"); %>" class=" bar_ed progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:<% out.print(width); %>" >
																		<span class="sr-only">0% Complete</span>
																	</div>
																	</div>
																</td>
																<td style="width:5%">
																	<button id="<% out.print("button"+colCount+"_3"); %>" type="button" class="btn btn-default" onclick="run_progress_rebuilder(<% out.print(colCount); %>,3,'<%out.print(state); %>','<% out.print(colId); %>','<%out.print(crawlerList.length);%>')">
																		<i id="buttonrun<% out.print(colCount); %>_3" class="<%out.print(img);%>" style="<%out.print(colors);%>"></i>
																	</button>
																</td>
																<td style="width:15%">
																	<dfn12 id="<%out.print("textrun"+colCount+"_3");%>"><% out.print(textrun); %></dfn12>
																</td>
																<td style="width:10%"></td>
															</tr>
															<tr>
																<td>
																	<dfn12 id="<%out.print("textrundetail"+colCount+"_3");%>"></dfn12>
																</td>
															</tr>
															<tr>
																<td colspan="4"></td>
															</tr>
														</table>
														<hr>
														<table style="margin-bottom:10px">
															<tr>
																<td colspan="4"><samp12>Deploy analytic resources</samp12></td>
															</tr>
															<tr>
															<td style="width:70%">
																<div id="<%out.print("progress-bar-ed-info"+colCount+"_4"); %>" class="progress no-margin">
																<div id="<%out.print("progress-bar-ed"+colCount+"_4"); %>" class=" bar_ed progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" >
																	<span class="sr-only">0% Complete</span>
																</div>
																</div>
															</td>
															<td style="width:5%">
																<button id="<% out.print("button"+colCount+"_4"); %>" title="" type="button" class="btn btn-default" onclick="reloadParse(<% out.print(colCount); %>,4,'<% out.print(colId); %>','na')"><img id="buttonrun<% out.print(colCount); %>_4" src="images/run.png" width="10px" height="10px" /></button>
															</td>
															<td style="width:15%">
																<dfn12 id="<%out.print("textrun"+colCount+"_4");%>">not running</dfn12>
															</td>
															<td>
															</td style="width:10%">
															</tr>
															
															
														</table>
												</div>
											</div>
											<div id="indexerAutoRefresh<%out.print("'"+colCount+"'");%>">
												<script type="text/javascript">
													refreshParse(<%out.print("'"+colCount+"'");%>,'2',<%out.print("'"+colId+"'");%>,'');
													refreshCollectionStatus(<%out.print("'"+colCount+"'");%>,<%out.print("'"+colId+"'");%>);
													
													$(document).ready(function(){
														var offsetRandom = Math.floor((Math.random() * 30000) + 10000);
														setInterval(function () {
															$content = $('#content_ed_' + <%out.print("'"+colId+"'");%>);
															if($content.is(":visible")){
																//console.debug("refresh indexer & collection status --> colId:" + <%out.print("'"+colId+"'");%>);
																refreshParse(<%out.print("'"+colCount+"'");%>,'2',<%out.print("'"+colId+"'");%>,'');
																refreshCollectionStatus(<%out.print("'"+colCount+"'");%>,<%out.print("'"+colId+"'");%>);
															}
														}, 30000 + offsetRandom);
													});
												</script>
											</div>
										</div>
									</td>
									<td >
										<div class="panel panel-default_ed">
											<table>
												<tr>
													<td colspan="3"><samp>Details</samp></td>
												</tr>
											</table>
											<hr>
											<table>
															<tr>
																<td style="width:50%"><samp12>Index size:</samp12></td>
																<td style="width:25%"><samp12 id="colSize<%out.print(colCount);%>"><% out.print(colSize); %></samp12></td>
																<td style="width:25%"></td>
															</tr>
															<tr>
																<td><samp12>Number of documents:</samp12></td>
																<td><samp12 id="numdocs<%out.print(colCount);%>"><% out.print(numDocs); %></samp12></td>
																<td></td>
															</tr>
		<!-- 													<tr> -->
		<!-- 														<td><samp12>Number of dropped documents:</samp12></td> -->
		<!-- 														<td><samp12>0</samp12></td> -->
		<!-- 														<td><button type="button" class="btn"><img src="images/eye.png" width="15px" height="15px" style="float:left" /></button></td> -->
		<!-- 													</tr> -->
															<tr>
																<td><samp12>Index version:</samp12></td>
																<td><samp12 id="colVersion<%out.print(colCount);%>"><% out.print(colVersion); %></samp12></td>
																<td></td>
															</tr>
															<tr>
																<% String[] currentPear = new PearRequest(hostname).currentPear(colId, token); %>
																<td><samp12>Current Pear:</samp12></td>
																<td><samp12 id="currentPear<%out.print(colCount);%>"><% out.print(currentPear[0]); %></samp12></td>
																<td></td>
															</tr>
															
															<tr><td colspan="3"><button class="btn btn-default" onclick="refreshDetails('<%out.print(colCount); %>','<%out.print(colId); %>');" style="float:right"><img src="images/refresh1.png" width="16px" height="16px"></button></td></tr>		
											</table>
											<div id="detailAutoRefresh<%out.print("'"+colCount+"'");%>">
												<script type="text/javascript">
													refreshDetails(<%out.print("'"+colCount+"'");%>,<%out.print("'"+colId+"'"); %>);
													
													$(document).ready(function(){
														var offsetRandom = Math.floor((Math.random() * 30000) + 10000);
														setInterval(function () {
															$content = $('#content_ed_' + <%out.print("'"+colId+"'");%>);
															if($content.is(":visible")){
																//console.debug("refresh details --> colId:" + <%out.print("'"+colId+"'");%>);
																refreshDetails(<%out.print("'"+colCount+"'");%>,<%out.print("'"+colId+"'"); %>);
															}
														}, 30000 + offsetRandom);
													});
												</script>
											</div>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				
				<%
						colCount++;
					}
				%>
				
			</div>
		</div>
	</div>
		
	</div>
</body>
</html>