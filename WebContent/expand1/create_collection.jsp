<!DOCTYPE html>
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
%>
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

    <title>Create Collection - MAX Administration Console</title>

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
			  		<li><a href="index.jsp">Collections</a></li>
			  		<li class="active">Create Collection</li>
				</ul>
			</div>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Create Collection</h1>
					<span>A collection contains the content that you want to query. After you click OK, you return to the Collections view.</span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-7">
				
                    <div class="panel-body">
						<form role="form" action='api/createCollection.jsp' method='post'>
                            <div class="form-group">
                                <span>* </span><label>Collection Name</label>
                                <input name ='colId' id='colId' type="text" class="form-control" placeholder="Collection Name" required pattern="[A-Za-z0-9]*">
                            </div>
							<div class="form-group">
                                <span>* </span><label>Description</label>
                                <textarea name='colDesc' id='colDesc' type="text" class="form-control" placeholder="write the description here..." ></textarea>
                            </div>
							
							<button type="submit" class="btn btn-default" title="ok">OK</button>
                            <button type="reset" class="btn btn-default" title="cancel" onclick="location.href='index.jsp'">Cancel</button>
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
