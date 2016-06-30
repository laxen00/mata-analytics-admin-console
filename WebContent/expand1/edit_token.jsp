<%@ page import="apiRequest.*" %>
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
	
	String colId = "";
	try {
		colId = session.getAttribute("colId").toString();
	}
	catch(Exception e) {
		colId = request.getParameter("colId");
		session.setAttribute("colId", colId);
	}
	
	String username = session.getAttribute("username").toString();
	
	String hostname = request.getServerName();
	String[][] appTokens = new SecurityRequest(hostname).getTokens(username, token); 
	
	String alias = request.getParameter("alias");
	String type = "";
	String accessToken = "";
	String apiKey = "";
	String secretKey = "";
	
	int count = 0;
	for(String[] appToken : appTokens){
		if(appToken[2].equals(alias)){
			break;
		}
		count++;
	}
	
	type = appTokens[count][0];
	accessToken = appTokens[count][1].trim();
	apiKey = appTokens[count][3];;
	secretKey = appTokens[count][4];
%>
<html lang="en">
<head>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script type="text/javascript" src="js/securityapi.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/bootstrap.js"></script>
    <script src="js/sb-admin-2.js"></script>
	
	<script>
		function opttype(rad) {
			var val = rad.value;
			var choice1 = "facebook";
			var choice2 = "twitter";
			var choice3 = "twitter_bluemix";
			var choice4 = "youtube";
	
			if (val == choice1) {
				document.getElementById('change_ed').innerHTML = 
				'<div class="form-group">' + 
					'<span>* </span>' + 
					'<label>App ID :</label>' +
					'<input id="apiKey" name="apiKey" type="text" class="form-control" placeholder="App ID are not allowed spaces character" required></input>' + 
				'</div>' + 
				'<div class="form-group">' + 
					'<span>* </span>' + 
					'<label>App Secret :</label>' +
					'<input id="secretKey" name="secretKey" type="text" class="form-control" placeholder="App Secret are not allowed spaces character" required></input>' +
				'</div>';
	     	} else if (val == choice2) {
				document.getElementById('change_ed').innerHTML = 
					'<div class="form-group">' +
					'<span>* </span>' +
					'<label>Consumer Key (API Key) :</label>'+
					'<input id="apiKey" name="apiKey" type="text" class="form-control" placeholder="API Key are not allowed spaces character" required></input>' +
				'</div>' +
				'<div class="form-group">'+
					'<span>* </span>' +
					'<label>Consumer Secret (API Secret) :</label>' +
					'<input id="secretKey" name="secretKey" type="text" class="form-control" placeholder="API Secret are not allowed spaces character" required></input>'+
				'</div>';
	       	} else if (val == choice3) {
				document.getElementById('change_ed').innerHTML = 
					'<div class="form-group">' +
							'<span>* </span>' +
							'<label>Consumer Key (API Key) :</label>'+
							'<input id="apiKey" name="apiKey" type="text" class="form-control" placeholder="API Key are not allowed spaces character" required></input>' +
						'</div>' +
						'<div class="form-group">'+
							'<span>* </span>' +
							'<label>Consumer Secret (API Secret) :</label>' +
							'<input id="secretKey" name="secretKey" type="text" class="form-control" placeholder="API Secret are not allowed spaces character" required></input>'+
						'</div>';
	       	} else if (val == choice4) {
				document.getElementById('change_ed').innerHTML = 
					'<div class="form-group">' +
							'<label>Google API Token :</label>'+
							'<input id="apiKey" name="apiKey" type="text" class="form-control" placeholder="API Key are not allowed spaces character" required></input>' +
							'<input id="secretKey" name="secretKey" type="text" class="form-control" placeholder="API Secret are not allowed spaces character" style="display:none"></input>'+
						'</div>';
	       	}
		}
	</script>
    
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

    <title>Edit Token - MAX Administration Console</title>

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
			  		<li><a href="security_fields.jsp#<% out.print(alias); %>">Security</a></li>
					<li class="active">Edit Token - <% out.print(alias); %></li>
				</ul>
			</div>
            <div class="row maxhead">
                <div class="col-lg-12">
                    <h1 class="page-header">Edit Token</h1>
					<span>Token details can be edited to be used for Facebook and Twitter crawling purpose.</span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-7">
				
                    <div class="panel-body">
						<form id="crawlerform" method='post' role="form" action="api/editAccessToken.jsp" style="margin-bottom:10px">
                            <input type="hidden" name="type" id="type" value="<% out.print(type); %>" />
                            <div class="form-group">
								<span>* </span><label>Alias :</label><p class="help-block"> (Spaces and the characters a-z, A-Z, 0-9, underscore, and hyphen are allowed.)</p>
                                <input id='alias' name='alias' type="text" class="form-control" placeholder="Alias" style="margin-bottom:15px" value="<% out.print(alias); %>" required readonly></input>
                                
								<span>* </span><label>Type :</label>
								<input id='type' name='type' type="text" class="form-control" value="<% out.print(type); %>" required readonly></input>
                            </div>
							<div id="change_ed">
								<div class="form-group">
								<%
									String fieldName = "";
									if (type.equalsIgnoreCase("youtube")) fieldName = "Google API Token";
									else fieldName = "App ID";
								%>
	                                <span>* </span><label><% out.print(fieldName); %> :</label>
	                                <input id='apiKey' name='apiKey' type="text" class="form-control" placeholder="App ID are not allowed spaces character" value="<% out.print(apiKey); %>" required></input>
	                            </div>
								<%
									String displayNone = "";
									if (type.equalsIgnoreCase("youtube")) displayNone = "style='display:none;'";
									else displayNone = "";
								%>
								<div class="form-group" <% out.print(displayNone); %>>
	                                <span>* </span><label>App Secret :</label>
	                                <input id='secretKey' name='secretKey' type="text" class="form-control" placeholder="App Secret are not allowed spaces character" value="<% out.print(secretKey); %>" required></input>
									
								</div>
							</div>
							<div class="form-group" id="generate">
								<label>Token :</label>
								<textarea id='accessToken' name='accessToken' class="form-control" readonly><% out.print(accessToken); %></textarea>
							</div>
							<div>
								<button type='button' id="generateButton" onclick='generateToken();' class="btn btn-default">Generate</button>
								<button id="finishButton" type="submit" class="btn btn-default disabled" title="Ok">Ok</button>
                            	<button type="reset" class="btn btn-default" title="Cancel" onclick="location.href='security_fields.jsp';">Cancel</button>
                        	</div>
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
