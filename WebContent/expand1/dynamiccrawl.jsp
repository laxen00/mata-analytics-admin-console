<%@ page import="apiRequest.*" %>
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
	catch(Exception e) {
		colId = request.getParameter("colId");
		session.setAttribute("colId", colId);
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/sb-admin-2.js"></script>
    
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

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
			<div class="row">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
			  		<li><a href="create_crawler.jsp">Create Crawler</a></li>
					<li class="active">Create Metadata for Crawler</li>
				</ul>
			</div>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Create Metadata for Crawler</h1>
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
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <form role="form">
                                        <div class="form-group">
                                            <label>Header</label>
                                            <input class="form-control" placeholder="Header Path">
                                        </div>
										<div class="form-group">
                                            <label>User Name / Author</label>
                                            <input type="text" class="form-control" placeholder="User Name / Author Path">
                                        </div>
										<div class="form-group">
                                            <label>Content</label>
                                            <input class="form-control" placeholder="Content Path">
                                        </div>
										<div class="form-group">
                                            <label style="display:block;">Date</label>
                                            <input class="form-control control-t1" placeholder="Date Path">
											<input class="form-control control-t2" placeholder="Date Format ex. DD MM YYYY HH:MM">
                                        </div>
										
                                        
                                        <button type="submit" class="btn btn-default" title="Run Testing"><img src="images/run.png" width="15px" height="17px"></button>
                                        <button type="reset" class="btn btn-default" title="Save and Compile">Submit</button>
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
                        <div class="panel-body_ed">
							<div class="col-lg-12">
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							asd </br>
							</div>
						</div>
					</div>
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
