<%@ page import="apiRequest.*" %>
<%
	String token = "";
	try {
		token = session.getAttribute("token").toString();
		String hostname = request.getServerName();
		String[] checkSession = new LoginRequest(hostname).checkSession(token);
		// System.out.println("response length:"+checkSession.length);
		// System.out.println("response value:"+checkSession[1]);
		if (!(checkSession.length == 2) || checkSession[1].equalsIgnoreCase("1")) {
			token = "";
			session.removeAttribute("token");
		}
	}
	catch (Exception e) {
		token = "";
		session.removeAttribute("token");
	}
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="Cache-control" content="private">
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width">
    <meta name="author" content="PT. Mata Prima Universal">
	
	<link rel="icon" type="image/png" href="images/eye-icon.png">
	
    <title>Mata Analytics Administration Console</title>
	
	<!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
    <!-- MetisMenu CSS -->
    <!--link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet"-->
    <!-- Timeline CSS -->
    <!--link href="css/plugins/timeline.css" rel="stylesheet"--> <!-- Custom CSS -->
    <link href="css/sb-admin-2.css" rel="stylesheet" type="text/css">
    <!-- Morris Charts CSS -->
    <!--link href="css/plugins/morris.css" rel="stylesheet"-->
    <!-- Custom Fonts -->
    <!--link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"-->
	
    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js" type="text/javascript"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/plugins/metisMenu/metisMenu.min.js" type="text/javascript"></script>
    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js" type="text/javascript"></script>
<!--     <script src="js/plugins/morris/morris.min.js"></script> -->
<!--     <script src="js/plugins/morris/morris-data.js"></script> -->
    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js" type="text/javascript"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body style="overflow: hidden">
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0px;">
            <div class="navbar-header">
                <a class="navbar-brand" href="index.jsp">
                	Mata Analytics Admin Console
                </a>
            </div>
            <!-- /.navbar-header -->
			
            <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown">
						Help <i class="icon-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu">
						<li>
							<a data-toggle="modal" data-target="#aboutModal">About</a>
                        </li>
                    </ul>
                </li>
            <%
            	String username = "";
            	try {
    				username = session.getAttribute("username").toString();
            	}
            	catch (Exception e) {
            		username = "";
            	}
            	if(!username.isEmpty()) {
            %>	
            	<li id="navbarCollection" class="active">
            		<a href="expand1/index.jsp" target='iframe_a' style="color:#E1E1D2" onclick="document.getElementById('navbarCollection').className == 'active';document.getElementById('navbarSecurity').className = '';">
                        Collection
                    </a>
                </li>
                <li id="navbarSecurity" class="">
                    <a href="expand1/security_fields.jsp" target='iframe_a' style="color:#E1E1D2" onclick="document.getElementById('navbarCollection').className == '';document.getElementById('navbarSecurity').className = 'active';">
                        Security
                    </a>
                </li>
                <!-- /.dropdown -->
                <%
            		}
                	String framesrc= "";
                	//// System.out.println("token (main index):"+token);
                	//// System.out.println("framesrc:"+framesrc);
            	    if (token.equalsIgnoreCase("")) {
            	    	framesrc = "expand1/login.jsp";
            	    }
            	    else {
            	    	framesrc = "expand1/index.jsp";
            	    }
            	    //// System.out.println("framesrc2:"+framesrc);
                %>
                <% if (!token.equalsIgnoreCase("")) { %>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <% out.print(username); %><i class="fa fa-user fa-fw" style="margin-left:5px"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <!--li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li-->
                        <li><a href="expand1/api/logoutUser.jsp"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <% } %>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <!--div class="navbar-default sidebar" role="navigation">
                
                
            </div-->
            <!-- /.navbar-static-side -->
        </nav>

        <div id="page-wrapper">
            <iframe src="<%out.print(framesrc); %>" frameborder="0" id="iframe_a" name="iframe_a" style="overflow: hidden; height: 88%; width: 100%; position: absolute;" ></iframe>
        </div>
        <!-- /#page-wrapper -->
        <div id="aboutModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">About Mata Analytics Dashboard</h4>
				</div>
				<div class="modal-body">
					<p>
						<table>
							<tr>
								<th>
									<img src="images/mata_analytics_150w.png">
								</th>
								<th style="padding-left:10px">
									<h5><b>Mata Analytics Dashboard v1.5</b><br/>
										Bahasa Indonesia Language Pack / BILP v1.0.0.14<br/>
										Banana v1.5.0
									</h5>
								</th>
							</tr>
						</table>
					</p>
					
					<p style="text-align: justify">
						Mata Analytics Admin Console is centralized user interface used for social media data and process management. Data collected will be nicely organized in collections, ensuring focus and accurate context for your analysis. 
					</p>
					
					<p style="text-align: justify">
						Mata Analytics Admin Console is part of Mata Analytics solution. Mata Analytics brings insights from unstructured information of social media and turns valuable information into actionable items. Powered by unique capability of natural language processing in Bahasa Indonesia, you can now use social media data in ways that were only previously attainable from your structured data.
					</p>
					
					<p style="text-align: justify">
						For more info please visit our website at <a href="http://www.mataprima.com/#max" target="_blank" style="color:#333"><i>http://www.mataprima.com/#max</i></a><br/>
						or send email to <a href="mailto:support@mataprima.com" style="color:#333"><i>support@mataprima.com</i></a>
					</p>
					
					<p style="text-align: justify">
						Copyright &copy; 2016 </br> PT. Mata Prima Universal.
					</p>
					
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

			</div>
		</div>
		<footer>
		<div style="display:block;position:fixed; width:100%; height:25px;bottom:0; background: #45484d; /* Old browsers */
background: -moz-linear-gradient(top,  #45484d 0%, #000000 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#45484d), color-stop(100%,#000000)); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(top,  #45484d 0%,#000000 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(top,  #45484d 0%,#000000 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(top,  #45484d 0%,#000000 100%); /* IE10+ */
background: linear-gradient(to bottom,  #45484d 0%,#000000 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#45484d', endColorstr='#000000',GradientType=0 ); /* IE6-9 */ border-top: 2px solid #286CD1; ">
		
			<a href="http://www.mataprima.com" style="margin:5px 5px 0 0; font-size:12px;float:right; color:#e5e5e5" target="_blank">Copyright &copy; 2016 PT. Mata Prima Universal</a>
		</div>
	</footer>
    </div>
    <!-- /#wrapper -->
</body>

</html>
