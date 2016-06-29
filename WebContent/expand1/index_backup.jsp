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
%>
<%
	// System.out.println("token (expand1):"+token);
	session.removeAttribute("colId");
	session.removeAttribute("crawlerId");
	session.removeAttribute("edit");
%>
<html>
<head>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet" type="text/css" >
	<link href="css/sb-admin-2.css" rel="stylesheet">
	<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script>
	function run_prog(col,con,state,colId,crawlId) {
		var progressBar = $('#progress-bar-ed'+col+'_'+con);
		
			if (state == "not running") {
				width = 0;
				progressBar.width(width);
				document.getElementById("button"+col+"_"+con).onclick = function() {run_prog(col,con,'running',colId,crawlId)};
				document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "starting";
				var interval = setInterval(function() {
	
					width += 10;
	
					progressBar.css('width', width + '%');
					
					if (width >= 100) {
						clearInterval(interval);
						startCrawler(col, con, colId, crawlId);
					}
				}, 200);
			}
			else if (state == "running") {
				document.getElementById('textrun'+col+'_'+con).innerHTML = "stopping";
				stopCrawler(col, con, colId, crawlId);
			}
	}
	
	function run_prog2(col,con,state,colId,crawlId) {
		var progressBar = $('#progress-bar-ed'+col+'_'+con);
		
			if (state == "not running") {
				width = 0;
				progressBar.width(width);
				document.getElementById("button"+col+"_"+con).onclick = function() {run_prog2(col,con,'running',colId,crawlId)};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "starting";
				var interval = setInterval(function() {
	
					width += 10;
	
					progressBar.css('width', width + '%');
					
					if (width >= 100) {
						clearInterval(interval);
						if (con == 2) {
							startCollection(col,con,colId,crawlId);
						}
						if (con == 3) {
							document.getElementById('progress-bar-ed-info'+col+'_'+con).className += ' progress-striped active';
							document.getElementById('textrun'+col+'_'+con).innerHTML = "rebuilding";
							document.getElementById('button'+col+'_'+con).classname = "btn disabled";
							rebuildIndex(col,con,colId,crawlId);
						}
						if (con == 4) {
							document.getElementById('progress-bar-ed-info'+col+'_'+con).className += ' progress-striped active';
							document.getElementById('textrun'+col+'_'+con).innerHTML = "reloading";
							document.getElementById('button'+col+'_'+con).classname = "btn disabled";
							reloadParse(col,con,colId,crawlId);
						}
						if (con == 5) {
							startCollection(col,con,colId,crawlId);
						}
					}
				}, 200);
			}
			else if (state == "running") {
				if (con == 2) {
					document.getElementById('textrun'+col+'_'+con).innerHTML = "stopping";
					stopCollection(col,con,colId,crawlId);
				}
				if (con == 3) {
// 					stopCollection(col,con,colId,crawlId);
				}
				if (con == 4) {
// 					document.getElementById('textrun'+col+'_'+con).innerHTML = "stopping";
// 					stopCollection(col,con,colId,crawlId);
				}
				if (con == 5) {
// 					document.getElementById('textrun'+col+'_'+con).innerHTML = "stopping";
// 					stopCollection(col,con,colId,crawlId);
				}
			}
	}
	
	</script>
	<script type="text/javascript" src="js/apirequest.js"></script>
	<script type="text/javascript" src="js/refresh.js"></script>
	<script type="text/javascript" src="js/expand1.js"></script>
	
	<script src="js/bootstrap.js"></script>
	<script src="js/sb-admin-2.js"></script>
	<script>
// 		setTimeout(function(){
// 			refreshSession();
// 		  },10000);
	</script>
