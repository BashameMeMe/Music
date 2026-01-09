package controller;

import model.User;
import model.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/changePassword")
public class ChangePasswordController extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");

        UserDao dao = new UserDao();

        if (!dao.checkPassword(user.getId(), oldPass)) {
            request.setAttribute("error", "Mật khẩu cũ không đúng");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        dao.updatePassword(user.getId(), newPass);

        request.setAttribute("message", "Đổi mật khẩu thành công");
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
