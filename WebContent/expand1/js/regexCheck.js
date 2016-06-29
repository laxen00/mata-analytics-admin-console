function regexCheck() {
	var xmlhttp=new XMLHttpRequest();
	var follow = document.getElementById("linktofollow").value;
	var forbid = document.getElementById("linktoforbid").value;
	var test = document.getElementById("urlregextest").value;
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  document.getElementById("table_test").innerHTML = xmlhttp.responseText;
	    }
	  }
	xmlhttp.open("GET","etc/regexCheck.jsp?linktofollow="+follow+"&linktoforbid="+forbid+"&urlregextest="+test,true);
	xmlhttp.send();
}