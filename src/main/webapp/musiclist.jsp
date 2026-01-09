<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music App | Khám Phá</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/musiclist.css">
</head>
<style>
.ai-user {
  background: #0d6efd;
  color: #fff;
  border-bottom-right-radius: 4px;
}

.ai-assistant {
  background: #f1f3f5;
  color: #212529;
  border: 1px solid #dee2e6;
  border-bottom-left-radius: 4px;
}
.ai-bubble {
  max-width: 60%;
  width: fit-content;        /* 🔥 FIX CHÍNH */
  padding: 6px 10px;
  font-size: 16px;
  line-height: 1.4;
  border-radius: 10px;
  white-space: pre-wrap;
  word-break: break-word;
}
</style>
<body>
<div class="app">

    <!-- SIDEBAR -->
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="musiclist" />
    </jsp:include>

    <!-- MAIN CONTENT -->
    <div class="main">
        <div class="header">
            <h1>Khám Phá</h1>
        </div>

        <div class="banner">Music App</div>

        <!-- SEARCH BAR -->
        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" 
                   placeholder="Tìm bài hát, nghệ sĩ..." onkeyup="filterMusic()">
        </div>

        <div class="section">
            <div class="section-title">
                Gợi Ý Cho Bạn
                <a href="#">Tất cả →</a>
            </div>

            <div class="music-grid">
                <c:forEach var="m" items="${musiclist}">
                    <div class="card">
                        <div class="card-img">
                            <img 
                                src="${pageContext.request.contextPath}/image/${empty m.coverImage ? 'AnhTrong3.jpg' : m.coverImage}"
                                alt="${m.title}">

                            <!-- ACTION BUTTONS -->
                            <div class="action-buttons">
                                <a href="favorite?musicId=${m.id}" title="Yêu thích"
                                   onclick="event.stopPropagation();">
                                    <i class="fas fa-heart"></i>
                                </a>
                                <a href="addToPlaylist?musicId=${m.id}" title="Thêm vào playlist"
                                   onclick="event.stopPropagation();">
                                    <i class="fas fa-plus"></i>
                                </a>
                            </div>

                            <!-- PLAY -->
                            <div class="play-overlay"
                                 onclick="playSong(
                                    '${pageContext.request.contextPath}${m.filePath}',
                                    '${m.title}',
                                    '${m.artist}',
                                    '${pageContext.request.contextPath}/image/${empty m.coverImage ? 'AnhTrong3.jpg' : m.coverImage}'
                                 )">
                                <div class="play-btn">
                                    <i class="fas fa-play"></i>
                                </div>
                            </div>
                        </div>

                        <div class="card-info">
                            <div class="card-title">${m.title}</div>
                            <div class="card-subtitle">${m.artist}</div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty musiclist}">
                    <p style="grid-column: 1/-1; text-align: center; color: #777; padding: 80px 20px; font-size: 18px;">
                        Chưa có bài hát nào trong hệ thống...
                    </p>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- PLAYER BAR -->
<div id="player-bar">
    <img id="player-cover" src="${pageContext.request.contextPath}/image/anhTrong3.jpg" alt="Cover">
    <div id="player-info">
        <div id="player-title">Chọn một bài hát để phát</div>
        <div id="player-artist"></div>
    </div>
    <audio id="audio-player" controls></audio>
</div>
<!-- AI CHAT MODAL -->
<div class="modal fade" id="aiChatModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">

      <!-- HEADER -->
      <div class="modal-header">
        <h5 class="modal-title">
          <i class="bi bi-robot me-2"></i>
          Trợ lý AI
        </h5>
        <button class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- BODY -->
      <div class="modal-body" style="max-height:400px; overflow-y:auto;">
        <div id="aiChatMessages" class="d-flex flex-column gap-2">
          <div class="text-muted small text-center">
            👋 Xin chào! Tôi có thể giúp gì cho bạn?
          </div>
        </div>
      </div>

      <!-- FOOTER -->
		<div class="modal-footer">
		  <div class="d-flex w-100 gap-2 align-items-center">
          <input
		    type="text"
		    id="aiChatInput"
		    class="form-control"
		    placeholder="Nhập câu hỏi..."
		    onkeydown="handleAiEnter(event)"
		  >
          <button class="btn btn-primary px-3" onclick="sendAiMessage()">
		    <i class="bi bi-send"></i>
		  </button>
        </div>
		</div>
		
		
        
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function playSong(src, title, artist, cover) {
    const audio = document.getElementById("audio-player");
    const coverImg = document.getElementById("player-cover");

    audio.src = src;
    audio.play().catch(e => console.log("Auto-play bị chặn:", e));

    document.getElementById("player-title").textContent = title;
    document.getElementById("player-artist").textContent = artist;
    coverImg.src = cover;

    coverImg.classList.remove("is-playing");
    void coverImg.offsetWidth;
    coverImg.classList.add("is-playing");

    audio.onpause = () => coverImg.classList.remove("is-playing");
    audio.onplay = () => coverImg.classList.add("is-playing");
}


