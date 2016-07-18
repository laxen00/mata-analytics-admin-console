function refreshCollection(col, colId, crawlCount) {
	refreshCrawlers(col, colId, crawlCount);
	refreshParse(col, '2', colId, 'na');
	refreshRebuild(col, '3', colId, 'na');
	refreshDetails(col, colId);
}

function refreshCrawlers(col, colId, crawlCount) {
	refreshSession();
	var count = parseInt(crawlCount);
	var i = 0;
	var totalCrawlerOffset = 6 + count;
	for (i=6;i<totalCrawlerOffset;i++) {
		var crawlIdElement = "crawlId"+col+"_"+i;
		var crawlId = document.getElementById(crawlIdElement).innerHTML;
		refreshCrawler(col, i, colId, crawlId);
	}
}

function refreshParse(col, con, colId, unused) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var stat = parseInt(xmlhttp.responseText);
		  var progressBar = $('#progress-bar-ed'+col+'_'+con);
		  
		  if (stat == 0) {
			  	progressBar.css('width',  '0%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_collection(col,con,'not running',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "not running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin';
				document.getElementById('index_indicator'+col).src = "images/noactive1.png";
				document.getElementById('colSize'+col).src = "";
				document.getElementById('numdocs'+col).src = "";
				document.getElementById('colVersion2'+col).src = "";
		  }else if (stat == 1) {
			  	progressBar.css('width',  '100%');
			  	document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_collection(col,con,'running',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin progress-striped active';
				document.getElementById('index_indicator'+col).src = "images/active1.png";
		  }
		  refreshDetails(col, colId);
	    }
	  };
	xmlhttp.open("GET","refresh/refreshParse.jsp?colId="+colId,true);
	xmlhttp.send();
}

function refreshReload(col, con, colId, unused) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var stat = xmlhttp.responseText;
		  var progressBar = $('#progress-bar-ed'+col+'_'+con);
		  
		  if (stat.indexOf("reloading") > -1) {
			  	progressBar.css('width',  '100%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_reloader(col,con,'running',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin progress-striped active';
				
				document.getElementById('button'+col+'_2').classname = "btn btn-default disabled";
				document.getElementById('button'+col+'_2').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_3').classname = "btn btn-default disabled";
				document.getElementById('button'+col+'_3').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('annotatorMenu'+col).className = "disabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", 
					"Please wait until current process is finished");
		  }else {
			  	progressBar.css('width',  '0%');
			  	document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_reloader(col,con,'not running',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "not running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin';
				
				document.getElementById('button'+col+'_2').classname = "btn btn-default";
				document.getElementById('button'+col+'_2').setAttribute("title", "");
				
				document.getElementById('button'+col+'_3').classname = "btn btn-default";
				document.getElementById('button'+col+'_3').setAttribute("title", "");
				
				document.getElementById('annotatorMenu'+col).className = "enabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", "");
				
				refreshParse(col, '2', colId, unused);
				refreshDetails(col, colId);
		  }
	    }
	  };
	xmlhttp.open("GET","refresh/refreshReload.jsp?colId="+colId,true);
	xmlhttp.send();
}

