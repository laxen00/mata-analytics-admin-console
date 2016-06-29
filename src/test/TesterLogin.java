package test;

import apiRequest.LoginRequest;
import auth.Authentication;

public class TesterLogin {

	public static String login(String hostname) {
		String token = "";
		
		String username = "Administrator";
		String password = "passw0rd!";
		
		String usernameEncrypt = Authentication.encryptData(username);
		String passwordEncrypt = Authentication.encryptData(password);
		
		String startarg = "{";
		String argdata = "\"username\":\""+usernameEncrypt+"\",\"password\":\""+passwordEncrypt+"\"";
		String endarg = "}";
		String argbody = startarg + argdata + endarg;
		System.out.println(argbody);
		
		int indicator = 0;
		LoginRequest loginreq = new LoginRequest(hostname);
		do {
			String[] login = loginreq.login(argbody);
			try {
			    Thread.sleep(1000);                 //1000 milliseconds is one second.
			} catch(InterruptedException ex) {
			    Thread.currentThread().interrupt();
			}
			
//			System.out.println("login length:"+login.length);
			
			if (login.length != 3) {
				System.out.println("Wrong username/password");
				break;
			}
			
			else {
				String[] checkSession = loginreq.checkSession(login[1]);
				
				if (checkSession[1].equalsIgnoreCase("0")) {
					indicator = 1;
					token = login[1];
				}
				else {
					indicator = 0;
				}
			}
		}while (indicator !=1);
		
		return token;
	}
	
}
