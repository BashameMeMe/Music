package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import model.UserDao;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("admin-login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		UserDao userDAO = new UserDao();
		User user = userDAO.login(username, password);
		String error = "";
		if (user == null) {
			error = "Tên đăng nhập hoặc mật khẩu không đúng!";
		} else {

			if ("ADMIN".equalsIgnoreCase(user.getRole())) {
				HttpSession session = request.getSession();
				session.setAttribute("admin", user);
				response.sendRedirect("dashboard");

				return;
			} else {
				error = "Tài khoản này không có quyền truy cập trang quản trị!";
			}
		}

		request.setAttribute("error", error);
		request.getRequestDispatcher("admin-login.jsp").forward(request, response);
	}
}