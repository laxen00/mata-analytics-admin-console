<jsp:include page="etc/header.jsp"/>
<%@ page import="apiRequest.*" %>
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
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta http-equiv="Cache-control" content="private">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

    <title>Field Map - MAX Administration Console</title>
	
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript" src="_lib/jquery.js"></script>
	<script type="text/javascript" src="_lib/jquery.cookie.js"></script>
	<script type="text/javascript" src="_lib/jquery.hotkeys.js"></script>
	<script type="text/javascript" src="jquery.jstree.js"></script>
	
	<script type="text/javascript" src="_docs/syntax/!script.js"></script>
	<script type="text/javascript" class="source below">
		$(function() {
			$("#demo3").jstree({
				// the `plugins` array allows you to configure the active plugins on this instance
				"plugins" : ["themes","html_data","ui","crrm","hotkeys"],
				// each plugin you have included can have its own config object
				"core" : {
					"animation" : 100,
					"initially_open" : [ "phtml_1" ]
				},
				// set a theme
				"themes" : {
		            "theme" : "classic",
		            "icons" : false
		        },
			});
		});
		
		function submitForm(action)
	    {
	        document.getElementById('mapForm').action = action;
	        document.getElementById('mapForm').target = "iframe_a";
	        document.getElementById('mapForm').submit();
	    }
		
		function selectFeature(featurename, annoname) {
			document.getElementById('featurename').value = featurename;
			document.getElementById('annoname').value = annoname;
			toggleAddMap();
		}
		
		function removeAnnoFeature() {
			document.getElementById('featurename').value = '';
			document.getElementById('annoname').value = '';
			toggleAddMap();
		}
		
		function toggleAddMap() {
			var currentAnnoValue = document.getElementById('annoname').value;
			var currentFeatureValue = document.getElementById('featurename').value;
			var currentFieldValue = document.getElementById('fieldname').value;
			if (currentFieldValue == '' || currentFeatureValue == '' || currentAnnoValue == '') {
				document.getElementById('addmapbutton').disabled = true;
			}
			else {
				document.getElementById('addmapbutton').disabled = false;
			}
			
		}
		
		$(document).ready(function() {
	        $('#dataTables-example').dataTable();
	    });
	</script>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="css/plugins/dataTables.bootstrap.css" rel="stylesheet">

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
        <form name="mapForm" id="mapForm" action="api/addMap.jsp" method="post">
		<input type="hidden" name="featurename" id="featurename" value="" />
		<input type="hidden" name="annoname" id="annoname" value="" />
        <div id="page-wrapper">
        	<div class="row">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
					<li class="active">Field Map</li>
				</ul>
			</div>
            <div class="row maxhead">
                <div class="col-lg-12">
                    <h1 class="page-header">Field Map</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
				<div class="panel-body">
					<div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								<b>Feature Name</b>
							</div>
							<!-- /.panel-heading -->
							<% 
							String hostname = request.getServerName();
							String[][] anno = new FieldRequest(hostname).getAnnotator(colId, token); %>
								<div class="panel-body" style="padding:15px">
								<div id="demo3" class="demo" style="height:200px; overflow:auto">
									<ul>
									<% if (anno != null) { %>
										<% for (int i=0;i<anno.length;i++) { %>
										<li id="phtml_1">
											<a href="#" onclick="removeAnnoFeature();"><% out.print(anno[i][0]); %></a>
											<ul>
												<% for (int j=1;j<anno[i].length;j++) { %>
												<li value="<% out.print(anno[i][j]); %>" id="phtml_2">
													<a href="#" onclick="selectFeature('<%out.print(anno[i][j]);%>','<%out.print(anno[i][0]);%>')"><% out.print(anno[i][j]); %></a>
												</li>
												<% } %>
											</ul>
										</li>
										<% } %>
										<% } %>
									</ul>
								</div>
								<script type="text/javascript" class="source below">
											$(function() {
												$("#demo3").jstree({
													// the `plugins` array allows you to configure the active plugins on this instance
												"plugins" : ["themes","html_data","ui","crrm","hotkeys"],
												// each plugin you have included can have its own config object
												"core" : {
													"animation" : 100,
													
												},
												// set a theme
												"themes" : {
													"theme" : "proton",
													"icons" : false
												},
											})
										});
							</script>

								
							</div>
							<!-- /.panel-body -->
						</div>
						<!-- /.panel -->
					</div>
					<!-- /.col-lg-4 -->
					<!--div class="col-lg-1">
						<img src="images/blackt2.png">
					</div-->
					<div class="col-lg-2">
						<div class="panel panel-default">
							<div class="panel-heading">
								<b>Field Name</b>
							</div>
							<!-- /.panel-heading -->
							<div class="panel-body" style="padding:15px">
							<div class="col-xs-12" style="margin:0px;padding:0px">
								<select id="fieldname" onchange="toggleAddMap()" size="10" class="form-control1" name="fieldname" style="height:200px">
								<% String[][] fields = new FieldRequest(hostname).getField(colId, token); %>
								<% for (String[] field : fields) { %>
									<option style="margin-bottom:5px" value="<%out.print(field[0]);%>"><% out.print(field[0]); %></option>
								<% } %>
								</select>
							</div>

								
							</div>
							<!-- /.panel-body -->
						</div>
						<!-- /.panel -->
					</div>
					<!-- /.col-lg-4 -->
					<!--div class="col-lg-1">
						<img src="images/blackt2.png">
					</div-->
					<!--div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								Facet
							</div>
							<!-- /.panel-heading -->
							<!--div class="panel-body">
							<div id="demo3" class="demo" style="height:200px; overflow:auto">
								<ul>
									<li id="phtml_1">
										<a href="#">Root node 1</a>
										<ul>
											<li id="phtml_2">
												<a href="#">Child node 1</a>
												<ul>
													<li id="phtml_8">
														<a href="#">Grand Child node 1</a>
													</li>
												</ul>
											</li>
											<li id="phtml_3">
												<a href="#">Child node 2</a>
											</li>
											<li id="phtml_4">
												<a href="#">Child node 3</a>
											</li>
										</ul>
									</li>
									<li id="phtml_5">
										<a href="#">Root node 2</a>
										<ul>
											<li id="phtml_9">
												<a href="#">Child node 4</a>
											</li>
										</ul>
									</li>
									<li id="phtml_6">
										<a href="#">Root node 2</a>
									</li>
									<li id="phtml_7">
										<a href="#">Root node 2</a>
									</li>
								</ul>
							</div>
							<script type="text/javascript" class="source below">
										$(function() {
											$("#demo3").jstree({
												// the `plugins` array allows you to configure the active plugins on this instance
												"plugins" : ["themes","html_data","ui","crrm","hotkeys"],
												// each plugin you have included can have its own config object
												"core" : {
													"animation" : 100,
													"initially_open" : [ "phtml_1" ]
												},
												// set a theme
												"themes" : {
													"theme" : "proton",
													"icons" : false
												},
											})
										});
							</script>
					
								
							</div>
							<!-- /.panel-body -->
					
						
					
						
					
					<div class="col-lg-6">
						<div class="panel panel-default" >
                            <div class="panel-heading" style="padding-left:5px;">
								<div class="row">
									<div class="col-lg-4" style="">
									<b>Feature Name</b>
									</div>
									<div class="col-lg-4" style="margin-left:-10px">
									<b>Field Name</b>
									</div>
									<div class="col-lg-4"style="margin-left:-10px">
									<b>Action</b>
									</div>
								</div>
							</div>
							<div class="table-responsive" style="height:230px; overflow:auto; padding:0px 10px 0px 10px ">
                                <table style="width:100%" class="table table-striped table-hover" id="dataTables-example">
                                    <!--thead>
                                        <tr>
                                            <th>Annotators</th>
                                            <th>Fields</th>
                                            
											<th>Action</th>
                                        </tr>
                                    </thead-->
                                    <tbody>
                                    	<% String[][] mapping = new FieldRequest(hostname).getFieldFeature(colId, token); %>
                                    	<% if (mapping != null) { %>
	                                    	<% int count = 1; %>
	                                    	<% String classname = ""; %>
	                                    	<% for (String[] map : mapping) { %>
	                                    	<%
	                                    		if (count%2 != 0) classname = "odd gradeX";
	                                    		else classname = "even gradeC";
	                                    	%>
	                                        <tr class="<%out.print(classname);%>">
	                                            <td><% out.print(map[0]); %></td>
	                                            <td><%out.print(map[1]);%></td>
	                                            
	
												<td><span style="cursor:pointer" onclick="location.href='api/deleteMap.jsp?featurename=<%out.print(map[0]);%>&fieldname=<%out.print(map[1]);%>'"><button type="button"  class="btn btn-danger btn-xs" title="">Delete</button></span></td>
	                                           
	                                        </tr>
	                                        <% count++; %>
	                                        <% } %>
											<% } %>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
							</div>
                    </div>
				</div>
						<!-- /.panel -->
					</div>
					<!-- /.col-lg-4 -->
					
					        <button type="submit" id="addmapbutton" onclick="submitForm('api/addMap.jsp')" class="btn btn-default" disabled>Add Map</button>
                            <button type="reset" onclick="location.href='index.jsp#<% out.print(colId); %>'" class="btn btn-default">Back</button>
                            
                            
                    
				</div>
				</form>
			</div>
            <!-- /.row -->
            
            <!-- /.row -->
