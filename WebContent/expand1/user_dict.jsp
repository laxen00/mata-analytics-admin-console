<!DOCTYPE html>
<html lang="en">
<%@ page import="
apiRequest.*,
org.json.JSONObject,
org.json.JSONArray" %>
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
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MAX Administration Console</title>
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/loading.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="css/plugins/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/bootstrap-dialog.css" rel="stylesheet">

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
	<script type="text/javascript" src="_lib/jquery.js"></script>
		<script type="text/javascript" src="_lib/jquery.cookie.js"></script>
		<!--<script type="text/javascript" src="_lib/jquery.hotkeys.js"></script>-->
		<script type="text/javascript" src="jquery.jstree.js"></script>
		<script type="text/javascript" src="js/bootstrap-dialog.js"></script>
		
		<script type="text/javascript" src="_docs/syntax/!script.js"></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<style>
			.selected {
				background-color : #DEDEDE;
			}
			[contenteditable=true]:empty:before{
			  content: attr(placeholder);
			  color: #cccccc;
			  font-style: italic;
			  display: block; /* For Firefox */
			}
		</style>
		<script>
// 			$(document).ready(function(){
// 				$("#addkeys").click(function(){
// 					$("#dataTables-example").append('<tr id="cobacoba"><td class="contoh" contenteditable="true" style="width:80%" placeholder="Insert keyword here"></td><td><span class="" style="cursor:pointer"onclick="del1(this)"><button class="btn btn-danger btn-xs">Delete</button></span></td></tr>');
// 				});
// 			});
		</script>
		<script>
		var valdict = document.getElementById('create_dictName');
		valdict.oninvalid = function(event) {
			event.target.setCustomValidity('Dictionary name should only contain alphanumeric characters');
		}
		</script>
		<script>
			function setdelProp(colId, dictName) {
				document.getElementById('del_colId').value = colId;
				document.getElementById('del_dictName').value = dictName;
			}
			
			function addKeywords(colId) {
				document.getElementById('loadingmodal').style.display = "inline";
				var dictName = document.getElementById('selected_dict').innerHTML;
				var list = document.getElementsByClassName('contoh');
				var objStart = '{';
				var objEnd = '}';
				var entry_colId = '"colId" : "' + colId + '",';
				var entry_dictName = '"dictName" : "' + dictName + '",';
				var keywordsStart = '[';
				var keywordsEnd = ']';
				var keywordsList = '';
				for (var i = 0; i < list.length ; i++) {
					var entryword = list[i].innerHTML;
					var entryword = entryword.replace(/<br>/gi, "");
					if (entryword == '') continue;
					keywordsList = keywordsList + '"' + entryword + '"';
					if (i != (list.length - 1)) keywordsList = keywordsList + ",";
				}
				var keywords = keywordsStart + keywordsList + keywordsEnd;
				var entry_keywords = '"keywords" : ' + keywords;
				var obj = objStart + entry_colId + entry_dictName + entry_keywords + objEnd;
// 				document.getElementById('create_dictName').value = obj;
// 				document.getElementById('create_dictName').innerHTML = obj;
				
				var xmlhttp=new XMLHttpRequest();
				xmlhttp.onreadystatechange=function() {
				  if (xmlhttp.readyState==4 && xmlhttp.status==200)
				    {
// 					  document.location.href = "userDict.jsp?colId="+colId;
					  //var iframe = document.getElementById('iframe_a');
					  //iframe.src = iframe.src;
					  location.href = 'user_dict.jsp?colId=' + colId;
				    }
				}
				xmlhttp.open("POST","api/saveDict.jsp",true);
				xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xmlhttp.send("json="+obj);
				
			}
			function selectDict(count, max, dictName, colId) {
				document.getElementById('loadingmodal').style.display = "inline";
				document.getElementById('addkeys').disabled = false;
				document.getElementById('savekeys').disabled = false;
				for (var i = 1 ; i <= max ; i++) {
					document.getElementById('dict_'+i).className = "";
				}
				document.getElementById('dict_'+count).className = "selected";
				document.getElementById('selected_dict').innerHTML = dictName;
				
				var xmlhttp=new XMLHttpRequest();
				xmlhttp.onreadystatechange=function() {
				  if (xmlhttp.readyState==4 && xmlhttp.status==200)
				    {
						var arr = JSON.parse(xmlhttp.responseText);
						var tablelist = document.getElementById('dataTables-example');
						tablelist.innerHTML = '';
						
						for (var i = 0 ; i < arr.length ; i++) {
							var entry = arr[i];
 							//if (entry == '') entry = '';
							tablelist.innerHTML = tablelist.innerHTML + '<tr id="cobacoba">'
							+ '<td class="contoh" contenteditable="true" style="width:80%" placeholder="Insert keyword here">'+ entry +'</td>'
							+ '<td><span class="" style="cursor:pointer" onclick="del1(this)"><button class="btn btn-danger btn-xs">Delete</button></span></td>'
							+ '</tr>';
						}
						document.getElementById('loadingmodal').style.display = "none";
				    }
				}
				xmlhttp.open("POST","api/getKeywords.jsp",true);
				xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xmlhttp.send("colId="+colId+"&dictName="+dictName);
			}
			
			function insertNewKeyword(){
				var tablelist = document.getElementById('dataTables-example');
				var oldlist = tablelist.innerHTML;
				tablelist.innerHTML = '<tr id="cobacoba">'
				+ '<td class="contoh" contenteditable="true" style="width:80%" placeholder="Insert keyword here"></td>'
				+ '<td><span class="" style="cursor:pointer" onclick="del1(this)"><button class="btn btn-danger btn-xs">Delete</button></span></td>'
				+ '</tr>'
				+ oldlist;
			} 
		</script>
