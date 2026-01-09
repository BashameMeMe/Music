package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.PlayListDao;

/**
 * Servlet implementation class Playlistcontroller
 */
@WebServlet("/playlist")
public class Playlistcontroller extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        PlayListDao dao = new PlayListDao();
        var playlists = dao.getPlaylists(userId);
        request.setAttribute("playlists", playlists);
        request.getRequestDispatcher("playlist.jsp").forward(request, response);
    }
}
