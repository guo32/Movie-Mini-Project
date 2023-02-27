package servlet.film;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import controller.FilmController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.FilmDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "FilmSearchServlet", value = "/film/search")
public class FilmSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        JsonObject object = new JsonObject();
        try {
            String text = request.getParameter("text");

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            FilmController filmController = new FilmController(connectionMaker);
            ArrayList<FilmDTO> list = filmController.searchFilmTitle(text);

            JsonArray array = new JsonArray();
            for (FilmDTO f : list) {
                JsonObject temp = new JsonObject();
                temp.addProperty("id", f.getId());
                temp.addProperty("title", f.getTitle());
                temp.addProperty("description", f.getDescription());
                temp.addProperty("director", f.getDirector());
                temp.addProperty("rating", f.getRating());
                temp.addProperty("poster", f.getPoster());

                array.add(temp);
            }

            object.addProperty("status", "success");
            object.addProperty("list", array.toString());
        } catch (Exception e) {
            object.addProperty("status", "fail");
        }

        PrintWriter writer = response.getWriter();
        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
