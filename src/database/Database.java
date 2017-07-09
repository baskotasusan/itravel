package database;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

public class Database {

    public static Connection getConnection(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection con = (Connection) request.getServletContext().getAttribute("connection");

        if (con == null) {
            try {
                Class.forName(request.getServletContext().getInitParameter("dbDriver"));

            } catch (ClassNotFoundException e) {
                response.sendRedirect("error.jsp");

            }

            try {
                con = DriverManager.getConnection(request.getServletContext().getInitParameter("dbUrl"), request.getServletContext().getInitParameter("dbUser"), request.getServletContext().getInitParameter("dbPwd"));
                request.getServletContext().setAttribute("connection", con);

            } catch (Exception e) {
                response.sendRedirect("error.jsp");

            }

        }

        return con;
    }

}
