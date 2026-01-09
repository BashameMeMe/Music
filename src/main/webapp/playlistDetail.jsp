<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music App | ${playlistName}</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/playlistdetail.css">
</head>
<body>
<div class="app">

    <!-- SIDEBAR -->
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="playlist" />
    </jsp:include>

    <!-- MAIN CONTENT -->
    <div class="main">
        <a href="${pageContext.request.contextPath}/playlist" class="back-btn">
            ← Quay lại danh sách Playlist
        </a>

        <!-- Playlist Header -->
        <div class="playlist-header">
            <img
                src="${pageContext.request.contextPath}/image/${empty playlistCover ? 'anhTrong3.jpg' : playlistCover}"
                class="playlist-cover" alt="Playlist Cover">
            <div class="playlist-info">
                <h1>${playlistName}</h1>
                <p>Playlist • ${musicList.size()} bài hát</p>
            </div>
        </div>

        <!-- Song List -->
        <div class="song-list">
            <c:if test="${empty musicList}">
                <div class="empty-state">
                    Playlist này hiện chưa có bài hát nào.<br>
                    <a href="${pageContext.request.contextPath}/musiclist">Thêm bài hát ngay →</a>
                </div>
            </c:if>

            <c:forEach var="m" items="${musicList}" varStatus="loop">
                <div class="song-item"
                     onclick="playSong(${loop.index},
                         '${pageContext.request.contextPath}${m.filePath}',
                         '${m.title}',
                         '${m.artist}',
                         '${pageContext.request.contextPath}/image/${empty m.coverImage ? 'AnhTrong3.jpg' : m.coverImage}')">
                    <img
                        src="${pageContext.request.contextPath}/image/${empty m.coverImage ? 'AnhTrong3.jpg' : m.coverImage}"
                        class="song-cover" alt="${m.title}">
                    <div class="song-info">
                        <div class="song-title">${m.title}</div>
                        <div class="song-artist">${m.artist}</div>
                    </div>

                    <span class="remove-btn"
                          onclick="event.stopPropagation(); removeFromPlaylist(${playlist.id}, ${m.id}, '${m.title.replace("'", "\\'")}')">
                        <i class="fas fa-trash-alt"></i>
                    </span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- PLAYER BAR -->
<div id="player-bar">
    <img id="player-cover" src="${pageContext.request.contextPath}/image/anhTrong3.jpg" alt="Cover">
    <div style="flex:1;">
        <div id="player-title" style="font-weight:700; font-size:16px;">Chọn một bài hát để phát</div>
        <div id="player-artist" style="color:#b3b3b3; font-size:14px;"></div>
    </div>
    <audio id="audio-player" controls></audio>
</div>

<script>
const audio = document.getElementById("audio-player");
const cover = document.getElementById("player-cover");
const titleEl = document.getElementById("player-title");
const artistEl = document.getElementById("player-artist");

let currentIndex = -1;
const playlistSongs = [
    <c:forEach var="m" items="${musicList}">
        {
            src: "${pageContext.request.contextPath}${m.filePath}",
            title: "${m.title}",
            artist: "${m.artist}",
            cover: "${pageContext.request.contextPath}/image/${empty m.coverImage ? 'AnhTrong3.jpg' : m.coverImage}"
        },
    </c:forEach>
];

function playSong(index, src, title, artist, coverImg) {
    currentIndex = index;
    audio.src = src;
    audio.play().catch(e => console.log("Auto play bị chặn:", e));

    titleEl.textContent = title;
    artistEl.textContent = artist;
    cover.src = coverImg;
    cover.classList.add("is-playing");
}

audio.addEventListener("ended", () => {
    currentIndex = (currentIndex + 1) % playlistSongs.length;
    const next = playlistSongs[currentIndex];
    playSong(currentIndex, next.src, next.title, next.artist, next.cover);
});

function removeFromPlaylist(playlistId, musicId, title) {
    if (confirm(`Xóa "${title}" khỏi playlist?`)) {
        window.location.href = 
            "${pageContext.request.contextPath}/removeFromPlaylist?playlistId=" + playlistId + "&musicId=" + musicId;
    }
}
</script>
</body>
</html>