package mata.common.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlParser {

	public Node childNode = null;
	Document doc = null;
	
	public XmlParser(String fileLoc){
		
		try{
		    File fXmlFile = new File(fileLoc);
		    DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		    DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		    doc = dBuilder.parse(fXmlFile);
		    doc.getDocumentElement().normalize();
		}
		catch(Exception e){
			
		}
		
	}
	
	public ArrayList<String> xmlReadFirstTag(){
		
		ArrayList<String> outputList = new ArrayList<String>();		
		try {
		    Element docEl = doc.getDocumentElement();       
		    childNode = docEl.getFirstChild();   
		    
		    while( childNode.getNextSibling()!=null ){          
		        childNode = childNode.getNextSibling();         
		        if (childNode.getNodeType() == Node.ELEMENT_NODE) {         
		            Element childElement = (Element) childNode;             
//		            System.out.println("attr name : " + childElement.getNodeName());
		            outputList.add(childElement.getNodeName());
		        }       
		    }

		} catch (Exception e) {
			System.out.println("ERROR:- " + e.toString() + "<br/>\n");
		}
		
		return outputList;
	}
	
    public Map<String,ArrayList<String>> getLastChildElement(String tag)
    {
    	ArrayList<String> outputList = new ArrayList<String>();
    	ArrayList<String> outputNode = new ArrayList<String>();	
		try {
			Node parent = doc.getElementsByTagName(tag).item(0);
		    NodeList list = parent.getChildNodes();
//		    System.out.println(list.getLength());
		    for(int x = 0; x < list.getLength(); x++){
		    	if(!list.item(x).getNodeName().contains("#")){
//		    		System.out.println(list.item(x).getNodeName());
//		    		System.out.println(list.item(x).getTextContent());
		    		outputList.add(list.item(x).getTextContent());
		    		outputNode.add(list.item(x).getNodeName());
		    	}
		    }
		    
		    
		}
		
		catch(Exception e){
			
		}
		
		Map<String,ArrayList<String>> map =new HashMap<String, ArrayList<String>>();
		map.put("node",outputNode);
		map.put("value",outputList);
		
		return map;
    }    
}

	
