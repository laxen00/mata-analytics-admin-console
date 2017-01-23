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

public class CrawlerRequest {
	private String hostname = "max.mataprima.com";
	private static final String PROTOCOL = "http://";
	private static final String PORT = ":8081";
	private final static boolean DEBUG = true;
	
	public CrawlerRequest(String hostname){
		if(!DEBUG)
			this.hostname = hostname;
	}
	
	public String[][] getCrawlers(String colId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=getList&collectionId="+colId+"&sessionId="+token;
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
						"crawlerid", 					// 0
						"displayname", 					// 1
						"type", 						// 2
						"depthlink", 					// 3
						"thread", 						// 4
						"useragent", 					// 5
						"linktofollow", 				// 6
						"url", 							// 7
						"newsconfigloc", 				// 8
						"linktoforbid", 				// 9
						"forumconfigloc", 				// 10
						"keyword", 						// 11
						"progressive",					// 12
						"contenttype", 					// 13	
						"since", 						// 14	
						"until",						// 15	
						"count",						// 16	
						"lang",							// 17	
						"query",						// 18	
						"token",						// 19
						"videosearchtype",				// 20	
						"videokeywordascommentfilter",	// 21
						"key",							// 22
						"delaybetweenrequest"			// 23
						};
				String[] xPathName = {
						"xpathpostids",			// 13
						"replacepostids",		// 14
						"patternpostids",		// 15
						"xpathpostcontents",	// 16	13
						"xpathpost",			// 16	13
						"replacepostcontents",	// 17	14
						"replacepost",			// 17	14
						"crawlname",			// 18	15
						"xpathdates",			// 19	16
						"dateformat",			// 20	17
						"replacedates",			// 21	18
						"attribute",			// 22	19
						"xpathusers",			// 23	20
						"replaceusers",			// 24	21
						"replaceheader",		// 25	22
						"xpathheader"			// 26	23
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
				
				for (int j=0;j<crawlerProperties.getLength();j++) {
					if (crawlerProperties.item(j).getNodeName().equalsIgnoreCase("xpath")) {
						Node properties = crawlerProperties.item(j).getFirstChild();
						NodeList propertiesChild = properties.getChildNodes();
						
						ArrayList<String[]> xPathUnsortedList = new ArrayList<String[]>();
						ArrayList<String> xPathUnsorted = new ArrayList<String>();
						
						for (int m=0;m<propertiesChild.getLength();m++) {
							NodeList childList = propertiesChild.item(m).getChildNodes();
							for (int n=0;n<childList.getLength();n++) {
								xPathUnsorted.add(childList.item(n).getNodeName());
								xPathUnsorted.add(childList.item(n).getTextContent());
								String[] unsortedXPath = xPathUnsorted.toArray(new String[xPathUnsorted.size()]);
								xPathUnsortedList.add(unsortedXPath);
								xPathUnsorted.clear();
							}
						}
						
						for (int k=0;k<xPathName.length;k++) {
							for (int z=0;z<xPathUnsortedList.size();z++) {
								if (xPathName[k].equals(xPathUnsortedList.get(z)[0])) {
									crawlerPropertyList.add(xPathUnsortedList.get(z)[1]);
//									// System.out.println("field:" + xPathName[k] + "\t\tvalue:" + xPathUnsortedList.get(z)[1]);
									break;
								}
							}
						}
						break;		
					}
				}
				
				String[] properties = crawlerPropertyList.toArray(new String[crawlerPropertyList.size()]);
				crawlerList.add(properties);
				crawlerPropertyList.clear();
			}
		
