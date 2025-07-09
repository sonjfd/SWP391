
const chatBtn = document.getElementById("chatAiBtn");
const chatWindow = document.getElementById("chatWindow");
const closeChatBtn = document.getElementById("closeChatBtn");
const sendMessageBtn = document.getElementById("sendMessageBtn");
const userInput = document.getElementById("userInput");
const chatContent = document.getElementById("chatContent");


chatBtn.addEventListener("click", () => {
    chatWindow.style.display = "flex";
    chatBtn.style.display = "none";
    if (isLoggedIn) {
        loadChatHistory();
    }
});
closeChatBtn.addEventListener("click", () => {
    chatWindow.style.display = "none";
    chatBtn.style.display = "block";
});

userInput.addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
        sendMessage();
    }
});

sendMessageBtn.addEventListener("click", sendMessage);


function formatAiResponse(text) {
    text = text.replace(/^Tuyệt vời!.*?\?/, "").trim();
    text = text
            .replace(/\*\*(.*?)\*\*/g, "<b>$1</b>")
            .replace(/\*(.*?)\*/g, "<i>$1</i>")
            .replace(/\n{2,}/g, "<br><br>")
            .replace(/\n/g, "<br>");
    return text;
}

function sendMessage() {
    const message = userInput.value.trim();
    if (message === "")
        return;


    const userMsg = document.createElement("div");
    userMsg.style.textAlign = "right";
    const userBubble = document.createElement("span");
    userBubble.textContent = message;
    userBubble.style.cssText = `
        background: #007bff; 
        color: white; 
        padding: 8px 12px; 
        border-radius: 12px; 
        display: inline-block; 
        max-width: 80%; 
        word-wrap: break-word;
        margin-bottom: 4px;
    `;
    userMsg.appendChild(userBubble);
    chatContent.appendChild(userMsg);

    userInput.value = "";
    chatContent.scrollTop = chatContent.scrollHeight;


    const aiMsg = document.createElement("div");
    aiMsg.className = "ai-message";
    aiMsg.innerHTML = `<div style="margin-top:5px; font-style: italic;">Đang trả lời...</div>`;
    chatContent.appendChild(aiMsg);
    chatContent.scrollTop = chatContent.scrollHeight;


    fetch("chat-ai", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "message=" + encodeURIComponent(message)
    })
            .then(response => response.text())
            .then(data => {
                const aiBubble = document.createElement("span");
                aiBubble.innerHTML = formatAiResponse(data);
                aiBubble.style.cssText = `
            background: #f1f1f1; 
            padding: 8px 12px; 
            border-radius: 12px; 
            display: inline-block; 
            max-width: 80%; 
            word-wrap: break-word;
            margin-left: 6px;
        `;

                const aiWrapper = document.createElement("div");
                aiWrapper.style.display = "flex";
                aiWrapper.style.alignItems = "flex-start";
                aiWrapper.style.marginTop = "8px";

                const aiImg = document.createElement("img");
                aiImg.src = "assets/images/ai.png";
                aiImg.alt = "AI";
                aiImg.style.cssText = "width: 28px; height: 28px; border-radius: 50%; margin-top: 2px;";

                aiWrapper.appendChild(aiImg);
                aiWrapper.appendChild(aiBubble);

                aiMsg.innerHTML = "";
                aiMsg.appendChild(aiWrapper);
                chatContent.scrollTop = chatContent.scrollHeight;

                if (data.includes("các bác sĩ sau") || data.includes("có tại phòng khám ")) {
                    aiMsg.innerHTML = "";
                    fetch("chat-ai-doctor-list")
                            .then(res => res.json())
                            .then(doctors => {
                                const listDiv = document.createElement("div");
                                listDiv.style.marginTop = "8px";

                                let html = "<b>Danh sách bác sĩ tại phòng khám:</b><ul>";
                                doctors.forEach(doc => {
                                    html += `<li>${doc.fullName || doc.name} - ${doc.specialty || ''}</li>`;
                                });
                                html += "</ul>";
                                listDiv.innerHTML = html;
                                chatContent.appendChild(listDiv);
                                chatContent.scrollTop = chatContent.scrollHeight;

                                // Gợi ý đặt lịch
                                const confirm = document.createElement("div");
                                confirm.innerHTML = `<div style="margin-top:8px;">Bạn có muốn đặt lịch khám với một bác sĩ không?</div>`;
                                chatContent.appendChild(confirm);

                                const btnGroup = document.createElement("div");
                                btnGroup.style.marginTop = "6px";
                                btnGroup.style.display = "flex";
                                btnGroup.style.gap = "8px";

                                const yesBtn = document.createElement("button");
                                yesBtn.textContent = "Có";
                                yesBtn.style.cssText = `
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                background-color: #28a745;
                color: white;
                cursor: pointer;
            `;

                                const noBtn = document.createElement("button");
                                noBtn.textContent = "Không";
                                noBtn.style.cssText = `
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                background-color: #dc3545;
                color: white;
                cursor: pointer;
            `;

                                yesBtn.addEventListener("click", () => {
                                    showDoctorBookingPrompt();
                                    btnGroup.remove();
                                });

                                noBtn.addEventListener("click", () => {
                                    const noMsg = document.createElement("div");
                                    noMsg.innerHTML = `<div style="text-align:right;"><span style="background:#007bff;color:white;padding:8px 12px;border-radius:12px;display:inline-block;">Không</span></div>`;
                                    chatContent.appendChild(noMsg);
                                    chatContent.scrollTop = chatContent.scrollHeight;
                                    btnGroup.remove();
                                });

                                btnGroup.appendChild(yesBtn);
                                btnGroup.appendChild(noBtn);
                                chatContent.appendChild(btnGroup);
                                chatContent.scrollTop = chatContent.scrollHeight;
                            })
                            .catch(err => {
                                console.error("Lỗi khi lấy danh sách bác sĩ:", err);
                            });
                }



                if (data.includes("Bạn có muốn đặt lịch khám tại phòng khám Pet24h không")) {
                    const btnGroup = document.createElement("div");
                    btnGroup.style.marginTop = "8px";
                    btnGroup.style.display = "flex";
                    btnGroup.style.gap = "8px";

                    const yesBtn = document.createElement("button");
                    yesBtn.textContent = "Có";
                    yesBtn.style.cssText = `
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                background-color: #28a745;
                color: white;
                cursor: pointer;
            `;

                    const noBtn = document.createElement("button");
                    noBtn.textContent = "Không";
                    noBtn.style.cssText = `
                padding: 6px 12px;
                border: none;
                border-radius: 6px;
                background-color: #dc3545;
                color: white;
                cursor: pointer;
            `;

                    yesBtn.addEventListener("click", () => {
                        showBookingPrompt();
                        btnGroup.remove();
                    });

                    noBtn.addEventListener("click", () => {
                        const noMsg = document.createElement("div");
                        noMsg.innerHTML = `<div style="text-align:right;"><span style="background:#007bff;color:white;padding:8px 12px;border-radius:12px;display:inline-block;">Không</span></div>`;
                        chatContent.appendChild(noMsg);
                        chatContent.scrollTop = chatContent.scrollHeight;
                        btnGroup.remove();
                    });

                    btnGroup.appendChild(yesBtn);
                    btnGroup.appendChild(noBtn);
                    chatContent.appendChild(btnGroup);
                    chatContent.scrollTop = chatContent.scrollHeight;
                }
            })
            .catch(err => {
                console.error("Lỗi khi gửi hoặc nhận tin nhắn:", err);
                aiMsg.innerHTML = `<div style="color:red;">Lỗi: ${err.message}</div>`;
            });
}

