package controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Music;
import model.MusicDao;

/**
 * Servlet implementation class AdminDeleteMusicController
 */
@WebServlet("/deleteMusic")
public class AdminDeleteMusicController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        MusicDao dao = new MusicDao();
        Music m = dao.getMusicById(id);

        String base = req.getServletContext().getRealPath("");
        new File(base + m.getFilePath()).delete();

        if (m.getCoverImage() != null)
            new File(base + "/image/" + m.getCoverImage()).delete();

        dao.deleteMusic(id);
        resp.sendRedirect(req.getContextPath() + "/music");
    }
}
