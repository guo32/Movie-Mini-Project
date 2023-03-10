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

    public boolean insert(TheaterDTO theaterDTO) {
        String query = "INSERT INTO `theater`(`cinema_id`, `name`, `capacity`) VALUES(?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, theaterDTO.getCinema_id());
            pstmt.setString(2, theaterDTO.getName());
            pstmt.setInt(3, theaterDTO.getCapacity());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }

        return true;
    }

    public void update(TheaterDTO theaterDTO) {
        String query = "UPDATE `theater` SET `name` = ?, `capacity` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, theaterDTO.getName());
            pstmt.setInt(2, theaterDTO.getCapacity());
            pstmt.setInt(3, theaterDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `theater` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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

    public ArrayList<TheaterDTO> selectAll() {
        ArrayList<TheaterDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `theater` ORDER BY `name`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

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
