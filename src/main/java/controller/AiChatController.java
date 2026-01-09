package controller;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import model.*;
import model.User;
import service.GroqService;

@WebServlet("/ai/chat")
public class AiChatController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("application/json;charset=UTF-8");

		User user = (User) req.getSession().getAttribute("user");
		JsonObject json = new JsonObject();

		if (user == null) {
			json.addProperty("reply", "❌ Chưa đăng nhập");
			resp.getWriter().write(json.toString());
			return;
		}

		String message = req.getParameter("message");
		if (message == null || message.trim().isEmpty()) {
			json.addProperty("reply", "❌ Tin nhắn rỗng");
			resp.getWriter().write(json.toString());
			return;
		}

		long userId = user.getId();
		AiMessageDao.save(userId, "user", message);
		String reply = GroqService.ask(message);
		AiMessageDao.save(userId, "assistant", reply);
		json.addProperty("reply", reply);
		resp.getWriter().write(json.toString());
	}
}