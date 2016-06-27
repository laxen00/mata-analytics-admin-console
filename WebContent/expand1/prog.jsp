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
	$(function() {	
		var progressBar = $('#progress-bar-ed'),
			width = 0;

		progressBar.width(width);

		var interval = setInterval(function() {

			width += 10;

			progressBar.css('width', width + '%');

			if (width >= 100) {
				clearInterval(interval);
			}
		}, 1000);
	});
	</script>
</head>
<body>	
	<div class="panel panel-default_ed">
	<div class="progress progress-striped active no-margin">
											<div id="progress-bar-ed" class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" >
												<span class="sr-only">0% Complete</span>
											</div>
	</div>
	</div>
</body>
</html>