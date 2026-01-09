package controller;

import model.PlayListDao;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/deletePlaylist")
public class DeletePlaylistController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idRaw = request.getParameter("id");
        if (idRaw == null || idRaw.trim().isEmpty()) {
            response.sendRedirect("playlist");
            return;
        }

        try {
            int playlistId = Integer.parseInt(idRaw);

            User user = (User) session.getAttribute("user");
            PlayListDao dao = new PlayListDao();

            // 🔐 kiểm tra quyền sở hữu
            if (!dao.isPlaylistOwnedByUser(playlistId, user.getId())) {
                response.sendRedirect("playlist");
                return;
            }

            // 🗑 xóa playlist (DAO tự xử lý xóa playlist_music trước)
            dao.deletePlaylist(playlistId);

            response.sendRedirect("playlist");

        } catch (NumberFormatException e) {
            response.sendRedirect("playlist");
        }
    }
}

