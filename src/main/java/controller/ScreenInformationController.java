package controller;

import dbConn.ConnectionMaker;
import model.ScreenInformationDTO;

import java.sql.*;
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
        String query = "UPDATE `screenInformation` SET `start_time` = ?, `end_time` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setTimestamp(1, screenInformationDTO.getStart_time());
            pstmt.setTimestamp(2, screenInformationDTO.getEnd_time());
            pstmt.setInt(3, screenInformationDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `screenInformation` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ScreenInformationDTO selectById(int id) {
        ScreenInformationDTO screenInformationDTO = null;
        String query = "SELECT * FROM `screenInformation` WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                screenInformationDTO = new ScreenInformationDTO();
                screenInformationDTO.setId(resultSet.getInt("id"));
                screenInformationDTO.setCinema_id(resultSet.getInt("cinema_id"));
                screenInformationDTO.setTheater_id(resultSet.getInt("theater_id"));
                screenInformationDTO.setFilm_id(resultSet.getInt("film_id"));
                screenInformationDTO.setStart_time(resultSet.getTimestamp("start_time"));
                screenInformationDTO.setEnd_time(resultSet.getTimestamp("end_time"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return screenInformationDTO;
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
        String query = "SELECT * FROM `screenInformation` WHERE `start_time` >= now() ORDER BY `start_time` DESC";

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

    public ArrayList<ScreenInformationDTO> selectByCinemaAndDate(int cinema_id, String date) {
        ArrayList<ScreenInformationDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `screenInformation` WHERE `cinema_id` = ? AND YEAR(`start_time`) = ? AND MONTH(`start_time`) = ? AND DAY(`start_time`) = ? ORDER BY `cinema_id`";
        String[] dateArray = date.split("-");

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, cinema_id);
            pstmt.setInt(2, Integer.parseInt(dateArray[0]));
            pstmt.setInt(3, Integer.parseInt(dateArray[1]));
            pstmt.setInt(4, Integer.parseInt(dateArray[2]));

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