function filterMusic() {
    const keyword = document.getElementById("searchInput").value.toLowerCase();
    const cards = document.querySelectorAll(".music-grid .card");

    cards.forEach(card => {
        const title = card.querySelector(".card-title").textContent.toLowerCase();
        const artist = card.querySelector(".card-subtitle").textContent.toLowerCase();
        card.style.display = (title.includes(keyword) || artist.includes(keyword)) ? "block" : "none";
    });
}
</script>
<script>
console.log("groq ai");

document.addEventListener("DOMContentLoaded", () => {

  const aiModal = document.getElementById("aiChatModal");
  const input = document.getElementById("aiChatInput");

  // 👉 Khi mở modal → load lịch sử
  if (aiModal) {
    aiModal.addEventListener("shown.bs.modal", () => {
      loadAiHistory();
      if (input) input.focus();
    });
  }

  
  if (input) {
    input.addEventListener("keydown", (e) => {
      if (e.key === "Enter" && !e.isComposing) {
        e.preventDefault();
        sendAiMessage();
      }
    });
  }
});

/* ================================
   APPEND MESSAGE
================================ */
function appendAiMessage(role, text) {
  const box = document.getElementById("aiChatMessages");

  const row = document.createElement("div");
  row.className =
    role === "user"
      ? "d-flex justify-content-end"
      : "d-flex justify-content-start";

  const bubble = document.createElement("div");
  bubble.className =
    role === "user"
      ? "ai-bubble ai-user"
      : "ai-bubble ai-assistant";

  bubble.innerHTML = escapeHtml(text);

  row.appendChild(bubble);
  box.appendChild(row);
  box.scrollTop = box.scrollHeight;
}


/* ================================
   SEND MESSAGE
================================ */
function sendAiMessage() {
  const input = document.getElementById("aiChatInput");
  if (!input) return;

  const text = input.value.trim();
  if (!text) return;

  appendAiMessage("user", text);
  input.value = "";

  // typing indicator
  const typingId = showTyping();

  fetch("${pageContext.request.contextPath}/ai/chat", {
	    method: "POST",
	    headers: {
	        "Content-Type": "application/x-www-form-urlencoded"
	    },
	    body: "message=" + encodeURIComponent(text)
	})
    .then(res => res.json())
    .then(data => {
      removeTyping(typingId);
      appendAiMessage("assistant", data.reply || "🤖 Không có phản hồi");
    })
    .catch(() => {
      removeTyping(typingId);
      appendAiMessage("assistant", "❌ AI hiện không phản hồi được");
    });
}

/* ================================
   LOAD HISTORY
================================ */
function loadAiHistory() {
  const box = document.getElementById("aiChatMessages");
  if (!box) return;

  box.innerHTML = `
    <div class="text-muted small text-center">
      ⏳ Đang tải lịch sử...
    </div>
  `;

  fetch(contextPath + "/ai/history")
    .then(res => {
      if (!res.ok) throw new Error("Unauthorized");
      return res.json();
    })
    .then(data => {
      box.innerHTML = "";

      if (!data || data.length === 0) {
        box.innerHTML = `
          <div class="text-muted small text-center">
            👋 Chưa có lịch sử chat với AI
          </div>
        `;
        return;
      }

      data.forEach(m => {
        appendAiMessage(m.role, m.content);
      });
    })
    .catch(() => {
      box.innerHTML = `
        <div class="text-danger text-center">
          ❌ Không tải được lịch sử AI
        </div>
      `;
    });
}

/* ================================
   TYPING INDICATOR
================================ */
function showTyping() {
  const box = document.getElementById("aiChatMessages");
  if (!box) return null;

  const id = "typing-" + Date.now();
  const div = document.createElement("div");
  div.id = id;
  div.className = "text-muted small fst-italic";
  div.innerText = "🤖 AI đang trả lời...";

  box.appendChild(div);
  box.scrollTop = box.scrollHeight;
  return id;
}

function removeTyping(id) {
  if (!id) return;
  const el = document.getElementById(id);
  if (el) el.remove();
}

/* ================================
   ESCAPE HTML (TRÁNH XSS)
================================ */
function escapeHtml(text) {
  return text
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}
</script>
</body>
</html>