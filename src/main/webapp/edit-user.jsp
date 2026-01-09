<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | Chỉnh sửa người dùng</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #0a0a0a;
            color: #f5f5f5;
            min-height: 100vh;
        }
        
        .admin-container {
            max-width: 580px;
            margin: 60px auto;
            background: #181818;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 16px 60px rgba(0,0,0,0.7);
            border: 1px solid #282828;
        }
        
        h1 {
            text-align: center;
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 32px;
            color: #c273ed;
        }
        
        .avatar-preview {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #c273ed;
            margin: 0 auto 24px;
            display: block;
            box-shadow: 0 8px 32px rgba(194,115,237,0.3);
        }
        
        .form-group {
            margin-bottom: 24px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #b3b3b3;
            font-size: 14px;
            font-weight: 500;
        }
        
        input, select {
            width: 100%;
            padding: 14px 16px;
            background: #282828;
            border: 1px solid #444;
            border-radius: 10px;
            color: white;
            font-size: 15px;
            transition: all 0.25s;
        }
        
        input:focus, select:focus {
            outline: none;
            border-color: #c273ed;
            box-shadow: 0 0 0 3px rgba(194,115,237,0.2);
        }
        
        .btn {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #c273ed;
            color: white;
        }
        
        .btn-primary:hover {
            background: #b35ed9;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #444;
            color: white;
            margin-top: 12px;
        }
        
        .btn-secondary:hover {
            background: #555;
        }
        
        .message {
            padding: 14px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .success { background: rgba(40,167,69,0.2); color: #28a745; }
        .error   { background: rgba(220,53,69,0.2); color: #dc3545; }
    </style>
</head>
<body>

<div class="admin-container">
    <h1>✏️ Chỉnh sửa người dùng</h1>

    <c:if test="${not empty message}">
        <div class="message success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/editUser" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${user.id}"/>

        <img class="avatar-preview"
             src="${pageContext.request.contextPath}/image/${empty user.avatar ? 'default.png' : user.avatar}"
             alt="Avatar"/>

        <div class="form-group">
            <label>Thay đổi ảnh đại diện</label>
            <input type="file" name="avatar" accept="image/*">
        </div>

        <div class="form-group">
            <label>Tên đăng nhập</label>
            <input type="text" name="username" value="${user.username}" required>
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" value="${user.email}" required>
        </div>

        <div class="form-group">
            <label>Quyền</label>
            <select name="role">
                <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>USER</option>
                <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
            </select>
        </div>

        <div class="form-group">
            <label>Số dư ví (VND)</label>
            <input type="number" name="balance" step="1000" min="0" 
                   value="${String.format('%.0f', user.balance)}">
        </div>

        <div class="form-group">
            <label>Ngày hết hạn VIP</label>
            <input type="datetime-local" name="vip_expiration_date"
                   value="${user.vipExpirationDate != null ? user.vipExpirationDate.toString().replace(' ', 'T').substring(0,16) : ''}">
        </div>

        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/users" class="btn btn-secondary" style="text-align:center; display:block; text-decoration:none;">Quay lại</a>
    </form>
</div>

</body>
</html>