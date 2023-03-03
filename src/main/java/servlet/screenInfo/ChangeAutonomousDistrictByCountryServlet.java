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
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ChangeAutonomousDistrictByCountryServlet", value = "/screenInfo/changeAutonomousDistrictByCountry")
public class ChangeAutonomousDistrictByCountryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        JsonObject object = new JsonObject();
        try {
            String country = request.getParameter("country");
            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            CinemaController cinemaController = new CinemaController(connectionMaker);
            HashMap<String, Integer> autonomousDistrictMap = cinemaController.selectAutonomousDistrictByCountry(country);

            JsonArray array = new JsonArray();
            for (Map.Entry<String, Integer> e : autonomousDistrictMap.entrySet()) {
                JsonObject temp = new JsonObject();
                temp.addProperty("autonomousDistrict", e.getKey());
                temp.addProperty("count", e.getValue());
                array.add(temp);
            }
            System.out.println(array);
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
