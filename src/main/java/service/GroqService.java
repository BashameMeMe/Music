package service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


public class GroqService {

	private static final String API_URL = "https://api.groq.com/openai/v1/chat/completions";
	private static final String MODEL = "llama-3.1-8b-instant";

	public static String ask(String userMessage) {
	    HttpURLConnection conn = null;
	    try {
	        String apiKey = "";  

	      

	        URL url = new URL(API_URL);
	        conn = (HttpURLConnection) url.openConnection();

	        // === CẤU HÌNH ĐẦY ĐỦ TRƯỚC KHI GỬI BẤT KỲ THỨ GÌ ===
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
	        conn.setDoOutput(true);

	        // Timeout tránh treo
	        conn.setConnectTimeout(10000);
	        conn.setReadTimeout(60000);

	        // === BUILD BODY ===
	        JsonObject body = new JsonObject();
	        body.addProperty("model", MODEL);
	        JsonArray messages = new JsonArray();
	        JsonObject userMsg = new JsonObject();
	        userMsg.addProperty("role", "user");
	        userMsg.addProperty("content", userMessage);
	        messages.add(userMsg);
	        body.add("messages", messages);

	        // === GỬI BODY ===
	        try (OutputStream os = conn.getOutputStream()) {
	            os.write(body.toString().getBytes(StandardCharsets.UTF_8));
	            os.flush();
	        }

	        // === BÂY GIỜ MỚI ĐỌC RESPONSE ===
	        int responseCode = conn.getResponseCode();
	      

	        if (responseCode >= 400) {
	            String error = readStream(conn.getErrorStream());
	            System.out.println(">>> [GROQ] Error: " + error);
	            return "Groq lỗi " + responseCode + ": " + error;
	        }

	        String response = readStream(conn.getInputStream());
	    

	        JsonObject json = JsonParser.parseString(response).getAsJsonObject();
	        if (json.has("error")) {
	            return "Groq error: " + json.getAsJsonObject("error").get("message").getAsString();
	        }

	        return json.getAsJsonArray("choices")
	                   .get(0).getAsJsonObject()
	                   .getAsJsonObject("message")
	                   .get("content").getAsString();

	    } catch (Exception e) {
	        System.err.println(">>> [GROQ] Exception:");
	        e.printStackTrace();
	        return "AI hiện không phản hồi được: " + e.getMessage();
	    } finally {
	        if (conn != null) conn.disconnect();
	    }
	}

	// Helper để đọc stream
	private static String readStream(InputStream is) throws IOException {
	    if (is == null) return "No response body";
	    StringBuilder sb = new StringBuilder();
	    try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
	        String line;
	        while ((line = br.readLine()) != null) {
	            sb.append(line);
	        }
	    }
	    return sb.toString();
	}
}