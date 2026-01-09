package controller;

import model.User;
import model.UserDao;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;

@WebServlet("/editUser")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,
	    maxFileSize = 5 * 1024 * 1024,
	    maxRequestSize = 10 * 1024 * 1024
	)
public class AdminEditUserController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = "image";

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int id = Integer.parseInt(req.getParameter("id"));
			UserDao dao = new UserDao();
			User user = dao.getById(id);
			req.setAttribute("user", user);
			req.getRequestDispatcher("/edit-user.jsp").forward(req, resp);
		} catch (NumberFormatException e) {
			resp.sendRedirect(req.getContextPath() + "/users");
		}
	}

	private UserDao userDao = new UserDao();

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            String balanceStr = request.getParameter("balance");
            double balance = (balanceStr != null && !balanceStr.isEmpty()) ? Double.parseDouble(balanceStr) : 0.0;
            Part avatarPart = request.getPart("avatar");
            String avatar = request.getParameter("oldAvatar");       
            if (avatarPart != null && avatarPart.getSize() > 0 && avatarPart.getSubmittedFileName() != null && !avatarPart.getSubmittedFileName().isEmpty()) {
                avatar = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
                avatar = System.currentTimeMillis() + "_" + avatar;
                String uploadPath = getServletContext().getRealPath("/image");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                avatarPart.write(uploadPath + File.separator + avatar);
            }
            String vipDateStr = request.getParameter("vip_expiration_date");
            Timestamp vipExpirationDate = null;
            if (vipDateStr != null && !vipDateStr.trim().isEmpty()) {
                if (vipDateStr.contains("T")) {
                    vipDateStr = vipDateStr.replace("T", " ");
                    if (vipDateStr.length() == 16) {
                        vipDateStr += ":00";
                    }
                }
                vipExpirationDate = Timestamp.valueOf(vipDateStr);
            }

            // 4. Tạo User object và Update
            User u = new User();
            u.setId(id);
            u.setUsername(username);
            u.setEmail(email);
            u.setAvatar(avatar);
            u.setRole(role);
            u.setBalance(balance);
            u.setVipExpirationDate(vipExpirationDate);

            userDao.update(u);

            response.sendRedirect(request.getContextPath() + "/users");

        } catch (Exception e) {
            e.printStackTrace(); // Xem lỗi trong Console Eclipse
            request.setAttribute("error", "Lỗi cập nhật: " + e.getMessage());
            // Cần lấy lại thông tin user để hiển thị lại form nếu lỗi
            doGet(request, response); 
        }
    }
}