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
	<% String username = session.getAttribute("username").toString(); %>
	<% 
		String hostname = request.getServerName();
		String[][] tokens = new SecurityRequest(hostname).getTokens(username, token); 
	%>
<html>
<head>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script type="text/javascript" src="js/expand1.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/sb-admin-2.js"></script>
	
	<script>
		$(document).ready(function() {
		    var anchor = window.location.hash.replace("#", "");
		    colexpand(anchor);
		});
	</script>
	
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet" type="text/css" >
	<link href="css/sb-admin-2.css" rel="stylesheet">
	<link href="font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>	
	<div class="wrapper">
	<div class="page-wrapper">
		<div class="row_ed">
			<ul class="breadcrumb">
				<li><a href="index.jsp">Home</a></li>
				<li class="active">Security</li>
			</ul>
		</div>
		<div class="row_ed">
			<div class="col-lg-12">
				<h1 class="page-header">Security Fields</h1>
			</div>
		</div>
		<div class="row_ed">
			<div class="col-lg-12">
				<a href="create_token.jsp"><button type="button" class="btn btn-default">Create Token +</button></a>
				<% for (int i=0; i<tokens.length;i++) { %>
				<div id="<%out.print(tokens[i][2]); %>" class="container_ex">
					<div class="panel-heading" style="background-color:#e6e6e6;" >
						<table style="width:100%">
							<tr>
								<td style="width:99%">
									<div style="cursor:pointer" class="panel_ed-heading" onclick="colexpand('<%out.print(tokens[i][2]); %>')">
										<span id='alias<%out.print(i+1);%>'><%out.print(tokens[i][2]); %></span>
										<button class="btn btn-default" data-toggle="modal" data-target="#delconf<%out.print(i);%>" style="padding-top:0px; padding-bottom:0px; float:right; margin: 0 2px 0 2px;">Delete</button>
										<button class="btn btn-default" onclick="location.href='edit_token.jsp?alias=<%out.print(tokens[i][2]);%>'" style="padding-top:0px; padding-bottom:0px; float:right; margin: 0 2px 0 2px;">Edit</button>
									</div>
								</td>
							</tr>
						</table>
					</div>
				
					<div id="content_ed_<%out.print(tokens[i][2]); %>" class="content">
						<div class="panel-body">
							<table>
								<tr>
									<td>
										<div class="panel panel-default_ed" style="min-height:0px; height:inherit">
											<table>
												<tr>
													<td style="width:30%">Type :</td>
													<td style="width:70%; color:blue" id="type<%out.print(i+1);%>"><%out.print(tokens[i][0]);%></td>
												</tr>	
												<tr>
													<td style="width:30%">Token :</td>
													<td style="width:70%" id="token<%out.print(i+1);%>"><%out.print(tokens[i][1]);%></td>
												</tr>
												<tr>
													<td style="width:30%">App ID :</td>
													<td style="width:70%" id="keyid<%out.print(i+1);%>"><%out.print(tokens[i][3]);%></td>
												</tr>
												<tr>
													<td style="width:30%">App Secret :</td>
													<td style="width:70%" id="secret<%out.print(i+1);%>"><%out.print(tokens[i][4]);%></td>
												</tr>										
											</table>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<div class="modal fade" id="delconf<%out.print(i);%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                                    <button type="button" class="btn btn-primary" onclick="location.href='api/deleteAccessToken.jsp?alias=<%out.print(tokens[i][2]);%>'">Yes</button>
							  <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                                </div>
                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
              	</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
	</div>
</body>
</html>