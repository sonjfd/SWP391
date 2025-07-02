<%-- 
    Document   : StaffChat
    Created on : Jun 22, 2025, 11:29:32 PM
    Author     : Admin
--%>
<%@ page import="java.util.List" %>
<%@ page import="Model.User" %>
<%@ page import="Model.Conversation" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <%
    User staff = (User) session.getAttribute("user");
    if (staff == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
    %>
    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->

        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

        <style>
            #chatBox {
                overflow-y: auto;
                height: 67vh;
                background: white;
            }

            .chat-message {
                margin: 5px 0;
            }

            .chat-message.staff {
                text-align: right;
                color: #343a40;
            }

            .chat-message.customer {
                text-align: left;
                color: #343a40;
            }

            #sendBtn i {
                transition: transform 0.2s ease;
            }

            #sendBtn:hover i {
                transform: scale(1.2) rotate(-10deg);
            }

            #chatSection {
                display: none;
            }

            .conversation-item {
                cursor: pointer;
            }
            /* Tổng thể */
            body {
                background-color: #f4f7fa;
            }



            .chat-list-section h4 {
                font-weight: bold;
                color: #333;
            }

            /* ITEM TRÒ CHUYỆN */
            .list-group-item {
                background-color: #f9f9f9;
                border: none;
                border-radius: 8px;
                margin-bottom: 10px;
                transition: background-color 0.3s, transform 0.2s;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            }

            .list-group-item:hover {
                background-color: #e3f2fd;
                transform: translateX(5px);
            }

            .list-group-item strong {
                color: #007bff;
                font-size: 16px;
            }

            .list-group-item small {
                color: #666;
            }


            /* Tin nhắn */
            .chat-message {
                margin: 8px 0;
                padding: 8px 12px;
                border-radius: 16px;
                display: inline-block;
                max-width: 70%;
                word-break: break-word;
            }

            .chat-message.staff {
                background-color: #d1e7dd;
                align-self: flex-end;
                text-align: right;
                margin-left: auto;
            }

            .chat-message.customer {
                background-color: #f8d7da;
                align-self: flex-start;
                text-align: left;
            }

            /* Input */
            .input-group {
                margin-top: 15px;
            }

            #messageInput {
                border-radius: 20px 0 0 20px;
            }

            #sendBtn {
                border-radius: 0 20px 20px 0;
            }

            #sendBtn:hover i {
                transform: scale(1.2) rotate(-10deg);
                transition: transform 0.2s;
            }

            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                overflow: hidden;
            }

            .container-fluid, .chat-wrapper {
                height: 100vh;
                display: flex;
                flex-direction: row;
                padding: 0;
                margin: 0;
            }



            /* Phần chat box (bên phải) */
            #chatSection {
                flex: 1;
                height: 100%;
                display: flex;
                flex-direction: column;
                padding: 20px;
                box-sizing: border-box;
            }


            /* Input nhắn tin */
            .input-group {
                margin-top: 10px;
                align-items: center;
            }

            #messageInput {
                border-radius: 20px 0 0 20px;
            }

            #sendBtn {
                border-radius: 0 20px 20px 0;
            }
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }

            .container-fluid {
                height: 100vh;
                display: flex;
            }

            .chat-list-section {
                width: 25%;
                height: 100%;
                overflow-y: auto;
                border-right: 1px solid #ddd;
                padding: 20px;
                box-sizing: border-box;
            }

            #chatSection {
                flex: 1;
                display: flex;
                flex-direction: column;
                padding: 0px;
                margin-top:5px;
                box-sizing: border-box;
                height: 100%;
            }

            #chatBox {
                flex-grow: 1;
                overflow-y: auto;
                background: #ffffff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: inset 0 0 8px rgba(0,0,0,0.05);
            }

            .bg-dashboard{
                padding:10px 0 10px;

            }
            #imagePreview button {
                height: 30px;
                width: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 0;
            }
            #imagePreview img {
                box-shadow: 0 0 5px rgba(0,0,0,0.3);
            }

            #imagePreview button i {
                font-size: 12px;
            }
            #imagePreview img {
                box-shadow: 0 0 5px rgba(0,0,0,0.3);
            }



        </style>

    </head>

    <body>


        <c:if test="${not empty sessionScope.SuccessMessage}">
            <script>alert('${sessionScope.SuccessMessage}');</script>
            <c:remove var="SuccessMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.FailMessage}">
            <script>alert('${sessionScope.FailMessage}');</script>
            <c:remove var="FailMessage" scope="session"/>
        </c:if>

        <%@ include file="../layout/Header.jsp" %>

        <section class="bg-dashboard">

            <div class="container-fluid chat-wrapper">
                <div class="chat-list-section" id="conversationSection">
                    <h4 class="mb-3">Danh sách cuộc trò chuyện</h4>
                    <form method="get" action="staff-conversations">
                        <input type="text" name="keyword" class="form-control mb-3" placeholder="Tìm khách hàng...">
                    </form>
                    <ul class="list-group">
                        <c:forEach var="c" items="${conversations}">
                            <li class="list-group-item conversation-item"
                                data-id="${c.id}" 
                                data-name="${fn:escapeXml(c.customer.fullName)}">
                                <strong>${c.customer.fullName}</strong><br>
                                <small>${c.last_masage_time}</small>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div id="chatSection" style="display:none;">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <button class="btn btn-outline-secondary" id="backBtn"><i class="fas fa-arrow-left"></i> Quay lại</button>
                        <h5 id="chatWith" style="margin-right: 40%"> Khách hàng ...</h5>

                    </div>

                    <div id="chatBox" class="d-flex flex-column mb-2"></div>

                    <div class="input-group d-flex flex-column">
                        <div id="imagePreview" class="position-relative d-inline-block mb-2"></div>

                        <div class="d-flex w-100">
                            <input type="text" id="messageInput" class="form-control" placeholder="Nhập tin nhắn...">
                            <input type="file" id="imageInput" accept="image/*" hidden>
                            <button id="uploadImageBtn" class="btn btn-outline-secondary"><i class="fas fa-image"></i></button>
                            <button id="sendBtn" class="btn btn-success">
                                <i class="fas fa-paper-plane"></i>
                            </button>
                        </div>
                    </div>

                </div>

            </div>


        </section>
        <script>
            let socket;
            let currentConversationId = "";
            const staffId = "<%= staff.getId() %>";
            const fullName = "<%= staff.getFullName() %>";

            const conversationItems = document.querySelectorAll(".conversation-item");
            const chatSection = document.getElementById("chatSection");
            const conversationSection = document.getElementById("conversationSection");
            const chatBox = document.getElementById("chatBox");

            let pendingImageLink = ""; // Link ảnh chờ gửi

            conversationItems.forEach(function (item) {
                item.addEventListener("click", function () {
                    const id = item.getAttribute("data-id");
                    const name = item.getAttribute("data-name");

                    document.getElementById("chatWith").innerText = "Khách hàng " + name;
                    conversationSection.style.display = "none";
                    chatSection.style.display = "block";
                    openChat(id, name);
                });
            });

            document.getElementById("backBtn").addEventListener("click", function () {
                if (socket && socket.readyState === WebSocket.OPEN) {
                    socket.close();
                }
                chatBox.innerHTML = "";
                chatSection.style.display = "none";
                conversationSection.style.display = "block";
            });

