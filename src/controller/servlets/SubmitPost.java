package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import model.Post;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

@WebServlet(name = "SubmitPost")
public class SubmitPost extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = Database.getConnection(request, response);

        String postContent = request.getParameter("postcontent");
        String currentLocation = request.getParameter("location");

        User user = (User) request.getSession().getAttribute("loggedInUser");

        HashMap<String, String> jsonData = new HashMap<String, String>();

        if (user == null) {
            response.sendRedirect("/index.jsp");
            return;
        }

        try {
            if (insertPost(con, user, postContent, currentLocation)) {
                jsonData.put("status", "success");
                jsonData.put("post", getLatestPost(con, user));

            } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Unable To Insert Post!");

            }
        } catch (SQLException e) {
            jsonData.put("status", "fail");
            jsonData.put("message", "Oops, something went wrong!");
        }

        Gson gson = new Gson();

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(jsonData));
        out.flush();
    }

    private boolean insertPost(Connection con, User user, String postContent, String location) throws SQLException {
        String sql = "INSERT INTO posts (user_id, content, images, location) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, user.getId());
        ps.setString(2, postContent);
        ps.setString(3, "");
        if(location.equals("")){
            ps.setString(4, location);
        } else {
            ps.setString(4, user.getCity() + ", " + user.getState());
        }

        int result = ps.executeUpdate();

        if (result > 0) {
            return true;

        }

        return false;
    }

    private String getLatestPost(Connection con, User user) throws SQLException {
        Post post = new Post();

        String sql = "SELECT posts.id, user_id, content, images, location, datetime, full_name FROM posts INNER JOIN users ON posts.user_id=users.id ORDER BY posts.id DESC LIMIT 1";
        PreparedStatement ps = con.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            post.setId(rs.getString("id"));
            post.setUserId(rs.getString("user_id"));
            post.setContent(rs.getString("content"));
            post.setImages(rs.getString("images"));
            post.setLocation(rs.getString("location"));
            String dateTime = rs.getString("datetime");
            dateTime = dateTime.substring(0, dateTime.length()-5);
            post.setDateTime(dateTime);
            post.setPostedBy(rs.getString("full_name"));


            post.setTotalLikes("0");
            post.setLikedByMe("false");
        }

        Gson gson = new Gson();

        return gson.toJson(post);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
