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

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class FieldRequest {
	private String hostname = "max.mataprima.com";
	private static final String PROTOCOL = "http://";
	private static final String PORT = ":8081";
	private final static boolean DEBUG = true;

	public FieldRequest(String hostname){
		if(!DEBUG)
			this.hostname = hostname;
	}
	
	public String[][] getField(String colId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=getFieldSchema&collectionId="+colId+"&sessionId="+token;
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
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes();
				for (int j=0;j<fieldProperty.getLength();j++) {
					propertyList.add(fieldProperty.item(j).getTextContent());
				}
				String[] properties = propertyList.toArray(new String[propertyList.size()]);
				fieldPropertyList.add(properties);
				propertyList.clear();
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] addField(String colId, String token, String args) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=addFieldSchema&collectionId="+colId+"&sessionId="+token;
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
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes();
				for (int j=0;j<fieldProperty.getLength();j++) {
					propertyList.add(fieldProperty.item(j).getTextContent());
				}
				String[] properties = propertyList.toArray(new String[propertyList.size()]);
				fieldPropertyList.add(properties);
				propertyList.clear();
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] editField(String colId, String token, String name, String args) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=editFieldSchema&collectionId="+colId+"&name="+name+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.httpPostWithBody(url, args);
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
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes();
				for (int j=0;j<fieldProperty.getLength();j++) {
					propertyList.add(fieldProperty.item(j).getTextContent());
				}
				String[] properties = propertyList.toArray(new String[propertyList.size()]);
				fieldPropertyList.add(properties);
				propertyList.clear();
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] deleteField(String colId, String fieldname, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=deleteFieldSchema&collectionId="+colId+"&name="+fieldname+"&sessionId="+token;
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
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes();
				for (int j=0;j<fieldProperty.getLength();j++) {
					propertyList.add(fieldProperty.item(j).getTextContent());
				}
				String[] properties = propertyList.toArray(new String[propertyList.size()]);
				fieldPropertyList.add(properties);
				propertyList.clear();
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] getAnnotator(String colId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=getAnnotator&collectionId="+colId+"&sessionId="+token;
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
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes();
				propertyList.add(fieldProperty.item(0).getTextContent().trim());
				NodeList features = fieldProperty.item(1).getChildNodes();
				for (int j=0;j<features.getLength();j++) {
					propertyList.add(features.item(j).getTextContent().trim());
				}
				String[] properties = propertyList.toArray(new String[propertyList.size()]);
				fieldPropertyList.add(properties);
				propertyList.clear();
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
//			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] getFieldFeature(String colId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=getFieldFeature&collectionId="+colId+"&sessionId="+token;
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
			
			Node firstChild = doc.getFirstChild(); //apiresponse
			NodeList list = firstChild.getChildNodes(); //annotator
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes(); //name & mapping
				if (fieldProperty.item(1).hasChildNodes()) { //mapping
					NodeList mapping = fieldProperty.item(1).getChildNodes();
					for (int j=0;j<mapping.getLength();j+=2) {
						propertyList.add(mapping.item(j).getTextContent().trim());
						propertyList.add(mapping.item(j+1).getTextContent().trim());
						String[] properties = propertyList.toArray(new String[propertyList.size()]);
						fieldPropertyList.add(properties);
						propertyList.clear();
					}
				}
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
			//e.printStackTrace();
		}
		return result;
	}

	public String[][] addFieldMapping(String colId, String token, String args) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=addFieldMapping&collectionId="+colId+"&sessionId="+token;
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
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes();
				for (int j=0;j<fieldProperty.getLength();j++) {
					propertyList.add(fieldProperty.item(j).getTextContent());
				}
				String[] properties = propertyList.toArray(new String[propertyList.size()]);
				fieldPropertyList.add(properties);
				propertyList.clear();
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] deleteFieldMapping(String colId, String token, String args) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/field?method=deleteFieldFeature&collectionId="+colId+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.httpPostWithBody(url, args);
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
			
			List<String[]> fieldPropertyList = new ArrayList<String[]>();
			List<String> propertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				NodeList fieldProperty = list.item(i).getChildNodes();
				for (int j=0;j<fieldProperty.getLength();j++) {
					propertyList.add(fieldProperty.item(j).getTextContent());
				}
				String[] properties = propertyList.toArray(new String[propertyList.size()]);
				fieldPropertyList.add(properties);
				propertyList.clear();
			}
		
			result = fieldPropertyList.toArray(new String[fieldPropertyList.size()][]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