// Gửi tin nhắn hoặc ảnh khi bấm nút gửi
            document.getElementById("sendBtn").onclick = sendMessage;

// Gửi tin nhắn hoặc ảnh khi nhấn Enter
            document.getElementById("messageInput").addEventListener("keypress", function (e) {
                if (e.key === "Enter") {
                    e.preventDefault();
                    sendMessage();
                }
            });

// Chọn ảnh từ máy
            document.getElementById("uploadImageBtn").onclick = function () {
                document.getElementById("imageInput").click();
            };

// Xử lý chọn ảnh và upload
            document.getElementById("imageInput").onchange = function (e) {
                const file = e.target.files[0];
                if (file && file.type.startsWith("image/")) {
                    uploadImage(file);
                }
            };

// Dán ảnh từ clipboard
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

// Hàm gửi tin nhắn hoặc ảnh nếu có
            function sendMessage() {
                const msg = document.getElementById("messageInput").value.trim();
                if (!socket || socket.readyState !== WebSocket.OPEN)
                    return;

                if (pendingImageLink) {
                    socket.send("IMAGE:" + pendingImageLink);
                    pendingImageLink = "";
                    document.getElementById("imagePreview").innerHTML = "";
                }

                if (msg) {
                    socket.send(msg);
                    document.getElementById("messageInput").value = "";
                }
            }