</head>

<body>

    <div id="wrapper">

        

        <div id="page-wrapper">
        	<div class="row maxbreadcrumb">
        		<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
					<li class="active">User Dictionary</li>
				</ul>
        	</div>
            <div class="row maxhead">
                <div class="col-lg-12">
                    <h1 class="page-header">User Dictionary</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
				<div class="panel-body">
					<div class="col-lg-3">
						<div class="panel panel-default">
							<div class="panel-heading" style="height:40px">
								
							</div>
							<!-- /.panel-heading -->
							<div class="panel-body" style="height:230px">
								<h4>Dictionary Name</h4>
								<form action="api/createDict.jsp" method="post">
									<input name="create_dictName" id="create_dictName" class="form-control" pattern="[a-zA-Z0-9]+" >
									<input name="create_colId" id="create_colId" type="hidden" value="<% out.print(colId); %>">
									<input type="submit" class="btn btn-default btn-sm" value="Create" style="margin:10px 0 10px 0"/>
								</form>
							</div>
							<!-- /.panel-body -->
						</div>
						<!-- /.panel -->
					</div>
					<!-- /.col-lg-4 -->
					<!--div class="col-lg-1">
						<img src="images/blackt2.png">
					</div-->
					<div class="col-lg-4">
						<div class="panel panel-default">
							<div class="panel-heading">
								Dictionary List
							</div>
							<!-- /.panel-heading -->
							
							<div class="table-responsive" style="height:230px; overflow:auto; padding:0px 10px 0px 10px ">
                                <table id="mtable" style="width:100%; border:none" class="table table-hover" id="dataTables-example">
                                <%
