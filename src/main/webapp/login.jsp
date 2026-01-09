<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Music App | Đăng nhập</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto,
		Oxygen, Ubuntu, Cantarell, sans-serif;
	background: #0f0f0f;
	color: #fff;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: linear-gradient(135deg, #0f0f0f 0%, #121212 100%);
}

.login-container {
	background: #181818;
	border-radius: 16px;
	padding: 48px 40px;
	width: 100%;
	max-width: 420px;
	box-shadow: 0 16px 40px rgba(0, 0, 0, 0.6);
	border: 1px solid #282828;
	position: relative;
	overflow: hidden;
}

.login-container::before {
	content: "";
	position: absolute;
	top: -50%;
	left: -50%;
	width: 200%;
	height: 200%;
	background: radial-gradient(circle at 30% 20%, rgba(194, 115, 237, 0.12)
		0%, transparent 60%);
	pointer-events: none;
}

.logo {
	font-size: 36px;
	font-weight: bold;
	color: #c273ed;
	text-align: center;
	margin-bottom: 12px;
	letter-spacing: -1px;
}

.subtitle {
	color: #b3b3b3;
	text-align: center;
	margin-bottom: 40px;
	font-size: 15px;
}

h2 {
	text-align: center;
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 8px;
}

.form-group {
	margin-bottom: 24px;
	position: relative;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-size: 14px;
	font-weight: 500;
	color: #ddd;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 14px 16px;
	background: #282828;
	border: 1px solid #444;
	border-radius: 8px;
	color: white;
	font-size: 16px;
	transition: all 0.2s;
}

input:focus {
	outline: none;
	border-color: #c273ed;
	box-shadow: 0 0 0 2px rgba(194, 115, 237, 0.3);
}

.btn-login {
	width: 100%;
	padding: 14px;
	background: #c273ed;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
	margin-top: 12px;
}

.btn-login:hover {
	background: #b35ed9;
	transform: translateY(-2px);
}

.error {
	color: #ff4d4d;
	text-align: center;
	margin-bottom: 20px;
	font-size: 14px;
	background: rgba(255, 77, 77, 0.1);
	padding: 10px;
	border-radius: 8px;
	border: 1px solid rgba(255, 77, 77, 0.3);
}

.register-link {
	text-align: center;
	margin-top: 28px;
	color: #b3b3b3;
	font-size: 15px;
}

.register-link a {
	color: #c273ed;
	text-decoration: none;
	font-weight: 500;
}

.register-link a:hover {
	text-decoration: underline;
}

.back-home {
	text-align: center;
	margin-top: 24px;
}

.back-home a {
	color: #b3b3b3;
	text-decoration: none;
	font-size: 14px;
}

.back-home a:hover {
	color: #fff;
}
</style>
</head>
<body>

	<div class="login-container">
		<div class="logo">
			<i class="fas fa-music"></i> Music App
		</div>

		<h2>Đăng nhập</h2>

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>

		<form action="login" method="post">
			<div class="form-group">
				<label for="username">Tên đăng nhập</label> <input type="text"
					id="username" name="username" placeholder="Nhập tên đăng nhập"
					required autofocus>
			</div>

			<div class="form-group">
				<label for="password">Mật khẩu</label> <input type="password"
					id="password" name="password" placeholder="Nhập mật khẩu" required>
			</div>

			<button type="submit" class="btn-login">Đăng nhập</button>
		</form>

		<div class="register-link">
			Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
		</div>

		<div class="back-home">
			<a href="musiclist">← Quay về trang chủ</a>
			<p class="admin-link">
				<a href="admin-login.jsp"> <i class="fas fa-user-shield"></i>
					Đăng nhập Admin
				</a>
			</p>
		</div>

	</div>

</body>
</html>