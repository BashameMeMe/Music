package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.FavoriteDao;
import model.Music;
import model.User;

/**
 * Servlet implementation class Favoritecontroller
 */
@WebServlet("/favorite")
public class Favoritecontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ===== 1. BẮT BUỘC LOGIN =====
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		User user = (User) session.getAttribute("user");
		int userId = user.getId();

		FavoriteDao dao = new FavoriteDao();

		// ===== 2. TOGGLE FAVORITE (nếu có musicId) =====
		String musicIdRaw = request.getParameter("musicId");
		if (musicIdRaw != null && !musicIdRaw.isEmpty()) {
			try {
				int musicId = Integer.parseInt(musicIdRaw);

				if (dao.isFavorite(userId, musicId)) {
					dao.removeFavorite(userId, musicId);
				} else {
					dao.addFavorite(userId, musicId);
				}

				String referer = request.getHeader("Referer");
				response.sendRedirect(referer != null ? referer : "musiclist");
				return;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// ===== 3. HIỂN THỊ FAVORITE =====
		List<Music> favoriteList = dao.getFavoriteMusicByUser(userId);
		request.setAttribute("favoriteList", favoriteList);
		request.getRequestDispatcher("favorite.jsp").forward(request, response);
	}
}
