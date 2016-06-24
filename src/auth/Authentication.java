package auth;

import java.security.Key;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class Authentication {
	
	  public static String encryptData(String password){
		  
		  try {
			  String text = password;
			  String key = "-CAXliteCAXlite-"; // 128 bit key

			  // Create key and cipher
			  Key aesKey = new SecretKeySpec(key.getBytes(), "AES");
			  Cipher cipher = Cipher.getInstance("AES");

			  // encrypt the text
			  cipher.init(Cipher.ENCRYPT_MODE, aesKey);
			  byte[] encrypted = cipher.doFinal(text.getBytes());
			  //System.out.println(new String(encrypted));
			  
			  String outputEncrypted = "";
			  for (int i=0; i<encrypted.length; i++){
				  outputEncrypted = outputEncrypted + Integer.toString(encrypted[i]) + "A";
			  }

			  return outputEncrypted;
		  }
		  
		  catch(Exception e) {
			  e.printStackTrace();
			  return null;
		  }
	  }
	
}
