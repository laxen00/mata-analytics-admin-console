package apiRequest;

import httpProcess.HttpProcess;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.json.JSONArray;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class DictRequest {
	private String hostname = "max.mataprima.com";
	private static final String PROTOCOL = "http://";
	private static final String PORT = ":8081";
	private final static boolean DEBUG = true;

	public DictRequest(String hostname){
		if(!DEBUG)
			this.hostname = hostname;
	}
	
	public JSONArray getDicts(String colId, String token) {
		JSONArray result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=getListCustomDictionary&collectionId="+colId+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.getData(url);
			// System.out.println(data);
			InputSource is = new InputSource(new StringReader(data));
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			Document doc = docBuilder.parse(is);
			
			XPathFactory xpathFactory = XPathFactory.newInstance();
			// XPath to find empty text nodes.
			XPathExpression xpathExp = xpathFactory.newXPath().compile(
			    	"//text()[normalize-space(.) = '']");  
			NodeList emptyTextNodes = (NodeList) 
			        xpathExp.evaluate(doc, XPathConstants.NODESET);
			// Remove each empty text node from document.
			for (int i = 0; i < emptyTextNodes.getLength(); i++) {
			    Node emptyTextNode = emptyTextNodes.item(i);
			    emptyTextNode.getParentNode().removeChild(emptyTextNode);
			}
			
			Node firstChild = doc.getFirstChild();
			NodeList list = firstChild.getChildNodes();
			
			List<String> dictPropertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
					if (list.item(i).getNodeName().equals("field")) {
						String entry = list.item(i).getTextContent().trim();
						entry = entry.replaceAll("customdict_", "");
						dictPropertyList.add(entry);
						continue;
					}
			}
		
			String[] dictsArr = dictPropertyList.toArray(new String[dictPropertyList.size()]);
			result = new JSONArray(dictsArr);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public JSONArray getKeywords(String colId, String dictName, String token) {
		JSONArray result = null;
		dictName = "customdict_" + dictName;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=getSpecificCustomDictionary&collectionId="+colId+"&name="+dictName+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.getData(url);
			// System.out.println(data);
			InputSource is = new InputSource(new StringReader(data));
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			Document doc = docBuilder.parse(is);
			
			XPathFactory xpathFactory = XPathFactory.newInstance();
			// XPath to find empty text nodes.
			XPathExpression xpathExp = xpathFactory.newXPath().compile(
			    	"//text()[normalize-space(.) = '']");  
			NodeList emptyTextNodes = (NodeList) 
			        xpathExp.evaluate(doc, XPathConstants.NODESET);
			// Remove each empty text node from document.
			for (int i = 0; i < emptyTextNodes.getLength(); i++) {
			    Node emptyTextNode = emptyTextNodes.item(i);
			    emptyTextNode.getParentNode().removeChild(emptyTextNode);
			}
			
			Node firstChild = doc.getFirstChild();
			NodeList list = firstChild.getChildNodes();
			
			List<String> dictPropertyList = new ArrayList<String>();
			
			if (list.getLength() > 0) {
				for (int i=0;i<list.getLength();i++) {
						if (list.item(i).getNodeName().equals("field")) {
							String entry = list.item(i).getTextContent().trim();
							entry = entry.replaceAll("customdict_", "");
							dictPropertyList.add(entry);
							continue;
						}
				}
			}
			else {
				String entry = "";
				dictPropertyList.add(entry);
			}
		
			String[] dictsArr = dictPropertyList.toArray(new String[dictPropertyList.size()]);
			result = new JSONArray(dictsArr);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public JSONObject createDict(String colId, String dictName, String args, String token) {
		JSONObject result = new JSONObject();
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=addCustomDictionary&collectionId="+colId+"&name="+dictName+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.httpPostWithBody(url, args);
			// System.out.println(data);
			InputSource is = new InputSource(new StringReader(data));
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			Document doc = docBuilder.parse(is);
			
			XPathFactory xpathFactory = XPathFactory.newInstance();
			// XPath to find empty text nodes.
			XPathExpression xpathExp = xpathFactory.newXPath().compile(
			    	"//text()[normalize-space(.) = '']");  
			NodeList emptyTextNodes = (NodeList) 
			        xpathExp.evaluate(doc, XPathConstants.NODESET);
			// Remove each empty text node from document.
			for (int i = 0; i < emptyTextNodes.getLength(); i++) {
			    Node emptyTextNode = emptyTextNodes.item(i);
			    emptyTextNode.getParentNode().removeChild(emptyTextNode);
			}
			
			Node firstChild = doc.getFirstChild();
			NodeList list = firstChild.getChildNodes();
			
//			List<String> dictPropertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
					if (list.item(i).getNodeName().equals("value")) {
//						dictPropertyList.add(0,list.item(i).getTextContent());
						result.put("value", list.item(i).getTextContent());
						continue;
					}
					if (list.item(i).getNodeName().equals("message")) {
//						dictPropertyList.add(1,list.item(i).getTextContent());
						result.put("message", list.item(i).getTextContent());
						continue;
					}
			}
		
//			String[] dictsString = dictPropertyList.toArray(new String[dictPropertyList.size()]);
//			result = new JSONArray(dictsString);
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println(result);
		return result;
	}
	
	public JSONObject editDict(String colId, String dictName, String args, String token) {
		JSONObject result = new JSONObject();
//		dictName = "customdict_" + dictName;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=editCustomDictionary&collectionId="+colId+"&name="+dictName+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.httpPostWithBody(url, args);
			// System.out.println(data);
			InputSource is = new InputSource(new StringReader(data));
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			Document doc = docBuilder.parse(is);
			
			XPathFactory xpathFactory = XPathFactory.newInstance();
			// XPath to find empty text nodes.
			XPathExpression xpathExp = xpathFactory.newXPath().compile(
			    	"//text()[normalize-space(.) = '']");  
			NodeList emptyTextNodes = (NodeList) 
			        xpathExp.evaluate(doc, XPathConstants.NODESET);
			// Remove each empty text node from document.
			for (int i = 0; i < emptyTextNodes.getLength(); i++) {
			    Node emptyTextNode = emptyTextNodes.item(i);
			    emptyTextNode.getParentNode().removeChild(emptyTextNode);
			}
			
			Node firstChild = doc.getFirstChild();
			NodeList list = firstChild.getChildNodes();
			
//			List<String> dictPropertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				if (list.item(i).getNodeName().equals("value")) {
//					dictPropertyList.add(0,list.item(i).getTextContent());
					result.put("value", list.item(i).getTextContent());
					continue;
				}
				if (list.item(i).getNodeName().equals("message")) {
//					dictPropertyList.add(1,list.item(i).getTextContent());
					result.put("message", list.item(i).getTextContent());
					continue;
				}
		}
		
