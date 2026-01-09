<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nâng cấp VIP - Web Music</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #e91e63;
            --secondary: #9c27b0;
            --accent: #ff4081;
            --glow: rgba(233, 30, 99, 0.5);
            --text: #ffffff;
            --text-secondary: #e0e0e0;
            --bg-card: rgba(30, 30, 50, 0.6);
        }
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
            color: var(--text);
            font-family: 'Segoe UI', sans-serif;
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        #particles-js {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
        }
        .container-main {
            position: relative;
            z-index: 2;
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
            flex: 1; /* Để footer đẩy xuống dưới */
            display: flex;
            flex-direction: column;
            justify-content: center; /* Căn giữa dọc toàn bộ nội dung chính */
        }
        .vip-header {
            text-align: center;
            margin-bottom: 80px;
        }
        .vip-header h1 {
            font-size: 4.5rem;
            font-weight: 900;
            background: linear-gradient(90deg, var(--primary), var(--secondary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-size: 200%;
            animation: shine 6s linear infinite;
            letter-spacing: 4px;
            text-shadow: 0 0 40px var(--glow);
        }
        @keyframes shine {
            0% { background-position: 0%; }
            100% { background-position: 200%; }
        }
        .vip-header p {
            font-size: 1.4rem;
            color: var(--text-secondary);
            margin-top: 20px;
            opacity: 0.9;
        }
        .pricing-grid {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            gap: 40px;
            width: 100%;
        }
        .pricing-card {
            background: var(--bg-card);
            backdrop-filter: blur(25px);
            border-radius: 32px;
            overflow: hidden;
            width: 100%;
            max-width: 380px;
            text-align: center;
            padding: 40px 20px;
            transition: all 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 60px rgba(0,0,0,0.6);
            position: relative;
            flex: 0 1 380px;
        }
        .pricing-card:hover {
            transform: translateY(-30px);
            box-shadow: 0 30px 80px var(--glow);
        }
        .popular {
            position: relative;
            z-index: 20;
            transform: scale(1.1);
            border: 3px solid var(--accent);
        }
        .popular::before {
            content: '★ PHỔ BIẾN NHẤT ★';
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            background: linear-gradient(45deg, #ffd700, #ff8c00);
            color: #000;
            padding: 12px 40px;
            border-radius: 50px;
            font-weight: bold;
            font-size: 1rem;
            box-shadow: 0 0 30px rgba(255,215,0,0.8);
            animation: float 3s ease-in-out infinite;
            z-index: 30;
        }
        @keyframes float {
            0%, 100% { transform: translateX(-50%) translateY(0); }
            50% { transform: translateX(-50%) translateY(-10px); }
        }
        .card-header h3 {
            font-size: 2.2rem;
            margin: 0 0 30px;
            color: var(--text);
        }
        .price {
            font-size: 4.5rem;
            font-weight: 900;
            color: var(--primary);
            margin: 20px 0;
            text-shadow: 0 0 30px var(--glow);
        }
        .price sup {
            font-size: 2rem;
            top: -1.5rem;
        }
        .price span {
            font-size: 1.6rem;
            color: var(--text-secondary);
        }
        .saving {
            background: rgba(76, 175, 80, 0.3);
            color: #a5d6a7;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: bold;
            margin: 20px 0;
            display: inline-block;
            border: 1px solid #4caf50;
        }
        .features ul {
            list-style: none;
            padding: 0;
            margin: 40px 0;
        }
        .features li {
            padding: 15px 0;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
        }
        .features i {
            color: #4caf50;
            font-size: 1.8rem;
            margin-right: 15px;
            text-shadow: 0 0 15px rgba(76,175,80,0.6);
        }
        .upgrade-form {
            display: flex;
            justify-content: center;
        }
        .btn-upgrade {
            background: linear-gradient(45deg, var(--primary), var(--accent));
            border: none;
            padding: 18px 50px;
            border-radius: 50px;
            font-size: 1.3rem;
            font-weight: bold;
            color: #fff;
            box-shadow: 0 0 40px var(--glow);
            transition: all 0.4s;
            cursor: pointer;
        }
        .btn-upgrade:hover {
            transform: scale(1.1);
            box-shadow: 0 0 60px var(--glow);
        }
        .popular .btn-upgrade {
            background: linear-gradient(45deg, #ffd700, #ff8c00);
            color: #000;
        }
        footer {
            text-align: center;
            padding: 40px 0;
            color: #888;
            font-size: 1rem;
            margin-top: auto; /* Đẩy footer xuống dưới cùng */
        }
    </style>
</head>
<body>

    <div id="particles-js"></div>

    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="vip" />
    </jsp:include>

    <div class="container-main">
        <div class="vip-header">
            <h1>NÂNG CẤP VIP</h1>
            <p>Mở khóa trải nghiệm âm nhạc đỉnh cao – Không giới hạn, chất lượng vượt trội</p>
        </div>

        <div class="pricing-grid">
            <!-- Gói 1 Tháng -->
            <div class="pricing-card">
                <div class="card-header">
                    <h3>Gói 1 Tháng</h3>
                </div>
                <div class="price">29.000<sup>đ</sup><span>/tháng</span></div>
                <div class="features">
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Nghe nhạc không quảng cáo</li>
                        <li><i class="fas fa-check-circle"></i> Tải nhạc chất lượng cao</li>
                        <li><i class="fas fa-check-circle"></i> Truy cập kho nhạc Premium</li>
                        <li><i class="fas fa-check-circle"></i> Nghe offline mọi lúc</li>
                    </ul>
                </div>
                <form class="upgrade-form" action="PaymentController" method="post">
                    <input type="hidden" name="packageType" value="1_month">
                    <input type="hidden" name="amount" value="29000">
                    <button type="submit" onclick="triggerConfetti(event)" class="btn-upgrade">Đăng ký ngay</button>
                </form>
            </div>

            <!-- Gói 1 Năm (Phổ biến nhất) -->
            <div class="pricing-card popular">
                <div class="card-header">
                    <h3 class="text-warning">Gói 1 Năm</h3>
                </div>
                <div class="price">299.000<sup>đ</sup><span>/năm</span></div>
                <div class="saving">Tiết kiệm 15% – Siêu hời!</div>
                <div class="features">
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Toàn bộ quyền lợi gói 1 tháng</li>
                        <li><i class="fas fa-check-circle"></i> Tải Lossless không giới hạn</li>
                        <li><i class="fas fa-check-circle"></i> Huy hiệu VIP Vàng độc quyền</li>
                        <li><i class="fas fa-check-circle"></i> Vé mời sự kiện âm nhạc offline</li>
                    </ul>
                </div>
                <form class="upgrade-form" action="PaymentController" method="post">
                    <input type="hidden" name="packageType" value="1_year">
                    <input type="hidden" name="amount" value="299000">
                    <button type="submit" onclick="triggerConfetti(event)" class="btn-upgrade">Đăng ký ngay</button>
                </form>
            </div>

            <!-- Gói 6 Tháng -->
            <div class="pricing-card">
                <div class="card-header">
                    <h3>Gói 6 Tháng</h3>
                </div>
                <div class="price">159.000<sup>đ</sup><span>/6 tháng</span></div>
                <div class="features">
                    <ul>
                        <li><i class="fas fa-check-circle"></i> Không quảng cáo hoàn toàn</li>
                        <li><i class="fas fa-check-circle"></i> Tốc độ tải siêu nhanh</li>
                        <li><i class="fas fa-check-circle"></i> Đồng bộ trên mọi thiết bị</li>
                        <li><i class="fas fa-check-circle"></i> Hỗ trợ ưu tiên 24/7</li>
                    </ul>
                </div>
                <form class="upgrade-form" action="PaymentController" method="post">
                    <input type="hidden" name="packageType" value="6_month">
                    <input type="hidden" name="amount" value="159000">
                    <button type="submit" onclick="triggerConfetti(event)" class="btn-upgrade">Đăng ký ngay</button>
                </form>
            </div>
        </div>
    </div>

    <footer>
        <p>© 2026 Web Music Application. All rights reserved.</p>
    </footer>

    <!-- Particles.js -->
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <script>
        particlesJS("particles-js", {
            "particles": {
                "number": { "value": 120, "density": { "enable": true, "value_area": 800 } },
                "color": { "value": ["#e91e63", "#9c27b0", "#ff4081", "#ffffff"] },
                "shape": { "type": "circle" },
                "opacity": { "value": 0.7, "random": true },
                "size": { "value": 4, "random": true },
                "line_linked": { "enable": true, "distance": 150, "color": "#e91e63", "opacity": 0.2, "width": 1 },
                "move": { "enable": true, "speed": 1.5, "direction": "none", "random": true }
            },
            "interactivity": {
                "detect_on": "canvas",
                "events": { "onhover": { "enable": true, "mode": "grab" }, "onclick": { "enable": true, "mode": "push" } }
            },
            "retina_detect": true
        });
    </script>

    <!-- Confetti -->
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.3/dist/confetti.browser.min.js"></script>
    <script>
        function triggerConfetti(event) {
            const button = event.target;
            const rect = button.getBoundingClientRect();
            const x = (rect.left + rect.right) / 2 / window.innerWidth;
            const y = (rect.top + rect.bottom) / 2 / window.innerHeight;

            confetti({
                particleCount: 200,
                spread: 80,
                origin: { x: x, y: y },
                colors: ['#e91e63', '#9c27b0', '#ff4081', '#ffd700', '#ffffff'],
                gravity: 0.7,
                scalar: 1.3,
                ticks: 250
            });
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>