<!--         </div> -->
        <!-- /#page-wrapper -->

<!--     </div> -->
    <!-- /#wrapper -->
	<!--div class="modal fade" id="delconf" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
								<form role="form">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Add New Field</h4>
                                        </div>
                                        <div class="modal-body">
										<div class="row">
										<div class="col-lg-12">
										
											
											<div class="form-group">
                                            
                                            <input class="form-control control-t5" placeholder="Name">
											
											<select name="type" class="form-control control-t5" placeholder="Type">
											<option value="" disabled selected style="display:none;">Type</option>
											<option value="text_general">text_general</option>
											<option value="int">int</option>
											<option value="date">date</option>
											<option value="string">string</option>
											<option value="long">long</option>
											<option value="float">float</option>
											<option value="double">double</option>
                                    		</select>
											<select name="multivalue" class="form-control control-t5" placeholder="Type">
											<option value="" disabled selected style="display:none;">Multivalue</option>
											<option value="true">True</option>
											<option value="false">False</option>
											
                                    		</select>
											</div>
											
										
										</div>
										</div>
										</div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary">Add</button>
											<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                            
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
<!--                                 </form> -->
<!-- 								</div> -->
                                <!-- /.modal-dialog -->
<!--     </div> -->
    <!-- jQuery Version 1.11.0 -->
    <!--script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <!--script src="js/bootstrap.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <!--script src="js/plugins/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <!--script src="js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>

    <!-- Custom Theme JavaScript -->
    <!--script src="js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
</body>

</html>
