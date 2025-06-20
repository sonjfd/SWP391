/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mail;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Dell
 */
public class SendEmail {

    private final String from = "vuphamoanh@gmail.com";
    private final String password = "nndr edek inpv gspe";

    public void sendEmailAfterBooking(String to, String name, String phone, String address, String petName, String appointmentDate, String doctorName, String slotStart, String slotEnd, double totalBill, String paymentMethod) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);

        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Xác Nhận Đặt Lịch Khám Thành Công", "UTF-8");
            String content = "<html><body>";
            content += "<h2>Xác nhận đặt lịch khám thành công!</h2>";
            content += "<p>Xin chào <strong>" + name + "</strong>,</p>";
            content += "<p>Chúng tôi đã nhận được yêu cầu đặt lịch khám của bạn. Dưới đây là thông tin chi tiết:</p>";
            content += "<p><strong>Họ và tên:</strong> " + name + "</p>";
            content += "<p><strong>Số điện thoại:</strong> " + phone + "</p>";
            content += "<p><strong>Địa chỉ:</strong> " + address + "</p>";
            content += "<p><strong>Thú cưng:</strong> " + petName + "</p>";
            content += "<p><strong>Ngày khám:</strong> " + appointmentDate + "</p>";
            content += "<p><strong>Bác sĩ:</strong> " + doctorName + "</p>";
            content += "<p><strong>Ca khám:</strong> " + slotStart + " - " + slotEnd + "</p>";
            content += "<p><strong>Phí đặt lịch khám:</strong> " + totalBill + " VNĐ</p>";
            content += "<p><strong>Phương thức thanh toán:</strong> " + paymentMethod + "</p>";
            content += "<p>Chúng tôi rất mong được phục vụ bạn!</p>";
            content += "<p><em>Đội ngũ chăm sóc khách hàng</em></p>";
            content += "</body></html>";

            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendEmailAfterCancelBooking(String to, String name, String phone, String address, String petName, String appointmentDate, String slotStart, String slotEnd) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        };

        Session session = Session.getInstance(props, auth);
        MimeMessage msg = new MimeMessage(session);

        try {
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Xác Nhận Đặt Lịch Khám Thành Công", "UTF-8");
            String content = "<html><body>";
            content += "<h2>Xác nhận đặt huỷ lịch khám thành công!</h2>";
            content += "<p>Xin chào <strong>" + name + "</strong>,</p>";
            content += "<p>Chúng tôi đã nhận chấp nhận yêu cầu huỷ đặt lịch khám của bạn!</p>";
            content += "<p><strong>Họ và tên:</strong> " + name + "</p>";
            content += "<p><strong>Số điện thoại:</strong> " + phone + "</p>";
            content += "<p><strong>Địa chỉ:</strong> " + address + "</p>";
            content += "<p><strong>Thú cưng:</strong> " + petName + "</p>";
            content += "<p><strong>Ngày khám:</strong> " + appointmentDate + "</p>";
          
            content += "<p><strong>Ca khám:</strong> " + slotStart + " - " + slotEnd + "</p>";
            content += "<p>Vui lòng liên hệ với nhân viên để hỗ trợ giải quyết thanh toán!</p>";
            content += "<p>Chúng tôi rất mong được phục vụ bạn!</p>";
            content += "<p><em>Đội ngũ chăm sóc khách hàng</em></p>";
            content += "</body></html>";

            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
