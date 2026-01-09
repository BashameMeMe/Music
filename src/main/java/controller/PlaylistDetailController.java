package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Music;
import model.PlayList;
import model.PlayListDao;
import model.User;

@WebServlet("/playlistDetail")
public class PlaylistDetailController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	response.setCharacterEncoding("utf-8");
     
    	
    	HttpSession session = request.getSession(false);
    	if (session == null || session.getAttribute("user") == null) {
    	    response.sendRedirect("login.jsp");
    	    return;
    	}

    	// lấy user từ session
    	User user = (User) session.getAttribute("user");
    	int userId = user.getId();


        // 🔎 Lấy playlistId
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("playlist");
            return;
        }

        
        int playlistId = Integer.parseInt(idParam);
        PlayListDao dao = new PlayListDao();

        // 🎵 Lấy playlist
        PlayList playlist = null;
		try {
			playlist = dao.getPlaylistById(playlistId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
        // 🎶 Lấy danh sách bài hát
        List<Music> musicList = null;
		try {
			musicList = dao.getMusicInPlaylist(playlistId);
		} catch (Exception e) {
			e.printStackTrace();
		}

        request.setAttribute("playlist", playlist);
        request.setAttribute("musicList", musicList);

        request.getRequestDispatcher("playlistDetail.jsp").forward(request, response);
    }
}