function refreshRebuild(col, con, colId, unused) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
		  var stat = xmlhttp.responseText.toLowerCase();
		  
		  if (stat.indexOf("idle") > -1) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '0%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_rebuilder(col,con,'not running',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
				document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "not running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin';
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default';
				document.getElementById('button'+col+'_2').setAttribute("title","");

				document.getElementById('button'+col+'_4').className = 'btn btn-default';
				document.getElementById('button'+col+'_4').setAttribute("title","");
				
				document.getElementById('annotatorMenu'+col).className = "enabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title","");
		  }else if (stat.indexOf("preparing") > -1) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '20%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_rebuilder(col,con,'preparing states',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin progress-striped active';
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_2').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_4').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_4').setAttribute("title", 
					"Please wait until current process is finished");

				document.getElementById('annotatorMenu'+col).className = "disabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", 
					"Please wait until current process is finished");
		  }else if (stat.indexOf("preparing") > -1 && stat.indexOf("%") > -1) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '50%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_rebuilder(col,con,'preparing run',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin progress-striped active';
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_2').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_4').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_4').setAttribute("title", 
					"Please wait until current process is finished");

				document.getElementById('annotatorMenu'+col).className = "disabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", 
					"Please wait until current process is finished");
		  }else if (stat.indexOf("rebuilding") > -1) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '100%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_rebuilder(col,con,'rebuilding',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin progress-striped active';
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_2').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_4').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_4').setAttribute("title", 
					"Please wait until current process is finished");

				document.getElementById('annotatorMenu'+col).className = "disabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", 
					"Please wait until current process is finished");
		  }else if (stat.indexOf("rebuilding") > -1 && stat.indexOf("100%") > -1) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '0%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_rebuilder(col,con,'rebuilding done',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/start.png";
				document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "done";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin';
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default';
				document.getElementById('button'+col+'_2').setAttribute("title", "");

				document.getElementById('button'+col+'_4').className = 'btn btn-default';
				document.getElementById('button'+col+'_4').setAttribute("title", "");

				document.getElementById('annotatorMenu'+col).className = "enabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", "");
				
				document.getElementById('collectionStatus'+col).innerHTML = '';
				refreshDetails(col,colId);
		  }else {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '0%');
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_rebuilder(col,con,'error',colId, unused);
				};
				document.getElementById('buttonrun'+col+'_'+con).src = "images/start.png";
				document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
				document.getElementById('textrun'+col+'_'+con).innerHTML = "error";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin';
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default';
				document.getElementById('button'+col+'_2').setAttribute("title", "");
				
				document.getElementById('button'+col+'_4').className = 'btn btn-default';
				document.getElementById('button'+col+'_4').setAttribute("title", "");

				document.getElementById('annotatorMenu'+col).className = "enabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", "");
		  }

		  document.getElementById('textrundetail'+col+'_'+con).innerHTML = stat;
	    }
	  };
	xmlhttp.open("GET","refresh/refreshRebuild.jsp?colId="+colId,true);
	xmlhttp.send();
}

