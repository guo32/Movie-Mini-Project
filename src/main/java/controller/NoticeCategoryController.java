package controller;

import dbConn.ConnectionMaker;
import model.NoticeCategoryDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class NoticeCategoryController {
    private Connection connection;

    public NoticeCategoryController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public ArrayList<NoticeCategoryDTO> selectAll() {
        ArrayList<NoticeCategoryDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `notice_category`";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                NoticeCategoryDTO noticeCategoryDTO = new NoticeCategoryDTO();
                noticeCategoryDTO.setId(resultSet.getInt("id"));
                noticeCategoryDTO.setName(resultSet.getString("name"));

                list.add(noticeCategoryDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public String selectNameById(int id) {
        String name = null;
        String query = "SELECT `name` FROM `notice_category` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                name = resultSet.getString("name");
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return name;
    }
}
