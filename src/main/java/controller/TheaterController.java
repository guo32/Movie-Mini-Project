package controller;

import dbConn.ConnectionMaker;
import model.TheaterDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TheaterController {
    private Connection connection;

    public TheaterController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public TheaterDTO selectById(int id) {
        TheaterDTO theaterDTO = null;
        String query = "SELECT * FROM `theater` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                theaterDTO = new TheaterDTO();
                theaterDTO.setId(resultSet.getInt("id"));
                theaterDTO.setCinema_id(resultSet.getInt("cinema_id"));
                theaterDTO.setName(resultSet.getString("name"));
                theaterDTO.setCapacity(resultSet.getInt("capacity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return theaterDTO;
    }

    public ArrayList<TheaterDTO> selectByCinemaId(int cinema_id) {
        ArrayList<TheaterDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `theater` WHERE `cinema_id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, cinema_id);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                TheaterDTO theaterDTO = new TheaterDTO();
                theaterDTO.setId(resultSet.getInt("id"));
                theaterDTO.setCinema_id(resultSet.getInt("cinema_id"));
                theaterDTO.setName(resultSet.getString("name"));
                theaterDTO.setCapacity(resultSet.getInt("capacity"));

                list.add(theaterDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
