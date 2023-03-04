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
}
