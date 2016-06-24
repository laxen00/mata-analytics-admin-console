package httpProcess;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
//import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

public class HttpProcess {
	
	public static String getData(String url) throws Exception {
 
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
 
		// optional default is GET
		con.setRequestMethod("GET");
 
		//add request header
		con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB;     rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13 (.NET CLR 3.5.30729)");
		
		BufferedReader in = new BufferedReader(
		new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
 
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
 
		//print result
		return response.toString();
 
	}
	
	public static String postData(String url, String args) throws Exception {
		
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
 
		// optional default is GET
		con.setRequestMethod("POST");
		
		//add request header
		con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB;     rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13 (.NET CLR 3.5.30729)");
		con.setRequestProperty("Content-Type", "application/json");
		con.setRequestProperty("Content-Length", Integer.toString(args.getBytes().length));
		con.setRequestProperty("Accept", "application/xml");
		
		con.setDoOutput(true);
		con.setDoInput(true);
		
		con.addRequestProperty("Content-Type", "application/" + "POST");
		if (args != null) {
		con.setRequestProperty("Content-Length", Integer.toString(args.length()));
		con.getOutputStream().write(args.getBytes("UTF8"));
		}
		
		DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		wr.writeBytes(args);
		wr.flush();
		wr.close();
		
		BufferedReader in = new BufferedReader(
		new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
 
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
 
		//print result
		return response.toString();
	}
	
	public static String getOAuth(String url) throws Exception {
		 
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
 
		// optional default is GET
		con.setRequestMethod("GET");
 
		//add request header
		con.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB;     rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13 (.NET CLR 3.5.30729)");

		BufferedReader in = new BufferedReader(
		new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
 
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
 
		//print result
		return response.toString();
 
	}
	
	public static String httpPostWithBody(String url, String args) {
		String result = null;
//		HttpClient client = new DefaultHttpClient();
		CloseableHttpClient  client = HttpClientBuilder.create().build();
		
        HttpPost post = new HttpPost(url);
        String json = args;
        HttpEntity entity = null;
        
		try {
			entity = new ByteArrayEntity(json.getBytes("UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        post.setEntity(entity);
        HttpResponse response = null;
        
		try {
			response = client.execute(post);
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
        try {
			result = EntityUtils.toString(response.getEntity());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				EntityUtils.consume(response.getEntity());
				client.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        
		return result;
	}
}
