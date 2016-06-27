package mata.html.parser;

import java.io.IOException;
import java.util.ArrayList;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class JsoupParser {
	
	public JsoupParser(){
		
	}
	
	public Document getDoc(String dataInput, boolean fromWeb){
		
		Document doc = null;
		if(fromWeb){
			try {
				doc = Jsoup.connect(dataInput).timeout(60000).userAgent("CHROME").get();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else{
			doc = Jsoup.parse(dataInput);			
		}
		
		return doc;
	}

	public ArrayList<String> getBlocksContent(Document doc, String cssQuery){
		
		Elements elements = doc.select(cssQuery);
		ArrayList<String> listBlocksContent = new ArrayList<String>();
		
		for(Element element : elements){
			listBlocksContent.add(element.html());
		}
		return listBlocksContent;	
	}
}
