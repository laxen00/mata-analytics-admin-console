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
<html lang="en">
<head>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript" src="js/securityapi.js"></script>
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
			    }else if (val == choice4) {
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

    <title>Create Token - MAX Administration Console</title>

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
					<li><a href="security_fields.jsp">Security</a></li>
					<li class="active">Create Token</li>
				</ul>
			</div>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Create Token</h1>
					<span>New Token can be added to be used for Facebook and Twitter crawling purpose.</span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-7">
                    <div class="panel-body">
						<form id="crawlerform" method='post' role="form" action="api/postAccessToken.jsp" style="margin-bottom:10px">
                            <div class="form-group">
								<span>* </span><label>Alias :</label><p class="help-block"> (Spaces and the characters a-z, A-Z, 0-9, underscore, and hyphen are allowed.)</p>
                                <input id='alias' name='alias' type="text" class="form-control" placeholder="Alias" style="margin-bottom:15px" required></input>
                                
								<span>* </span><label>Type :</label>
                                <select id='type' name='type' onchange="opttype(this)" class="form-control">
                                    <option value="facebook">facebook</option>
                                    <option value="twitter">twitter</option>
                                    <option value="twitter_bluemix">twitter (by IBM Bluemix®)</option>
                                    <option value="youtube">Youtube</option>
                                </select>
                            </div>
							<div id="change_ed">
							<div class="form-group">
                                <span>* </span><label>App ID :</label>
                                <input id='apiKey' name='apiKey' type="text" class="form-control" placeholder="App ID are not allowed spaces character" required></input>
                            </div>
							
							<div class="form-group">
                                <span>* </span><label>App Secret :</label>
                                <input id='secretKey' name='secretKey' type="text" class="form-control" placeholder="App Secret are not allowed spaces character" required></input>
								
							</div>
							</div>
							<div id="generate" class="form-group">
								<label>Token :</label>
								<textarea id='accessToken' name='accessToken' class="form-control" readonly></textarea>
							</div>
							
							<div>
								<button type='button' id="generateButton" onclick='generateToken();' class="btn btn-default">Generate</button>
								<button id="finishButton" type="submit" class="btn btn-default disabled" title="Ok">Ok</button>
                            	<button type="reset" class="btn btn-default" title="Cancel" onclick="location.href='security_fields.jsp';">Cancel</button>
                        	</div>
                        </form>
						<!-- <div class="modal fade" id="existconf" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	                          <div class="modal-dialog">
	                              <div class="modal-content">
	                                  <div class="modal-header">
	                                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                                      <h4 class="modal-title" id="myModalLabel">Duplicate Token</h4>
	                                  </div>
	                                  <div class="modal-body">
										Token already exists.
									  </div>
	                                  <div class="modal-footer">
	                                      <button type="button" class="close" data-dismiss="modal">Ok</button>
	                                  </div>
	                              </div>
	                              /.modal-content
	                          </div>
	                          /.modal-dialog
		               	</div> -->
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
