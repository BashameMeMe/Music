package controller;

import model.Music;
import model.MusicDao;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

@WebServlet("/addMusic")
@MultipartConfig
public class AdminAddMusicController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String MUSIC_DIR = "music";
	private static final String IMAGE_DIR = "image";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.getRequestDispatcher("/add-music.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
    	resp.setCharacterEncoding("utf-8");

		String title = req.getParameter("title");
		String artist = req.getParameter("artist");

		Part musicPart = req.getPart("musicFile");
		Part imagePart = req.getPart("coverImage");

		String musicName = System.currentTimeMillis() + "_" + musicPart.getSubmittedFileName();
		String imageName = imagePart.getSize() > 0 ? System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName()
				: null;

		String basePath = req.getServletContext().getRealPath("");

		musicPart.write(basePath + File.separator + MUSIC_DIR + File.separator + musicName);

		if (imageName != null) {
			imagePart.write(basePath + File.separator + IMAGE_DIR + File.separator + imageName);
		}

		Music m = new Music(0, title, artist, "/" + MUSIC_DIR + "/" + musicName, imageName);

		new MusicDao().addMusic(m);

		resp.sendRedirect(req.getContextPath() + "/music");
	}
}
