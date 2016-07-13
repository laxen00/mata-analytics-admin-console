package test;

import org.json.JSONArray;
import org.json.JSONObject;

import apiRequest.*;

public class Main {

	public static void main(String[] args) {
		
		String hostname = "max.mataprima.com";
		String token = TesterLogin.login(hostname);
		String colId = "SahabatSampoerna";
		String username = "administrator";
		String crawlerId = "WEB_13854";
//		String[] out = new CrawlerRequest(hostname).getListTemplate("forum", token);
		String[] out = new CrawlerRequest(hostname).getCrawler(colId, crawlerId, token);
//		String[] out = new CollectionRequest(hostname).deleteCollection(colId, token);
//		String[] out = new CrawlerRequest(hostname).getTemplate("kaskus.co.id", token);
		int counter = 0;
		for (String line : out) {
			System.out.println(counter + "\t:\t"+ line);
			counter++;
		}
	}
	
}