function refreshCollectionStatus(col, colId) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
		  var stat = xmlhttp.responseText;
		  
		  if (stat.indexOf("idle") > -1 || stat.indexOf("unloaded") > -1) {
			  try{
				  document.getElementById('button'+col+'_2').className = 'btn btn-default';
				  document.getElementById('button'+col+'_2').setAttribute("title", "");
				
				  document.getElementById('button'+col+'_3').className = 'btn btn-default';
				  document.getElementById('button'+col+'_3').setAttribute("title", "");
				
				  document.getElementById('button'+col+'_4').className = 'btn btn-default';
				  document.getElementById('button'+col+'_4').setAttribute("title", "");
				  
				  document.getElementById('annotatorMenu'+col).className = "enabled";
				  document.getElementById('annotatorMenu'+col).setAttribute("title", "");
				  
				  document.getElementById('collectionStatus'+col).innerHTML = '';
			  }catch(err){}
			  
			  try{
				  clearInterval(rebuilderAutoRefresh);
				  clearInterval(reloaderAutoRefresh);
				  clearInterval(pearAutoRefresh);
			  }catch(err){}
		  }else if (stat.indexOf("rebuildindex") > -1) {
			  	var offsetRandom = Math.floor((Math.random() * 5000) + 1000);
				var rebuilderAutoRefresh = setInterval(function () {
					if(document.getElementById('textrun'+col+'_3').innerHTML == "not running"){
						refreshRebuild(col,'3',colId,"");
						clearInterval(rebuilderAutoRefresh);
					}
					//console.debug("refresh rebuilder --> colId:" + colId);
					refreshRebuild(col,'3',colId,"");
				}, 5000 + offsetRandom);
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_2').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_4').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_4').setAttribute("title", 
					"Please wait until current process is finished");

				document.getElementById('annotatorMenu'+col).className = "disabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('collectionStatus'+col).innerHTML = 'Rebuilding Index..';
		  }else if (stat.indexOf("reloading") > -1) {
			  	var offsetRandom = Math.floor((Math.random() * 800) + 100);
				var reloaderAutoRefresh = setInterval(function () {
					if(document.getElementById('textrun'+col+'_4').innerHTML == "not running"){
						refreshReload(col,'4',colId,"");
						clearInterval(reloaderAutoRefresh);
					}
					//console.debug("refresh reloader --> colId:" + colId);
					refreshReload(col,'4',colId,"");
				}, 200 + offsetRandom);
				
				document.getElementById('button'+col+'_2').classname = "btn btn-default disabled";
				document.getElementById('button'+col+'_2').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_3').classname = "btn btn-default disabled";
				document.getElementById('button'+col+'_3').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('annotatorMenu'+col).className = "disabled";
				document.getElementById('annotatorMenu'+col).setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('collectionStatus'+col).innerHTML = 'Reloading..';
		  }else if (stat.indexOf("installingpear") > -1) {
			  	var offsetRandom = Math.floor((Math.random() * 5000) + 1000);
				var pearAutoRefresh = setInterval(function () {
					//console.debug('refresh pear --> colId:' + colId);
					refreshPear(colId, pearAutoRefresh);
				}, 5000 + offsetRandom);
				
				document.getElementById('button'+col+'_2').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_2').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_3').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_3').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('button'+col+'_4').className = 'btn btn-default disabled';
				document.getElementById('button'+col+'_4').setAttribute("title", 
					"Please wait until current process is finished");
				
				document.getElementById('installButton').className = "btn_ed btn btn-default disabled";
				document.getElementById('uninstallButton').className = "btn_ed btn btn-default disabled";
				document.getElementById('pearStatus').innerHTML = "please wait..";
				
				document.getElementById('collectionStatus'+col).innerHTML = 'Processing PEAR..';
		  }else {
			  
		  }
	    }
	  };
	xmlhttp.open("GET","refresh/refreshCollectionStatus.jsp?colId="+colId,true);
	xmlhttp.send();
}

function refreshCrawler(col, con, colId, crawlId) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var stat = parseInt(xmlhttp.responseText);
		  
		  if (stat == 0) {
			  	var progressBar = $('#progress-bar-ed'+col+'_'+con);
			  	progressBar.css('width',  '0%');
			  	document.getElementById('deletebutton'+col+'_'+con).className = "btn";
				document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
					'progress no-margin';
				document.getElementById('textrun'+col+'_'+con).innerHTML = 'not running';
				document.getElementById("button"+col+"_"+con).onclick = function() {
					run_progress_crawler(col,con,'not running',colId,crawlId);
				};
				getOverallState(col, colId);
		  }else if (stat == 1) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '50%');
			  	document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
					= 'progress no-margin progress-striped active';
				document.getElementById('textrun'+col+'_'+con).innerHTML = 'stopping';
			  	document.getElementById("button"+col+"_"+con).onclick = function() {
			  		run_progress_crawler(col,con,'stopping',colId,crawlId);
			  	};
				getOverallState(col, colId);			  
		  }else if (stat == 2) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '50%');
			  	document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
				document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
					= 'progress no-margin progress-striped active';
				document.getElementById('textrun'+col+'_'+con).innerHTML = 'starting';
			  	document.getElementById("button"+col+"_"+con).onclick = function() {
			  		run_progress_crawler(col,con,'starting',colId,crawlId);
			  	};
				getOverallState(col, colId);			  
		  }else if (stat == 3) {
				var progressBar = $('#progress-bar-ed'+col+'_'+con);
				progressBar.css('width',  '100%');
			  	document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
				document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
				document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
					= 'progress no-margin progress-striped active';
				document.getElementById('textrun'+col+'_'+con).innerHTML = 'running';
			  	document.getElementById("button"+col+"_"+con).onclick = function() {
			  		run_progress_crawler(col,con,'running',colId,crawlId);
			  	};
				getOverallState(col, colId);			  
		  }
	    }
	  };
	xmlhttp.open("GET","refresh/refreshCrawler.jsp?colId="+colId+"&crawlId="+crawlId,true);
	xmlhttp.send();
}

