<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.regex.Matcher, java.util.regex.Pattern, java.util.ArrayList, org.json.*" %>
<%
	String follows = request.getParameter("linktofollow").toString();
	String forbids = request.getParameter("linktoforbid").toString();
	String[] tests = request.getParameter("urlregextest").toString().split("\\|");
	// System.out.println(follows);
	// System.out.println(forbids);
// 	for (String t : tests) // System.out.println(t);
	String[][] result = null;
	String[] resultPair = null;
	ArrayList<String> resultPairList = new ArrayList<String>();
	ArrayList<String[]> resultList = new ArrayList<String[]>();
	
	for (String test : tests) {
		Pattern p;
		Matcher m;
		int allow = 1;
		if (!follows.isEmpty()) {
			p = Pattern.compile(follows);
			m = p.matcher(test);
			if(!m.find()){
				// System.out.println("Allow check false");
				allow = 0;
			}
			else allow = 1;
			// System.out.println("Allow check true");
		}
		
		

		if (!forbids.isEmpty()) {
			p = Pattern.compile(forbids);
			m = p.matcher(test);
			if(m.find()){
				allow = 0;
				// System.out.println("Forbid check true");
			}
			else allow = 1;
			// System.out.println("Forbid check false");
		}
		
		
		resultPairList.add(test);
		resultPairList.add(Integer.toString(allow));
		resultPair = resultPairList.toArray(new String[resultPairList.size()]);
		resultList.add(resultPair);
		resultPairList.clear();
	}
	
	String newString = "<table><tr><th style=\"width:85%\">URL</th><th style=\"width:15%\">Allow</th></tr>";
	result = resultList.toArray(new String[resultList.size()][]);
	for (int i=0; i<result.length; i++) {
		// System.out.println(result[i][0] + "\t" + result[i][1]);
		String imgsrc = "";
		int allowcheck = Integer.parseInt(result[i][1]);
		if (allowcheck == 1) imgsrc = "images/active1.png";
		else imgsrc = "images/forbid.png";
		
		String row = "<tr><td>"+result[i][0]+"</td><td align=\'center\'><img src=\'"+imgsrc+"\' width=\'12px\' height=\'12px\'></td></tr>";
		// System.out.println(row);
		newString = newString + row;
	}
	newString = newString + "</table>";
	// System.out.println(newString);
	out.print(newString);
%>