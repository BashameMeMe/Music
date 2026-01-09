<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music App | Yêu Thích</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Favorite.css">
</head>
<body>
<div class="app">

    <!-- SIDEBAR -->
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="favorite" />
    </jsp:include>

    <!-- MAIN CONTENT -->
    <div class="main">
        <div class="header">
            <h1>Yêu Thích</h1>
        </div>

        <div class="section">
            <div class="section-title">Bài hát bạn đã thích ❤️</div>

            <c:if test="${empty favoriteList}">
                <div class="empty-state">
                    Chưa có bài hát nào trong danh sách yêu thích.<br>
                    <a href="${pageContext.request.contextPath}/musiclist">Khám phá ngay →</a>
                </div>
            </c:if>

            <div class="music-grid">
                <c:forEach var="m" items="${favoriteList}">
                    <div class="card"
                         onclick="playSong(
                            '${pageContext.request.contextPath}${m.filePath}',
                            '${m.title}',
                            '${m.artist}',
                            '${pageContext.request.contextPath}/image/${empty m.coverImage ? "AnhTrong3.jpg" : m.coverImage}'
                         )">
                        <div class="card-img">
                            <img 
                                src="${pageContext.request.contextPath}/image/${empty m.coverImage ? 'AnhTrong3.jpg' : m.coverImage}"
                                alt="${m.title}">
                            <div class="play-overlay">
                                <div class="play-btn"><i class="fas fa-play"></i></div>
                            </div>
                        </div>

                        <!-- Nút xóa yêu thích -->
                        <a href="${pageContext.request.contextPath}/favorite?musicId=${m.id}" 
                           class="remove-btn" 
                           title="Xóa khỏi yêu thích"
                           onclick="event.stopPropagation();">
                            <i class="fas fa-heart-broken"></i>
                        </a>

                        <div class="card-info">
                            <div class="card-title">${m.title}</div>
                            <div class="card-subtitle">${m.artist}</div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<!-- PLAYER BAR -->
<div id="player-bar">
    <img id="player-cover" 
         src="${pageContext.request.contextPath}/image/anhTrong3.jpg" 
         alt="Cover">
    <div style="flex:1;">
        <div id="player-title" style="font-weight:700; font-size:16px;">Chọn một bài hát để phát</div>
        <div id="player-artist" style="color:#b3b3b3; font-size:14px;"></div>
    </div>
    <audio id="audio-player" controls></audio>
</div>

<script>
function playSong(src, title, artist, cover) {
    const audio = document.getElementById("audio-player");
    const coverImg = document.getElementById("player-cover");

    audio.src = src;
    audio.play().catch(e => console.log("Auto play bị chặn:", e));

    document.getElementById("player-title").textContent = title;
    document.getElementById("player-artist").textContent = artist;
    coverImg.src = cover;

    coverImg.classList.remove("is-playing");
    void coverImg.offsetWidth;
    coverImg.classList.add("is-playing");

    audio.onpause = () => coverImg.classList.remove("is-playing");
    audio.onplay = () => coverImg.classList.add("is-playing");
}
</script>
</body>
</html>