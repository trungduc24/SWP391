package utils;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    // Lấy email & mật khẩu từ biến môi trường (cấu hình trong server)
    private static final String USERNAME = System.getenv("SMTP_USERNAME"); // ví dụ: daohai11089@gmail.com
    private static final String PASSWORD = System.getenv("SMTP_PASSWORD"); // ví dụ: app password của Gmail

    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });
    }

    public static void sendEmail(String toEmail, String subject, String content, boolean isHtml) throws MessagingException {
        Message message = new MimeMessage(getSession());
        message.setFrom(new InternetAddress(USERNAME));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);

        if (isHtml) {
            message.setContent(content, "text/html; charset=utf-8");
        } else {
            message.setText(content);
        }

        Transport.send(message);
    }

    public static void sendVerificationEmail(String toEmail, String username, String verificationLink) throws MessagingException {
        String subject = "Xác nhận email đăng ký tài khoản";
        String content = "Chào " + username + ",<br><br>Vui lòng nhấp vào link để xác nhận email:<br>" +
                         "<a href='" + verificationLink + "'>Xác nhận Email</a><br><br>Trân trọng!";
        sendEmail(toEmail, subject, content, true);
    }
}
