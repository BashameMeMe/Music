<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music App | Hồ sơ</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">

</head>
<body>
<div class="app">

    <!-- SIDEBAR -->
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="profile" />
    </jsp:include>

    <!-- MAIN CONTENT -->
    <div class="main">
        <div class="profile-container">

            <!-- Tabs -->
            <div class="tabs">
                <button class="tab-btn active" onclick="openTab('info')">Thông tin</button>
                <button class="tab-btn" onclick="openTab('email')">Email</button>
                <button class="tab-btn" onclick="openTab('password')">Mật khẩu</button>
            </div>

            <!-- Tab 1: Thông tin & Avatar -->
            <div id="info" class="tab-content active">
                <div class="avatar-wrapper">
                    <img 
                        src="${pageContext.request.contextPath}/image/${empty sessionScope.user.avatar ? '10.png' : sessionScope.user.avatar}"
                        alt="Avatar">
                </div>
                <h2>${sessionScope.username}</h2>
                <p class="user-role">Người dùng Music App</p>

                <!-- Upload Avatar -->
                <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                    <input type="file" name="avatar" accept="image/*" required>
                    <button type="submit" class="btn btn-primary">Cập nhật ảnh đại diện</button>
                </form>

                <!-- Messages -->
                <c:if test="${not empty message}">
                    <div class="message success">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="message error">${error}</div>
                </c:if>
            </div>

            <!-- Tab 2: Cập nhật Email -->
            <div id="email" class="tab-content" style="display:none;">
                <h3 style="margin-bottom:24px; text-align:center;">Cập nhật Email</h3>
                <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                    <input type="email" name="email" placeholder="Email mới" required>
                    <button type="submit" class="btn btn-primary">Cập nhật Email</button>
                </form>
            </div>

            <!-- Tab 3: Đổi mật khẩu -->
            <div id="password" class="tab-content" style="display:none;">
                <h3 style="margin-bottom:24px; text-align:center;">Đổi mật khẩu</h3>
                <form action="${pageContext.request.contextPath}/changePassword" method="post">
                    <input type="password" name="oldPass" placeholder="Mật khẩu cũ" required>
                    <input type="password" name="newPass" placeholder="Mật khẩu mới" required>
                    <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                </form>
            </div>

            <!-- Logout -->
            <form action="${pageContext.request.contextPath}/logout" method="post" style="margin-top:40px;">
                <button type="submit" class="btn btn-danger">Đăng xuất</button>
            </form>
        </div>
    </div>
</div>


<script>
function openTab(tabName) {
    document.querySelectorAll('.tab-content').forEach(tab => tab.style.display = 'none');
    document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));

    document.getElementById(tabName).style.display = 'block';
    event.currentTarget.classList.add('active');
}

</script>
</body>
</html>