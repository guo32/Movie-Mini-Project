package servlet.screenInfo;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import controller.CinemaController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.CinemaDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet(name = "ChangeCinemaByAutonomousDistrictServlet", value = "/screenInfo/changeCinemaByAutonomousDistrict")
public class ChangeCinemaByAutonomousDistrictServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        JsonObject object = new JsonObject();
        try {
            String country = request.getParameter("country");
            String autonomousDistrict = request.getParameter("autonomousDistrict");

            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            CinemaController cinemaController = new CinemaController(connectionMaker);
            ArrayList<CinemaDTO> list = cinemaController.selectCinemaByCountryAndAutonomousDistrict(country, autonomousDistrict);

            JsonArray array = new JsonArray();
            for (CinemaDTO c : list) {
                JsonObject temp = new JsonObject();
                temp.addProperty("cinemaId", c.getId());
                temp.addProperty("cinemaName", c.getName());

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
