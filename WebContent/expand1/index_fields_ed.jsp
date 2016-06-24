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
	if (token.isEmpty()) {
		%>
	<script>window.top.location.href="../index.jsp";</script>
		<%
	}
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
    <meta name="author" content="PT. Mata Prima Universal">
	
	<title>Index Fields - MAX Administration Console</title>

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
<%
	String hostname = request.getServerName();
	String[] currentPear = new PearRequest(hostname).currentPear(colId, token);
%>
<body>
    <div id="wrapper">
        <div id="page-wrapper">
			<div class="row">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
					<li class="active">Index Fields</li>
				</ul>
			</div>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Index Fields</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <%
            //	if (currentPear[0].contains("No Pear Installed")) out.print(currentPear[0]);
    		%>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Data Index Fields
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body_dynamic">
                            <div class="table-responsive" style="margin-bottom:20px">
                                <table style="width:70%" class="table table-striped table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Type</th>
                                            <th>Multivalue</th>
											<th colspan="2">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                 //   if (!currentPear[0].contains("No Pear Installed")) {
                                    	String[][] fields = new FieldRequest(hostname).getField(colId, token);
                                    	int counter = 1;
                                    	String counterClass = "";
                                    	for (String[] field : fields) {
                                    		if (counter % 2 == 0) {
                                    			counterClass = "even gradeC";
                                    		}
                                    		else {
                                    			counterClass = "odd gradeX";
                                    		}
                                    %>
                                        <tr class="<%out.print(counterClass);%>">
                                            <td><%out.print(field[0]); %></td>
                                            <td><%out.print(field[1]); %></td>
                                            <td><%out.print(field[2]); %></td>
                                            
											<td><button type="button" class="btn btn-default" title="Run Testing" data-toggle="modal" data-target="#editconf<%out.print(counter);%>">Edit</button></td>
											<td><button type="button" class="btn btn-default" title="Run Testing" data-toggle="modal" data-target="#deleteconf<%out.print(counter);%>">Delete</button></td>
                                            
                                        </tr>
										<div class="modal fade" id="editconf<%out.print(counter); %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
																	<div class="modal-dialog">
																	<form role="form" action="api/editField.jsp">
																		<div class="modal-content">
																			<div class="modal-header">
																				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
																				<h4 class="modal-title" id="myModalLabel">Edit Field</h4>
																			</div>
																			<div class="modal-body">
																			<div class="row">
																			<div class="col-lg-12">
																			
																				
																				<div class="form-group">
																				<input type="hidden" name="fieldname" value="<%out.print(field[0]); %>"/>
																				<input class="form-control control-t5" placeholder="Name" name="newname" value="<%out.print(field[0]);%>">
																				
																				<select name="type" class="form-control control-t5" placeholder="Type">
																				<option value="" disabled selected style="display:none;">Type</option>
																				<option <%if (field[1].equalsIgnoreCase("text_general")) out.print("selected=\"selected\""); %> value="text_general">text_general</option>
																				<option <%if (field[1].equalsIgnoreCase("int")) out.print("selected=\"selected\""); %> value="int">int</option>
																				<option <%if (field[1].equalsIgnoreCase("date")) out.print("selected=\"selected\""); %> value="date">date</option>
																				<option <%if (field[1].equalsIgnoreCase("string")) out.print("selected=\"selected\""); %> value="string">string</option>
																				<option <%if (field[1].equalsIgnoreCase("long")) out.print("selected=\"selected\""); %> value="long">long</option>
																				<option <%if (field[1].equalsIgnoreCase("float")) out.print("selected=\"selected\""); %> value="float">float</option>
																				<option <%if (field[1].equalsIgnoreCase("double")) out.print("selected=\"selected\""); %> value="double">double</option>
																				</select>
																				<select name="multivalue" class="form-control control-t5" placeholder="Type">
																				<option value="" disabled selected style="display:none;">Multivalue</option>
																				<option <%if (field[2].equalsIgnoreCase("true")) out.print("selected=\"selected\""); %> value="true">True</option>
																				<option <%if (field[2].equalsIgnoreCase("false")) out.print("selected=\"selected\""); %> value="false">False</option>
																				
																				</select>
																				</div>
																				
																			
																			</div>
																			</div>
																			</div>
																			<div class="modal-footer">
																				<button type="submit" class="btn btn-primary">Save</button>
																				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
																				
																			</div>
																		</div>
																		<!-- /.modal-content -->
																	</form>
																	</div>
																	<!-- /.modal-dialog -->
										</div>
										<div class="modal fade" id="deleteconf<%out.print(counter); %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
																		<button type="button" onclick="location.href='api/deleteField.jsp?fieldname=<% out.print(field[0]); %>'" class="btn btn-primary">Yes</button>
																		<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
																		
																	</div>
															</div>
																	<!-- /.modal-content -->
														</div>
															<!-- /.modal-dialog -->
										</div>
                                   <%
                                   		counter++;
                                    	}
                              //      }
                                   %>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                            <%
                         //           if (!currentPear[0].contains("No Pear Installed")) {
                                    	
                            %>
                            <button type="button" class="btn btn-default" title="Run Testing"  data-toggle="modal" data-target="#delconf">Add Custom field</button>
                            <button type="submit" class="btn btn-default" onclick="location.href='index.jsp'" title="Run Testing">Back</button>
<!--                             <button type="reset" class="btn btn-default" title="Save and Compile">Cancel</button> -->
                            <%
                       //     	} 
                            %>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
	<%
	 //       if (!currentPear[0].contains("No Pear Installed")) {
	        	
	%>
	<div class="modal fade" id="delconf" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
								<form role="form" action="api/addField.jsp">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Add New Field</h4>
                                        </div>
                                        <div class="modal-body">
										<div class="row">
										<div class="col-lg-12">
										
											
											<div class="form-group">
                                            
                                            <input class="form-control control-t5" placeholder="Name" name="fieldname">
											
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
                                            <button type="submit" class="btn btn-primary">Add</button>
											<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                            
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </form>
								</div>
                                <!-- /.modal-dialog -->
    </div>
	<%
	      //  }
	%>
    <!-- jQuery Version 1.11.0 -->
    <script src="js/jquery-1.11.0.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="js/plugins/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').dataTable();
    });
    </script>

</body>
</html>
