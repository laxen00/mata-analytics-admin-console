function startCrawler(col, con, colId, crawlerId) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  	var progressBar = $('#progress-bar-ed'+col+'_'+con);
		  	progressBar.css('width',  '100%');
		  	document.getElementById("button"+col+"_"+con).onclick = function() {
		  		run_progress_crawler(col,con,'running',colId,crawlerId);
			};
		  	document.getElementById('deletebutton'+col+'_'+con).className = "btn disabled";
			document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-stop";
			document.getElementById('buttonrun'+col+'_'+con).style.color = "red";
			document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
			document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
				'progress no-margin progress-striped active';
			getOverallState(col, colId);
	    }
	  };
	xmlhttp.open("GET","api/startCrawler.jsp?colId="+colId+"&crawlerId="+crawlerId,true);
	xmlhttp.send();
}

function stopCrawler(col, con, colId, crawlerId) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  	var progressBar = $('#progress-bar-ed'+col+'_'+con);
			progressBar.css('width',  '0%');
			document.getElementById("button"+col+"_"+con).onclick = function() {
				run_progress_crawler(col,con,'not running',colId,crawlerId);
			};
			document.getElementById('deletebutton'+col+'_'+con).className = "btn";
			document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-play";
			document.getElementById('buttonrun'+col+'_'+con).style.color = "green";
			document.getElementById('textrun'+col+'_'+con).innerHTML = "not running";
			document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
				'progress no-margin';
			getOverallState(col, colId);
	    }
	  };
	xmlhttp.open("GET","api/stopCrawler.jsp?colId="+colId+"&crawlerId="+crawlerId,true);
	xmlhttp.send();
}

function startAll(colId) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function(){
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
	    	return xmlhttp.responseText;
	    }
	};
	xmlhttp.open("GET","api/startAll.jsp?colId="+colId,true);
	xmlhttp.send();
}

function stopAll(colId) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function(){
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			return xmlhttp.responseText;
	    }
	};
	xmlhttp.open("GET","api/stopAll.jsp?colId="+colId,true);
	xmlhttp.send();
}

function getOverallState(col, colId) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var state = parseInt(xmlhttp.responseText);
		  if (state == 1) {
			  document.getElementById("crawl_indicator"+col).src = "images/active1.png";
		  }
		  else {
			  document.getElementById("crawl_indicator"+col).src = "images/noactive1.png";
		  }
	    }
	  };
	xmlhttp.open("GET","api/getStateCollection.jsp?colId="+colId,true);
	xmlhttp.send();
}

function getState(colId, crawlId) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  return xmlhttp.responseText;
	    }
	  };
	xmlhttp.open("GET","api/getState.jsp?colId="+colId+"&crawlId="+crawlId,true);
	xmlhttp.send();
}

function startCollection(col, con, colId, unused) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var progressBar = $('#progress-bar-ed'+col+'_'+con);
			progressBar.css('width',  '100%');
			document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-stop";
			document.getElementById('buttonrun'+col+'_'+con).style.color = "red";
			document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
			document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 'progress no-margin progress-striped active';
			document.getElementById('index_indicator'+col).src = "images/active1.png";
			document.getElementById("button"+col+"_"+con).onclick = function() {
				run_progress_collection(col,con,'running',colId, unused);
			};
			
			var data = JSON.parse(xmlhttp.responseText);
			document.getElementById('colSize'+col).src = data[0];
			document.getElementById('numdocs'+col).src = data[1];
			document.getElementById('colVersion'+col).src = data[2];
	    }
	  };
	xmlhttp.open("GET","api/startCollection.jsp?colId="+colId,true);
	xmlhttp.send();
}

function stopCollection(col, con, colId, unused) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function(){
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
		  	var progressBar = $('#progress-bar-ed'+col+'_'+con);
		  	progressBar.css('width',  '0%');
			document.getElementById("button"+col+"_"+con).onclick = function() {
				run_progress_collection(col,con,'not running',colId, unused);
			};
			document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-play";
			document.getElementById('buttonrun'+col+'_'+con).style.color = "green";
			document.getElementById('textrun'+col+'_'+con).innerHTML = "not running";
			document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 'progress no-margin';
			document.getElementById('index_indicator'+col).src = "images/noactive1.png";
			document.getElementById('colSize'+col).src = "";
			document.getElementById('numdocs'+col).src = "";
			document.getElementById('colVersion'+col).src = "";
		}
	};
	xmlhttp.open("GET","api/stopCollection.jsp?colId="+colId,true);
	xmlhttp.send();
}

function rebuildIndex(col, con, colId, crawlLength) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			/*var progressBar = $('#progress-bar-ed'+col+'_'+con);
			progressBar.css('width',  '20%');
			document.getElementById("button"+col+"_"+con).onclick = function() {
				run_progress_rebuilder(col,con,'preparing states',colId, unused);
			};
			document.getElementById('buttonrun'+col+'_'+con).src = "images/stop.png";
			document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
			document.getElementById('textrun'+col+'_'+con).innerHTML = "running";
			document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
				'progress no-margin progress-striped active';*/
	    }
	  };
	xmlhttp.open("GET","api/rebuildIndex.jsp?colId="+colId,true);
	xmlhttp.send();
}

function reloadParse(col, con, colId, unused) {
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
			var progressBar = $('#progress-bar-ed'+col+'_'+con);
			progressBar.css('width',  '0%');
			document.getElementById("button"+col+"_"+con).onclick = function() {
				run_progress_reloader(col,con,'not running',colId, unused);
			};
			document.getElementById('buttonrun'+col+'_'+con).className = "fa fa-play";
			document.getElementById('buttonrun'+col+'_'+con).style.color = "green";
			document.getElementById('button'+col+'_'+con).classname = "btn btn-default";
			document.getElementById('textrun'+col+'_'+con).innerHTML = "not running";
			document.getElementById('progress-bar-ed-info'+col+'_'+con).className = 
				'progress no-margin';
	  }
	};
	xmlhttp.open("GET","api/reloadParse.jsp?colId="+colId,true);
	xmlhttp.send();
}

/*function installPear(colId, pearname) {
	var xmlhttp=new XMLHttpRequest();
	
	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
			var progressBar = $('#progress-bar-ed');
			progressBar.css('width',  '0%');
			document.getElementById('progress-bar-ed-info').className = 'progress no-margin';
			document.getElementById('installButton').classname = "btn_ed btn btn-default";
	  }
	};
	
	xmlhttp.open("GET","api/installPear.jsp?colId="+colId+"&pearname="+pearname,true);
	xmlhttp.send();
}*/