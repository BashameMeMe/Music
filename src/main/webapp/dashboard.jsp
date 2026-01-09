<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | Dashboard</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        body {
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #0a0a0a;
            color: #f5f5f5;
            margin: 0;
            min-height: 100vh;
        }
        
        .main-content {
            margin-left: 260px;
            padding: 40px;
            min-height: 100vh;
        }
        
        h1 {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 8px;
            background: linear-gradient(90deg, #c273ed, #9b5de5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .subtitle {
            color: #b0b0b0;
            font-size: 16px;
            margin-bottom: 40px;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-bottom: 48px;
        }
        
        .stat-card {
            background: linear-gradient(135deg, #181818, #121212);
            border-radius: 16px;
            padding: 32px;
            border: 1px solid #282828;
            transition: all 0.35s ease;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 50px rgba(194,115,237,0.18);
            border-color: #c273ed;
        }
        
        .stat-icon {
            font-size: 48px;
            color: #c273ed;
            margin-bottom: 16px;
            opacity: 0.9;
        }
        
        .stat-number {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 8px;
        }
        
        .stat-label {
            color: #b0b0b0;
            font-size: 16px;
        }
        
        /* Recent Sections */
        .recent-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 32px;
        }
        
        .recent-card {
            background: #181818;
            border-radius: 16px;
            padding: 28px;
            border: 1px solid #282828;
        }
        
        .recent-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #c273ed;
        }
        
        .recent-list li {
            padding: 14px 0;
            border-bottom: 1px solid #222;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .recent-list li:last-child {
            border-bottom: none;
        }
        
        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .badge-user { background: #4e73df; }
        .badge-admin { background: #c273ed; }
        
        @media (max-width: 992px) {
            .main-content { margin-left: 80px; padding: 24px; }
            .recent-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<jsp:include page="admin-sidebar.jsp">
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="main-content">
    <h1>Dashboard</h1>
    <p class="subtitle">Tổng quan hệ thống • Cập nhật ${currentDate}</p>

    <!-- Thống kê chính -->
    <div class="stats-grid">
        <div class="stat-card">
            <i class="fas fa-users stat-icon"></i>
            <div class="stat-number">${totalUsers}</div>
            <div class="stat-label">Tổng người dùng</div>
        </div>
        
        <div class="stat-card">
            <i class="fas fa-music stat-icon"></i>
            <div class="stat-number">${totalMusic}</div>
            <div class="stat-label">Bài hát</div>
        </div>
        
        <div class="stat-card">
            <i class="fas fa-play-circle stat-icon"></i>
            <div class="stat-number">${totalPlays}</div>
            <div class="stat-label">Lượt phát</div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="recent-grid">
        <!-- Latest Users -->
        <div class="recent-card">
            <div class="recent-title">Người dùng mới nhất</div>
            <ul class="recent-list">
                <c:forEach items="${latestUsers}" var="u">
                    <li>
                        <div>
                            <strong>${u.username}</strong>
                            <span style="margin-left:12px;">${u.email}</span>
                        </div>
                        <span class="badge ${u.role == 'ADMIN' ? 'badge-admin' : 'badge-user'}">
                            ${u.role}
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <!-- Latest Music -->
        <div class="recent-card">
            <div class="recent-title">Bài hát mới nhất</div>
            <ul class="recent-list">
                <c:forEach items="${latestMusic}" var="m">
                    <li>
                        <div>
                            <strong>${m.title}</strong>
                            <span style="margin-left:12px; color:#b0b0b0;">${m.artist}</span>
                        </div>
                        <i class="fas fa-music" style="color:#c273ed;"></i>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

</body>
</html>