function refreshRecentlyCrawled(colId, crawlId) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var data = JSON.parse(xmlhttp.responseText);
		  document.getElementById('crawlcount_recent').innerHTML = data[0];
		  var url = "";
		  for (var i = 1; i < data.length ; i++) url = url + data[i] + "\r\n";
		  document.getElementById('crawlList_recent').innerHTML = url;
	    }
	  };
	xmlhttp.open("GET","refresh/refreshRecentlyCrawled.jsp?colId="+colId+"&crawlId="+crawlId,true);
	xmlhttp.send();
}

function refreshRecentlyCrawledHome(col, con, colId, crawlId) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	
	xmlhttp.onreadystatechange=function(){
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
			  var data = JSON.parse(xmlhttp.responseText);
			  
			  document.getElementById('recentlyCrawledStatus' + col + '_' + con).innerHTML = data[0];
	    }
	};
	xmlhttp.open("GET","refresh/refreshRecentlyCrawled.jsp?colId="+colId+"&crawlId="+crawlId,true);
	xmlhttp.send();
}

function refreshAllCrawled(colId, crawlId) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var data = JSON.parse(xmlhttp.responseText);
		  document.getElementById('crawlcount_all').innerHTML = data[0];
		  var url = "";
		  for (var i = 1; i < data.length ; i++) url = url + data[i] + "\r\n";
		  document.getElementById('crawlList_all').innerHTML = url;
	    }
	  };
	xmlhttp.open("GET","refresh/refreshAllCrawled.jsp?colId="+colId+"&crawlId="+crawlId,true);
	xmlhttp.send();
}

function refreshSession() {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var indicator = parseInt(xmlhttp.responseText);
		  if (indicator == 0) {
			  //window.alert('Session Expired');
		      window.top.location.href='../index.jsp';
		  }
	    }
	  };
	xmlhttp.open("GET","refresh/refreshSession.jsp",true);
	xmlhttp.send();
}

function refreshDetails(col, colId) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var data = JSON.parse(xmlhttp.responseText);
		  document.getElementById("colSize"+col).innerHTML = data[0];
		  document.getElementById("numdocs"+col).innerHTML = data[1];
		  document.getElementById("colVersion"+col).innerHTML = data[2];
		  document.getElementById("currentPear"+col).innerHTML = data[3];
	    }
	  };
	xmlhttp.open("GET","refresh/refreshDetails.jsp?colId="+colId,true);
	xmlhttp.send();
}

