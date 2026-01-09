package controller;

import model.UserDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp; // Nhớ import cái này

@WebServlet("/adduser")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class AdminAddUserController extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 1. Lấy thông tin cơ bản
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String role = request.getParameter("role");

		// 2. Xử lý Balance (Chuyển String sang Double)
		String balanceStr = request.getParameter("balance");
		double balance = 0.0;
		try {
			if (balanceStr != null && !balanceStr.isEmpty()) {
				balance = Double.parseDouble(balanceStr);
			}
		} catch (NumberFormatException e) {
			System.out.println("Lỗi format số dư, set về 0");
		}

		// 3. Xử lý Vip Expiration Date (Chuyển String sang Timestamp)
		String vipDateStr = request.getParameter("vip_expiration_date");
		Timestamp vipExpirationDate = null;

		try {
			if (vipDateStr != null && !vipDateStr.trim().isEmpty()) {

				if (vipDateStr.contains("T")) {
					vipDateStr = vipDateStr.replace("T", " ");

					if (vipDateStr.length() == 16) {
						vipDateStr += ":00";
					}
				} else if (vipDateStr.length() == 10) {
					vipDateStr += " 00:00:00";
				}
				vipExpirationDate = Timestamp.valueOf(vipDateStr);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi format ngày tháng: " + vipDateStr);
		}

		Part avatarPart = request.getPart("avatar");
		String avatarFileName = null;

		if (avatarPart != null && avatarPart.getSize() > 0) {
			String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
			avatarFileName = System.currentTimeMillis() + "_" + fileName;

			String uploadPath = getServletContext().getRealPath("/image");
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists())
				uploadDir.mkdirs();

			avatarPart.write(uploadPath + File.separator + avatarFileName);
		}
		UserDao dao = new UserDao();

		dao.insert(username, password, email, avatarFileName, role, balance, vipExpirationDate);

		response.sendRedirect(request.getContextPath() + "/users");
	}
}