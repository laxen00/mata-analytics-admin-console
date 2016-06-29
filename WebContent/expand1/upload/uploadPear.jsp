<%@ page import=" org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="apiRequest.*" %>

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
	String colId = "";
	try {
	colId = session.getAttribute("colId").toString();
	}
	catch (Exception e) {
	colId = "";
	}
	
	// Check that we have a file upload request
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	// System.out.println("isMultiPart: " + isMultipart);
	
	if (isMultipart) {
		//Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		//Configure a repository (to ensure a secure temp location is used)
		ServletContext servletContext = this.getServletConfig().getServletContext();
		File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
		factory.setRepository(repository);
		
		//Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		//Parse the request
		List<FileItem> items = upload.parseRequest(request);
		
		for (FileItem item : items) {
			// System.out.println("Filename: " + items.get(0).getName());
			// Process a file upload
			
			String hostname = request.getServerName();
			String colLocation = new CollectionRequest(hostname).getLocationCollection(colId, token);
			File dir = new File(colLocation);
			if (!dir.exists()) {
				dir.mkdirs();
			}
		    File uploadedFile = new File(dir.getAbsoluteFile() + "\\" + item.getName());
		    item.write(uploadedFile);
		}
		
		out.print("File uploaded successfully.");
	}
	
	try {
	    Thread.sleep(2000);                 //1000 milliseconds is one second.
	} catch(InterruptedException ex) {
	    Thread.currentThread().interrupt();
	}
	
	String redirectURL = "../annotators.jsp";
    response.sendRedirect(redirectURL);
%>