function refreshPear(colId, pearAutoRefresh) {
	refreshSession();
	var xmlhttp=new XMLHttpRequest();
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var data = xmlhttp.responseText.trim();
		  var dataParts = data.split(' ');
		  
		  var progressBar = $('#progress-bar-ed');
		  
		  var percentage = -1;
		  
		  try{
			  percentage = parseInt(dataParts[1]); 
		  }catch(err){
			  percentage = -1;
		  }
		  
		  if(percentage == 100){
			  document.getElementById('installButton').className = "btn_ed btn btn-default disabled";
			  document.getElementById('uninstallButton').className = "btn_ed btn btn-default disabled";
			  document.getElementById('progress-bar-ed-info').className = 'progress no-margin';
			  progressBar.css('width',  '100%');
		  }else if(percentage >= 0){
			  document.getElementById('installButton').className = "btn_ed btn btn-default disabled";
			  document.getElementById('uninstallButton').className = "btn_ed btn btn-default disabled";
			  document.getElementById('progress-bar-ed-info').className = 'progress no-margin progress-striped active';
			  document.getElementById('pearStatus').innerHTML = data + ' %, please wait..';
			  progressBar.css('width',  dataParts[1] + '%');
		  }else{
			  document.getElementById('installButton').className = "btn_ed btn btn-default";
			  document.getElementById('uninstallButton').className = "btn_ed btn btn-default";
			  document.getElementById('progress-bar-ed-info').className = 'progress no-margin';
			  document.getElementById('pearStatus').innerHTML = data;
			  progressBar.css('width',  '0%');
			  
			  try{
				  clearInterval(pearAutoRefresh);
			  }catch(err){}
		  }
	    }
	  };
	xmlhttp.open("GET","refresh/refreshPear.jsp?colId="+colId,true);
	xmlhttp.send();
}

function run_progress_crawler(col,con,state,colId,crawlId) {
	document.getElementById("button"+col+"_"+con).disabled = true;

	document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-spinner fa-spin";
	document.getElementById('buttonrun'+col+'_'+con).style.color = "black";
	refreshSession();
	var progressBar = $('#progress-bar-ed'+col+'_'+con);
	
	if(state == "not running"){
		document.getElementById('deletebutton'+col+'_'+con).className = "btn";
		document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin';
		document.getElementById('textrun'+col+'_'+con).innerHTML = 'not running';
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_crawler(col,con,'starting',colId,crawlId);
		};
		progressBar.css('width',  '0%');
		startCrawler(col, con, colId, crawlId);
		progressBar.css('width',  '50%');
	}else if(state == "starting"){
		document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
		document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
		document.getElementById('textrun'+col+'_'+con).innerHTML = 'starting';
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_crawler(col,con,'starting',colId,crawlId);
		};
		progressBar.css('width',  '50%');
	}else if(state == "running"){
		document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin progress-striped active';
		document.getElementById('textrun'+col+'_'+con).innerHTML = 'running';
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_crawler(col,con,'running',colId,crawlId);
		};
		progressBar.css('width',  '100%');
		stopCrawler(col, con, colId, crawlId);
		progressBar.css('width',  '50%');
	}else if(state == "stopping"){
		document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('textrun'+col+'_'+con).innerHTML = 'stopping';
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_crawler(col,con,'stopping',colId,crawlId);
		};
		progressBar.css('width', '50%');
	}
	document.getElementById("button"+col+"_"+con).disabled = false;
}

function run_progress_rebuilder(col,con,state,colId,crawlId) {
	document.getElementById("button"+col+"_"+con).disabled = true;

	document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-spinner fa-spin";
	document.getElementById('buttonrun'+col+'_'+con).style.color = "black";
	refreshSession();
	var progressBar = $('#progress-bar-ed'+col+'_'+con);

	if (state == "not running") {
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin progress-striped active';
		document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_rebuilder(col,con,'preparing states',colId,crawlId);
		};
		
		progressBar.css('width',  '10%');
		rebuildIndex(col,con,colId,crawlId);
		
		var offsetRandom = Math.floor((Math.random() * 5000) + 1000);
		var rebuilderAutoRefresh = setInterval(function () {
			if(document.getElementById('textrun'+col+'_'+con).innerHTML == "not running"){
				refreshRebuild(col,con,colId,"");
				clearInterval(rebuilderAutoRefresh);
			}
			//console.debug("refresh rebuilder --> colId:" + colId);
			refreshRebuild(col,con,colId,"");
		}, 5000 + offsetRandom);
	}else if (state == "preparing states") {
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin progress-striped active';
		document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_rebuilder(col,con,'preparing states',colId,crawlId);
		};
	}else if (state == "preparing run") {
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin';
		document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_rebuilder(col,con,'preparing run',colId,crawlId);
		};
	}else if (state == "rebuilding") {
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin progress-striped active';
		document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_crawler(col,con,'rebuilding',colId,crawlId);
		};
	}else if (state == "rebuilding done") {
		document.getElementById('buttonrun'+col+'_'+con).src = "images/start.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin';
		document.getElementById('textrun'+col+'_'+con).innerHTML = "done";
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_crawler(col,con,'not running',colId,crawlId);
		};
	}else {
		document.getElementById('buttonrun'+col+'_'+con).src = "images/start.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className 
			= 'progress no-margin';
		document.getElementById('textrun'+col+'_'+con).innerHTML = "error";
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_crawler(col,con,'error',colId,crawlId);
		};
		progressBar.css('width',  '0%');
	}
	document.getElementById("button"+col+"_"+con).disabled = false;
}

