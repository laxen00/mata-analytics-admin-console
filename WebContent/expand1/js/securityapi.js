function generateToken() {
	var xmlhttp=new XMLHttpRequest();
	
	var type = document.getElementById('type').value;
	var apiKey = document.getElementById('apiKey').value;
	var secretKey = document.getElementById('secretKey').value;
	if (type == 'youtube') document.getElementById('secretKey').value = apiKey;
	var pathUrl = "api/generateAccessToken.jsp?type=" + type + "&apiKey=" + apiKey + "&secretKey="
		+ secretKey;
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  document.getElementById('accessToken').value = xmlhttp.responseText.trim();
		  
		  if(xmlhttp.responseText != null && xmlhttp.responseText != ""){
			  document.getElementById('finishButton').className = "btn btn-default";
		  }
	    }
	  };
	xmlhttp.open("GET", pathUrl, true);
	xmlhttp.send();
}