function showBookingPrompt() {
    fetch("chat-ai-select-pet")
            .then(res => {
                if (res.status === 500) {
                    const loginMsg = document.createElement("div");
                    loginMsg.innerHTML = `
                    <div style="margin-top:8px;">
                        Bạn cần <a href="login" style="color: #007bff;">đăng nhập</a> để đặt lịch khám.
                    </div>`;
                    chatContent.appendChild(loginMsg);
                    chatContent.scrollTop = chatContent.scrollHeight;
                    throw new Error("Chưa đăng nhập");
                }
                return res.json();
            })
            .then(pets => {
                const formDiv = document.createElement("div");
                formDiv.style.marginTop = "8px";
                formDiv.innerHTML = `
                <div id="bookingFormContent">
                    <label>Chọn thú cưng:</label><br>
                    <select id="petSelect" style="width: 100%; padding: 6px; margin-bottom: 6px; border-radius: 6px; border: 1px solid #ccc;">
                        <option value="">-- Chọn thú cưng --</option>
                    </select>
                    <div id="noPetMessage" style="display:none; margin-top:5px;">
                        Bạn chưa có thú cưng nào. <a href="them-thu-cung" style="color:#007bff;">Thêm thú cưng</a>
                    </div>
                    <label>Ngày khám mong muốn:</label><br>
                    <input type="date" id="appointmentDateInput" style="width: 100%; padding: 6px; border-radius: 6px; border: 1px solid #ccc;" />
                    <button type="button" id="confirmBookingBtn" style="margin-top: 10px; background: #007bff; color: white; border: none; padding: 6px 12px; border-radius: 6px;">Đặt lịch</button>
                </div>`;
                chatContent.appendChild(formDiv);
                chatContent.scrollTop = chatContent.scrollHeight;
                const petSelect = formDiv.querySelector("#petSelect");
                const noPetMessage = formDiv.querySelector("#noPetMessage");
                if (pets.length === 0) {
                    noPetMessage.style.display = "block";
                } else {
                    pets.forEach(pet => {
                        const option = document.createElement("option");
                        option.value = pet.id;
                        option.textContent = pet.name;
                        petSelect.appendChild(option);
                    });
                }
                formDiv.querySelector("#confirmBookingBtn").addEventListener("click", () => {
                    const petId = petSelect.value;
                    const date = formDiv.querySelector("#appointmentDateInput").value;
                    if (!petId || !date) {
                        alert("Vui lòng chọn thú cưng và ngày khám.");
                        return;
                    }
                    const today = new Date();
                    const selectedDate = new Date(date);
                    today.setHours(0, 0, 0, 0);
                    selectedDate.setHours(0, 0, 0, 0);
                    if (selectedDate < today) {
                        alert("Không thể chọn ngày trong quá khứ. Vui lòng chọn lại.");
                        return;
                    }
                    fetch("ai-booking", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "petId=" + encodeURIComponent(petId) + "&date=" + encodeURIComponent(date)
                    })
                            .then(res => res.text())
                            .then(msg => {
                                const msgEl = document.createElement("div");
                                msgEl.style.marginTop = "8px";
                                const span = document.createElement("span");
                                span.style.color = msg.includes("thành công") ? "black" : "red";
                                if (msg.includes("thành công")) {

                                    const textNode = document.createTextNode(msg + " Hoặc xem chi tiết tại ");
                                    span.appendChild(textNode);

                                    const link = document.createElement("a");
                                    link.href = "customer-viewappointment";
                                    link.textContent = "đây";
                                    link.style.color = "#007bff";
                                    span.appendChild(link);
                                    span.appendChild(document.createTextNode("."));
                                } else {
                                    span.textContent = msg;
                                }
                                msgEl.appendChild(span);
                                const form = document.querySelector("#bookingFormContent");
                                form?.appendChild(msgEl);
                                chatContent.scrollTop = chatContent.scrollHeight;
                            })
                            .catch(err => {
                                console.error("Lỗi đặt lịch:", err);
                                alert("Có lỗi xảy ra khi đặt lịch.");
                            });
                });
            })
            .catch(err => {
                console.log(err);
            });
}


