<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    /* ── SIDEBAR ── */
    .sidebar {
        width: 240px;
        background: #000;
        padding: 24px 16px;
        overflow-y: auto;
        border-right: 1px solid #222;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        transition: width 0.3s ease;
    }

    .logo {
        font-size: 28px;
        font-weight: 800;
        color: #c273ed;
        margin-bottom: 40px;
        display: flex;
        align-items: center;
        gap: 12px;
        letter-spacing: -0.5px;
    }

    .sidebar-menu {
        margin: 16px 0 32px;
    }

    .sidebar-menu a {
        display: flex;
        align-items: center;
        gap: 14px;
        color: #b3b3b3;
        text-decoration: none;
        padding: 14px 16px;
        border-radius: 10px;
        margin: 6px 0;
        font-weight: 500;
        font-size: 15px;
        transition: all 0.25s ease;
    }

    .sidebar-menu a:hover {
        background: #282828;
        color: white;
        transform: translateX(4px);
    }

    .sidebar-menu a.active {
        background: rgba(194, 115, 237, 0.15);
        color: #c273ed;
        font-weight: 600;
        border-left: 4px solid #c273ed;
    }

    .sidebar hr {
        border: none;
        border-top: 1px solid #333;
        margin: 28px 0;
    }

    /* User info */
    .user-info {
        display: flex;
        align-items: center;
        gap: 14px;
        padding: 12px 16px;
        border-radius: 10px;
        transition: background 0.25s;
        cursor: pointer;
    }

    .user-info:hover {
        background: #181818;
    }

    .user-info img {
        width: 44px;
        height: 44px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #333;
    }

    .user-name {
        font-weight: 600;
        font-size: 15px;
    }

    .user-role {
        font-size: 13px;
        color: #777;
    }

    /* Dropdown menu */
    .dropdown {
        background: #181818;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 8px 24px rgba(0,0,0,0.6);
        margin-top: 12px;
    }

    .dropdown a,
    .dropdown button {
        display: block;
        padding: 14px 20px;
        color: #ddd;
        text-decoration: none;
        background: transparent;
        border: none;
        width: 100%;
        text-align: left;
        cursor: pointer;
        transition: background 0.2s;
    }

    .dropdown a:hover,
    .dropdown button:hover {
        background: #282828;
    }

    .dropdown button {
        color: #ff4d4d;
        font-weight: 500;
    }

    @media (max-width: 992px) {
        .sidebar {
            width: 80px;
            padding: 24px 8px;
        }
        .sidebar .logo span,
        .sidebar .sidebar-menu a span,
        .user-info span {
            display: none;
        }
        .sidebar .logo {
            justify-content: center;
        }
        .sidebar-menu a {
            justify-content: center;
        }
    }
</style>

<div class="sidebar">
    <div class="logo">
        <i class="fas fa-music"></i>
        <span>Music App</span>
    </div>

    <div class="sidebar-menu">
        <a href="${pageContext.request.contextPath}/musiclist" 
           class="${param.activePage == 'musiclist' ? 'active' : ''}">
            <i class="fas fa-home"></i>
            <span>Trang chủ</span>
        </a>
        
        <a href="${pageContext.request.contextPath}/favorite" 
           class="${param.activePage == 'favorite' ? 'active' : ''}">
            <i class="fas fa-heart"></i>
            <span>Yêu thích</span>
        </a>
        
        <a href="${pageContext.request.contextPath}/playlist" 
           class="${param.activePage == 'playlist' ? 'active' : ''}">
            <i class="fas fa-list"></i>
            <span>Playlist</span>
        </a>
        
            <a href="#" class="nav-link d-flex align-items-center mb-2"
			   data-bs-toggle="modal" data-bs-target="#aiChatModal">
			  <i class="bi bi-robot fs-4 me-3"></i>
			  <span>AI</span>
			</a>



        <c:if test="${not empty sessionScope.username}">
            <a href="${pageContext.request.contextPath}/profile" 
               class="${param.activePage == 'profile' ? 'active' : ''}">
                <i class="fas fa-user-circle"></i>
                <span>Hồ sơ</span>
            </a>
        </c:if>
    </div>

    <hr>

    <c:choose>
        <c:when test="${not empty sessionScope.username}">
            <div class="user-info" onclick="toggleMenu()">
                <img 
                    src="${pageContext.request.contextPath}/image/${empty sessionScope.user.avatar ? 'AnhTrong.jpg' : sessionScope.user.avatar}"
                    alt="Avatar">
                <div>
                    <div class="user-name">${sessionScope.username}</div>
                    <div class="user-role">Người dùng</div>
                </div>
            </div>

            <!-- Dropdown menu khi click avatar -->
            <div id="userDropdown" class="dropdown" style="display: none;">
                <a href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                    <button type="submit">Đăng xuất</button>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <a href="login.jsp" class="sidebar-menu" style="color:#c273ed; font-weight:600;">
                <i class="fas fa-sign-in-alt"></i>
                <span>Đăng nhập</span>
            </a>
        </c:otherwise>
    </c:choose>
</div>

<script>
function toggleMenu() {
    const dropdown = document.getElementById("userDropdown");
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
}

// Đóng dropdown khi click ra ngoài
document.addEventListener("click", function(event) {
    const userInfo = document.querySelector(".user-info");
    const dropdown = document.getElementById("userDropdown");
    if (!userInfo?.contains(event.target) && dropdown) {
        dropdown.style.display = "none";
    }
});
</script>