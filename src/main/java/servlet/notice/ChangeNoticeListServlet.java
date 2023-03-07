package servlet.notice;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import controller.NoticeCategoryController;
import controller.NoticeController;
import controller.UserController;
import dbConn.ConnectionMaker;
import dbConn.MySqlConnectionMaker;
import model.NoticeDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet(name = "ChangeNoticeListServlet", value = "/notice/changeListByCategory")
public class ChangeNoticeListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        JsonObject object = new JsonObject();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ConnectionMaker connectionMaker = new MySqlConnectionMaker();
            NoticeController noticeController = new NoticeController(connectionMaker);
            UserController userController = new UserController(connectionMaker);
            NoticeCategoryController noticeCategoryController = new NoticeCategoryController(connectionMaker);

            ArrayList<NoticeDTO> list = noticeController.selectByCategoryId(id);
            SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");

            JsonArray array = new JsonArray();
            for (NoticeDTO n : list) {
                JsonObject temp = new JsonObject();
                temp.addProperty("id", n.getId());
                temp.addProperty("writer", userController.selectById(n.getWriter_id()).getNickname());
                temp.addProperty("category", noticeCategoryController.selectNameById(n.getCategory_id()));
                temp.addProperty("title", n.getTitle());
                temp.addProperty("entry_date", sdf.format(n.getEntry_date()));

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
