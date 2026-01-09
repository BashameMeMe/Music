<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm vào Playlist • Music App</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            color: #ffffff;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        /* Neon particle background */
        .background-particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: transparent;
            z-index: 1;
            pointer-events: none;
        }

        .particle {
            position: absolute;
            border-radius: 50%;
            animation: particleMove 10s infinite linear;
            opacity: 0.6;
            filter: blur(2px);
        }

        @keyframes particleMove {
            0% { transform: translate(0, 0); opacity: 0.3; }
            50% { transform: translate(calc(50vw * var(--dx)), calc(50vh * var(--dy))); opacity: 0.8; }
            100% { transform: translate(calc(100vw * var(--dx)), calc(100vh * var(--dy))); opacity: 0.3; }
        }

        .container {
            background: rgba(24, 24, 24, 0.85);
            border-radius: 24px;
            width: 100%;
            max-width: 480px;
            padding: 40px 32px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.7), inset 0 0 20px rgba(194, 115, 237, 0.15);
            backdrop-filter: blur(20px);
            position: relative;
            z-index: 2;
            animation: glowPulse 2s infinite alternate ease-in-out;
        }

        @keyframes glowPulse {
            0% { box-shadow: 0 20px 60px rgba(0, 0, 0, 0.7), inset 0 0 20px rgba(194, 115, 237, 0.15); }
            100% { box-shadow: 0 24px 72px rgba(0, 0, 0, 0.8), inset 0 0 30px rgba(194, 115, 237, 0.25); }
        }

        .header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 32px;
        }

        .icon-neon {
            width: 56px;
            height: 56px;
            background: transparent;
            border: 2px solid #c273ed;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            color: #c273ed;
            box-shadow: 0 0 20px #c273ed, inset 0 0 10px #c273ed;
            animation: neonFlicker 1.5s infinite alternate;
        }

        @keyframes neonFlicker {
            0% { box-shadow: 0 0 10px #c273ed, inset 0 0 5px #c273ed; }
            100% { box-shadow: 0 0 30px #c273ed, inset 0 0 15px #c273ed; }
        }

        h2 {
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(90deg, #c273ed, #9b5de5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -0.5px;
        }

        select {
            width: 100%;
            padding: 16px 20px;
            background: rgba(40, 40, 40, 0.7);
            color: #ffffff;
            border: 1px solid rgba(194, 115, 237, 0.3);
            border-radius: 12px;
            font-size: 1.05rem;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23c273ed'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 20px center;
            background-size: 22px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        select:hover, select:focus {
            border-color: #c273ed;
            box-shadow: 0 0 15px rgba(194, 115, 237, 0.5);
            outline: none;
        }

        option {
            background: #181818;
            color: #ffffff;
        }

        .btn-add {
            width: 100%;
            margin-top: 28px;
            padding: 16px;
            background: linear-gradient(135deg, #c273ed, #764ba2);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-add::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 70%);
            transform: rotate(45deg);
            opacity: 0;
            transition: opacity 0.4s;
        }

        .btn-add:hover::before {
            opacity: 1;
        }

        .btn-add:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: 0 12px 32px rgba(194, 115, 237, 0.6);
        }

        .empty-message {
            text-align: center;
            color: #b3b3b3;
            padding: 48px 0;
            font-size: 1.2rem;
            animation: fadeInText 1s ease-in;
        }

        @keyframes fadeInText {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 500px) {
            .container { padding: 32px 24px; border-radius: 20px; }
        }
    </style>
</head>
<body>

<!-- Neon particles background -->
<div class="background-particles" id="particles"></div>

<div class="container">
    <div class="header">
        <div class="icon-neon">
            <i class="fas fa-plus"></i>
        </div>
        <h2>Thêm vào Playlist</h2>
    </div>

    <form action="addToPlaylist" method="post">
        <input type="hidden" name="musicId" value="${musicId}">

        <c:choose>
            <c:when test="${not empty playlists}">
                <select name="playlistId" required>
                    <option value="" disabled selected>Chọn playlist của bạn...</option>
                    <c:forEach var="pl" items="${playlists}">
                        <option value="${pl.id}">${pl.name}</option>
                    </c:forEach>
                </select>

                <button type="submit" class="btn-add">
                    <i class="fas fa-music"></i> Thêm Ngay!
                </button>
            </c:when>
            <c:otherwise>
                <div class="empty-message">
                    <i class="fas fa-exclamation-circle" style="font-size: 2rem; display: block; margin-bottom: 16px; color: #c273ed;"></i>
                    Chưa có playlist nào!<br>
                    <small>Tạo playlist để thêm bài hát yêu thích nhé</small>
                </div>
            </c:otherwise>
        </c:choose>
    </form>
</div>

<script>
    // Generate neon particles
    const particlesContainer = document.getElementById('particles');
    const colors = ['#c273ed', '#9b5de5', '#764ba2'];
    for (let i = 0; i < 30; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        particle.style.background = colors[Math.floor(Math.random() * colors.length)];
        particle.style.width = `${Math.random() * 8 + 4}px`;
        particle.style.height = particle.style.width;
        particle.style.left = `${Math.random() * 100}%`;
        particle.style.top = `${Math.random() * 100}%`;
        particle.style.setProperty('--dx', Math.random() * 2 - 1);
        particle.style.setProperty('--dy', Math.random() * 2 - 1);
        particle.style.animationDuration = `${Math.random() * 20 + 10}s`;
        particle.style.animationDelay = `${Math.random() * 5}s`;
        particlesContainer.appendChild(particle);
    }
</script>

</body>
</html>