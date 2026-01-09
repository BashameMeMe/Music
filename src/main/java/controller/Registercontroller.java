package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;
import model.UserDao;
import util.HashPassword;
@WebServlet("/register")
public class Registercontroller extends HttpServlet{
	   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        // Hiển thị trang register.jsp
	        request.getRequestDispatcher("register.jsp").forward(request, response);
	    }

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        String username = request.getParameter("username");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password");
	        String confirmPassword = request.getParameter("confirmPassword");

	        // Kiểm tra password và confirm password
	        if (!password.equals(confirmPassword)) {
	            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
	            request.getRequestDispatcher("register.jsp").forward(request, response);
	            return;
	        }

	        UserDao userDAO = new UserDao();
	        User newUser = new User();
	        newUser.setUsername(username);
	        newUser.setEmail(email);
	        newUser.setPassword(HashPassword.hasPasword(password)); 

	        boolean success = userDAO.register(newUser);
	        if (success) {
	 
	            response.sendRedirect("login.jsp");
	        } else {
	            request.setAttribute("error", "Tên đăng nhập đã tồn tại hoặc lỗi hệ thống!");
	            request.getRequestDispatcher("register.jsp").forward(request, response);
	        }
	    }
}
