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

public class SecurityRequest {
	private String hostname = "max.mataprima.com";
	private static final String PROTOCOL = "http://";
	private static final String PORT = ":8081";
	private final static boolean DEBUG = true;

	public SecurityRequest(String hostname){
		if(!DEBUG)
			this.hostname = hostname;
	}
	
	public String[][] getTokens(String username, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/securitypage?method=getListToken&username="+username+"&sessionId="+token;
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
			
			List<String[]> crawlerList = new ArrayList<String[]>();
			
			for (int i=0;i<list.getLength();i++) {
				if (!list.item(i).hasChildNodes()) continue;
				Node crawler = list.item(i);
				NodeList crawlerProperties = crawler.getChildNodes();

				String[] propertyName = {
						"type", 			// 0
						"token", 			// 1
						"alias", 			// 2
						"keyid",			// 3
						"secret"			// 4
						};
				
				List<String> crawlerPropertyList = new ArrayList<String>();
				
				ArrayList<String[]> propertyUnsortedList = new ArrayList<String[]>();
				ArrayList<String> unsortedList = new ArrayList<String>();

				for (int j=0;j<crawlerProperties.getLength();j++) {
					unsortedList.add(crawlerProperties.item(j).getNodeName());
					unsortedList.add(crawlerProperties.item(j).getTextContent());
					String[] unsorted = unsortedList.toArray(new String[unsortedList.size()]);
					propertyUnsortedList.add(unsorted);
					unsortedList.clear();
				}
				
				for (int j=0;j<propertyName.length;j++) {
					for (int k=0;k<propertyUnsortedList.size();k++) {
						if (propertyName[j].equals(propertyUnsortedList.get(k)[0])) {
							crawlerPropertyList.add(propertyUnsortedList.get(k)[1]);
							break;
						}
					}
				}
				
				String[] properties = crawlerPropertyList.toArray(new String[crawlerPropertyList.size()]);
				crawlerList.add(properties);
				crawlerPropertyList.clear();
			}
		
			result = crawlerList.toArray(new String[crawlerList.size()][]);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String getTwitterToken(String apiKey, String secretKey, String token) {
		String[] resultArray = null;
		String result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/securitypage?method=getTwitterToken&apiKey="+apiKey+"&secretKey="+secretKey+"&sessionId="+token;
		// System.out.println(url);
		try {
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
			List<String> propertyList = new ArrayList<String>();
			String[] properties = {"value", "message"};
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
						propertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			resultArray = propertyList.toArray(new String[propertyList.size()]);
			result = resultArray[1].trim();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String getFacebookToken(String apiKey, String secretKey, String token) {
		String[] resultArray = null;
		String result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/securitypage?method=getFacebookToken&apiKey="+apiKey+"&secretKey="+secretKey+"&sessionId="+token;
		// System.out.println(url);
		
		try {
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
			List<String> propertyList = new ArrayList<String>();
			String[] properties = {"value", "message"};
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
						propertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			resultArray = propertyList.toArray(new String[propertyList.size()]);
			result = resultArray[1].trim();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] postAccessToken(String token, String args) {
		String[] resultArray = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/securitypage?method=postToken&sessionId="+token;
		// System.out.println(url);
		
		try {
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
			List<String> propertyList = new ArrayList<String>();
			String[] properties = {"value", "message"};
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
						propertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			resultArray = propertyList.toArray(new String[propertyList.size()]);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return resultArray;
	}
	
	public String[] editAccessToken(String username, String alias, String args, String token) {
		String[] resultArray = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/securitypage?method=editToken&username="+username+"&alias="+alias+"&sessionId="+token;
		// System.out.println(url);
		
		try {
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
			List<String> propertyList = new ArrayList<String>();
			String[] properties = {"value", "message"};
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
						propertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			resultArray = propertyList.toArray(new String[propertyList.size()]);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return resultArray;
	}
	
	public String[] deleteAccessToken(String username, String alias, String token) {
		String[] resultArray = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/securitypage?method=deleteToken&username="+username+"&alias="+alias+"&sessionId="+token;
		// System.out.println(url);
		
		try {
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
			List<String> propertyList = new ArrayList<String>();
			String[] properties = {"value", "message"};
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
						propertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			resultArray = propertyList.toArray(new String[propertyList.size()]);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return resultArray;
	}
}
