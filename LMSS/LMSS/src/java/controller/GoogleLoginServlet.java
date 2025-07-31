package controller;

import dao.UsersDAO;      // đổi UserDAO thành UsersDAO
import model.User;
import utils.BCryptUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.UUID;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class GoogleLoginServlet extends HttpServlet {

    private static final String CLIENT_ID = "1078177483149-37par608983poj4s99q8u5pme5skomqp.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/LMSS/GoogleLoginServlet";

    private static final String TOKEN_ENDPOINT = "https://oauth2.googleapis.com/token";
    private static final String USERINFO_ENDPOINT = "https://www.googleapis.com/oauth2/v2/userinfo";

    private UsersDAO usersDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        // Tạo kết nối DB (thay thông số kết nối đúng với bạn)
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // hoặc driver DB bạn dùng
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/your_db_name", "db_user", "db_password");
            usersDAO = new UsersDAO(conn);
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");

        if (code == null || code.isEmpty()) {
            String googleAuthUrl = "https://accounts.google.com/o/oauth2/v2/auth" +
                    "?client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8) +
                    "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8) +
                    "&response_type=code" +
                    "&scope=" + URLEncoder.encode("openid email profile", StandardCharsets.UTF_8) +
                    "&access_type=online";

            resp.sendRedirect(googleAuthUrl);
            return;
        }

        String accessToken = getAccessToken(code);
        if (accessToken == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Google login failed");
            return;
        }

        JsonObject userInfo = getUserInfo(accessToken);
        if (userInfo == null || !userInfo.has("email")) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Google login failed");
            return;
        }

        String email = userInfo.get("email").getAsString();
        String name = userInfo.has("name") ? userInfo.get("name").getAsString() : email;

        try {
            // Trong UsersDAO bạn có getUserByUsername(), hiện username là email của Google
            User user = usersDAO.getUserByUsername(email);

            if (user == null) {
                String randomPassword = UUID.randomUUID().toString();
                String hashedPassword = BCryptUtil.hashPassword(randomPassword);
                // avatarUrl tạm để null hoặc có thể lấy từ userInfo nếu có
                String avatarUrl = userInfo.has("picture") ? userInfo.get("picture").getAsString() : null;

                // Tạo user mới với role mặc định là "student"
                // Chú ý: constructor User trong dao của bạn gồm 7 tham số, tôi giả sử có constructor phù hợp,
                // nếu không bạn cần tạo constructor tương ứng hoặc dùng setter
                user = new User(0, email, hashedPassword, "student", email, avatarUrl, true); 
                // email_verified = true vì Google login mặc định xác thực email rồi
                usersDAO.registerUserWithToken(
                    user.getUsername(), 
                    user.getPassword(), 
                    user.getRole(), 
                    user.getEmail(), 
                    avatarUrl, 
                    null // token null vì email đã verified
                );
                // Sau khi đăng ký thì có thể lấy lại user với id từ DB hoặc giữ nguyên user này tạm
            }

            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            switch (user.getRole()) {
                case "student":
                    resp.sendRedirect(req.getContextPath() + "/student/dashboard.html");
                    break;
                case "lecturer":
                    resp.sendRedirect(req.getContextPath() + "/lecturer/dashboard.html");
                    break;
                case "admin":
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard.html");
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Role not recognized");
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Internal server error");
        }
    }

    private String getAccessToken(String code) throws IOException {
        String params = "code=" + URLEncoder.encode(code, StandardCharsets.UTF_8) +
                "&client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8) +
                "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, StandardCharsets.UTF_8) +
                "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8) +
                "&grant_type=authorization_code";

        URL url = new URL(TOKEN_ENDPOINT);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.getOutputStream().write(params.getBytes(StandardCharsets.UTF_8));

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            JsonObject json = JsonParser.parseReader(new InputStreamReader(conn.getInputStream())).getAsJsonObject();
            return json.get("access_token").getAsString();
        } else {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            StringBuilder errorResponse = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                errorResponse.append(line);
            }
            System.err.println("Error when getting access token. HTTP code: " + responseCode);
            System.err.println("Error response from Google: " + errorResponse.toString());
            return null;
        }
    }

    private JsonObject getUserInfo(String accessToken) throws IOException {
        URL url = new URL(USERINFO_ENDPOINT + "?access_token=" + URLEncoder.encode(accessToken, StandardCharsets.UTF_8));
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        if (conn.getResponseCode() == 200) {
            return JsonParser.parseReader(new InputStreamReader(conn.getInputStream())).getAsJsonObject();
        }

        return null;
    }
}
