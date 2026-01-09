package controller;

import model.PlayList;
import model.PlayListDao;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/addToPlaylist")
public class Addtoplaylistcontroller extends HttpServlet {
  
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int musicId = Integer.parseInt(request.getParameter("musicId"));

        PlayListDao dao = new PlayListDao();
        List<PlayList> playlists = dao.getPlaylists(userId);
        request.setAttribute("musicId", musicId);
        request.setAttribute("playlists", playlists);
        request.getRequestDispatcher("addToPlaylist.jsp").forward(request, response);
    }
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int playlistId = Integer.parseInt(request.getParameter("playlistId"));
        int musicId = Integer.parseInt(request.getParameter("musicId"));
        PlayListDao dao = new PlayListDao();
        try {
			dao.addMusicToPlaylist(playlistId, musicId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        response.sendRedirect("musiclist");
    }

}
