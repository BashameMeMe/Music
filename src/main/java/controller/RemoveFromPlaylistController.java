package controller;


import model.PlayListDao;
import model.User;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
@WebServlet("/removeFromPlaylist")
public class RemoveFromPlaylistController extends HttpServlet {

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

        String playlistIdRaw = request.getParameter("playlistId");
        String musicIdRaw = request.getParameter("musicId");

        if (playlistIdRaw == null || musicIdRaw == null) {
            response.sendRedirect("playlist");
            return;
        }

        try {
            int playlistId = Integer.parseInt(playlistIdRaw);
            int musicId = Integer.parseInt(musicIdRaw);

            User user = (User) session.getAttribute("user");

            PlayListDao dao = new PlayListDao();

            // 🔐 KIỂM TRA PLAYLIST CÓ THUỘC USER KHÔNG
            if (!dao.isPlaylistOwnedByUser(playlistId, user.getId())) {
                response.sendRedirect("playlist");
                return;
            }

            dao.removeMusicFromPlaylist(playlistId, musicId);
            response.sendRedirect("playlistDetail?id=" + playlistId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("playlist");
        }
    }
}

