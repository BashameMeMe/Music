<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    .admin-sidebar {
        width: 260px;
        height: 100vh;
        background: linear-gradient(180deg, #0f0f0f 0%, #000 100%);
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        padding: 32px 20px;
        border-right: 1px solid #1a1a1a;
        overflow-y: auto;
        transition: width 0.4s ease;
    }

    /* Logo */
    .logo {
        display: flex;
        align-items: center;
        gap: 14px;
        font-size: 28px;
        font-weight: 900;
        margin-bottom: 48px;
        background: linear-gradient(90deg, #c273ed, #9b5de5);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        letter-spacing: -1px;
    }

    .logo i {
        font-size: 32px;
    }

    /* Menu */
    .menu-list {
        margin-bottom: 40px;
    }

    .menu-item {
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 16px 20px;
        color: #b0b0b0;
        text-decoration: none;
        border-radius: 12px;
        font-size: 15px;
        font-weight: 500;
        margin: 8px 0;
        transition: all 0.3s ease;
        position: relative;
    }

    .menu-item:hover {
        background: rgba(194, 115, 237, 0.12);
        color: white;
        transform: translateX(8px);
    }

    .menu-item.active {
        background: rgba(194, 115, 237, 0.22);
        color: #c273ed;
        font-weight: 700;
    }

    .menu-item.active::before {
        content: '';
        position: absolute;
        left: -8px;
        top: 50%;
        width: 6px;
        height: 32px;
        background: #c273ed;
        border-radius: 4px;
        transform: translateY(-50%);
    }

    /* User Info (dưới cùng) */
    .user-section {
        margin-top: 60px;
        padding-top: 20px;
        border-top: 1px solid #222;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 14px;
        padding: 14px 20px;
        border-radius: 12px;
        background: rgba(40, 40, 40, 0.4);
        transition: all 0.3s;
    }

    .user-info:hover {
        background: rgba(60, 60, 60, 0.6);
    }

    .user-avatar {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #c273ed;
    }

    .user-details {
        flex: 1;
    }

    .user-name {
        font-weight: 700;
        font-size: 15px;
    }

    .user-role {
        font-size: 13px;
        color: #888;
    }

    .logout-btn {
        margin-top: 16px;
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 14px 20px;
        color: #ff6b6b;
        text-decoration: none;
        border-radius: 12px;
        transition: all 0.3s;
    }

    .logout-btn:hover {
        background: rgba(255, 107, 107, 0.15);
        color: #ff8787;
    }

    /* Responsive */
    @media (max-width: 992px) {
        .admin-sidebar {
            width: 80px;
            padding: 32px 12px;
        }
        
        .logo span,
        .menu-item span,
        .user-name,
        .user-role,
        .logout-btn span {
            display: none;
        }
        
        .menu-item {
            justify-content: center;
        }
        
        .user-info {
            justify-content: center;
            padding: 12px;
        }
    }
</style>

<div class="admin-sidebar">
    <div class="logo">
        <i class="fas fa-user-shield"></i>
        <span>Admin</span>
    </div>

    <div class="menu-list">
        <a href="${pageContext.request.contextPath}/dashboard" 
           class="menu-item ${param.active == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>

        <a href="${pageContext.request.contextPath}/users" 
           class="menu-item ${param.active == 'users' ? 'active' : ''}">
            <i class="fas fa-users-cog"></i>
            <span>Quản lý người dùng</span>
        </a>

        <a href="${pageContext.request.contextPath}/music" 
           class="menu-item ${param.active == 'music' ? 'active' : ''}">
            <i class="fas fa-music"></i>
            <span>Quản lý nhạc</span>
        </a>

        <a href="${pageContext.request.contextPath}/musiclist" 
           class="menu-item ${param.active == 'reports' ? 'active' : ''}">
            <i class="fas fa-chart-line"></i>
            <span>Quay Lại Menu</span>
        </a>
    </div>

    <!-- Phần thông tin admin -->
    <div class="user-section">
        <div class="user-info">
            <img 
                class="user-avatar"
                src="${pageContext.request.contextPath}/image/${empty sessionScope.admin.avatar ? 'default-admin.png' : sessionScope.admin.avatar}"
                alt="Admin">
            <div class="user-details">
                <div class="user-name">${sessionScope.admin.username}</div>
                <div class="user-role">Administrator</div>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            <span>Đăng xuất</span>
        </a>
    </div>
</div>