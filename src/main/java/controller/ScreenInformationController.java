package controller;

import dbConn.ConnectionMaker;
import model.ScreenInformationDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class ScreenInformationController {
    private Connection connection;

    public ScreenInformationController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public boolean insert(ScreenInformationDTO screenInformationDTO) {
        String query = "INSERT INTO `movie`.`screenInformation` (`cinema_id`, `theater_id`, `film_id`, `start_time`, `end_time`) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, screenInformationDTO.getCinema_id());
            pstmt.setInt(2, screenInformationDTO.getTheater_id());
            pstmt.setInt(3, screenInformationDTO.getFilm_id());
            pstmt.setTimestamp(4, screenInformationDTO.getStart_time());
            pstmt.setTimestamp(5, screenInformationDTO.getEnd_time());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }

        return true;
    }

    public void update(ScreenInformationDTO screenInformationDTO) {

    }

    public void delete(int id) {

    }

    public ArrayList<ScreenInformationDTO> selectByCinemaId(int cinema_id) {
        ArrayList<ScreenInformationDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `screenInformation` WHERE `cinema_id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, cinema_id);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                ScreenInformationDTO screenInformationDTO = new ScreenInformationDTO();
                screenInformationDTO.setId(resultSet.getInt("id"));
                screenInformationDTO.setCinema_id(resultSet.getInt("cinema_id"));
                screenInformationDTO.setTheater_id(resultSet.getInt("theater_id"));
                screenInformationDTO.setFilm_id(resultSet.getInt("film_id"));
                screenInformationDTO.setStart_time(resultSet.getTimestamp("start_time"));
                screenInformationDTO.setEnd_time(resultSet.getTimestamp("end_time"));

                list.add(screenInformationDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public ArrayList<ScreenInformationDTO> selectAll() {
        ArrayList<ScreenInformationDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `screenInformation`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                ScreenInformationDTO screenInformationDTO = new ScreenInformationDTO();
                screenInformationDTO.setId(resultSet.getInt("id"));
                screenInformationDTO.setCinema_id(resultSet.getInt("cinema_id"));
                screenInformationDTO.setTheater_id(resultSet.getInt("theater_id"));
                screenInformationDTO.setFilm_id(resultSet.getInt("film_id"));
                screenInformationDTO.setStart_time(resultSet.getTimestamp("start_time"));
                screenInformationDTO.setEnd_time(resultSet.getTimestamp("end_time"));

                list.add(screenInformationDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
