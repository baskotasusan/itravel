package controller.servlets;

import database.Database;
import model.Post;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/Profile")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Post> posts = new ArrayList<Post>();

        User user = (User) request.getSession().getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("/index.jsp");
            return;
        }

        Connection con = Database.getConnection(request, response);

        try {
            String sql = "SELECT posts.id, user_id, content, images, location, datetime, full_name FROM posts INNER JOIN users ON posts.user_id=users.id WHERE users.id = ? ORDER BY posts.id DESC LIMIT 10";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getId());

            ResultSet result = ps.executeQuery();

            while (result.next()) {
                Post post = new Post();

                post.setId(result.getString("id"));
                post.setUserId(result.getString("user_id"));
                post.setContent(result.getString("content"));
                post.setImages(result.getString("images"));
                post.setLocation(result.getString("location"));
                String dateTime = result.getString("datetime");
                dateTime = dateTime.substring(0, dateTime.length() - 5);
                post.setDateTime(dateTime);
                post.setPostedBy(result.getString("full_name"));

                String sql2 = "SELECT COUNT(*) FROM likes WHERE post_id=?";
                PreparedStatement ps2 = con.prepareStatement(sql2);
                ps2.setString(1, post.getId());

                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    post.setTotalLikes(rs2.getInt(1) + "");
                } else {
                    post.setTotalLikes("0");
                }

                String sql3 = "SELECT * FROM likes WHERE post_id=? AND user_id=? LIMIT 1";
                PreparedStatement ps3 = con.prepareStatement(sql3);
                ps3.setString(1, post.getId());
                ps3.setString(2, user.getId());

                ResultSet rs3 = ps3.executeQuery();
                if (rs3.next()) {
                    post.setLikedByMe("true");
                } else {
                    post.setLikedByMe("false");
                }

                posts.add(post);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        }

        request.setAttribute("posts", posts);

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
