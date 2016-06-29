package mata.common.util;

import java.io.File;

public class Logs {

	FileManager fm = null;
	String logDir = null;
	Formatter format = null;
	
	public Logs(String logdir){
		
		logDir = logdir;
		fm = new FileManager();
		format = new Formatter();
		fm.createDir(logDir);
		
	}
	
	public void writeLogs(String log){
		
		String timeStamp = Formatter.getCurrentTime("dd/MM/yy HH:mm");
		
		deleteLogs();
		fm.fileWriter(logDir+"\\infolog.txt", timeStamp+"  "+log, true);
		
	}
	
	public void deleteLogs(){
		
		File file = new File(logDir+"\\infolog.txt");
		
		if(file.exists()){
			if(fm.checkFileSize(logDir+"\\infolog.txt")>4.0){
				file.delete();
			}
		}
		
	}

}