//                                 	String[] dictList = {"Dict 1", "Dict 2"};
                                String hostname = request.getServerName();
                        		JSONArray dictList = new DictRequest(hostname).getDicts(colId, token);
                                	int count = 1;
                                	for (int i = 0; i < dictList.length() ; i++) {
                                		String dictName = dictList.getString(i);
                                %>
									<tr id="dict_<% out.print(count); %>"onclick='selectDict("<% out.print(count); %>","<% out.print(dictList.length()); %>","<% out.print(dictName); %>","<% out.print(colId); %>")'>
										<td style="cursor:pointer"><% out.print(dictName); %></td>
										<td><span class="fa fa-trash-o" style="cursor:pointer" onclick="setdelProp('<% out.print(colId); %>','<% out.print(dictName); %>')" data-toggle="modal" data-target="#delconf"></span></td>
									</tr>
								<%
									count++;
                                	}
								%>
								</table>
								<div id="dictCount" style="display:none"><%out.print(count);%></div>
							</div>
							<!--<div class="col-xs-12" style="margin:0px;padding:0px">
								<select id="select_id" size="5" class="form-control1" style="height:200px">
									<option style="margin-bottom:5px;">Dictionary 1</option>
									<option style="margin-bottom:5px;">Dictionary 2</option>
									<option style="margin-bottom:5px;">Dictionary 3</option>
									<option style="margin-bottom:5px;">Dictionary 4</option>
									<option style="margin-bottom:5px;">Dictionary 5</option>
									
								</select>
							</div>-->

								
							
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
					
						
					
						
					<div id='selected_dict' style='display:none'></div>
					<div class="col-lg-5">
						<div class="panel panel-default" >
                            <div class="panel-heading">
								Keywords
							</div>
							<div id="table" class="table-editable">
							<div class="table-responsive" style="height:190px; overflow:auto; padding:0px 10px 0px 10px ">
                                <table style="width:100%; border:none" class="table table-hover" id="dataTables-example">
								
<!--                                     <tr> -->
<!--         <td contenteditable="true">1</td> -->
        
        
<!--         <td> -->
		  
<!-- 		  <span class="table-remove fa fa-trash-o" style="cursor:pointer"></span> -->
          
<!--         </td> -->
<!--       </tr> -->
      <!-- This is our clonable table line -->
      <tr id="cobacoba" class="hide">
        <td class="contoh" contenteditable="true"></td>
        
        <td>
		
		<span class="table-remove" style="cursor:pointer"><button class="btn btn-danger btn-xs">Delete</button></span>
          
        </td>
      </tr>
                                </table>
                            </div>
							</div>
                            <!-- /.table-responsive -->
                            <div class="panel-footer" style="padding:5px 15px">
							<button id="addkeys" class="btn btn-primary btn-sm" onclick="insertNewKeyword()" disabled>Add</button>
							<button id="savekeys" onclick='addKeywords("<% out.print(colId); %>")' class="btn btn-info btn-sm" disabled>Save</button>
							</div>
							</div>
                    </div>
				</div>
						<!-- /.panel -->
					<!--/div-->
					<!-- /.col-lg-4 -->
					
					        
                            
                            <button class="btn btn-default" onclick="location.href='index.jsp#<% out.print(colId); %>'">Back</button>
                            
                            
                    
				</div>
			</div>
            <!-- /.row -->
            
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
	<div class="modal fade in" id="loadingmodal" tabindex="-1" role="dialog" style="display:none; background-color: rgba(26, 26, 26, 0.8);"  >
         <div class="icon">
			<div class="hexagon"></div>
			<div class="lines"></div>
			<div class="lines"></div>
			<div class="lines"></div>
		</div>
    </div>
	<div class="modal fade" id="delconf" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x—</button>
                                            <h4 class="modal-title" id="myModalLabel">Delete Confirmation</h4>
                                        </div>
                                        <div class="modal-body">
                                          Are you sure to delete?
                                        </div>
                                        <form action="api/deleteDict.jsp" method="post">
	                                        <div class="modal-footer">
	                                        	<input type="hidden" name="del_colId" id="del_colId" value="" />
	                                        	<input type="hidden" name="del_dictName" id="del_dictName" value="" />
	                                            <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
	                                            <input type="submit" class="btn btn-primary" value="Yes"/>
	                                        </div>
                                        </form>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
	
    <!-- /#wrapper -->
	<div class="modal fade" id="delconf1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                                <!--/form>
								<!--/div>
                                <!-- /.modal-dialog -->
    </div>
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
	<script>
		$('#irow').click(function(){
    if($('#row').val()){
        $('#mtable tbody').append($("#mtable tbody tr:last").clone());
        $('#mtable tbody tr:last :checkbox').attr('checked',false);
        $('#mtable tbody tr:last td:first').html($('#row').val());
    }else{alert('Enter Text');}
});
		function del1(element){
			$(element).closest('tr').remove();
		};
	</script>
    
	<script src="js/table.js"></script>
</body>

</html>
