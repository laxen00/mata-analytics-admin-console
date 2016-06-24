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

public class PearRequest {
	private String hostname = "max.mataprima.com";
	private static final String PROTOCOL = "http://";
	private static final String PORT = ":8081";
	private final static boolean DEBUG = true;

	public PearRequest(String hostname){
		if(!DEBUG)
			this.hostname = hostname;
	}

	public String[][] installPear (String colId, String pearName, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/pear?method=pear&collectionId="+colId+"&pearName="+pearName+"&sessionId="+token;
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
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] uninstallPear (String colId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/pear?method=uninstall&collectionId="+colId+"&sessionId="+token;
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
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] currentPear (String colId, String token) {
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/pear?method=currentPear&collectionId="+colId+"&sessionId="+token;
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
			
			List<String> pearPropertyList = new ArrayList<String>();
			
			String[] properties = {"message", "value"};
			ArrayList<String[]> propertyUnsortedList = new ArrayList<String[]>();
			ArrayList<String> unsortedList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				unsortedList.add(list.item(i).getNodeName());
				unsortedList.add(list.item(i).getTextContent());
				String[] unsorted = unsortedList.toArray(new String[unsortedList.size()]);
				propertyUnsortedList.add(unsorted);
				unsortedList.clear();
			}
			
			for (int j=0;j<properties.length;j++) {
				for (int k=0;k<propertyUnsortedList.size();k++) {
					if (properties[j].equals(propertyUnsortedList.get(k)[0])) {
						pearPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
		
			result = pearPropertyList.toArray(new String[pearPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] getPearStatus (String colId, String token) {
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/pear?method=getStatusInstallPear&collectionId="+colId+"&sessionId="+token;
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
			
			List<String> pearPropertyList = new ArrayList<String>();
			
			String[] properties = {"message", "value"};
			ArrayList<String[]> propertyUnsortedList = new ArrayList<String[]>();
			ArrayList<String> unsortedList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				unsortedList.add(list.item(i).getNodeName());
				unsortedList.add(list.item(i).getTextContent());
				String[] unsorted = unsortedList.toArray(new String[unsortedList.size()]);
				propertyUnsortedList.add(unsorted);
				unsortedList.clear();
			}
			
			for (int j=0;j<properties.length;j++) {
				for (int k=0;k<propertyUnsortedList.size();k++) {
					if (properties[j].equals(propertyUnsortedList.get(k)[0])) {
						pearPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
		
			result = pearPropertyList.toArray(new String[pearPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
