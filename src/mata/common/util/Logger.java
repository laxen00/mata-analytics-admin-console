package mata.common.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Logger {
	private String projectPath = null;
	
	public Logger(String logDir)
	{
		//projectPath = System.getProperty("user.dir");
		projectPath = logDir + "\\social-media.log";
	}
	
	public Logger()
	{
		projectPath = System.getProperty("user.dir");
		projectPath = projectPath + "\\social-media.log";
	}
	
	public void writeLog(String trace){
		checkFileSize();
		try {
			FileWriter fw = new FileWriter(projectPath,true);
			fw.append("(" + getCurrentDateTime() + ") " + trace);
			fw.append("\n");
			fw.close();
		} catch (IOException e) {}
	}
	
	public void writeStackTrace(Exception exc){
		checkFileSize();
		StringWriter stackTrace = new StringWriter();
		exc.printStackTrace(new PrintWriter(stackTrace));
		
		try {
			FileWriter fw = new FileWriter(projectPath,true);
			fw.append("(" + getCurrentDateTime() + ") " + stackTrace.toString());
			fw.append("\n");
			fw.close();
		} catch (IOException e) {}
	}
	
	private String getCurrentDateTime(){
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		return dateFormat.format(date);
	}
	
	private void checkFileSize(){
		File logFile = new File(projectPath);
		if(logFile.isFile()){
			double size = logFile.length() / 1024; //KB
			//System.out.print(Double.toString(size));
			if(size > 1000){
				delete(logFile);
			}
		}
	}
	
	public void delete(File file){
		 
		if(file.isDirectory()){
    		//directory is empty, then delete it
    		if(file.list().length==0){
    		   file.delete();
    		}else{
    		   //list all the directory contents
        	   String files[] = file.list();
 
        	   for (String temp : files) {
        	      //construct the file structure
        	      File fileDelete = new File(file, temp);
        	      //recursive delete
        	      delete(fileDelete);
        	   }
 
        	   //check the directory again, if empty then delete it
        	   if(file.list().length==0){
           	     file.delete();
        	   }
    		}
    	}else{
    		//if file, then delete it
    		file.delete();
    	}
    }
}
