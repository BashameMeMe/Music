<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | Quản lý người dùng</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        body { font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #0a0a0a; color: #f5f5f5; margin:0; }
        .main-content { margin-left: 260px; padding: 40px; }
        h1 { font-size: 36px; font-weight: 800; margin-bottom: 8px; background: linear-gradient(90deg, #c273ed, #9b5de5); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .subtitle { color: #b0b0b0; font-size: 16px; margin-bottom: 32px; }
        
        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
        .btn-add { background: linear-gradient(90deg, #c273ed, #9b5de5); color: white; padding: 12px 28px; border-radius: 50px; text-decoration: none; font-weight: 600; box-shadow: 0 6px 20px rgba(194,115,237,0.3); transition: all 0.3s; }
        .btn-add:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(194,115,237,0.45); }
        
        table { width: 100%; border-collapse: collapse; background: #181818; border-radius: 16px; overflow: hidden; box-shadow: 0 8px 32px rgba(0,0,0,0.4); }
        th, td { padding: 18px 24px; text-align: left; }
        th { background: #222; color: #b0b0b0; font-weight: 600; font-size: 14px; text-transform: uppercase; letter-spacing: 0.5px; }
        tr { border-bottom: 1px solid #282828; transition: all 0.25s; }
        tr:hover { background: #282828; }
        
        .vip-active { color: #28a745; font-weight: 700; background: rgba(40,167,69,0.15); padding: 6px 12px; border-radius: 20px; }
        .not-vip { color: #777; font-style: italic; }
        
        .action-links a { margin-right: 16px; text-decoration: none; font-weight: 600; transition: all 0.2s; }
        .action-links .edit { color: #c273ed; }
        .action-links .delete { color: #ff6b6b; }
        .action-links a:hover { opacity: 0.8; transform: scale(1.05); }
        
        @media (max-width: 992px) {
            .main-content { margin-left: 80px; padding: 24px; }
            table { font-size: 14px; }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<jsp:include page="admin-sidebar.jsp">
    <jsp:param name="active" value="users" />
</jsp:include>

<div class="main-content">
    <h1>Quản lý người dùng</h1>
    <p class="subtitle">Theo dõi & quản lý tất cả tài khoản</p>

    <div class="header-actions">
        <div></div>
        <a href="${pageContext.request.contextPath}/add-users.jsp" class="btn-add">
            <i class="fas fa-plus"></i> Thêm người dùng mới
        </a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên đăng nhập</th>
                <th>Email</th>
                <th>Quyền</th>
                <th>Số dư (VND)</th>
                <th>Hạn VIP</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${users}" var="u">
                <tr>
                    <td><strong>${u.id}</strong></td>
                    <td>${u.username}</td>
                    <td>${u.email}</td>
                    <td>
                        <span class="badge ${u.role == 'ADMIN' ? 'badge-admin' : 'badge-user'}">
                            ${u.role}
                        </span>
                    </td>
                    <td>
                        <fmt:formatNumber value="${u.balance}" type="number" groupingUsed="true"/> đ
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty u.vipExpirationDate}">
                                <span class="vip-active">
                                    <fmt:formatDate value="${u.vipExpirationDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </c:when>
                            <c:otherwise><span class="not-vip">-</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td class="action-links">
                        <a href="editUser?id=${u.id}" class="edit"><i class="fas fa-edit"></i> Sửa</a>
                        <a href="deleteUser?id=${u.id}" class="delete" onclick="return confirm('Xác nhận xóa người dùng ${u.username}?')">
                            <i class="fas fa-trash-alt"></i> Xóa
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>