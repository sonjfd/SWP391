<%@ page import="Model.User" %>
<%@ page import="Model.Messages" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
User currentUser = (User) request.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String conversationId = (String) request.getAttribute("conversationId");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Chat với Nhân viên hỗ trợ</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css"/>
        <meta charset="utf-8" />

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->

        <!-- Bootstrap -->

        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            #messages {
                overflow-y: auto;
                max-height: calc(100vh - 100px); /* tự động tính chiều cao để không che thanh nhập */
                border: 1px solid #ddd;
                border-radius: 8px;
                background: #f8f9fa;
            }

            /* Tin nhắn của người dùng hiện tại */
            .my-message {
                text-align: right;
                color: #343a40;
                margin: 6px 0;
            }

            /* Tin nhắn của người khác */
            .other-message {
                text-align: left;
                color: #343a40;
                margin: 6px 0;
            }

            /* Avatar trong sidebar */
            .avatar-profile img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border: 3px solid #fff;
                box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            }
            img {
                border-radius: 8px;
                object-fit: cover;
            }
            .img-fluid {
                max-height: 300px;
                border-radius: 10px;
            }
            #sendBtn i {
                transition: transform 0.2s ease;
            }

            #sendBtn:hover i {
                transform: scale(1.2) rotate(-10deg);
            }
            #messages {
                overflow-y: auto;
                max-height: calc(100vh - 200px);
                padding: 10px;
                background-color: #f9f9f9;
                border-radius: 10px;
            }

            /* Tin nhắn của mình */
            .my-message {
                text-align: right;
                margin: 10px 0;
            }

            .my-message div {
                display: inline-block;
                background-color: #d1e7dd;
                color: #000;
                padding: 10px 15px;
                border-radius: 20px;
                max-width: 70%;
                word-wrap: break-word;
                font-size: 14px;
                text-align: left;
            }

            /* Tin nhắn của người khác */
            .other-message {
                text-align: left;
                margin: 10px 0;
            }

            .other-message div {
                display: inline-block;
                background-color: #f8d7da;
                color: #000;
                padding: 10px 15px;
                border-radius: 20px;
                max-width: 70%;
                word-wrap: break-word;
                font-size: 14px;
            }

            /* Tên người gửi */
            .my-message strong,
            .other-message strong {
                display: block;
                font-weight: bold;
                margin-bottom: 3px;
            }




        </style>
    </head>
    <body class="row">
        <div class=" col-3">
            <div class="rounded shadow overflow-hidden sticky-bar">
                <div class="card border-0">
                    <img src="${user.avatar}" class="img-fluid" alt="">
                </div>
                <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                    <img src="${user.avatar}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                    <h5 class="mt-3 mb-1">${user.fullName}</h5>

                </div>
                <ul class="list-unstyled sidebar-nav mb-0">
                    <li class="navbar-item"><a href="customer-viewappointment" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Danh sách cuộc hẹn</a></li>
                    <li class="navbar-item"><a href="customer-viewmedicalhistory" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i>Lịch sử khám bệnh</a></li>
                    <li class="navbar-item"><a href="customer-viewlistpet" class="navbar-link"><i class="ri-bear-smile-line align-middle navbar-icon"></i> Danh sách thú cưng</a></li>
                    <li class="navbar-item"><a href="customer-updateuserinformation" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i> Cài đặt thông tin cá nhân</a></li>
                    <li class="navbar-item"><a href="customer-chat" class="navbar-link"><i class="ri-chat-voice-line align-middle navbar-icon"></i> Chat với nhân viên hỗ trợ</a></li>
                </ul>

            </div>
        </div><!--end col-->
        <div class="col-9 d-flex flex-column vh-100">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <a href="customer-updateuserinformation" class="btn btn-outline-secondary d-flex align-items-center">
                    <i class="fas fa-arrow-left"></i>
                </a>

                <h4 class="m-0 text-center flex-grow-1">Chat với nhân viên hỗ trợ</h4>

                <div style="width: 40px;"></div> <!-- Để giữ khoảng trống cân đối bên phải -->

            </div>
            <!-- Khung tin nhắn -->
            <div id="messages" class="mb-3 flex-grow-1 overflow-auto p-3 bg-white rounded shadow-sm">
                <c:forEach var="m" items="${messages}">
                    <div class="${m.sender.id == currentUser.id ? 'my-message' : 'other-message'}">
                        <div>
                            <strong>${m.sender.fullName}</strong> ${m.content}
                        </div>
                    </div>

                </c:forEach>
            </div>
            <!-- Ô nhập và nút gửi -->
            <div class="input-group d-flex flex-column">
                <div id="imagePreview" class="mb-2 d-flex flex-wrap"></div>
                <div class="d-flex w-100">
                    <input type="text" id="messageInput" class="form-control" placeholder="Nhập tin nhắn...">
                    <input type="file" id="imageInput" accept="image/*" hidden>
                    <button id="uploadImageBtn" class="btn btn-outline-secondary"><i class="fas fa-image"></i></button>
                    <button id="sendBtn" class="btn btn-primary"><i class="fas fa-paper-plane"></i></button>
                </div>
            </div>



        </div>
        <script>
            const conversationId = "<%= conversationId %>";
            const userId = "<%= currentUser.getId() %>";
            const fullName = "<%= currentUser.getFullName() %>";
            const messagesDiv = document.getElementById("messages");
            const imagePreview = document.getElementById("imagePreview");
            let pendingImageLink = ""; // Đường dẫn ảnh đã upload nhưng chưa gửi

            let ws;

            function connectWebSocket() {
                ws = new WebSocket("ws://localhost:8080/SWP391/chat/" + encodeURIComponent(conversationId) + "/" + encodeURIComponent(userId) + "/" + encodeURIComponent(fullName));

                ws.onopen = function () {
                    fetch("customer-chat?conversationId=" + encodeURIComponent(conversationId) + "&ajax=true")
                            .then(res => {
                                if (!res.ok)
                                    throw new Error("Lỗi HTTP: " + res.status);
                                return res.json();
                            })
                            .then(data => {
                                messagesDiv.innerHTML = "";
                                data.forEach(msg => renderMessage(msg.senderName, msg.content, msg.senderId === userId));
                            })
                            .catch(err => console.error("❌ Lỗi tải tin nhắn cũ:", err));
                };


                ws.onmessage = function (event) {
                    const parts = event.data.split(": ");
                    const sender = parts[0];
                    const messageContent = parts.slice(1).join(": ");
                    renderMessage(sender, messageContent, sender === fullName);
                };

                ws.onerror = err => console.error("❌ WebSocket lỗi:", err);
                ws.onclose = () => console.warn("⚠️ WebSocket đã đóng kết nối.");
            }

            function renderMessage(sender, content, isMine) {
                const wrapper = document.createElement("div");
                wrapper.className = isMine ? "my-message" : "other-message";

                const inner = document.createElement("div");

                if (content.startsWith("IMAGE:")) {
                    const img = document.createElement("img");
                    const relativePath = content.replace("IMAGE:", "");
                    img.src = window.location.origin + relativePath;
                    img.style.maxWidth = "200px";
                    img.style.borderRadius = "10px";
                    inner.innerHTML = "<strong>" + sender + "</strong><br>";
                    inner.appendChild(img);
                } else {
                    inner.innerHTML = "<strong>" + sender + "</strong> " + content;
                }

                wrapper.appendChild(inner);
                messagesDiv.appendChild(wrapper);
                messagesDiv.scrollTop = messagesDiv.scrollHeight;
            }

            document.getElementById("sendBtn").addEventListener("click", sendMessage);

            document.getElementById("messageInput").addEventListener("keypress", function (e) {
                if (e.key === "Enter") {
                    e.preventDefault();
                    sendMessage();
                }
            });

            function sendMessage() {
                const input = document.getElementById("messageInput");
                const msg = input.value.trim();

                if (ws.readyState !== WebSocket.OPEN)
                    return;

                if (pendingImageLink) {
                    ws.send("IMAGE:" + pendingImageLink);
                    pendingImageLink = "";
                    imagePreview.innerHTML = "";
                }

                if (msg) {
                    ws.send(msg);
                    input.value = "";
                }
            }

            document.getElementById("uploadImageBtn").addEventListener("click", () => {
                document.getElementById("imageInput").click();
            });

            document.getElementById("imageInput").addEventListener("change", function (e) {
                const file = e.target.files[0];
                if (file && file.type.startsWith("image/")) {
                    uploadImage(file);
                }
            });

            document.getElementById("messageInput").addEventListener("paste", function (e) {
                const items = (e.clipboardData || window.clipboardData).items;
                for (let i = 0; i < items.length; i++) {
                    if (items[i].type.startsWith("image/")) {
                        const file = items[i].getAsFile();
                        if (file) {
                            uploadImage(file);
                        }
                    }
                }
            });

            function uploadImage(file) {
                const formData = new FormData();
                formData.append("image", file);

                fetch("upload-image", {
                    method: "POST",
                    body: formData
                })
                        .then(res => res.text())
                        .then(link => {
                            pendingImageLink = link;
                            showImagePreview(link);
                        })
                        .catch(err => console.error("❌ Upload ảnh lỗi:", err));
            }

            function showImagePreview(link) {
                imagePreview.innerHTML = "";
                const img = document.createElement("img");
                img.src = window.location.origin + link;
                img.style.maxHeight = "80px";
                img.style.marginRight = "10px";
                img.style.borderRadius = "6px";
                imagePreview.appendChild(img);
            }

            connectWebSocket();
        </script>


    </body>
</html>
