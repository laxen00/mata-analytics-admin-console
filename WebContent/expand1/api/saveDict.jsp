<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="
apiRequest.*,
org.json.JSONObject,
org.json.JSONArray
" %>

<jsp:include page="../etc/header.jsp"/>
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

	String jsonString = request.getParameter("json");
	JSONObject obj = new JSONObject(jsonString);
	String colId = obj.getString("colId");
	String dictName = obj.getString("dictName");
	JSONArray keywords = obj.getJSONArray("keywords");
	
	String openarg = "{";
	String argproperties = "\"custom\": ";
	String closearg = "}";
	String keystart = "[";
	String keyprop = "";
	String keyend = "]";
	
	for (int i = 0; i < keywords.length(); i++) {
		if (keywords.get(i).equals("Insert keyword here") || keywords.get(i).equals("insert keyword here")) continue;
		keyprop = keyprop + "{\"dictionary\":\"" + keywords.get(i) + "\"}";
		if (i != (keywords.length() - 1)) keyprop = keyprop + ",";
	}
	
	String keyargs = keystart + keyprop + keyend;
		
	String args = openarg + argproperties + keyargs + closearg;
	// System.out.println(args);
	
	String hostname = request.getServerName();
// 	JSONArray dictList = new DictRequest(hostname).getDicts(colId, token);
// 	int checker = 0;
// 	for (int i = 0; i < dictList.length(); i++) {
// 		if (dictList.getString(i).equals(dictName)) { checker = 1; break; }
// 	}
	
// 	if (checker == 0) {
// 		String[] create = new DictRequest(hostname).createDict(colId, dictName, args, token);
// 		if (!create[0].equalsIgnoreCase("0")) session.setAttribute("createMessage", create[1]);
// 	}
// 	else {
		JSONObject edit = new DictRequest(hostname).editDict(colId, dictName, args, token);
		if (!edit.getString("value").equalsIgnoreCase("0")) session.setAttribute("editMessage", edit.getString("message"));
// 	}
	
// 	String redirectURL = "../user_dict.jsp?colId="+colId;
// 	response.sendRedirect(redirectURL);
%>