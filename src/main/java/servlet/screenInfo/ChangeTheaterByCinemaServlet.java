package servlet.screenInfo;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import controller.TheaterController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.TheaterDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "ChangeTheaterByCinemaServlet", value = "/screenInfo/changeTheaterByCinema")
public class ChangeTheaterByCinemaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        JsonObject object = new JsonObject();
        try {
            int cinemaId = Integer.parseInt(request.getParameter("cinemaId"));

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            TheaterController theaterController = new TheaterController(connectionMaker);
            ArrayList<TheaterDTO> list = theaterController.selectByCinemaId(cinemaId);

            JsonArray array = new JsonArray();
            for (TheaterDTO t : list) {
                JsonObject temp = new JsonObject();
                temp.addProperty("theaterId", t.getId());
                temp.addProperty("theaterName", t.getName());
                temp.addProperty("capacity", t.getCapacity());

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