function run_progress_reloader(col,con,state,colId,crawlId) {
	document.getElementById("button"+col+"_"+con).disabled = true;

	document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-spinner fa-spin";
	document.getElementById('buttonrun'+col+'_'+con).style.color = "black";
	refreshSession();
	var progressBar = $('#progress-bar-ed'+col+'_'+con);
	
	if (state == "not running") {
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_reloader(col,con,'running',colId,crawlId);
		};
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
			'progress no-margin progress-striped active';
		document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
		progressBar.css('width',  '50%');
		
		reloadParse(col,con,colId,crawlId);
		
		var offsetRandom = Math.floor((Math.random() * 800) + 100);
		var reloaderAutoRefresh = setInterval(function () {
			if(document.getElementById('textrun'+col+'_'+con).innerHTML == "not running"){
				refreshReload(col,con,colId,"");
				clearInterval(reloaderAutoRefresh);
			}
			//console.debug("refresh reloader --> colId:" + colId);
			refreshReload(col,con,colId,"");
		}, 200 + offsetRandom);

		progressBar.css('width',  '100%');
	}else if(state == "running"){
		
	}
	document.getElementById("button"+col+"_"+con).disabled = false;
}

function run_progress_collection(col,con,state,colId,crawlId) {
	document.getElementById("button"+col+"_"+con).disabled = true;

	document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-spinner fa-spin";
	document.getElementById('buttonrun'+col+'_'+con).style.color = "black";
	refreshSession();
	if (state == "not running") {
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_reloader(col,con,'running',colId,crawlId);
		};
		document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
			'progress no-margin progress-striped active';
		startCollection(col,con,colId,"");
		
		var offsetRandom = Math.floor((Math.random() * 800) + 100);
		var collectionStatusAutoRefresh = setInterval(function () {
			if(document.getElementById('textrun'+col+'_'+con).innerHTML != "running"){
				refreshParse(col,con,colId,"");
				clearInterval(collectionStatusAutoRefresh);
			}
			//console.debug("refresh indexer --> colId:" + colId);
			refreshParse(col,con,colId,"");
		}, 200 + offsetRandom);
	}else if(state == "running"){
		document.getElementById("button"+col+"_"+con).onclick = function() {
			run_progress_reloader(col,con,'not running',colId,crawlId);
		};
		document.getElementById('buttonrun'+col+'_'+con).src = "images/run.png";
		document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
			'progress no-margin';
		stopCollection(col,con,colId,"");
		
		var offsetRandom = Math.floor((Math.random() * 800) + 100);
		var collectionStatusAutoRefresh = setInterval(function () {
			if(document.getElementById('textrun'+col+'_'+con).innerHTML != "not running"){
				refreshParse(col,con,colId,"");
				clearInterval(collectionStatusAutoRefresh);
			}
			//console.debug("refresh indexer --> colId:" + colId);
			refreshParse(col,con,colId,"");
		}, 200 + offsetRandom);
		document.getElementById("button"+col+"_"+con).disabled = false;
	}
}