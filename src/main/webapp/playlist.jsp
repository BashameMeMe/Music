<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music App | Playlist</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/playlist.css">
</head>
<body>
<div class="app">

    <!-- SIDEBAR -->
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="playlist" />
    </jsp:include>

    <!-- MAIN -->
    <div class="main">
        <div class="header">
            <h1>Playlist của bạn</h1>
            <button class="create-btn" onclick="openCreateModal()">
                <i class="fas fa-plus"></i> Tạo playlist mới
            </button>
        </div>

        <c:if test="${empty playlists}">
            <div class="empty-state">
                Bạn chưa có playlist nào.<br>
                <span onclick="openCreateModal()">Tạo playlist đầu tiên ngay →</span>
            </div>
        </c:if>

        <c:if test="${not empty playlists}">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên playlist</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${playlists}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/playlistDetail?id=${p.id}" 
                                   class="playlist-name">${p.name}</a>
                            </td>
                            <td>
                                <span class="delete-btn" 
                                      onclick="deletePlaylist(${p.id}, '${p.name.replace("'", "\\'")}')">
                                    <i class="fas fa-trash-alt"></i>
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</div>

<!-- Modal tạo playlist -->
<div class="modal" id="createModal">
    <div class="modal-content">
        <div class="modal-header">Tạo playlist mới</div>
        <form action="${pageContext.request.contextPath}/createPlaylist" method="post">
            <input type="text" name="playlistName" placeholder="Tên playlist" required autofocus>
            <div class="modal-buttons">
                <button type="submit" class="btn btn-primary">Tạo</button>
                <button type="button" class="btn btn-secondary" onclick="closeCreateModal()">Hủy</button>
            </div>
        </form>
    </div>
</div>



<script>
function openCreateModal() {
    document.getElementById('createModal').style.display = 'flex';
}

function closeCreateModal() {
    document.getElementById('createModal').style.display = 'none';
}

function deletePlaylist(id, name) {
    if (confirm(`Bạn chắc chắn muốn xóa playlist "${name}"?`)) {
        window.location.href = "${pageContext.request.contextPath}/deletePlaylist?id=" + id;
    }
}
</script>
</body>
</html>