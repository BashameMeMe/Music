package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;
import model.AiMessage;
import model.User;

@WebServlet("/ai/history")
public class AiHistoryController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		User user = (User) req.getSession().getAttribute("user");
		if (user == null) {
			resp.setStatus(401);
			return;
		}
		System.out.println(user.getId());
		List<AiMessage> history = AiMessageDao.getHistory(user.getId());

		resp.setContentType("application/json;charset=UTF-8");
		resp.getWriter().write(new Gson().toJson(history));
	}
}