			result = crawlerList.toArray(new String[crawlerList.size()][]);
			// System.out.println();
			// System.out.println();
			// System.out.println();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] getCrawler(String colId, String crawlerId, String token) {
		String[] result= null;
		String[][] crawlers = getCrawlers(colId, token);
		ArrayList<String> list = new ArrayList<String>();
		for (String[] crawler : crawlers) {
			if (crawler[0].equals(crawlerId)) {
				for (int i=0;i<crawler.length;i++){
					/*String newValue = deEscape(crawler[i]);
					list.add(i, newValue);*/
					list.add(i, crawler[i]);
				}
				break;
			}
		}
		result = list.toArray(new String[list.size()]);
//		// System.out.println("====================");
//		for (int i = 0; i < result.length ; i++) {
//			// System.out.println(i + " : " + result[i]);
//		}
//		// System.out.println("====================");
		return result;
	}
	
	/*public String deEscape(String value){
		String newValue = value;
		
		if(newValue.contains("&amp;")){
			newValue.replace("&amp;", "&");
		}
		if(newValue.contains("&quot;")){
			newValue.replace("&quot;", "\"");
		}
		if(newValue.contains("&apos;")){
			newValue.replace("&apos;", "'");
		}
		if(newValue.contains("&lt;")){
			newValue.replace("&lt;", "<");
		}
		if(newValue.contains("&gt;")){
			newValue.replace("&gt;", ">");
		}
		
		return newValue;
	}*/
	
	public String[][] startCrawler(String colId, String crawlerId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=start&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
	
	public String[][] stopCrawler(String colId, String crawlerId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=stop&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
	
	public String[][] fullRecrawl(String colId, String crawlerId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=fullRecrawl&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
	
	public String[][] deleteCrawler(String colId, String crawlerId, String token) {
		String[][] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=delete&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
	
	public String[] getState(String colId, String crawlerId, String token) {
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=getState&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
			
			List<String> crawlerPropertyList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
					if (list.item(i).getNodeName().equals("state")) {
						crawlerPropertyList.add(0,list.item(i).getTextContent());
						continue;
					}
					if (list.item(i).getNodeName().equals("pid")) {
						crawlerPropertyList.add(1,list.item(i).getTextContent());
						continue;
					}
			}
		
			result = crawlerPropertyList.toArray(new String[crawlerPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public String[] createCrawler(String colId, String args, String token) {
		String[] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=create&collectionId="+colId+"&sessionId="+token;
		// System.out.println(url);
		// System.out.println(args);
		try {
			String data = HttpProcess.httpPostWithBody(url, args);
			 System.out.println(data);
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
			
			List<String> crawlerStatusPropertyList = new ArrayList<String>();
			
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
						crawlerStatusPropertyList.add(propertyUnsortedList.get(k)[1]);
						break;
					}
				}
			}
		
			result = crawlerStatusPropertyList.toArray(new String[crawlerStatusPropertyList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[][] createXML(String colId, String crawlerId, String args, String token) {
		String[][] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=createXmlConfig&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
	
	public String[][] editCrawler(String colId, String crawlerId, String args, String token) {
		String[][] result = null;
		String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=edit&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
	
	public String[] getRecentlyCrawled(String colId, String crawlerId, String token) {
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=getRecentlyCrawled&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
			
			for (int i=0;i<list.getLength();i++) {
					if (list.item(i).getNodeName().equals("url")) {
						result = list.item(i).getTextContent().split("\\|");
						continue;
					}
			}
			
			
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] getAllCrawled(String colId, String crawlerId, String token) {
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=getAllCrawled&collectionId="+colId+"&crawlerId="+crawlerId+"&sessionId="+token;
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
			
			for (int i=0;i<list.getLength();i++) {
				if (list.item(i).getNodeName().equals("url")) {
					result = list.item(i).getTextContent().split("\\|");
					continue;
				}
		}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public String[][] startAll(String colId, String token) {
		String[][] result = null;
		String[][] crawlers = getCrawlers(colId, token);
		for (int j=0; j<crawlers.length;j++) {
			try {
				String crawlerId = crawlers[j][0];
				String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=start&collectionId="+colId+"&crawlerId="+crawlerId;
				// System.out.println(url);
				String data = HttpProcess.getData(url);
//				// System.out.println(data);
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
		}
		return result;
	}
	
	public String[][] stopAll(String colId, String token) {
		String[][] result = null;
		String[][] crawlers = getCrawlers(colId, token);
		for (int j=0; j<crawlers.length;j++) {
			try {
				String crawlerId = crawlers[j][0];
				String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=stop&collectionId="+colId+"&crawlerId="+crawlerId;
				// System.out.println(url);
				String data = HttpProcess.getData(url);
//				// System.out.println(data);
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
		}
		return result;
	}
	
	public String[] getListTemplate(String type, String token) {
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=getListTemplate&type="+type+"&sessionId="+token;
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
			
			ArrayList<String> resultList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				if (list.item(i).getNodeName().equalsIgnoreCase("message")) {
					NodeList templates = list.item(i).getChildNodes();
					for (int j=0; j<templates.getLength();j++) {
						resultList.add(templates.item(j).getTextContent());
					}
					break;
				}
			}
			
			for (int a=0;a<resultList.size();a++) {
				resultList.set(a, resultList.get(a).replaceAll(".xml",""));
			}
			result = resultList.toArray(new String[resultList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String[] getTemplate(String type, String templateName, String token) {
		String[] xPathName = {
				"xpathpostcontents",	//	0
				"xpathpost",			//	0 	
				"replacepostcontents",	//	1	
				"replacepost",			//	1	
				"crawlname",			//	2	
				"xpathdates",			//	3	
				"dateformat",			//	4	
				"replacedates",			//	5	
				"attribute",			//	6	
				"xpathusers",			//	7	
				"replaceusers",			//	8	
				"replaceheader",		//	9	
				"xpathheader",			//	10	
				"xpathpostids",			//	11
				"replacepostids",		//	12
				"patternpostids"		//	13
				};			
		String[] result = null;
		try {
			String url = PROTOCOL+hostname+ PORT + "/api/admin/crawler?method=getTemplate&type="+type+"&template="+templateName+"&sessionId="+token;
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
			
			ArrayList<String> resultList = new ArrayList<String>();
			
			for (int i=0;i<list.getLength();i++) {
				if (list.item(i).getNodeName().equalsIgnoreCase("message")) {
					Node propertiesNode = list.item(i).getFirstChild();
					NodeList propertiesChild = propertiesNode.getChildNodes();

					ArrayList<String[]> xPathUnsortedList = new ArrayList<String[]>();
					ArrayList<String> xPathUnsorted = new ArrayList<String>();
					
					for (int m=0;m<propertiesChild.getLength();m++) {
						NodeList childList = propertiesChild.item(m).getChildNodes();
						for (int n=0;n<childList.getLength();n++) {
							xPathUnsorted.add(childList.item(n).getNodeName());
							xPathUnsorted.add(childList.item(n).getTextContent());
//							// System.out.println(childList.item(n).getNodeName() + ":" + childList.item(n).getTextContent());
							String[] unsortedXPath = xPathUnsorted.toArray(new String[xPathUnsorted.size()]);
							xPathUnsortedList.add(unsortedXPath);
							xPathUnsorted.clear();
						}
					}
					
					for (int k=0;k<xPathName.length;k++) {
						for (int z=0;z<xPathUnsortedList.size();z++) {
							if (xPathName[k].equals(xPathUnsortedList.get(z)[0])) {
								resultList.add(xPathUnsortedList.get(z)[1]);
//								// System.out.println("field:" + xPathName[k] + "\t\tvalue:" + xPathUnsortedList.get(z)[1]);
								break;
							}
						}
					}
					break;
				}
			}
			
			result = resultList.toArray(new String[resultList.size()]);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
