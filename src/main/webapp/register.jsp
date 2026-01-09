<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Music App | Đăng Ký</title>

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
}

.register-container {
	background: #181818;
	border-radius: 16px;
	padding: 48px 40px;
	width: 100%;
	max-width: 420px;
	border: 1px solid #282828;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
}

.logo {
	font-size: 32px;
	font-weight: bold;
	color: #c273ed;
	text-align: center;
	margin-bottom: 8px;
}

.subtitle {
	color: #b3b3b3;
	text-align: center;
	margin-bottom: 32px;
	font-size: 15px;
}

h2 {
	text-align: center;
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 32px;
}

.form-group {
	margin-bottom: 24px;
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
	transition: border-color 0.2s;
}

input:focus {
	outline: none;
	border-color: #c273ed;
}

.btn-register {
	width: 100%;
	padding: 14px;
	background: #28a745;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: background 0.2s;
	margin-top: 12px;
}

.btn-register:hover {
	background: #218838;
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

.extra-links {
	text-align: center;
	margin-top: 28px;
	color: #b3b3b3;
	font-size: 14px;
}

.extra-links a {
	color: #c273ed;
	text-decoration: none;
	margin: 0 5px;
}

.extra-links a:hover {
	text-decoration: underline;
}

/* Thêm style cho link admin để nó hơi khác biệt chút (tùy chọn) */
.admin-link {
    display: inline-block;
    margin-top: 10px;
    font-size: 13px;
    opacity: 0.8;
}

.password-match {
	margin-top: 8px;
	font-size: 13px;
	text-align: right;
}

.password-match.valid {
	color: #28a745;
}

.password-match.invalid {
	color: #ff4d4d;
}
</style>
</head>
<body>

	<div class="register-container">
		<div class="logo">
			<i class="fas fa-music"></i> Music App
		</div>
		<div class="subtitle">Tạo tài khoản để bắt đầu</div>

		<h2>Đăng Ký</h2>

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>

		<form action="register" method="post" id="registerForm">
			<div class="form-group">
				<label for="username">Tên đăng nhập</label> 
				<input type="text" id="username" name="username" required autofocus>
			</div>
			
			<div class="form-group">
				<label for="email">Email</label> 
				<input type="text" id="email" name="email" required>
			</div>
			
			<div class="form-group">
				<label for="password">Mật khẩu</label> 
				<input type="password" id="password" name="password" required minlength="6">
			</div>

			<div class="form-group">
				<label for="confirmPassword">Xác nhận mật khẩu</label> 
				<input type="password" id="confirmPassword" name="confirmPassword" required>
				<div class="password-match" id="passwordMatch"></div>
			</div>

			<button type="submit" class="btn-register" id="registerBtn">Đăng Ký</button>
		</form>

		<div class="extra-links">
			<p>
				Đã có tài khoản? <a href="login.jsp">Đăng nhập</a>
			</p>
			<p>
				<a href="musiclist">← Về trang chủ</a>
			</p>
			
		</div>
	</div>

	<script>
		const password = document.getElementById('password');
		const confirmPassword = document.getElementById('confirmPassword');
		const passwordMatch = document.getElementById('passwordMatch');
		const registerBtn = document.getElementById('registerBtn');

		function checkMatch() {
			if (!confirmPassword.value) {
				passwordMatch.textContent = '';
				return;
			}

			if (password.value === confirmPassword.value) {
				passwordMatch.textContent = 'Mật khẩu khớp';
				passwordMatch.className = 'password-match valid';
				registerBtn.disabled = false;
			} else {
				passwordMatch.textContent = 'Mật khẩu không khớp';
				passwordMatch.className = 'password-match invalid';
				registerBtn.disabled = true;
			}
		}

		password.addEventListener('input', checkMatch);
		confirmPassword.addEventListener('input', checkMatch);

		// Form validation trước submit
		document.getElementById('registerForm').addEventListener('submit',
				function(e) {
					if (password.value !== confirmPassword.value) {
						e.preventDefault();
						alert('Mật khẩu xác nhận không khớp!');
						confirmPassword.focus();
					} else if (password.value.length < 6) {
						e.preventDefault();
						alert('Mật khẩu phải có ít nhất 6 ký tự!');
						password.focus();
					}
				});
	</script>

</body>
</html>