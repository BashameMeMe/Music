package util;

import org.mindrot.jbcrypt.BCrypt;

public class HashPassword {
	public static String hasPasword(String pass) {
		return BCrypt.hashpw(pass, BCrypt.gensalt(12));
	}

	public static boolean checkPassword(String pass, String hashedPassword) {
		return BCrypt.checkpw(pass, hashedPassword);
	}
}
