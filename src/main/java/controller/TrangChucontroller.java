package controller;

import model.MusicDao;
import model.Music;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.util.List;

@WebServlet("/musiclist")
public class TrangChucontroller extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
    	response.setCharacterEncoding("utf-8");
		MusicDao dao = new MusicDao();
		List<Music> list = dao.getAllMusic();
		request.setAttribute("musiclist", list);
		request.getRequestDispatcher("/musiclist.jsp").forward(request, response);
	}
}
