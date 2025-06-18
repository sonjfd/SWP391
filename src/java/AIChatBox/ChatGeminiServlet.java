/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AIChatBox;

import DAO.AIChatboxDAO;

import Model.ChatHistory;
import Model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpRequestRetryHandler;
import org.apache.http.impl.client.HttpClients;

/**
 *
 * @author Dell
 */
@WebServlet(name = "ChatGeminiServlet", urlPatterns = {"/chat-ai"})

public class ChatGeminiServlet extends HttpServlet {

    private static final String API_KEY = "AIzaSyCjUgHpTFZNhYKIjRLWe2jsTkoQkq_KBp8";
    private static final String GEMINI_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY;

    @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    String sessionId = session.getId();
    User user = (User) session.getAttribute("user");
    AIChatboxDAO dao = new AIChatboxDAO();
    List<ChatHistory> history;

    if (user != null) {
        history=dao.getChatHistoryByUserId(user.getId());
    } else {
        history = dao.getChatHistoryBySession(sessionId);
    }

    response.setContentType("application/json; charset=UTF-8");
    PrintWriter out = response.getWriter();

    Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, (JsonSerializer<LocalDateTime>) (src, typeOfSrc, context)
                    -> new JsonPrimitive(src.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)))
            .create();

    out.print(gson.toJson(history));
    out.flush();
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = request.getParameter("message");
        AIChatboxDAO dao = new AIChatboxDAO();
        HttpSession session = request.getSession();
        String sessionId = session.getId();
        User user = (User) session.getAttribute("user");
        String userId = (user != null) ? user.getId() : null;
        if (user != null) {
            dao.insertMessage(null, userId, "user", message); 
        } else {
            dao.insertMessage(sessionId, null, "user", message); 
        }
        List<ChatHistory> history = (user != null)
                ? dao.getChatHistoryByUserId(userId)
                : dao.getChatHistoryBySession(sessionId);
        String jsonInput = buildMessagesJson(history);
        String resultText = callGeminiAPI(jsonInput);
        if (user != null) {
            dao.insertMessage(null, userId, "ai", resultText);
        } else {
            dao.insertMessage(sessionId, null, "ai", resultText);
        }
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(resultText);
    }

    private String buildMessagesJson(List<ChatHistory> history) {
        StringBuilder sb = new StringBuilder();
        sb.append("{ \"contents\": [");

        if (history.isEmpty()) {
            sb.append("{ \"role\": \"user\", \"parts\": [ { \"text\": \"")
                    .append("Bạn là bác sĩ thú y. ")
                    .append("Chỉ trả lời đúng câu hỏi người dùng, không hỏi lại hoặc yêu cầu thêm thông tin nếu họ chưa cung cấp. ")
                    .append("Trả lời ngắn gọn, rõ ràng, đúng trọng tâm. ")
                    .append("Nếu thiếu dữ kiện để kết luận, hãy nói rõ là cần thêm thông tin, nhưng không hỏi lại. ")
                    .append("Nếu được hỏi về phòng khám uy tín, hãy giới thiệu Pet24h – phòng khám tại Thạch Hòa, Thạch Thất, gần Đại học FPT. ")
                    .append("Bắt đầu hội thoại...")
                    .append("\" } ] },");
        }

        for (ChatHistory msg : history) {
            String role = msg.getSenderType().equalsIgnoreCase("user") ? "user" : "model";
            sb.append("{ \"role\": \"").append(role).append("\", \"parts\": [ { \"text\": \"")
                    .append(escapeJson(msg.getMessageText()))
                    .append("\" } ] },");
        }

        if (history.size() > 0 || sb.toString().contains("\"role\": \"user\"")) {
            sb.setLength(sb.length() - 1);
        }

        sb.append(" ] }");
        return sb.toString();
    }

    
    
    private String callGeminiAPI(String jsonInput) {
        String resultText = "";

        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(5000)
                .setConnectionRequestTimeout(5000)
                .setSocketTimeout(10000)
                .build();

        DefaultHttpRequestRetryHandler retryHandler = new DefaultHttpRequestRetryHandler(3, true);

        try (CloseableHttpClient httpClient = HttpClients.custom()
                .setDefaultRequestConfig(requestConfig)
                .setRetryHandler(retryHandler)
                .build()) {

            HttpPost post = new HttpPost(GEMINI_ENDPOINT);
            post.setHeader("Content-Type", "application/json");
            post.setEntity(new StringEntity(jsonInput, "UTF-8"));

            try (CloseableHttpResponse apiResponse = httpClient.execute(post)) {
                BufferedReader br = new BufferedReader(new InputStreamReader(apiResponse.getEntity().getContent(), "utf-8"));
                StringBuilder result = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    result.append(line.trim());
                }

                Gson gson = new Gson();
                JsonObject jsonObject = gson.fromJson(result.toString(), JsonObject.class);

                JsonArray candidates = jsonObject.getAsJsonArray("candidates");
                if (candidates != null && candidates.size() > 0) {
                    JsonObject firstCandidate = candidates.get(0).getAsJsonObject();
                    JsonObject content = firstCandidate.getAsJsonObject("content");
                    JsonArray parts = content.getAsJsonArray("parts");
                    if (parts != null && parts.size() > 0) {
                        JsonObject part = parts.get(0).getAsJsonObject();
                        resultText = part.get("text").getAsString();
                    } else {
                        resultText = "Không có kết quả từ Gemini API.";
                    }
                } else {
                    resultText = "Không có candidates từ Gemini API.";
                }

                System.out.println("Raw Gemini API response: " + result.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            String message = e.getMessage();

            if (message.contains("ConnectTimeoutException")) {
                resultText = "Không thể kết nối tới máy chủ Google. Vui lòng kiểm tra kết nối mạng.";
            } else if (message.contains("SocketTimeoutException") || message.contains("Read timed out")) {
                resultText = "Máy chủ Google phản hồi quá chậm. Vui lòng thử lại sau.";
            } else if (message.contains("NoHttpResponseException")) {
                resultText = "Máy chủ Google không phản hồi. Có thể đang quá tải. Vui lòng thử lại.";
            } else {

                resultText = "Đã xảy ra lỗi vui lòng thử lại sau ";
            }
        }

        return resultText;
    }

    private String escapeJson(String text) {
        return text.replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
