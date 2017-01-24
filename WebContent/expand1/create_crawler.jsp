<!DOCTYPE html>
<html lang="en">
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
	String displayname = "";
	String useragent = "";
	String url = "";
	String type = "";
	String keyword = "";
	String prog = "";
	String progsince = "";
	
	try {
		displayname = request.getParameter("displayname");
		if (displayname.equalsIgnoreCase("null")) displayname = "";
	}
	catch (Exception e) {
		displayname = "";
	}
	try {
		useragent = request.getParameter("useragent");
		if (useragent.equalsIgnoreCase("null")) useragent = "";
	}
	catch (Exception e) {
		useragent = "";
	}
	try {
		url = request.getParameter("url");
		if (url.equalsIgnoreCase("null")) url = "";
	}
	catch (Exception e) {
		url = "";
	}
	try {
		type = request.getParameter("optionsRadios");
		if (type.equalsIgnoreCase("null")) type = "";
	}
	catch (Exception e) {
		type = "";
	}
	try {
		keyword = request.getParameter("keyword");
		if (keyword.equalsIgnoreCase("null")) keyword = "";
	}
	catch (Exception e) {
		keyword = "";
	}
	try {
		prog = request.getParameter("prog");
		if (prog.equalsIgnoreCase("null")) prog = "true";
	}
	catch (Exception e) {
		prog = "true";
	}
	try {
		progsince = request.getParameter("progsince");
		if (progsince.equalsIgnoreCase("null")) progsince = "";
	}
	catch (Exception e) {
		progsince = "";
	}
