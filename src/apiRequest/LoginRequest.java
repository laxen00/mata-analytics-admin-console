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

public class LoginRequest {
	private String hostname = "max.mataprima.com";
	private static final String PROTOCOL = "http://";
	private static final String PORT = ":8081";
	private final static boolean DEBUG = true;

	public LoginRequest(String hostname){
		if(!DEBUG)
			this.hostname = hostname;
	}
	
	public String[] login(String args) {
		String[] result = null;
		String url = PROTOCOL + hostname + PORT + "/api/admin/login?method=loginUser";
		// System.out.println(url);
		// System.out.println(args);
		try {
			String data = HttpProcess.httpPostWithBody(url, args);
			// System.out.println("Response data:" + data);
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
			List<String> LoginPropertyList = new ArrayList<String>();
//			// System.out.println("listLength:"+list.getLength());
			if (list.getLength() == 1) {
				LoginPropertyList.add("Wrong Username / Password, please try again");
			}
			
			else {
				String[] properties = {"message", "token", "value"};
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
							LoginPropertyList.add(propertyUnsortedList.get(k)[1]);
							break;
						}
					}
				}
			}
			
			result = LoginPropertyList.toArray(new String[LoginPropertyList.size()]);
			
		}
		catch (Exception e) {
			List<String> LoginPropertyList = new ArrayList<String>();
			LoginPropertyList.add("Error Logging In");
			result = LoginPropertyList.toArray(new String[LoginPropertyList.size()]);
		}
		return result;
	}
	
	public String[] checkSession(String token) {
		String[] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/login?method=checkSession&sessionId="+token;
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
			
			List<String> LoginPropertyList = new ArrayList<String>();
			
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
						LoginPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
		
			result = LoginPropertyList.toArray(new String[LoginPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] logout(String token) {
		String[] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/login?method=logout&sessionId="+token;
		// System.out.println(url);
		try {
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
			
			List<String> LoginPropertyList = new ArrayList<String>();
			
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
						LoginPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
		
			result = LoginPropertyList.toArray(new String[LoginPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