</head>
<body>	
	<div class="wrapper">
	<div class="page-wrapper">
		<div class="row_ed">
			<div class="col-lg-12">
				<h1 class="page-header">Collections</h1>
			</div>
		</div>
		<div class="row_ed">
			<div class="col-lg-12">
				<a href="create_collection.jsp"><button type="button" class="btn btn-default">Create Collection +</button></a>


				<%
					String hostname = request.getServerName();
					String[][] collections = new CollectionRequest(hostname).getCollections(token);
					int colCount = 1;
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


				<div class="container_ex">
				<div class="panel-heading" style="background-color:#e6e6e6;" >
					<table style="width:100%">
					<tr><td style="width:99%"><div style="cursor:pointer" class="panel_ed-heading" onclick="colexpand(<% out.print(colCount); %>)">
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
					<img id="ana_indicator<%out.print(colCount); %>" src="images/active1.png" title="Analytic Miner" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;">
					<img id="index_indicator<%out.print(colCount); %>" src="<% out.print(colActiveImg); %>" title="Parse and Index" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;">
					
					<% if (crawlerOverallState.equals("running")) { %><img id="crawl_indicator<% out.print(colCount); %>" src="images/active1.png" title="Crawl" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;"> <% } %>
					<% if (crawlerOverallState.equals("not running")) { %><img id="crawl_indicator<% out.print(colCount); %>" src="images/noactive1.png" title="Crawl" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;"> <% } %>
					<% if (crawlerOverallState.equals("")) { %><img id="crawl_indicator<% out.print(colCount); %>" src="images/noactive1.png" title="Crawl" style="display:block; float:right; z-index:1080; height:12px; width:12px; margin: 5px 15px 0px 15px;"> <% } %>
					</div></td>
					<td>
					<li class="dropdown navbar-right">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color:#000">
							Action
						</a>
						<ul class="dropdown-menu dropdown-tasks">
							<li>
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
							<li class="divider"></li>
							<li>
								<a href="#" data-toggle="modal" data-target="#delconf<%out.print(colCount); %>" data-placement="bottom" title="" data-original-title="Stop the crawler first to delete">
									Delete collection
								</a>
							</li>
							<li class="divider"></li>
							<li>
								<a href="#" target="iframe_a">
									Clone collection
								</a>
							</li>
							
							
						</ul>
						<!-- /.dropdown-tasks -->
					</li></td></tr>
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
				<div id="content_ed<% out.print(colCount); %>" class="content">
				
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
										<div class="subpanel-heading_ed" style="background-color:#e6e6e6;" >
											<table style="width:100%">
												<tr><td style="width:99%"><div style="cursor:pointer" class="subpanel_ed-heading_ed" onclick="subcolexpand(<% out.print(colCount); %>)"><b><samp12>Crawler</samp12></b></div></td>
												<td><button class="btn btn-default" onclick="location.href='create_crawler.jsp?colId=<% out.print(colId); %>'" style="padding-top:0px; padding-bottom:0px;">+</button></td>
												</tr>
											</table>
										
										</div>
										<div id="subcontent_ed<% out.print(colCount); %>" class="content">	
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
														
														if (type.equalsIgnoreCase("general")) icon = "images/icon/domain_c.png"; 
														if (type.equalsIgnoreCase("facebook")) icon = "images/icon/fb_c.png"; 
														if (type.equalsIgnoreCase("twitter")) icon = "images/icon/twitter_c.png"; 
														if (type.equalsIgnoreCase("news")) icon = "images/icon/news.png"; 
														if (type.equalsIgnoreCase("forum")) icon = "images/icon/forum_c.png"; 
														
												%>
												<div id="crawlId<%out.print(colCount+"_"+crawlCount); %>" style="display: none;"><%out.print(crawlerId); %></div>
												<table >
													<tr>
														<td colspan="4"><img src="<%out.print(icon);%>" width="15px" height="15px" style="margin-right:5px"><samp12><% out.println(displayname); %></samp12></td>
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
															String stateText = "";
															if (state.equals("not running")) {
																imgsrc = "images/run.png";
																stateText = "stopped";
															}
															if (state.equals("running")) {
																imgsrc = "images/stop.png";
																stateText = "running";
															}
															if (state.equals("starting")) {
																imgsrc = "images/run.png";
																stateText = "starting";
															}
															if (state.equals("stopping")) {
																imgsrc = "images/stop.png";
																stateText = "stopping";
															}
														%>
														<button type="button" id="<% out.print("button"+colCount+"_"+crawlCount); %>" class="btn btn-default" onclick="run_prog('<% out.print(colCount); %>','<% out.print(crawlCount); %>',<% out.print("\'"+state+"\'"); %>,<% out.print("\'"+colId+"\'"); %>, <% out.print("\'"+crawlerId+"\'"); %>)"><img id="<% out.print("buttonrun"+colCount+"_"+crawlCount); %>" src="<%out.print(imgsrc); %>" width="10px" height="10px" /></button>
<%-- 														<button type="button" id="<% out.print("button"+colCount+"_"+crawlCount); %>" class="btn btn-default" onclick="ivan()" src=<% out.print(imgsrc); %> width="10px" height="10px" /></button> --%>
														
													</td>
													<td style="width:15%">
														<dfn12 id="<% out.print("textrun"+colCount+"_"+crawlCount); %>"><% out.print(stateText); %></dfn12>
													</td>
													<td>
													</td style="width:10%">
													</tr>
													<tr>
														<td colspan="4">
														</td>
													</tr>
													<tr>
														<td colspan="4">
														<% if (state.equals("running")) { %> <button id="deletebutton<% out.print(colCount); %>_<% out.print(crawlCount); %>" type="button" class="btn disabled" style="float:right" data-toggle="modal" data-target="#delconf<%out.print(colCount); %>_<%out.print(crawlCount); %>"><img src="images/delete.png" width="16px" height="18px"/></button> <% } %>
														<% if (state.equals("not running")) { %> <button id="deletebutton<% out.print(colCount); %>_<% out.print(crawlCount); %>" type="button" class="btn" style="float:right" data-toggle="modal" data-target="#delconf<%out.print(colCount); %>_<%out.print(crawlCount); %>" data-placement="bottom" title="" data-original-title="Stop the crawler first to delete"><img src="images/delete.png" width="16px" height="18px"/></button> <% } %>
														<button type="button" class="btn" style="float:right" onclick="location.href='url_list.jsp?colId=<% out.print(colId); %>&crawlerId=<% out.print(crawlerId); %>'"><img src="images/eye.png" width="18px" height="18px"/></button>
														<button type="button" class="btn" style="float:right" onclick="location.href='edit_crawler.jsp?colId=<% out.print(colId); %>&crawlerId=<% out.print(crawlerId); %>'"><img src="images/pencil.png" width="16px" height="18px"/></button>
														
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
										<%
											String classname = "";
											String 	width = "";
											String img = "";
											String textrun = "";
											String state = "";
											if (collection.length > 1) {
												classname = "progress no-margin progress-striped active";
												width = "100%";
												img = "images/stop.png";
												textrun = "running";
												state = "running";
											}
											else {
												classname = "progress no-margin";
												width = "0%";
												img = "images/run.png";
												textrun = "stopped";
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
											<button id="<% out.print("button"+colCount+"_2"); %>" type="button" class="btn btn-default" onclick="run_prog2(<% out.print(colCount); %>,2,'<% out.print(state); %>','<% out.print(colId); %>','na')"><img id="<% out.print("buttonrun"+colCount+"_2"); %>" src="<%out.print(img); %>" width="15px" height="15px" /></button>
										</td>
										<td style="width:20%">
											<dfn id="<% out.print("textrun"+colCount+"_2"); %>"><%out.print(textrun); %></dfn>
										</td>
									</table>
									<hr>
									<div class="panel-body_ed5">
									<li class="dropdown navbar-right" style="display:block" >
										<a class="dropdown-toggle" data-toggle="dropdown" href="#" >
											<img src="images/pencil.png" width="16px" height="18px"  />
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
												<a href="#" target="iframe_a">
													User dictionaries
												</a>
											</li>
											<li>
												<a href="annotators.jsp?colId=<%out.print(colId);%>" target="iframe_a">
													Annotators
												</a>
											</li>
																
																
										</ul>
										<!-- /.dropdown-tasks -->
									</li>
									</div>
									<div class="container_ex1">
										<div class="panel-heading_ed" style="background-color:#e6e6e6;" ><b><samp12>Details</samp12></b></div>
										<div class="content overaut" style="height:200px;">	
												
												<%
													String[] rebuildStatus = new ParseRequest(hostname).getRebuildStatus(colId, token);
													if (rebuildStatus[0].equalsIgnoreCase("idle")) {
														classname = "progress no-margin";
														width = "0%";
														img = "images/run.png";
														textrun = "stopped";
														state = "not running";
													}
													else {
														classname = "progress no-margin progress-striped active";
														width = "100%";
														img = "images/stop.png";
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
<!-- 															<span class="sr-only">0% Complete</span> -->
														</div>
														</div>
													</td>
													<td style="width:5%">
														<button id="<% out.print("button"+colCount+"_3"); %>" type="button" class="btn btn-default" onclick="run_prog2(<% out.print(colCount); %>,3,'<%out.print(state); %>','<% out.print(colId); %>','na')"><img id="buttonrun<% out.print(colCount); %>_3" src="<%out.print(img);%>" width="10px" height="10px" /></button>
													</td>
													<td style="width:15%">
														<dfn12 id="<%out.print("textrun"+colCount+"_3");%>"><% out.print(textrun); %></dfn12>
													</td>
													<td>
													</td style="width:10%">
													</tr>
													<tr>
														<td colspan="4">
														</td>
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
												</table>
												
												
											
										</div>
									</div>
									<div class="container_ex1">
										<div class="panel-heading_ed" style="background-color:#e6e6e6;" ><b><samp12>Analytic Resources</samp12></b></div>
										<div class="content overaut" style="height:70px">	
											
												<table >
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
														<button id="<% out.print("button"+colCount+"_4"); %>" type="button" class="btn btn-default" onclick="run_prog2(<% out.print(colCount); %>,4,'not running','<% out.print(colId); %>','na')"><img id="buttonrun<% out.print(colCount); %>_4" src="images/run.png" width="10px" height="10px" /></button>
													</td>
													<td style="width:15%">
														<dfn12 id="<%out.print("textrun"+colCount+"_4");%>">stopped</dfn12>
													</td>
													<td>
													</td style="width:10%">
													</tr>
													
													
												</table>
												
												
												
											
										</div>
									</div>
									
								</div>
							</td>
							<td >
								<div class="panel panel-default_ed">
									<table>
										<tr>
											<td colspan="3"><samp>Analytics Miner</samp></td>
										</tr>
										<td style="width:70%">
											<div id="<% out.print("progress-bar-ed-info"+colCount+"_5"); %>" class="progress no-margin">
											<div id="<% out.print("progress-bar-ed"+colCount+"_5"); %>" class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" >
												<span class="sr-only">0% Complete</span>
											</div>
											</div>
										</td>
										<td style="width:10%">
											<button id="<% out.print("button"+colCount+"_5"); %>" type="button" class="btn btn-default" onclick="run_prog2(<% out.print(colCount); %>,5,'not running','<% out.print(colId); %>','na')"><img id="buttonrun<% out.print(colCount); %>_5" src="images/run.png" width="15px" height="15px" /></button>
										</td>
										<td style="width:20%">
											<dfn id="<%out.print("textrun"+colCount+"_5");%>">stopped</dfn>
										</td>
									</table>
									
									
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