%>
<head>
	<meta http-equiv="Cache-control" content="private">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="PT. Mata Prima Universal">

    <title>Create Crawler - MAX Administration Console</title>
	
	<%	if (token.isEmpty()) { %>
			<script>window.top.location.href="../index.jsp";</script>
	<%	} %>
	<script type="text/javascript" src="js/jquery1.10.1.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/bootstrap.js"></script>
    <script src="js/sb-admin-2.js"></script>
	<script>
		function getAppToken() {
			var xmlhttp=new XMLHttpRequest();
			var apptoken = "";
			xmlhttp.onreadystatechange=function()
			  {
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			    {
				  	apptoken = JSON.parse(xmlhttp.responseText);
				  	return apptoken;
			    }
			  };
			xmlhttp.open("GET","api/getAppToken.jsp",false);
			xmlhttp.send();
			return apptoken;
		}
		
		function datepick() {
			$( "#datepicker" ).datepicker({
				format: "yyyy-mm-dd"
			});
			$( "#datepicker1" ).datepicker({
				format: "yyyy-mm-dd"
			});
			$( "#datepicker2" ).datepicker({
				format: "yyyy-mm-dd"
			});
			$( "#datepicker3" ).datepicker({
				format: "yyyy-mm-dd"
			});
			$( "#progsince" ).datepicker({
				format: "yyyy-mm-dd"
			});
		};
		
		function opttype(rad) {
			var val = rad.value;
			var choice1 = "facebook";
			var choice2 = "twitter";
			var choice3 = "general";
			var choice4 = "news";
			var choice5 = "forum";
			var choice6 = "twitter_bluemix";
			var choice7 = "youtube";
			var choice8 = "instagram";
			
			var apptoken = getAppToken();
			if (val == choice1) {
				var fieldStart = '<div class="form-group"><span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px" required>';
				var options = "";
				var i;
				for (i=0; i< apptoken.length;i++) {
					if (apptoken[i].type == 'facebook') options +=  '<option value="'+apptoken[i].token+'">'+apptoken[i].alias+'</option>';
				}
				var fieldClose = '</select><span>* </span><label>Query:</label><input name="query" id="query" type="text" class="form-control" placeholder="Query" required></input></div><div class="form-group"><label>Since:</label><input name="datesince" type="text" class="form-control" placeholder="since date" id="datepicker" style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></input><label>Until:</label><input name="dateuntil" type="text" class="form-control" placeholder="until date" id="datepicker1" style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></div>'; 
				var fields = fieldStart + options + fieldClose;
				document.getElementById('change_ed').innerHTML = fields;
				datepick();
				document.getElementById('crawlerform').action ='api/createCrawler.jsp';
				document.getElementById('nextbutton').className ='btn btn-default disabled';
				document.getElementById('finishbutton').className ='btn btn-default';					
	       	}else if (val == choice2) {
				var fieldStart = '<div class="form-group"><span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px"required>';
				var options = "";
				var i;
				for (i=0; i< apptoken.length;i++) {
					if (apptoken[i].type == 'twitter') options +=  '<option value="'+apptoken[i].token+'">'+apptoken[i].alias+'</option>';
				}
				var fieldClose = '</select><span>* </span><label>Query:</label><input name="query" id="query" type="text" class="form-control" placeholder="Query" required></input></div><div class="form-group"><label>Until:</label><input name="dateuntil" type="text" class="form-control" placeholder="until date" id="datepicker" style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></div>';
				var fields = fieldStart + options + fieldClose;
				document.getElementById('change_ed').innerHTML = fields;
				datepick();
				document.getElementById('crawlerform').action ='api/createCrawler.jsp';
				document.getElementById('nextbutton').className ='btn btn-default disabled';
				document.getElementById('finishbutton').className ='btn btn-default';
	        }else if (val == choice3) {
//				document.getElementById('change_ed').innerHTML = 
//				"<div class='form-group'><span>* </span><label>User agent:</label><input name='useragent' id='useragent' type='text' class='form-control' value='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0' placeholder='User agent' required></input></div><div class='form-group'><span>* </span><label>Start URL:</label><p class='help-block'>Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p><input name ='url' id='url' type='text' value='<%out.print(url);%>' class='form-control' placeholder='URL' pattern='https?://.+' title='Include http:// or https://' required></input></div><div class='form-group'><label>Keyword:</label><p class='help-block'>Type the keyword.</p><input name ='keyword' id='keyword' type='text' value='<%out.print(keyword);%>' class='form-control' placeholder='keyword'></input></div><div class='form-group'><label>Progressive:</label><p class='help-block'></p><select id='prog' name='prog' value='<%out.print(prog);%>' class='form-control' onchange='javascript:progs(this)'><option value='true'>True</option><option value='false'>False</option></select></div><div id='_progsince' class='form-group' style='display:none'><label>Since Progresive:</label><p class='help-block'></p><input id='progsince' name='progsince' type='text' value='<%out.print(progsince);%>' class='form-control' placeholder='date' style='cursor:pointer;' pattern='([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])' title='yyyy-mm-dd'></input></div>";
				document.getElementById('change_ed').innerHTML = 
				"<div class='form-group'><span>* </span><label>User agent:</label><input name='useragent' id='useragent' type='text' class='form-control' value='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0' placeholder='User agent' required></input></div><div class='form-group'><span>* </span><label>Start URL:</label><p class='help-block'>Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p><input name ='url' id='url' type='text' class='form-control' placeholder='URL' pattern='https?://.+' title='Include http:// or https://' required></input></div><div class='form-group'><label>Keyword:</label><p class='help-block'>Type the keyword.</p><input name ='keyword' id='keyword' type='text' class='form-control' placeholder='keyword'></input></div><div class='form-group'><label>Progressive:</label><p class='help-block'></p><select id='prog' name='prog' class='form-control' onchange='javascript:progs(this)'><option value='true'>True</option><option value='false'>False</option></select></div><div id='_progsince' class='form-group' style='display:none'><label>Since Progresive:</label><p class='help-block'></p><input id='progsince' name='progsince' type='text' class='form-control' placeholder='date' style='cursor:pointer;' pattern='([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])' title='yyyy-mm-dd'></input></div>";
				datepick();
				document.getElementById('crawlerform').action = 'create_crawler_general.jsp';
	       	}else if (val == choice4 | val == choice5) {
//				document.getElementById('change_ed').innerHTML = 
//				"<div class='form-group'><span>* </span><label>User agent:</label><input name='useragent' id='useragent' type='text' class='form-control' value='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0' placeholder='User agent' required></input></div><div class='form-group'><span>* </span><label>Start URL:</label><p class='help-block'>Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p><input name ='url' id='url' type='text' value='<%out.print(url);%>' class='form-control' placeholder='URL' pattern='https?://.+' title='Include http:// or https://' required></input></div><div class='form-group'><label>Keyword:</label><p class='help-block'>Type the keyword.</p><input name ='keyword' id='keyword' type='text' value='<%out.print(keyword);%>' class='form-control' placeholder='keyword'></input></div><div class='form-group'><label>Progressive:</label><p class='help-block'></p><select id='prog' name='prog' value='<%out.print(prog);%>' class='form-control' onchange='javascript:progs(this)'><option value='true'>True</option><option value='false'>False</option></select></div><div id='_progsince' class='form-group' style='display:none'><label>Since Progresive:</label><p class='help-block'></p><input id='progsince' name='progsince' type='text' value='<%out.print(progsince);%>' class='form-control' placeholder='date' style='cursor:pointer;' pattern='([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])' title='yyyy-mm-dd'></input></div>";
				document.getElementById('change_ed').innerHTML = 
					"<div class='form-group'><span>* </span><label>User agent:</label><input name='useragent' id='useragent' type='text' class='form-control' value='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0' placeholder='User agent' required></input></div><div class='form-group'><span>* </span><label>Start URL:</label><p class='help-block'>Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p><input name ='url' id='url' type='text' class='form-control' placeholder='URL' pattern='https?://.+' title='Include http:// or https://' required></input></div><div class='form-group'><label>Keyword:</label><p class='help-block'>Type the keyword.</p><input name ='keyword' id='keyword' type='text' class='form-control' placeholder='keyword'></input></div><div class='form-group'><label>Progressive:</label><p class='help-block'></p><select id='prog' name='prog' class='form-control' onchange='javascript:progs(this)'><option value='true'>True</option><option value='false'>False</option></select></div><div id='_progsince' class='form-group' style='display:none'><label>Since Progresive:</label><p class='help-block'></p><input id='progsince' name='progsince' type='text' class='form-control' placeholder='date' style='cursor:pointer;' pattern='([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])' title='yyyy-mm-dd'></input></div>";
				datepick();
				document.getElementById('crawlerform').action = 'dynamiccrawl_test.jsp';
	       	}else if (val == choice6) {
	       		var fieldStart = '<div class="form-group"><span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px"required>';
				var options = "";
				var i;
				for (i=0; i< apptoken.length;i++) {
					if (apptoken[i].type == 'twitter_bluemix') options +=  '<option value="'+apptoken[i].token+'">'+apptoken[i].alias+'</option>';
				}
				var fieldClose = '</select><label>Count</label><input class="form-control" id="count" name="count" value="100" type="text"></input><span>* </span><label>Query:</label><input name="query" id="query" type="text" class="form-control" placeholder="Query" required></input></div><div class="form-group"><label>Since:</label><input name="datesince" type="text" class="form-control" placeholder="since date" id="datepicker2" style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></div><div class="form-group"><label>Until:</label><input name="dateuntil" type="text" class="form-control" placeholder="until date" id="datepicker3" style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></div>';
				var fields = fieldStart + options + fieldClose;
				document.getElementById('change_ed').innerHTML = fields;
				datepick();
				document.getElementById('crawlerform').action ='api/createCrawler.jsp';
				document.getElementById('nextbutton').className ='btn btn-default disabled';
				document.getElementById('finishbutton').className ='btn btn-default';
		    }else if (val == choice7) {
				var fieldStart = '<div class="form-group"><span>* </span><label>App Token</label><select name="apptoken" id="apptoken" class="form-control" style="margin-bottom:15px"required>';
				var options = "";
				var i;
				for (i=0; i< apptoken.length;i++) {
					if (apptoken[i].type == 'youtube') options +=  '<option value="'+apptoken[i].token+'">'+apptoken[i].alias+'</option>';
				}
				var fieldClose = '</select></div><div class="form-group"><label>Keyword</label><input name="keyword" id="keyword" type="text" class="form-control" placeholder="Query" required></input></div><div class="form-group"><label>Video Search Type:</label><select name="vst" id="vst" class="form-control"><option value="relevance">Relevance</option><option value="date">Date</option></select></div><div class="form-group"><label>Video Keywords As Comments Filter</label><select id="vkcf" name="vkcf" class="form-control"><option value="true">True</option><option value="false">False</option></select></div><div class="form-group"><label>Progressive:</label><p class="help-block"></p><select id="prog" name="prog" class="form-control" onchange="javascript:progs(this)"><option value="true">True</option><option value="false">False</option></select></div><div id="_progsince" class="form-group" style="display:none"><label>Since Progresive:</label><p class="help-block"></p><input id="progsince" name="progsince" type="text" class="form-control" placeholder="date" style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></input></div>';
				var fields = fieldStart + options + fieldClose;
				document.getElementById('change_ed').innerHTML = fields;
				datepick();
				document.getElementById('crawlerform').action ='api/createCrawler.jsp';
				document.getElementById('nextbutton').className ='btn btn-default disabled';
				document.getElementById('finishbutton').className ='btn btn-default';
		    }else if (val == choice8) {
				var fieldStart = '<div class="form-group"><span>* </span><label>Keyword</label><input name="query" id="query" type="text" class="form-control" placeholder="Query" required>';
				
				var fieldClose = '</input></div><div class="form-group"><label>Sort Type:</label><select name="searchtype" id="searchtype" class="form-control"><option value="user">User</option><option value="tag">Tag</option></select></div><div class="form-group"><label>Use Keyword As Comments Filter</label><select id="usaf" name="usaf" class="form-control"><option value="true">True</option><option value="false">False</option></select></div><div class="form-group"><label>Progressive:</label><p class="help-block"></p><select id="prog" name="prog" class="form-control" onchange="javascript:progs(this)"><option value="true">True</option><option value="false">False</option></select></div><div id="_progsince" class="form-group" style="display:none"><label>Since Progresive:</label><p class="help-block"></p><input id="progsince" name="progsince" type="text" class="form-control" placeholder="date" style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></input></div>';
				var fields = fieldStart + fieldClose;
				document.getElementById('change_ed').innerHTML = fields;
				datepick();
				document.getElementById('crawlerform').action ='api/createCrawler.jsp';
				document.getElementById('nextbutton').className ='btn btn-default disabled';
				document.getElementById('finishbutton').className ='btn btn-default';
		    }else {
				document.getElementById('change_ed').innerHTML = 
				'<div class="form-group"><span>* </span><label>User agent:</label><input name="useragent" id="useragent" type="text" class="form-control" placeholder="User agent" required></input></div><div class="form-group"><span>* </span><label>Start URL:</label><p class="help-block">Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p><input name ="url" id="url" type="text" class="form-control" placeholder="URL" required></input></div><div class="form-group"><label>Progressive:</label><p class="help-block"></p><select id="prog" name="prog" class="form-control" onchange="javascript:progs(this)"><option value="true">True</option><option value="false">False</option></select></div><div id="_progsince" class="form-group" style="display:none"><label>Since Progresive:</label><p class="help-block"></p><input id="progsince" name="progsince" type="text" class="form-control" placeholder="date"  style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></input></div>';
				datepick();
				document.getElementById('crawlerform').action = 'forms.jsp';
			}
		}
		function progs(what) {
			document.getElementById('_progsince').style.display = 'none';
			if (what.value == 'false') {
				document.getElementById('_progsince').style.display = 'inline';
				document.getElementById('progsince').style.marginBottom = '15px';
			} else if (what.value == 'true') {
				document.getElementById('_progsince').style.display = 'none';
				document.getElementById('progsince').value = '';
			}
		}
		function validate(){
	        x=document.crawlerform;
	        try {
	        	txt=x.twitcount.value;
	            if (txt>=1 && txt<=1000) {
	                return true;
	            }else{
	                alert("Must be between 1 and 1000");
	                return false;
	            }
	        }
	        catch(err) {
	        	return true;
	        }
		}
		
		window.onload = datepick;
	</script>

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
			  		<li><a href="index.jsp#<% out.print(colId); %>">Collections - <% out.print(colId); %></a></li>
					<li class="active">Create Crawler</li>
				</ul>
			</div>
            <div class="row maxhead">
                <div class="col-lg-12">
                    <h1 class="page-header">Create a Crawler</h1>
					<span>Select the type of data that you want to add to the collection.</br>
					Specify which default values you want to use with the new crawler.</br>
					Complete the pages of the wizard to create the crawler.</span>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-7">
				
                    <div class="panel-body">
						<form id="crawlerform" name="crawlerform" role="form" method="post" action="create_crawler_general.jsp" style="margin-bottom:10px" onsubmit="return validate()">
                            <div class="form-group">
                                <span>* </span><label>Crawler type:</label>
                                <select class="form-control">
                                    <option>Web</option>
                                    
                                </select>
                            </div>
							<div class="form-group">
                                <span>* </span><label>Crawler name:</label><p class="help-block"> (Spaces and the characters a-z, A-Z, 0-9, underscore, and hyphen are allowed.)</p>
                                <input name="displayname" id="displayname" value='<%out.print(displayname);%>' type="text" class="form-control" placeholder="Crawler name" required></input>
                            </div>
							<div class="form-group">
							
								<span>* </span><label>Website Type:</label>
							<div class="col-xs-12">
                                <div class="row">
								<div class="col-xs-2">
                                <div class="radio">
                                    <label>
                                        <input type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios1" value="general" checked>General
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios2" value="news" <% if (type.equalsIgnoreCase("news")) out.print("checked"); %>>News
                                    </label>
                                </div>
								<div class="radio">
                                    <label>
                                        <input type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios3" value="forum" <% if (type.equalsIgnoreCase("forum")) out.print("checked"); %>>Forum
                                    </label>
                                </div>
								</div>
								<div class="col-xs-4">
                                <div class="radio" data-toggle="tooltip" title="Under maintenance due to changing policy of data provider"  >
                                    <label style="cursor:not-allowed">
                                        <input id="faceradio" type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios4" value="facebook" <% if (type.equalsIgnoreCase("facebook")) out.print("checked"); %>>Facebook
                                    </label>
								</div>
								<div class="radio">
                                    <label>
                                        <input type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios5" value="twitter" <% if (type.equalsIgnoreCase("twitter")) out.print("checked"); %>>Twitter
                                    </label>
								
                                
								</div>
								<div class="radio">
                                    <label>
                                        <input type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios6" value="twitter_bluemix" <% if (type.equalsIgnoreCase("twitter_bluemix")) out.print("checked"); %>>Twitter (By IBM Bluemix®)
                                    </label>
								
                                
								</div>
                                </div>
                                <div class="col-xs-2">
                                	<div class="radio">
                                    <label>
                                        <input type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios7" value="youtube" <% if (type.equalsIgnoreCase("youtube")) out.print("checked"); %>>Youtube
                                    </label>
                                    <div class="radio">
                                    <label>
                                        <input type="radio" onclick="opttype(this)" name="optionsRadios" id="optionsRadios8" value="instagram" <% if (type.equalsIgnoreCase("instagram")) out.print("checked"); %>>Instagram
                                    </label>
								
                                
								</div>
                                </div>
								<div class="col-xs-2"></div>
								<div class="col-xs-2"></div>
								<div class="col-xs-2"></div>
								<div class="col-xs-2"></div>
								</div>
							</div>
							</div>
							<div id="change_ed">
							<div class="form-group">
                                <span>* </span><label>User agent:</label>
                                <input name="useragent" id="useragent" type="text" value="Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0" class="form-control" placeholder="User agent" required></input>
                            </div>
							
							<div class="form-group">
                                <span>* </span><label>Start URL:</label>
								<p class="help-block">Type one URL, include the protocol, such as http://, and do not specify wildcard characters.</p>
                                <input name ="url" id="url" type="text" value='<%out.print(url);%>' class="form-control" placeholder="URL" pattern="https?://.+" title="Include http:// or https://" required></input>
								
							</div>
							<div class="form-group">
                                <label>Keyword:</label>	
								<p class="help-block">Type any Keyword</p>
                                <input name ="keyword" id="keyword" value='<%out.print(keyword);%>' type="text" class="form-control" placeholder="keyword"></input>
								
							</div>
							<div class="form-group">
                                <label>Progressive:</label>
								<p class="help-block"></p>
                                <select id="prog" name="prog" class="form-control" onchange="javascript:progs(this)">
                                    <option value="true" <% if (prog.equalsIgnoreCase("true")) out.print("selected"); %>>True</option>
                                    <option value="false"<% if (prog.equalsIgnoreCase("false")) out.print("selected"); %>>False</option>
                                    
                                </select>
								
								
							</div>
							<%
								String progdisplay = "none";
								if (prog.equalsIgnoreCase("false")) progdisplay = "inline";
								else progdisplay = "none";
							%>
							<div id="_progsince" class="form-group" style="display:<% out.print(progdisplay); %>">
                                <label>Since Progresive:</label>
								<p class="help-block"></p>
                                <input id="progsince" name="progsince" value="<%out.print(progsince);%>" type="text" class="form-control" placeholder="date"  style="cursor:pointer;" pattern="([1|2][0-9]{3})-([0][0-9]|[1][0-2])-([0|1|2][0-9]|[3][0-1])" title="yyyy-mm-dd"></input>
							</div>
							</div>
							
							<input type="hidden" name="colId" id="colId" value="<% out.print(colId); %>" />
							
							<button type="submit" class="btn btn-default disabled" title="Back">Back</button>
							<button id="nextbutton" type="submit" class="btn btn-default" title="Next" >Next</button>
							<button id="finishbutton" type="submit" class="btn btn-default disabled" title="Finish">Finish</button>
                            <button type="reset" class="btn btn-default" title="Cancel" onclick="location.href='index.jsp#<% out.print(colId); %>'">Cancel</button>
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
    <script>
	$(document).ready(function(){
	    $('[data-toggle="tooltip"]').tooltip();
	});
	
	document.getElementById('faceradio').disabled = true;
	</script>
</body>

</html>
