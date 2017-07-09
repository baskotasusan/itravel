package controller.servlets;

import com.google.gson.Gson;
import database.Database;
import model.Comment;
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
import java.sql.Statement;
import java.util.HashMap;

@WebServlet("/PostComment")
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        Gson gson = new Gson();

        if (user == null) {
            response.sendRedirect("/index.jsp");
        }

        String comment = request.getParameter("comment");
        String post_id = request.getParameter("post_id");

        HashMap<String, String> jsonData = new HashMap<>();

        PrintWriter out = response.getWriter();
        response.setContentType("application/json");
        PreparedStatement statement = null;
        Connection con = Database.getConnection(request,response);

        try{
            String sql = "insert into comments (post_id, user_id, comment) values (?,?,?)";
            statement = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            statement.setString(1,post_id);
            statement.setString(2,user.getId());
            statement.setString(3,comment);

            int numOfRow = statement.executeUpdate();

            String generatedKey = "";

            ResultSet rs = statement.getGeneratedKeys();

            if (rs.next()) {
                generatedKey = rs.getString(1);

                PreparedStatement ps = con.prepareStatement("SELECT comments.id, comment, datetime, users.full_name FROM comments INNER JOIN users ON comments.user_id=users.id WHERE comments.id = ?");
                ps.setString(1, generatedKey);
                ResultSet resultSet = ps.executeQuery();

                if(resultSet.next()) {
                    Comment commentLatest = new Comment();

                    commentLatest.setId(resultSet.getString("id"));
                    commentLatest.setComment(resultSet.getString("comment"));
                    String dateTime = resultSet.getString("datetime");
                    dateTime = dateTime.substring(0, dateTime.length()-5);
                    commentLatest.setDateTime(dateTime);
                    commentLatest.setPostedBy(resultSet.getString("full_name"));

                    jsonData.put("status", "success");
                    jsonData.put("message", gson.toJson(commentLatest));

                } else {
                    jsonData.put("status", "fail");
                    jsonData.put("message", "Unable to post comment...");

                }

            } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Unable to post comment...");

            }

        }catch (Exception e){
            e.printStackTrace();
        }
        out.print(gson.toJson(jsonData));
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

    }
}
