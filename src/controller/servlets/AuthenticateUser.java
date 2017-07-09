package controller.servlets;

import com.google.gson.Gson;
import database.Database;
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

@WebServlet(name = "AuthenticateUser")
public class AuthenticateUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection con = Database.getConnection(request, response);

        HashMap<String, String> jsonData = new HashMap<String, String>();

        try {
            if(authenticate(con, request, response)) {
                jsonData.put("status", "success");
                jsonData.put("message", "Login Success!");

            } else {
                jsonData.put("status", "fail");
                jsonData.put("message", "Invalid Login Credentials!");

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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    private boolean authenticate(Connection con, HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String sql = "SELECT * FROM users WHERE (email=? AND password=?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, request.getParameter("email"));
        ps.setString(2, request.getParameter("password"));

        ResultSet result = ps.executeQuery();

        if (result.next()) {
            User user = new User(result.getString("id"), result.getString("full_name"), result.getString("gender"), result.getString("state"), result.getString("city"), result.getString("street"), result.getString("zip_code"), result.getString("birth_year"), result.getString("email"), result.getString("password"));
            request.getSession().setAttribute("loggedInUser", user);

            return true;

        } else {
            return false;

        }
    }
}
