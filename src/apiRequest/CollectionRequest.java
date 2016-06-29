package apiRequest;

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

import httpProcess.HttpProcess;

public class CollectionRequest {
	private String hostname = "max.mataprima.com";
	private static final String PROTOCOL = "http://";
	private static final String PORT = ":8081";
	private final static boolean DEBUG = true;
	
	public CollectionRequest(String hostname){
		if(!DEBUG)
			this.hostname = hostname;
	}
	
	public String[][] getCollections(String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/collection?method=getList&sessionId="+token;
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
			
			List<String[]> collectionList = new ArrayList<String[]>();
			
			for (int i=0;i<list.getLength();i++) {
				if (!list.item(i).hasChildNodes()) continue;
				Node collection = list.item(i);
				NodeList collectionProperties = collection.getChildNodes();
				
				int[] propertyNum = {0, 1, 2, 3};
				String[] propertyName = {"name", "size", "numDocs", "version"};
				List<String> collectionPropertyList = new ArrayList<String>();
				
				ArrayList<String[]> propertyUnsortedList = new ArrayList<String[]>();
				ArrayList<String> unsortedList = new ArrayList<String>();

				for (int j=0;j<collectionProperties.getLength();j++) {
					unsortedList.add(collectionProperties.item(j).getNodeName());
					unsortedList.add(collectionProperties.item(j).getTextContent());
					String[] unsorted = unsortedList.toArray(new String[unsortedList.size()]);
					propertyUnsortedList.add(unsorted);
					unsortedList.clear();
				}
				
				for (int j=0;j<propertyNum.length;j++) {
					for (int k=0;k<propertyUnsortedList.size();k++) {
						if (propertyName[j].equals(propertyUnsortedList.get(k)[0])) {
							collectionPropertyList.add(propertyUnsortedList.get(k)[1]);
							break;
						}
					}
				}
				
				String[] properties = collectionPropertyList.toArray(new String[collectionPropertyList.size()]);
				collectionList.add(properties);
				collectionPropertyList.clear();
			}
		
			result = collectionList.toArray(new String[collectionList.size()][]);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public String[] getCollection(String colId, String token) {
		String[] result= null;
		String[][] collections = getCollections(token);
		ArrayList<String> list = new ArrayList<String>();
		for (String[] collection : collections) {
			if (collection[0].equals(colId)) {
				for (int i=0;i<collection.length;i++) list.add(i, collection[i]);
				break;
			}
		}
		result = list.toArray(new String[list.size()]);
		return result;
	}
	
	public String[] createCollection(String args, String token) {
		String[] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/collection?method=create&sessionId="+token;
		// System.out.println(url);
		// System.out.println(args);
		try {
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
			List<String> collectionPropertyList = new ArrayList<String>();
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
						collectionPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			result = collectionPropertyList.toArray(new String[collectionPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] createV2Collection(String args, String token) {
		String[] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/collection?method=createV2&sessionId="+token;
		// System.out.println(url);
		// System.out.println(args);
		try {
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
			List<String> collectionPropertyList = new ArrayList<String>();
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
						collectionPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			result = collectionPropertyList.toArray(new String[collectionPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] deleteCollection(String colId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/collection?method=delete&collectionId="+colId+"&sessionId="+token;
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
	
	public String[][] editCollection(String colId, String args, String token) {
		String[][] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/collection?method=edit&collectionId="+colId+"&sessionId="+token;
		// System.out.println(url);
		// System.out.println(args);
		try {
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
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String getLocationCollection(String colId, String token) {
		String[] resultArray = null;
		String result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/collection?method=getLocationCollection&collectionId="+colId+"&sessionId="+token;
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
			List<String> collectionPropertyList = new ArrayList<String>();
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
						collectionPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
			
			resultArray = collectionPropertyList.toArray(new String[collectionPropertyList.size()]);
			result = resultArray[1];
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] getCollectionStatus(String colId, String token) {
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/collection?method=getStatusCollection&collectionId="+colId+"&sessionId="+token;
			// System.out.println(url);
			String data = HttpProcess.getData(url);
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
			
			List<String> collectionStatusPropertyList = new ArrayList<String>();
			
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
						collectionStatusPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
		
			result = collectionStatusPropertyList.toArray(new String[collectionStatusPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
