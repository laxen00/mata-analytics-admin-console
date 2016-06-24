<%@ page import ="
	mata.common.util.*,
	java.util.*,
	apiRequest.*
	"
%>

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
	String colId = "";
	
	try {
		colId = session.getAttribute("colId").toString();
	}
	catch(Exception e) {
		colId = request.getParameter("colId");
		session.setAttribute("colId", colId);
	}
	
	// System.out.println("colId:"+colId);
	
	FileManager fm = new FileManager();
	
	String hostname = request.getServerName();
	String colLocation = new CollectionRequest(hostname).getLocationCollection(colId, token);
	ArrayList<String> pearNames = fm.listSpesificFile(colLocation, "pear");
	if (pearNames.size() != 0) {
		for (int i=0;i<pearNames.size();i++) {
			pearNames.set(i, pearNames.get(i).replaceAll(".pear",""));
		}
	}
	
	String[] currentPear = new PearRequest(hostname).currentPear(colId, token);
	String currentPearString = "";
	if (currentPear[1].equalsIgnoreCase("0")) {
		if(currentPear[0].contains(":")){
			String[] currentPearParts = currentPear[0].split(":");
			currentPearString = currentPearParts[0].trim() + " (" + currentPearParts[1].trim() + ")"; 
		}
	}
	
	String[] collectionStatus = new CollectionRequest(hostname).getCollectionStatus(colId, token);
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
    <script src="js/apirequest.js"></script>
    <script src="js/refresh.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			refreshPear(<% out.print("'"+colId+"'"); %>,'');
			refreshCollectionStatus('', <% out.print("'"+colId+"'"); %>);
			
			<% if(collectionStatus[0].equals("installingpear")){ %>
					<% currentPearString = "please wait.."; %>
					document.getElementById('installButton').className = "btn_ed btn btn-default disabled";
					document.getElementById('uninstallButton').className = "btn_ed btn btn-default disabled";
					document.getElementById('pearStatus').innerHTML = 'please wait..';
			<% } %>
		});
	</script>
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

    <title>Annotator - MAX Administration Console</title>

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
	<style>
	.fileUpload {
		position: relative;
		overflow: hidden;
		margin: 5px;
		padding: 5px;
	}
	.fileUpload input.upload {
		position: absolute;
		top: 0;
		right: 0;
		margin: 0;
		padding: 0;
		font-size: 20px;
		cursor: pointer;
		opacity: 0;
		filter: alpha(opacity=0);
	}
	</style>
</head>

<body>
    <div id="wrapper">
        <div id="page-wrapper">
        	<div class="row">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
					<li class="active">Annotator</li>
				</ul>
			</div>
            <div class="row maxhead">
                <div class="col-lg-12">
                    <h1 class="page-header">PEAR Upload</h1>
					<span>Upload your PEAR here</span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-3">
				
                    <div class="panel-body">
						<form id="editcrawlerform" size="50" role="form" method="post" action="upload/uploadPear.jsp" enctype="multipart/form-data">
                            
							<div class="form-group">
                                <p class="help-block"> Select your PEAR file (*.pear)</p>
                                
                                
								<div class="fileUpload btn btn-primary">
									<span>Browse</span>
									<input id="uploadBtn" class="upload" type="file" name="file" size="50" />
								</div>
								<input id="uploadFile" placeholder="Choose File" disabled required/>
								<script>
									document.getElementById("uploadBtn").onchange = function () {
										var fileParts = this.value.split("\\");
										document.getElementById("uploadFile").value = fileParts[fileParts.length - 1];
										if(document.getElementById("uploadFile").value.endsWith(".pear")){
											document.getElementById("submitButton").disabled = false;
										}else{
											document.getElementById("submitButton").disabled = true;
										}
									};
								</script>
                            </div>
							<button id="submitButton" type="submit" class="btn btn-default" title="Save" disabled>Upload</button>
                            <button type="reset" class="btn btn-default" title="Cancel" onclick="location.href='index.jsp#<% out.print(colId); %>'">Back</button>
                        </form>
						
                    </div>
                    <!-- /.panel -->
                </div>
				<div class="col-lg-4">
					<form action="api/installPear.jsp" method="post">
						<div class="form-group">
                        	<p class="help-block"> Available PEAR</p>
                            <div class="col-xs-12" style="margin:0px;padding:0px">
								<table style="width:100%">
									<tr>
										<td rowspan="3" style="width:45% !important">
											<select id="pearname" multiple class="form-control" name="pearname" required>
												<% if (pearNames.size() != 0) { %> 
													<% for (String pear : pearNames) { %>
					                                             <option value="<%out.print(pear);%>"><%out.print(pear);%></option>
				                                         <% } %>
				                                <% } %>
			                                </select>
										</td>
										<td style="width:5% !important">
											<button id="installButton" type="submit" class="btn_ed btn btn-default" onclick="" title="install" style="margin:5px" <%if(pearNames.size() != 0) out.print(""); else out.print("disabled");%>>Install
											</button>
										</td>
									</tr>
									<tr>
										<td colspan="4"></td>
									</tr>
								</table>
							</div>
	                  	</div>
	                  	<div>Current PEAR: </div>
                 	</form>
                 	<form action="api/uninstallPear.jsp" method="post">
                 		<div class="form-group">
							<p class="help-block" id="pearStatus"><% out.print(currentPearString); %></p>
							<table style="width:100%">
									<tbody><tr>
										<td>
											<div id="progress-bar-ed-info" class="progress no-margin progress-striped active" style="width:80%">
												<div id="progress-bar-ed" class=" bar_ed progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width:0%">
													<span class="sr-only">0% Complete</span>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
                 		<button id="uninstallButton" class="btn btn-default" onclick="" title="uninstall" <%if(pearNames.size() != 0) out.print(""); else out.print("disabled");%>>Uninstall</button>
                 	</form>
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
