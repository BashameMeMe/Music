package controller;

import model.PlayListDao;
import model.User;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/createPlaylist")
public class CreatePlaylistController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ CHECK LOGIN
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2️⃣ LẤY USER
        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        // 3️⃣ LẤY TÊN PLAYLIST
        String name = request.getParameter("playlistName");
        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect("playlist");
            return;
        }

        // 4️⃣ TẠO PLAYLIST
        PlayListDao dao = new PlayListDao();
        dao.createPlaylist(name.trim(), userId);

        response.sendRedirect("playlist");
    }
}
