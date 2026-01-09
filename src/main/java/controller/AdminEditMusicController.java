package controller;

import model.Music;
import model.MusicDao;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/editMusic")
@MultipartConfig
public class AdminEditMusicController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Music music = new MusicDao().getMusicById(id);

        req.setAttribute("music", music);
        req.getRequestDispatcher("/edit-music.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String artist = req.getParameter("artist");

        MusicDao dao = new MusicDao();
        Music old = dao.getMusicById(id);

        Part musicPart = req.getPart("musicFile");
        Part imagePart = req.getPart("coverImage");

        String basePath = req.getServletContext().getRealPath("");

        String musicPath = old.getFilePath();
        String coverImage = old.getCoverImage();

        /* 🔄 UPDATE MP3 */
        if (musicPart != null && musicPart.getSize() > 0) {
            new File(basePath + musicPath).delete();

            String newMusic = System.currentTimeMillis() + "_" + musicPart.getSubmittedFileName();
            musicPart.write(basePath + "/music/" + newMusic);
            musicPath = "/music/" + newMusic;
        }

        /* 🔄 UPDATE COVER */
        if (imagePart != null && imagePart.getSize() > 0) {
            if (coverImage != null)
                new File(basePath + "/image/" + coverImage).delete();

            String newImage = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
            imagePart.write(basePath + "/image/" + newImage);
            coverImage = newImage;
        }

        Music m = new Music(id, title, artist, musicPath, coverImage);
        dao.updateMusic(m);

        resp.sendRedirect(req.getContextPath() + "/music");
    }
}
