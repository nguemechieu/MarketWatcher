package org.tradeexperts.marketwhatcher;

import java.io.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "server", value = "/MarketWatcher-servlet")
public class MarketWatcherServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "MarketWatcher\nHello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        CUser cUser;
        Connection con = null;
        try {
            con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/marketwatcher", "nguemechieu", "0304");
        } catch (SQLException e) {
            e.printStackTrace();
        }

        Statement stmt= null;
        try {
            stmt = con.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        ResultSet rs= null;
        try {
            rs = stmt.executeQuery("select * from marketwatcher.marketwatcher");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        while(true) {
            try {
                if (!rs.next()) break;
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                System.out.println(rs.getInt(1)+"  "+rs.getString(2)+"  "+rs.getString(3));
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}