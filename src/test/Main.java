package test;

import org.json.JSONArray;
import org.json.JSONObject;

import apiRequest.*;

public class Main {

	public static void main(String[] args) {
		
		String hostname = "max.mataprima.com";
		String token = TesterLogin.login(hostname);
		String colId = "ivantestcollection";
		String username = "administrator";
		String crawlerId = "WEB_78623";
//		String[] a = new CrawlerRequest(hostname).getListTemplate("forum", token);
//		String[] a = new CrawlerRequest(hostname).getCrawler(colId, crawlerId, token);
//		String bodeh = "{\"collectionId\":\"apalah\"}";
		String[] a = new ParseRequest(hostname).reloadParse(colId, token);
//		String[] a = new CrawlerRequest(hostname).getTemplate("kaskus.co.id", token);
		int counter = 0;
		for (String line : a) {
			System.out.println(counter + "\t:\t"+ line);
			counter++;
		}
		
	}

}
