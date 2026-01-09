<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Portal | Đăng Nhập</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* --- GIỮ NGUYÊN CSS NHƯ TRANG ĐĂNG KÝ ĐỂ ĐỒNG BỘ --- */
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background: #0a0a0a; /* Màu nền tối hơn chút cho trang admin */
    color: #fff;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}
.login-container {
    background: #181818;
    border-radius: 16px;
    padding: 48px 40px;
    width: 100%;
    max-width: 400px;
    border: 1px solid #333;
    box-shadow: 0 10px 40px rgba(194, 115, 237, 0.1); /* Ánh tím nhẹ */
}
.logo {
    font-size: 32px;
    font-weight: bold;
    color: #c273ed;
    text-align: center;
    margin-bottom: 8px;
}
.subtitle {
    color: #888;
    text-align: center;
    margin-bottom: 32px;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1px;
}
.form-group { margin-bottom: 24px; }
.form-group label {
    display: block; margin-bottom: 8px; font-size: 14px; font-weight: 500; color: #ddd;
}
input[type="text"], input[type="password"] {
    width: 100%; padding: 14px 16px; background: #222; border: 1px solid #444;
    border-radius: 8px; color: white; font-size: 16px; transition: all 0.3s;
}
input:focus { outline: none; border-color: #c273ed; background: #2a2a2a; }
.btn-login {
    width: 100%; padding: 14px;
    background: linear-gradient(135deg, #c273ed 0%, #a044d6 100%); /* Nút màu tím admin */
    color: white; border: none; border-radius: 8px; font-size: 16px; font-weight: 600;
    cursor: pointer; transition: opacity 0.2s; margin-top: 10px;
}
.btn-login:hover { opacity: 0.9; }
.error {
    color: #ff6b6b; text-align: center; margin-bottom: 20px; font-size: 14px;
    background: rgba(255, 107, 107, 0.1); padding: 12px; border-radius: 8px;
    border: 1px solid rgba(255, 107, 107, 0.2);
}
.back-link {
    text-align: center; margin-top: 24px; font-size: 14px;
}
.back-link a { color: #888; text-decoration: none; transition: color 0.2s; }
.back-link a:hover { color: #fff; }
</style>
</head>
<body>

    <div class="login-container">
        <div class="logo">
            <i class="fas fa-user-shield"></i> Admin Portal
        </div>
        <div class="subtitle">Quản trị hệ thống Music App</div>

        <c:if test="${not empty error}">
            <div class="error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form action="admin-login" method="post">
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" placeholder="Nhập username admin" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
            </div>

            <button type="submit" class="btn-login">
                Đăng nhập quản trị <i class="fas fa-arrow-right"></i>
            </button>
        </form>

        <div class="back-link">
            <a href="login.jsp">← Quay lại đăng nhập User</a>
        </div>
    </div>

</body>
</html>