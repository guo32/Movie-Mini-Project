package servlet.screenInfo;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import controller.CinemaController;
import controller.FilmController;
import controller.ScreenInformationController;
import controller.TheaterController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.ScreenInformationDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet(name = "ScreenInfoListByCinemaServlet", value = "/screenInfo/printScreenInfoByCinemaId")
public class ScreenInfoListByCinemaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        JsonObject object = new JsonObject();
        try {
            int cinemaId = Integer.parseInt(request.getParameter("id"));
            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            ScreenInformationController screenInformationController = new ScreenInformationController(connectionMaker);
            CinemaController cinemaController = new CinemaController(connectionMaker);
            TheaterController theaterController = new TheaterController(connectionMaker);
            FilmController filmController = new FilmController(connectionMaker);
            ArrayList<ScreenInformationDTO> list = screenInformationController.selectByCinemaId(cinemaId);

            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
            JsonArray array = new JsonArray();
            for (ScreenInformationDTO s : list) {
                JsonObject temp = new JsonObject();
                temp.addProperty("id", s.getId());
                temp.addProperty("cinema", cinemaController.selectById(s.getCinema_id()).getName());
                temp.addProperty("theater", theaterController.selectById(s.getTheater_id()).getName());
                temp.addProperty("film", filmController.selectById(s.getFilm_id()).getTitle());
                String startTime = sdf.format(s.getStart_time());
                String endTime = sdf.format(s.getEnd_time());
                temp.addProperty("time", startTime + " - " + endTime);

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
