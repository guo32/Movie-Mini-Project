package servlet.user;

import com.google.gson.JsonObject;
import controller.UserController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UserAuthServlet", value = "/user/auth")
public class UserAuthServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ConnectionMaker connectionMaker = new MySqlConnectionMaker();
        UserController userController = new UserController(connectionMaker);

        JsonObject result = new JsonObject();
        try {
            String username = request.getParameter("username");
            String password = userController.encrypt(request.getParameter("password"));

            UserDTO userDTO = userController.auth(username, password);

            if (userDTO != null) {
                HttpSession session = request.getSession();
                session.setAttribute("login", userDTO);
                result.addProperty("status", "success");
            } else {
                throw new NullPointerException();
            }
        } catch (Exception e) {
            result.addProperty("status", "fail");
        } finally {
            System.out.println(result);
            PrintWriter writer = response.getWriter();
            writer.print(result);
        }
    }
}
