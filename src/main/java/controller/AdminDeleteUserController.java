package controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.UserDao;

/**
 * Servlet implementation class DeleteUserController
 */
@WebServlet("/deleteUser")
public class AdminDeleteUserController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String idRaw = request.getParameter("id");

        if (idRaw != null) {
            int id = Integer.parseInt(idRaw);
            new UserDao().delete(id);
        }

        response.sendRedirect(request.getContextPath() + "/users");
    }
}

