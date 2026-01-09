<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | Chỉnh sửa bài hát</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        body { font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #0a0a0a; color: #f5f5f5; margin:0; }
        .main-content { margin-left: 260px; padding: 40px; max-width: 720px; margin: 40px auto; }
        h1 { font-size: 32px; font-weight: 800; margin-bottom: 8px; background: linear-gradient(90deg, #c273ed, #9b5de5); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-align: center; }
        
        .form-container {
            background: #181818;
            border-radius: 16px;
            padding: 40px;
            border: 1px solid #282828;
            box-shadow: 0 16px 60px rgba(0,0,0,0.6);
        }
        
        .current-cover {
            width: 180px;
            height: 180px;
            border-radius: 12px;
            object-fit: cover;
            display: block;
            margin: 0 auto 24px;
            border: 3px solid #c273ed;
            box-shadow: 0 10px 30px rgba(194,115,237,0.25);
        }
        
        .form-group { margin-bottom: 28px; }
        label { display: block; margin-bottom: 10px; color: #b0b0b0; font-weight: 500; font-size: 15px; }
        input, audio { width: 100%; padding: 14px; background: #282828; border: 1px solid #444; border-radius: 10px; color: white; font-size: 15px; }
        input:focus { outline: none; border-color: #c273ed; box-shadow: 0 0 0 3px rgba(194,115,237,0.2); }
        
        .btn { width: 100%; padding: 16px; border: none; border-radius: 10px; font-size: 16px; font-weight: 700; cursor: pointer; transition: all 0.3s; }
        .btn-primary { background: #c273ed; color: white; }
        .btn-primary:hover { background: #b35ed9; transform: translateY(-2px); }
        .btn-secondary { background: #444; color: white; margin-top: 16px; }
        .btn-secondary:hover { background: #555; }
        
        .message { padding: 16px; border-radius: 10px; text-align: center; margin-bottom: 24px; }
        .success { background: rgba(40,167,69,0.2); color: #28a745; }
        .error   { background: rgba(220,53,69,0.2); color: #dc3545; }
    </style>
</head>
<body>

<!-- Sidebar -->
<jsp:include page="admin-sidebar.jsp">
    <jsp:param name="active" value="music" />
</jsp:include>

<div class="main-content">
    <h1>Chỉnh sửa bài hát</h1>

    <div class="form-container">
        <c:if test="${not empty message}">
            <div class="message success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>

        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${music.id}">

            <div style="text-align:center;">
                <img class="current-cover"
                     src="${pageContext.request.contextPath}/image/${empty music.coverImage ? 'AnhTrong3.jpg' : music.coverImage}"
                     alt="Current Cover">
            </div>

            <div class="form-group">
                <label>Tiêu đề</label>
                <input type="text" name="title" value="${music.title}" required>
            </div>

            <div class="form-group">
                <label>Nghệ sĩ</label>
                <input type="text" name="artist" value="${music.artist}" required>
            </div>

            <div class="form-group">
                <label>File MP3 hiện tại</label>
                <audio controls style="margin-top:8px;">
                    <source src="${pageContext.request.contextPath}${music.filePath}" type="audio/mpeg">
                </audio>
            </div>

            <div class="form-group">
                <label>Thay MP3 mới (tùy chọn)</label>
                <input type="file" name="musicFile" accept="audio/*">
            </div>

            <div class="form-group">
                <label>Thay ảnh bìa mới (tùy chọn)</label>
                <input type="file" name="coverImage" accept="image/*">
            </div>

            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
            <a href="${pageContext.request.contextPath}/music" class="btn btn-secondary" style="text-align:center; display:block; text-decoration:none;">Quay lại</a>
        </form>
    </div>
</div>

</body>
</html>