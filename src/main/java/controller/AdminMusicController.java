package controller;

import model.Music;
import model.MusicDao;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/music")
public class AdminMusicController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        MusicDao dao = new MusicDao();
        List<Music> list = dao.getAllMusic();

        req.setAttribute("musics", list);
        req.getRequestDispatcher("/music.jsp").forward(req, resp);
    }
}
