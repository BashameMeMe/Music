package controller;

import model.MusicDao;
import model.UserDao;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class AdminDashboardController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        UserDao userDao = new UserDao();
        MusicDao musicDao = new MusicDao();

        req.setAttribute("totalUsers", userDao.countUsers());
        req.setAttribute("totalMusic", musicDao.countMusic());

        req.setAttribute("latestUsers", userDao.getLatestUsers(5));

        req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
    }
}