//			String[] dictsString = dictPropertyList.toArray(new String[dictPropertyList.size()]);
//			result = new JSONArray(dictsString);
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println(result);
		return result;
	}
	
	public JSONObject deleteDict(String colId, String dictName, String token) {
		JSONObject result = new JSONObject();
//		dictName = "customdict_" + dictName;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=deleteCustomDictionary&collectionId="+colId+"&name="+dictName+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.getData(url);
//			// System.out.println(data);
			InputSource is = new InputSource(new StringReader(data));
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			Document doc = docBuilder.parse(is);
			
			XPathFactory xpathFactory = XPathFactory.newInstance();
			// XPath to find empty text nodes.
			XPathExpression xpathExp = xpathFactory.newXPath().compile(
			    	"//text()[normalize-space(.) = '']");  
			NodeList emptyTextNodes = (NodeList) 
			        xpathExp.evaluate(doc, XPathConstants.NODESET);
			// Remove each empty text node from document.
			for (int i = 0; i < emptyTextNodes.getLength(); i++) {
			    Node emptyTextNode = emptyTextNodes.item(i);
			    emptyTextNode.getParentNode().removeChild(emptyTextNode);
			}
			
			Node firstChild = doc.getFirstChild();
			NodeList list = firstChild.getChildNodes();
			
//			List<String> dictPropertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				if (list.item(i).getNodeName().equals("value")) {
//					dictPropertyList.add(0,list.item(i).getTextContent());
					result.put("value", list.item(i).getTextContent());
					continue;
				}
				if (list.item(i).getNodeName().equals("message")) {
//					dictPropertyList.add(1,list.item(i).getTextContent());
					result.put("message", list.item(i).getTextContent());
					continue;
				}
		}
		
//			String[] dictsString = dictPropertyList.toArray(new String[dictPropertyList.size()]);
//			result = new JSONArray(dictsString);
			
		}
		
		catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println(result);
		return result;
	}
	
}