// Hàm upload ảnh
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
                        .catch(err => console.error("Upload lỗi", err));
            }

// Hiển thị ảnh xem trước
            function showImagePreview(link) {
                const preview = document.getElementById("imagePreview");
                preview.innerHTML = "";

                const wrapper = document.createElement("div");
                wrapper.style.position = "relative";
                wrapper.style.display = "inline-block";

                const img = document.createElement("img");
                img.src = link;
                img.style.maxHeight = "80px";
                img.style.borderRadius = "8px";
                img.style.display = "block";

                const removeBtn = document.createElement("button");
                removeBtn.innerHTML = '<i class="fas fa-times"></i>';
                removeBtn.className = "btn btn-sm btn-danger position-absolute";
                removeBtn.style.top = "5px";
                removeBtn.style.right = "5px";
                removeBtn.style.padding = "2px 6px";
                removeBtn.style.borderRadius = "50%";
                removeBtn.style.lineHeight = "1";
                removeBtn.onclick = function () {
                    pendingImageLink = "";
                    preview.innerHTML = "";
                };

                wrapper.appendChild(img);
                wrapper.appendChild(removeBtn);
                preview.appendChild(wrapper);
            }




// Hàm mở cuộc trò chuyện
            function openChat(conversationId, customerName) {
                chatBox.innerHTML = "";
                currentConversationId = conversationId;

                if (socket && socket.readyState === WebSocket.OPEN) {
                    socket.close();
                }

                socket = new WebSocket("ws://localhost:8080/SWP391/chat/" + conversationId + "/" + staffId + "/" + encodeURIComponent(fullName));

                socket.onopen = function () {
                    fetch("staff-get-messages?conversationId=" + conversationId)
                            .then(res => res.json())
                            .then(data => {
                                data.forEach(msg => {
                                    appendMessage(msg.senderName, msg.content, msg.senderId === staffId ? 'staff' : 'customer');
                                });
                            });
                };

                socket.onmessage = function (e) {
                    const parts = e.data.split(": ");
                    const sender = parts[0];
                    const message = parts.slice(1).join(": ");
                    appendMessage(sender, message, sender === fullName ? 'staff' : 'customer');
                };

                socket.onerror = function (err) {
                    console.error("WebSocket lỗi:", err);
                };

                socket.onclose = function () {
                    console.warn("WebSocket đã đóng.");
                };
            }

// Hàm hiển thị tin nhắn
            function appendMessage(sender, message, cssClass) {
                const div = document.createElement("div");
                div.className = "chat-message " + cssClass;

                if (message.startsWith("IMAGE:")) {
                    const img = document.createElement("img");
                    img.src = message.replace("IMAGE:", "");
                    img.style.maxWidth = "200px";
                    img.style.borderRadius = "10px";
                    div.innerHTML = "<strong>" + sender + "</strong><br>";
                    div.appendChild(img);
                } else {
                    div.innerHTML = "<strong>" + sender + "</strong>: " + message;
                }

                chatBox.appendChild(div);
                chatBox.scrollTop = chatBox.scrollHeight;
            }

        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    </body>

</html>
