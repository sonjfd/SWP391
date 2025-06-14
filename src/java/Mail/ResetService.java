/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Mail;

import java.time.LocalDateTime;
import java.util.Properties;
import java.util.UUID;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Admin
 */
public class ResetService {

    private final int LIMIT_MINUS = 3;
    private final String from = "vuphamoanh@gmail.com";
    private final String password = "nndr edek inpv gspe";

    public String generateToken() {
        return UUID.randomUUID().toString();
    }

    public LocalDateTime expireDateTime() {
        return LocalDateTime.now().plusMinutes(LIMIT_MINUS);
    }

    public boolean isExpireTime(LocalDateTime time) {
        return LocalDateTime.now().isAfter(time);
    }

    public boolean sendEmail(String to, String link, String name) {
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
            msg.setSubject("Reset Password", "UTF-8");
            String content = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; background-color: #fafafa;'>"
                    + "<h1 style='color: #333;'>Xin chào " + name + "</h1>"
                    + "<p style='font-size: 16px; color: #555;'>Nhấn vào để đổi mật khẩu:</p>"
                    + "<p style='text-align: center; margin: 20px 0;'>"
                    + "<a href='" + link + "' style='display: inline-block; padding: 12px 24px; background-color: #007BFF; color: #fff; text-decoration: none; border-radius: 5px; font-size: 16px;'>Reset Password</a>"
                    + "</p>"
                    + "<p style='font-size: 14px; color: #999;'>Nếu bạn không có nhu cầu cập nhật lại mật khẩu vui lòng bỏ qua email này.</p>"
                    + "<p style='font-size: 14px; color: #999999;'>Liên kết sẽ hết hạn sau 3 phút.</p>"
                    + "</div>";

            msg.setContent(content, "text/html; charset=UTF-8");
            Transport.send(msg);
            System.out.println("Send successfully");
            return true;
        } catch (Exception e) {
            System.out.println("Send error");
            System.out.println(e);
            return false;
        }
    }

    public boolean sendEmailLoginGoogle(String to, String link, String name) {
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

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.addHeader("Content-type", "text/html; charset=UTF-8");
            msg.setFrom(from);
            msg.setReplyTo(InternetAddress.parse(from, false));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Xác thực tài khoản", "UTF-8");

            String content = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; background-color: #f9f9f9;'>"
                    + "<h1 style='color: #333333;'>Xin chào " + name + "</h1>"
                    + "<p style='font-size: 16px; color: #555555;'>Vui lòng nhấn vào liên kết dưới đây để xác thực tài khoản:</p>"
                    + "<p style='text-align: center; margin: 20px 0;'>"
                    + "<a href='" + link + "' style='display: inline-block; padding: 12px 20px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px; font-size: 16px;'>Xác thực ngay</a>"
                    + "</p>"
                    + "<p style='font-size: 14px; color: #999999;'>Liên kết sẽ hết hạn sau 3 phút.</p>"
                    + "</div>";

            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);
            return true;
        } catch (Exception e) {
            System.out.println("Send error");
            e.printStackTrace();
            return false;
        }
    }

    public boolean sendEmailVerifyAccount(String to, String link, String name) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Authenticator auth = new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            };

            Session session = Session.getInstance(props, auth);

            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject("Xác thực tài khoản", "UTF-8");

            String content = "<h2>Xin chào " + name + "</h2>"
                    + "<p>Vui lòng nhấn vào liên kết sau để xác thực tài khoản:</p>"
                    + "<a href='" + link + "'>Xác thực ngay</a>";

            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
