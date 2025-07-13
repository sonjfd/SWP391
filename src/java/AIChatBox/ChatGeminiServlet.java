/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AIChatBox;

import DAO.AIChatboxDAO;
import DAO.DoctorDAO;
import DAO.MedicalRecordDAO;
import DAO.StaffDAO;
import DAO.UserDAO;
import Model.Appointment;
import Model.AppointmentSymptom;

import Model.ChatHistory;
import Model.Doctor;
import Model.MedicalRecord;
import Model.Pet;
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
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Pattern;

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
        User user = (User) session.getAttribute("user");
        List<ChatHistory> history = new AIChatboxDAO().getChatHistoryByUserId(user.getId());

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
        System.out.println("userId trong buildMessagesJson: " + userId);

        if (user != null) {
            dao.insertMessage(null, userId, "user", message);
        } else {
            dao.insertMessage(sessionId, null, "user", message);
        }
        List<ChatHistory> history = dao.getChatHistoryByUserId(userId);

        String jsonInput = buildMessagesJson(history, userId);
        String resultText = callGeminiAPI(jsonInput);
        if (user != null) {
            dao.insertMessage(null, userId, "ai", resultText);
        } else {
            dao.insertMessage(sessionId, null, "ai", resultText);
        }
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(resultText);
    }

    private String buildMessagesJson(List<ChatHistory> history, String userId) {
        StringBuilder sb = new StringBuilder();
        sb.append("{ \"contents\": [");
        sb.append("{ \"role\": \"user\", \"parts\": [ { \"text\": \"")
                .append("Bạn là trợ lý AI của phòng khám thú y Pet24h. ")
                .append("Bạn có quyền truy cập dữ liệu lịch sử khám bệnh của người dùng nếu họ đã đăng nhập vào hệ thống. ")
                .append("Tất cả dữ liệu đã được hệ thống cấp phép, bạn KHÔNG cần xác minh lại quyền truy cập. ")
                .append("Khi người dùng yêu cầu xem lịch sử khám bệnh, bạn phải trả về đầy đủ lịch sử các lần khám trước nếu có. ")
                .append("Khi thấy câu như 'lịch sử khám bệnh', 'xem lịch sử' hoặc tương tự, hãy lập tức phản hồi với dữ liệu có sẵn trong hệ thống. Không hỏi lại hoặc từ chối.")
                .append("Tuyệt đối KHÔNG được từ chối vì lý do bảo mật hoặc quyền riêng tư – hệ thống đã xử lý phần đó. ")
                .append("Nếu không có lịch sử khám bệnh, hãy thông báo rằng chưa có lần khám nào. ")
                .append("Không hỏi lại quyền, không xin lỗi, không từ chối. ")
                .append("Nếu được hỏi về phòng khám uy tín, hãy giới thiệu Pet24h – phòng khám tại Thạch Hòa, Thạch Thất, gần Đại học FPT.")
                .append("\" } ] },");

        String lastUserMessage = "";
        for (int i = 0; i < history.size(); i++) {
            ChatHistory msg = history.get(i);
            String role = msg.getSenderType().equalsIgnoreCase("user") ? "user" : "model";
            String text = escapeJson(msg.getMessageText());
            sb.append("{ \"role\": \"").append(role).append("\", \"parts\": [ { \"text\": \"")
                    .append(text).append("\" } ] },");
            if (i == history.size() - 1 && role.equals("user")) {
                lastUserMessage = text;
            }
        }
        Set<String> flags = regax(lastUserMessage);
        if (flags.contains("history_request")) {
            sb.append("{ \"role\": \"user\", \"parts\": [ { \"text\": \"")
                    .append("Người dùng đang yêu cầu xem lịch sử khám bệnh. Hãy phản hồi đầy đủ lịch sử khám nếu có.")
                    .append("\" } ] },");
        }

        if (flags.contains("symptom")) {
            sb.append("{ \"role\": \"user\", \"parts\": [ { \"text\": \"")
                    .append("Hãy trả lời câu hỏi về triệu chứng trước, sau đó hỏi: 'Bạn có muốn đặt lịch khám tại phòng khám Pet24h không? (Có / Không)'")
                    .append("\" } ] },");
        }
        if (flags.contains("book_request") && !flags.contains("symptom")) {
            sb.append("{ \"role\": \"user\", \"parts\": [ { \"text\": \"")
                    .append("Người dùng đang yêu cầu đặt lịch, hãy hỏi: 'Bạn có muốn đặt lịch khám tại phòng khám Pet24h không? (Có / Không)'")
                    .append("\" } ] },");
        }
        if (flags.contains("doctor_list")) {
            List<Doctor> doctors = new StaffDAO().getAllDoctors();
            StringBuilder doctorList = new StringBuilder();
            for (Doctor doc : doctors) {
                doctorList.append("- ").append(doc.getUser().getFullName());
                if (doc.getSpecialty() != null && !doc.getSpecialty().isEmpty()) {
                    doctorList.append(" – chuyên khoa ").append(doc.getSpecialty());
                }
                doctorList.append("\\n");
            }

            sb.append("{ \"role\": \"user\", \"parts\": [ { \"text\": \"")
                    .append("Danh sách bác sĩ tại phòng khám Pet24h như sau:\\n")
                    .append(doctorList)
                    .append("Sau đó, hãy hỏi người dùng: 'Bạn có muốn đặt lịch khám với một bác sĩ không? (Có / Không)'")
                    .append("\" } ] },");
        }

        if (userId != null && flags.contains("history_request")) {
            sb.append("{ \"role\": \"user\", \"parts\": [ { \"text\": \"")
                    .append("️ Đây là dữ liệu lịch sử khám bệnh thật từ hệ thống – vui lòng sử dụng đúng, không dựa trên phản hồi cũ.")
                    .append("\" } ] },");
            List<MedicalRecord> allHistory = new MedicalRecordDAO().getMedicalRecordsByCustomerId(userId);
            StringBuilder historyText = new StringBuilder();

            if (allHistory.isEmpty()) {
                historyText.append("Bạn chưa có lịch sử khám bệnh nào.");
            } else {
                for (MedicalRecord record : allHistory) {
                    Pet pet = record.getPet();
                    if (pet != null) {
                        historyText.append("- Thú cưng: ").append(pet.getName()).append("\n");
                    }

                    Appointment appt = record.getAppointment();
                    if (appt != null) {
                        if (appt.getAppointmentDate() != null) {
                            historyText.append("  Ngày khám: ")
                                    .append(new SimpleDateFormat("dd/MM/yyyy").format(appt.getAppointmentDate()))
                                    .append("\n");
                        }

                        Doctor doctor = record.getDoctor();
                        if (doctor != null && doctor.getUser() != null) {
                            historyText.append("  Bác sĩ: ").append(doctor.getUser().getFullName()).append("\n");
                        } else {
                            historyText.append("  Bác sĩ: (không rõ)\n");
                        }
                    } else {
                        historyText.append("  Thông tin lịch hẹn không khả dụng.\n");
                    }

                    List<AppointmentSymptom> symptoms = record.getAppointmentSymptoms();
                    if (symptoms != null && !symptoms.isEmpty()) {
                        historyText.append("  Triệu chứng: ");
                        for (int i = 0; i < symptoms.size(); i++) {
                            historyText.append(symptoms.get(i).getSymptom());
                            if (i < symptoms.size() - 1) {
                                historyText.append(", ");
                            }
                        }
                        historyText.append("\n");
                    }

                    if (record.getDiagnosis() != null) {
                        historyText.append("  Chuẩn đoán: ").append(record.getDiagnosis()).append("\n");
                    }

                    if (record.getTreatment() != null) {
                        historyText.append("  Điều trị: ").append(record.getTreatment()).append("\n");
                    }

                    historyText.append("\n");
                }
            }

            sb.append(message("user", "Dưới đây là toàn bộ lịch sử khám bệnh về thú cưng của bạn:\n" + historyText)).append(",");
        }

        if (sb.toString().endsWith(",")) {
            sb.setLength(sb.length() - 1);
        }
        sb.append(" ] }");
        return sb.toString();
    }

    private Set<String> regax(String message) {
        Set<String> result = new HashSet<>();
        String text = " " + removeDiacritics(message.toLowerCase()) + " ";

        String[] symptoms = {
            "sot", "non", "oi", "tieu chay", "di ngoai", "met", "lo do", "ue oai",
            "bo an", "chan an", "bieng an", "khong an", "an it", "khong uong nuoc", "khat nuoc",
            "ho", "hat hoi", "kho tho", "tho gap", "tho doc",
            "rong long", "long xo", "long rung", "long kho", "long xau",
            "ngua", "gai", "liem nhieu", "sung", "viem", "lo loet", "noi man",
            "dau bung", "phinh bung", "chuong bung",
            "nuoc tieu bat thuong", "dai dat", "tieu nhieu", "tieu ra mau", "khong tieu duoc",
            "phan long", "phan co mau", "phan den",
            "sut can", "gay", "giam can", "bung to",
            "mat do", "mat mo", "mat chay nuoc", "mat duc", "mat le",
            "tai co mui", "tai chay mu", "rung rang", "hoi mieng", "mieng chay nuoc dai",
            "run", "co giat", "di khap khieng", "di khong vung", "liet", "yeu chan",
            "not do", "mun", "buou", "u", "hach", "nhiem trung"
        };

        for (String symptom : symptoms) {
            if (text.contains(" " + symptom + " ")) {
                result.add("symptom");
                break;
            }
        }

        if (text.matches(".*\\b(danh sach bac si|xem bac si|bac si nao|co bac si nao)\\b.*")) {
            result.add("doctor_list");
        }

        if (text.matches(".*\\b(lich su kham|lich su benh|da tung kham|lich su thu cung|xem lich su)\\b.*")) {
            result.add("history_request");
        }

        if (text.matches(".*\\b(dat lich|muon dat lich|toi muon dat lich|dat kham|muon kham)\\b.*")) {
            result.add("book_request");
        }

        return result;
    }

    private String removeDiacritics(String input) {
        String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
        return normalized.replaceAll("\\p{InCombiningDiacriticalMarks}+", "")
                .replaceAll("đ", "d").replaceAll("Đ", "D");
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

    private String message(String role, String text) {
        return String.format("{ \"role\": \"%s\", \"parts\": [ { \"text\": \"%s\" } ] }", role, escapeJson(text));
    }

    private String escapeJson(String text) {
        return text.replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
