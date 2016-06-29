package checker;

import java.text.Normalizer;
//import java.text.SimpleDateFormat;
import java.util.ArrayList;
//import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import mata.common.util.Formatter;
import mata.html.parser.JsoupParser;

public class JsoupChecker {

	//public static String publishdate="";
	
	static JsoupParser jp = new JsoupParser();
	static String url;
	static Document doc;
	static String type;
	static String pattern;
	static String replace;
	static String format;
	static String attribute;
	static String data = "";
	
	public static String viewJsoupSource (String url_input) {
		url = url_input;
		doc = jp.getDoc(url, true);
//		System.out.println(doc);
		return doc.html();
	}
	
	public static String checker(String url_input, String type_input, String pattern_input, String replace_input, String format_input, String attribute_input) {
		
		//test purpose
//		url = "http://forum.kompas.com/megapolitan/311176-basuki-saya-enggak-suka-ada-kolom-agama-bodo-amat.html";
//		type = "content";
//		pattern = "div.postdetails>div.postbody>div.postrow>div.content>div>blockquote.postcontent.restore";
		
		//with args
		url = url_input;
		type = type_input;
		pattern = pattern_input;
		format = format_input;
		replace = replace_input;
		attribute = attribute_input;
		
		doc = jp.getDoc(url, true);
		
		//int testNum = 0;
		
		if (type.equalsIgnoreCase("header")) data = getHeader();
		if (type.equalsIgnoreCase("user")) {
			ArrayList<String> user_list = getUsers();
			String user_data = "";
			int count = 1;
			for (String users : user_list){
				user_data = user_data + count + ". " + users + "<br />";
				count++;
			}
			data = user_data;
		}
		if (type.equalsIgnoreCase("content")) {
			ArrayList<String> content_list = getPostContents();
			String content_data = "";
			int count = 1;
			for (String contents : content_list){
				content_data = content_data + count + ". " + contents + "<br /><br />";
				count++;
			}
			data = content_data;
		}
		if (type.equalsIgnoreCase("date")) {
			ArrayList<String> date_list = getDates();
			String date_data = "";
			int count = 1;
			for (String dates : date_list){
				date_data = date_data + count + ". " + dates + "<br />";
				count++;
			}
			data = date_data;
		}
		if (type.equalsIgnoreCase("postid")) {
			ArrayList<String> id_list = getPostId();
			String id_data = "";
			int count = 1;
			for (String ids : id_list){
				id_data = id_data + count + ". " + ids + "<br />";
				count++;
			}
			data = id_data;
		}
		return(data);
		
	}

	private static String getHeader(){
		ArrayList<String> arraysHeader = jp.getBlocksContent(doc, pattern);
		Document header = jp.getDoc(arraysHeader.get(0), false);
		String headerString = header.text();
		headerString = headerString.replaceAll(replace, "");
		
		return headerString;
	}
	
	public static ArrayList<String> getPostContents(){
		ArrayList<String> arrays = new ArrayList<String>();
		ArrayList<String> finalContent = new ArrayList<String>();
		arrays = jp.getBlocksContent(doc, pattern);
//		for (String array : arrays) System.out.println(array);
//		System.out.println(doc.text());
		try{
			for(String array : arrays){
				Document docs = jp.getDoc(array, false);
				String content = docs.text().replaceAll(replace, "");
				finalContent.add(content);
			}
		}
		catch(Exception e){
//			e.printStackTrace();
//			logger.writeStackTrace(e);
		}
		
		return finalContent;
	}
	
	public static ArrayList<String> getUsers(){
		ArrayList<String> arraysUser = new ArrayList<String>();
		ArrayList<String> finalUser = new ArrayList<String>();
		arraysUser = jp.getBlocksContent(doc, pattern);
		
		try{
			for(String array : arraysUser){
				Document docs = jp.getDoc(array, false);
				String user = docs.text().replaceAll(replace, "");
				finalUser.add(user);
			}
		}
		catch(Exception e){
//			logger.writeStackTrace(e);
		}
		return finalUser;
	}
	
	public static ArrayList<String> getPostId(){
		ArrayList<String> arrays = new ArrayList<String>();
		ArrayList<String> finalID = new ArrayList<String>();
		arrays = jp.getBlocksContent(doc, pattern);
		
		try{
			for(String array : arrays){
				Document docs = jp.getDoc(array, false);
				Pattern p = Pattern.compile(format);
				Matcher m = p.matcher(docs.html());
				while(m.find()){
					String id = m.group();
					id = id.replaceAll(replace, "");
					finalID.add(url + "#" + id);
				}
			}
		}
		catch(Exception e){
//			logger.writeStackTrace(e);
		}
		return finalID;
	}
	
	public static ArrayList<String> getDates(){
		ArrayList<String> arrays = new ArrayList<String>();
		ArrayList<String> finalDate = new ArrayList<String>();
		arrays = jp.getBlocksContent(doc, pattern);
		try{
			if(!attribute.equals("")){
				try{
					finalDate = new ArrayList<String>();
					Elements elements = doc.select(pattern);
			    	for(Element element:elements){
			    		String date = element.attr(attribute).replaceAll(replace, "");
			    		String date2 = Normalizer.normalize(date, Normalizer.Form.NFD).replaceAll("[^a-zA-Z0-9-+.^:,/]", "");
			    		if(date2.length()>3){
							Formatter fm = new Formatter();
							String date3 = fm .dateFormat(fm.dateConverter(date2.trim()), format, "MM/dd/yy HH:mm");
							finalDate.add(date+" --> "+date2+" --> "+date3);
//							finalDate.add(date);
						}
			    	}
				}
				catch(Exception e1){
					
				}
			}
			else{
				for(String array : arrays){
					Document docs = jp.getDoc(array, false);
					String date = docs.text().replaceAll(replace, "");
					date = Normalizer.normalize(date, Normalizer.Form.NFD).replaceAll("[^a-zA-Z0-9-+.^:,/]", "");
	//				date = "9Sep2014";
	//				System.out.println(date);
					if(date.length()>3){
						Formatter fm = new Formatter();
						date = fm.dateFormat(fm.dateConverter(date.trim()), format, "MM/dd/yy HH:mm");
	//					System.out.println(date);
						finalDate.add(date);
					}
					
				}
			}
		}
		catch(Exception e){

		}
		return finalDate;
	}
	
}