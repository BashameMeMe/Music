package controller;

import model.User;
import model.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileController extends HttpServlet {

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

        String email = request.getParameter("email");

        if (email == null || email.isEmpty()) {
            request.setAttribute("error", "Email không hợp lệ");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        UserDao dao = new UserDao();
        dao.updateEmail(user.getId(), email);

        user.setEmail(email);
        session.setAttribute("user", user);

        request.setAttribute("message", "Cập nhật email thành công");
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
