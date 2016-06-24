package mata.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Formatter {

	public Formatter(){
		
	}
	
	public String dateFormat(String inputDate, String inputFormat, String outputFormat)
	{        
        String dateName = "";
	    try
	    {
	       dateName = (new SimpleDateFormat(outputFormat)).format((new SimpleDateFormat(inputFormat)).parse(inputDate));
	    }
	    catch(ParseException parseexception) { }
	       return dateName;
	}
	
	public String AsciiToBinary(String asciiString){  
        
        byte[] bytes = asciiString.getBytes();  
        StringBuilder binary = new StringBuilder();  
        for (byte b : bytes)  
        {  
           int val = b;  
           for (int i = 0; i < 8; i++)  
           {  
              binary.append((val & 128) == 0 ? 0 : 1);  
              val <<= 1;  
           }  
          // binary.append(' ');  
        }  
        return binary.toString();  
  } 
	
	public String toCamelCase(String s){
		   String[] parts = s.split(" ");
		   String camelCaseString = "";
		   for (String part : parts){
		      camelCaseString = camelCaseString + toProperCase(part)+" ";
		   }
		   return camelCaseString;
		}

	public  String toProperCase(String s) {
		    return s.substring(0, 1).toUpperCase() +
		               s.substring(1).toLowerCase();
		}
	
	public String removeLastChar(String str) {
     return str.substring(0,str.length()-1);
 }
	
	public static double round(double value, int places) {
	    if (places < 0) throw new IllegalArgumentException();

	    long factor = (long) Math.pow(10, places);
	    value = value * factor;
	    long tmp = Math.round(value);
	    return (double) tmp / factor;
	}
	
	public String dateConverter(String inputString){
		inputString = inputString.toLowerCase();
		
//		Pattern p = Pattern.compile("[0-9]{1,2}[a-zA-Z]{1,}");
//		inputString = dateParsingFirst(inputString);
		inputString = dateStringParser(inputString);
		
		inputString = inputString.replaceAll("1st", "1");
		inputString = inputString.replaceAll("2nd", "2");
		inputString = inputString.replaceAll("3rd", "3");
		inputString = inputString.replaceAll("4th", "4");
		inputString = inputString.replaceAll("5th", "5");
		inputString = inputString.replaceAll("6th", "6");
		inputString = inputString.replaceAll("7th", "7");
		inputString = inputString.replaceAll("8th", "8");
		inputString = inputString.replaceAll("9th", "9");
		inputString = inputString.replaceAll("0th", "0");

		inputString = inputString.replaceAll("updated: ", "");
		inputString = inputString.replaceAll("&nbsp;", "");
		inputString = inputString.replaceAll("waktu", "");
		inputString = inputString.replaceAll("gmt", "");
		inputString = inputString.replaceAll("wib", "");
		inputString = inputString.replaceAll("wita", "");
		inputString = inputString.replaceAll("wit", "");
		
		inputString = inputString.replaceAll("senin", "Monday");
		inputString = inputString.replaceAll("selasa", "Tuesday");
		inputString = inputString.replaceAll("rabu", "Wednesday");
		inputString = inputString.replaceAll("kamis", "Thursday");
		inputString = inputString.replaceAll("jumat", "Friday");
		inputString = inputString.replaceAll("jum'at", "Friday");
		inputString = inputString.replaceAll("sabtu", "Saturday");
		inputString = inputString.replaceAll("minggu", "Sunday");
		inputString = inputString.replaceAll("januari", "January");
		inputString = inputString.replaceAll("februari", "February");
		inputString = inputString.replaceAll("pebruari", "February");
		inputString = inputString.replaceAll("maret", "March");
		inputString = inputString.replaceAll("april", "April");
		inputString = inputString.replaceAll("mei", "May");
		inputString = inputString.replaceAll("juni", "June");
		inputString = inputString.replaceAll("juli", "July");
		inputString = inputString.replaceAll("agustus", "August");
		inputString = inputString.replaceAll("september", "September");
		inputString = inputString.replaceAll("oktober", "October");
		inputString = inputString.replaceAll("nopember", "November");
		inputString = inputString.replaceAll("desember", "December");
		inputString = inputString.replaceAll("des", "Dec");
		inputString = inputString.replaceAll("nop", "Nov");
		inputString = inputString.replaceAll("agu", "Aug");
		inputString = inputString.replaceAll("okt", "Oct");
		
		return inputString;
	}
	
	public String dateParsingFirst(String input){
		
		String regex  = "[0-9]{1,2}[a-zA-Z]{1,}";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(input);
		ArrayList<String> parts = new ArrayList<String>();
		
		while(m.find()){
			String part = m.group();
//			System.out.println(part);
			parts.add(part);
		}
		
		for(String part : parts){
			String[] inputParts = input.split(part);
			String partParse = part.replaceAll("[a-zA-Z]{1,}", "");
			if(inputParts.length<2){
				input = inputParts[0]+partParse;
			}
			else{
				input = inputParts[0]+partParse+inputParts[1];
			}
//			System.out.println(input);
		}
		
		return input;
	}
	
	public static String normalizeToXML(String input){
		input = input.replace("\"", "&quot;");
		input = input.replace("'", "&apos;");
		input = input.replace("<", "&lt;");
		input = input.replace(">", "&gt;");
		input = input.replace("&", "&amp;");
		
		return input;
	}
	
	public static String normalizeFromXML(String input){
		input = input.replace("&quot;", "\"");
		input = input.replace("&apos;", "'");
		input = input.replace("&lt;", "<");
		input = input.replace("&gt;", ">");
		input = input.replace("&amp;", "&");
		
		return input;
	}
	
	public static String getCurrentTime(String formatoutput){
		
		String timeStamp = new SimpleDateFormat(formatoutput).format(Calendar.getInstance().getTime());
		
		return timeStamp;
	}
	
	public String dateStringParser(String input){
		
		if(input.toLowerCase().contains("today")){
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date date = new Date();
			input = input.toLowerCase().replace("today", dateFormat.format(date));
		}
		
		else if(input.toLowerCase().contains("yesterday")){
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        Calendar cal = Calendar.getInstance();
	        cal.add(Calendar.DATE, -1);    
	        input = input.toLowerCase().replace("yesterday", dateFormat.format(cal.getTime()));
		}
		
		else{
			
		}
		
		return input;
		
	}
}
