<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin | Thêm bài hát mới</title>
    
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
        
        .form-group { margin-bottom: 28px; }
        label { display: block; margin-bottom: 10px; color: #b0b0b0; font-weight: 500; font-size: 15px; }
        input { width: 100%; padding: 14px; background: #282828; border: 1px solid #444; border-radius: 10px; color: white; font-size: 15px; }
        input:focus { outline: none; border-color: #c273ed; box-shadow: 0 0 0 3px rgba(194,115,237,0.2); }
        
        .btn { width: 100%; padding: 16px; border: none; border-radius: 10px; font-size: 16px; font-weight: 700; cursor: pointer; transition: all 0.3s; }
        .btn-primary { background: #c273ed; color: white; }
        .btn-primary:hover { background: #b35ed9; transform: translateY(-2px); }
        .btn-secondary { background: #444; color: white; margin-top: 16px; }
        .btn-secondary:hover { background: #555; }
    </style>
</head>
<body>

<!-- Sidebar -->
<jsp:include page="admin-sidebar.jsp">
    <jsp:param name="active" value="music" />
</jsp:include>

<div class="main-content">
    <h1>Thêm bài hát mới</h1>

    <div class="form-container">
        <form method="post" action="${pageContext.request.contextPath}/addMusic" enctype="multipart/form-data">
            <div class="form-group">
                <label>Tiêu đề</label>
                <input type="text" name="title" required placeholder="Nhập tên bài hát">
            </div>

            <div class="form-group">
                <label>Nghệ sĩ</label>
                <input type="text" name="artist" required placeholder="Nhập tên nghệ sĩ">
            </div>

            <div class="form-group">
                <label>File MP3</label>
                <input type="file" name="musicFile" accept="audio/*" required>
            </div>

            <div class="form-group">
                <label>Ảnh bìa (tùy chọn)</label>
                <input type="file" name="coverImage" accept="image/*">
            </div>

            <button type="submit" class="btn btn-primary">Thêm bài hát</button>
            <a href="${pageContext.request.contextPath}/music" class="btn btn-secondary" style="text-align:center; display:block; text-decoration:none;">Hủy</a>
        </form>
    </div>
</div>

</body>
</html>