function showDoctorBookingPrompt() {
    Promise.all([
        fetch("chat-ai-select-pet").then(res => {
            if (res.status === 500) {
                const loginMsg = document.createElement("div");
                loginMsg.innerHTML = `
                <div style="margin-top:8px;">
                    Bạn cần <a href="login" style="color: #007bff;">đăng nhập</a> để đặt lịch khám.
                </div>`;
                chatContent.appendChild(loginMsg);
                chatContent.scrollTop = chatContent.scrollHeight;
                throw new Error("Chưa đăng nhập");
            }
            return res.json();
        }),
        fetch("chat-ai-doctor-list").then(res => res.json())
    ])
            .then(([doctors, pets]) => {
                const formDiv = document.createElement("div");
                formDiv.style.marginTop = "8px";
                formDiv.innerHTML = `
                <div id="doctorBookingForm">
                    <label>Chọn thú cưng:</label><br>
                    <select id="petSelect" style="width: 100%; padding: 6px; margin-bottom: 6px; border-radius: 6px; border: 1px solid #ccc;">
                        <option value="">-- Chọn thú cưng --</option>
                    </select>

                    <label>Chọn bác sĩ:</label><br>
                    <select id="doctorSelect" style="width: 100%; padding: 6px; margin-bottom: 6px; border-radius: 6px; border: 1px solid #ccc;">
                        <option value="">-- Chọn bác sĩ --</option>
                    </select>

                    <label>Chọn ngày rảnh:</label><br>
                    <input type="date" id="preferredDate" style="width: 100%; padding: 6px; border-radius: 6px; border: 1px solid #ccc;" />

                    <button type="button" id="doctorBookingBtn" style="margin-top: 10px; background: #007bff; color: white; border: none; padding: 6px 12px; border-radius: 6px;">Đặt lịch với bác sĩ</button>
                </div>
            `;
                chatContent.appendChild(formDiv);
                chatContent.scrollTop = chatContent.scrollHeight;

                const doctorSelect = formDiv.querySelector("#doctorSelect");
                const petSelect = formDiv.querySelector("#petSelect");

                // Đổ dữ liệu thú cưng
                pets.forEach(pet => {

                    const option = document.createElement("option");
                    option.value = pet.id;
                    option.textContent = pet.name;
                    petSelect.appendChild(option);
                });

                // Đổ dữ liệu bác sĩ
                doctors.forEach(doctor => {
                    const option = document.createElement("option");
                    option.value = doctor.id;
                    option.textContent = doctor.fullName;
                    doctorSelect.appendChild(option);
                });

                formDiv.querySelector("#doctorBookingBtn").addEventListener("click", () => {
                    const doctorId = doctorSelect.value;
                    const petId = petSelect.value;
                    const date = formDiv.querySelector("#preferredDate").value;

                    if (!doctorId || !date || !petId) {
                        alert("Vui lòng chọn thú cưng, bác sĩ và ngày khám.");
                        return;
                    }

                    const today = new Date();
                    const selectedDate = new Date(date);
                    today.setHours(0, 0, 0, 0);
                    selectedDate.setHours(0, 0, 0, 0);

                    if (selectedDate < today) {
                        alert("Không thể chọn ngày trong quá khứ. Vui lòng chọn lại.");
                        return;
                    }

                    // Gửi yêu cầu đặt lịch
                    fetch("chat-ai-book-with-doctor", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "doctorId=" + encodeURIComponent(doctorId) + "&petId=" + encodeURIComponent(petId) + "&date=" + encodeURIComponent(date)
                    })
                            .then(res => res.text())
                            .then(msg => {
                                const msgEl = document.createElement("div");
                                msgEl.style.marginTop = "8px";

                                const span = document.createElement("span");
                                span.style.color = msg.includes("thành công") ? "black" : "red";

                                if (msg.includes("thành công")) {
                                    const textNode = document.createTextNode(msg + " Hoặc xem chi tiết tại ");
                                    span.appendChild(textNode);

                                    const link = document.createElement("a");
                                    link.href = "customer-viewappointment";
                                    link.textContent = "đây";
                                    link.style.color = "#007bff";

                                    span.appendChild(link);
                                    span.appendChild(document.createTextNode("."));
                                } else {
                                    span.textContent = msg;
                                }

                                msgEl.appendChild(span);
                                formDiv.appendChild(msgEl);
                                chatContent.scrollTop = chatContent.scrollHeight;
                            })
                            .catch(err => {
                                console.error("Lỗi khi đặt lịch với bác sĩ:", err);
                                alert("Đã xảy ra lỗi khi đặt lịch.");
                            });
                });
            })
            .catch(err => {
                console.error("Lỗi khi lấy dữ liệu bác sĩ hoặc thú cưng:", err);
            });
}





