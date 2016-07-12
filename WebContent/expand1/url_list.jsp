<%@ page import="httpProcess.HttpProcess, apiRequest.*" %>
<!DOCTYPE html>

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

	String colId = request.getParameter("colId");
	String crawlerId = request.getParameter("crawlerId");
	
	// System.out.println("colId:"+colId);
	// System.out.println("crawlerId:"+crawlerId);
	String hostname = request.getServerName();
	String[] crawler = new CrawlerRequest(hostname).getCrawler(colId, crawlerId, token);
	String type = crawler[2];
	
	String[] urlList = new CrawlerRequest(hostname).getRecentlyCrawled(colId, crawlerId, token);
	String[] urlList2 = new CrawlerRequest(hostname).getAllCrawled(colId, crawlerId, token);
	
%>
<html lang="en">

<head>
    <meta http-equiv="Cache-control" content="private">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>URL List - MAX Administration Console</title>
	
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script type="text/javascript" src="js/refresh.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/sb-admin-2.js"></script>

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
        	<div class="row maxbreadcrumb">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
					<li class="active">URL List</li>
				</ul>
			</div>
            <div class="row maxhead">
                <div class="col-lg-12">
                    <h1 class="page-header">URL List</h1>
					<span></span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-7">
				
                    <div class="panel-body">
						<form id="urllist" role="form" action="" style="margin-bottom:10px">
							<div class="form-group">
							
							<ul class="nav nav-pills">
                                <li class="active"><a href="#recentcrawl" data-toggle="tab">Recently Crawled</a>
                                </li>
                                <li><a href="#fullcrawl" data-toggle="tab">Crawled</a>
                                </li>
                                
                            </ul>
							<div class="tab-content">
                                <div class="tab-pane fade in active" id="recentcrawl">
                                	<%
                                		int recentLength = urlList.length;
                                		if (urlList[0].equals("")) {
                                			recentLength = 0;
                                		}
                                		
                                		if (!urlList[0].equals("") && (type.equals("twitter") || type.equals("facebook") || type.equals("twitter_bluemix") || type.equals("youtube"))) {
                                			int counter = 0;
                                			for (int i=0;i<urlList.length;i++) {
                                				int total = Integer.parseInt(urlList[i].split("found: ")[1]);
                                				counter+=total;
                                			}
                                			recentLength = counter;
                                		}
                                		
                                	%>
                                    <p id="crawlcount_recent" class="help-block-ed"><% if (type.equals("twitter")) out.print("Tweet(s) crawled : "); else if (type.equals("facebook")) out.print("Post(s) crawled : "); else out.print("URL(s) crawled : "); %><% out.print(recentLength); %> </p>
									<div style="width:100%; margin:8px 0px 8px 0px; color:#3c763d">
									<button type="button" class="btn btn-default" title="Full recrawl" style="" onclick="location.href='api/fullRecrawl.jsp?colId=<%out.print(colId);%>&crawlerId=<%out.print(crawlerId);%>'"><img src="images/run.png" width="15px" height="17px"></button>
									Full Recrawl
									<button type="button" onclick="refreshRecentlyCrawled('<% out.print(colId); %>','<%out.print(crawlerId); %>')" class="btn_ed" title="Refresh" style="border:none;float:right"><img src="images/refresh.png" width="28px" height="28px"></button></div>
									
									<textarea id="crawlList_recent" rows="15" id="allowurl" name="allowurl" type="text" class="form-control" placeholder="" ><% for (String url : urlList) out.println(url);%></textarea>
									</div>
                                <div class="tab-pane fade" id="fullcrawl">
                                	<%
                                		int allLength = urlList2.length;
                                		if (urlList2[0].equals("")) {
                                			allLength = 0;
                                		}
                                		
                                		if (!urlList2[0].equals("") && (type.equals("twitter") || type.equals("facebook") || type.equals("twitter_bluemix") || type.equals("youtube"))) {
                                			int counter = 0;
                                			for (int i=0;i<urlList2.length;i++) {
                                				int total = Integer.parseInt(urlList2[i].split("found: ")[1]);
                                				counter+=total;
                                			}
                                			allLength = counter;
                                		}
                                		
                                	%>
                                    <p id="crawlcount_all" class="help-block-ed"><% if (type.equals("twitter")) out.print("Tweet(s) crawled : "); else if (type.equals("facebook")) out.print("Post(s) crawled : "); else out.print("URL(s) crawled : "); %><% out.print(allLength); %> </p>
									<div style="width:100%; margin:8px 0px 8px 0px; color:#3c763d">
									<button type="button" class="btn btn-default" title="Full recrawl" style="" onclick="location.href='api/fullRecrawl.jsp?colId=<%out.print(colId);%>&crawlerId=<%out.print(crawlerId);%>'"><img src="images/run.png" width="15px" height="17px"></button>
									Full Recrawl
									<button onclick="refreshAllCrawled('<% out.print(colId); %>','<%out.print(crawlerId); %>')" type="button" class="btn_ed" title="Refresh" style="border:none;float:right"><img src="images/refresh.png" width="28px" height="28px"></button></div>
									
									<textarea id="crawlList_all" rows="15" id="allowurl" name="allowurl" type="text" class="form-control" placeholder="" ><% for (String url : urlList2) out.println(url);%></textarea>
									</div>
                               
                            </div>
                                
								
								
								
                            </div>
										
							
							<button type="button" class="btn btn-default" title="back" onclick="location.href='index.jsp#<% out.print(colId); %>'">Back</button>
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
