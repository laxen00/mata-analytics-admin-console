<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="Cache-control" content="private">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

    <title>Mata Analytics Administration Console</title>
	
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/sb-admin-2.js"></script>
    <script>
		function InvalidMsg(textbox) {
		    if (textbox.value == '') {
		        textbox.setCustomValidity('Required Username');
		    }else {
		        textbox.setCustomValidity('');
		    }
		    return true;
		}
	</script>
	<script>
		function InvalidMsg1(textbox) {
			if (textbox.value == '') {
				textbox.setCustomValidity('Required Password');
			}else {
				textbox.setCustomValidity('');
			}
			return true;
		}
	</script>
	<style>
		.logologin {
				margin-top:5%;
			}
		@media screen and (max-width: 990px) {
			.logologin {
				margin-top:-5%;
			}
		}
	</style>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">

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

<body style="background: url(images/silver-light-blue.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;">
	<!-- new  -->
		<div class="container">
        <div class="row">
		<div class="col-lg-8 col-xs-10 col-xs-offset-1 col-lg-offset-2 fade-in one" style="background: rgba(100,100,100,0.05); box-shadow: 2px 2px 10px #333333; margin-top:12%; padding:50px 0 50px 0">
            <div class="row">
			<div class="col-md-4 col-md-offset-1 logologin">
			<img src="images/mata_analytics_816w.png" width="350px" style="margin:0px 30px 0 -35px">
			</div>
			<div class="col-md-4 col-md-offset-2 ">
				<!--img src="../images/toyotalogo.png" width="360px"-->
               
                  
                    <div class="panel-body">
                        <form role="form" method="post" action="api/loginUser.jsp">
                            <fieldset>
								<%
                                	String message = "";
                                	try {
                                		message = session.getAttribute("message").toString();
                                	}
                                	catch (Exception e) {
                                		message = "";
                                	}
                                	if (!message.equalsIgnoreCase("")) {
                                %>
									<span style="color:#F00;"><% out.print(message); %></span>
                                <%
                                	session.removeAttribute("message");
                                	}
                                	
                  				%>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Username" name="username" type="username" autofocus oninvalid="InvalidMsg(this);" oninput="InvalidMsg(this);" required="required" >
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="password" type="password" value="" oninvalid="InvalidMsg1(this);" oninput="InvalidMsg1(this);" required="required">
                                </div>
								<div class="row">
								<div class="col-md-4"><button type="submit" class="btn btn-default" value="Login">Login</button></div>
                                
								</div>
								<div class="row" style="margin-top:5%; margin-bottom:-5%">
									<div class="col-md-12">
										<span style="">Don't have account yet? Register <a href="http://mataprima.com/#ask-page" target="_blank" style="font-weight:bold; color: #2f2f2f">here</a><br>Or try the <a href="http://max.mataprima.com/analytics/?sessionId=37m23um98gv8d1hgm18wn5pmol" target="_blank" style="font-weight:bold; color: #2f2f2f">demo</a></span>
									</div>
								</div>
                                <!-- Change this to a button or input when using this as a form -->
                                
                            </fieldset>
                        </form>
                    </div>
                
            </div>
			
			</div>
		
			</div>
        </div>
    </div>
	<!-- new end  -->
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
						Mata Analytics Dashboard is powered by dynamic and customizable dashboard. Dashboard consists of individual drag-and-drop panel which automatically refresh when filter is applied to the dashboard. 
					</p>
					
					<p style="text-align: justify">
						Mata Analytics Dashboard is part of Mata Analytics solution. Mata Analytics brings insights from unstructured information of social media and turns valuable information into actionable items. Powered by unique capability of natural language processing in Bahasa Indonesia, you can now use social media data in ways that were only previously attainable from your structured data.
					</p>
					
					<p style="text-align: justify">
						For more info please visit our website at <a href="http://www.mataprima.com/#max" target="_blank" style="color:#333"><i>http://www.mataprima.com/#max</i></a><br/>
						or send email to <a href="mailto:support@mataprima.com" style="color:#333"><i>support@mataprima.com</i></a>
					</p>
					
					<p style="text-align: justify">
						Copyright &copy; 2016 PT. Mata Prima Universal.
					</p>
					
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

			</div>
		</div>
    <!-- jQuery Version 1.11.0 -->
<!--     <script src="js/jquery-1.11.0.js"></script> -->
    

    <!-- Metis Menu Plugin JavaScript -->
<!--     <script src="js/plugins/metisMenu/metisMenu.min.js"></script> -->

</body>

</html>