function loadChatHistory() {
    fetch("chat-ai")
            .then(response => {
                if (!response.ok) {
                    throw new Error("Lỗi HTTP: " + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log("Data received:", data);


                if (!Array.isArray(data)) {
                    console.error("Dữ liệu trả về không phải là mảng:", data);
                    return;
                }

                const chatContent = document.getElementById("chatContent");
                if (!chatContent) {
                    console.error("Không tìm thấy phần tử chat-content");
                    return;
                }

                chatContent.innerHTML = "";


                const baseUrl = window.location.origin + "/";

                const userAvatar = data[0].user.avatar
                        ? new URL(data[0].user.avatar, window.location.origin).href
                        : pageContextPath + "/image-loader/default_user.png";
                console.log(userAvatar);
                data.forEach(item => {


                    const msgDiv = document.createElement("div");
                    msgDiv.className = item.senderType === "user" ? "message user" : "message ai";

                    const avatarSrc = item.senderType === "user" ? userAvatar : "assets/images/ai.png";
                    const messageText = item.senderType === "ai" ? formatAiResponse(item.messageText) : item.messageText;

                    const messageBubbleDiv = document.createElement("div");
                    messageBubbleDiv.className = "message-bubble";
                    const avatarImg = document.createElement("img");
                    avatarImg.src = avatarSrc;
                    avatarImg.className = "avatar";
                    const messageSpan = document.createElement("span");
                    messageSpan.className = "text";
                    messageSpan.innerHTML = messageText;

                    messageBubbleDiv.appendChild(avatarImg);
                    messageBubbleDiv.appendChild(messageSpan);

                    msgDiv.appendChild(messageBubbleDiv);

                    chatContent.appendChild(msgDiv);
                });
                chatContent.scrollTop = chatContent.scrollHeight;
            })
            .catch(err => {
                console.error("Lỗi khi load lịch sử:", err);

            });
}



