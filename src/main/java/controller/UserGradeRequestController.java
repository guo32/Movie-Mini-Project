package controller;

import dbConn.ConnectionMaker;
import model.UserGradeRequestDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserGradeRequestController {
    private Connection connection;

    public UserGradeRequestController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public boolean insert(UserGradeRequestDTO userGradeRequestDTO) {
        String query = "INSERT INTO `userGradeRequest`(`user_id`, `request_grade`) VALUES(?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, userGradeRequestDTO.getUser_id());
            pstmt.setInt(2, userGradeRequestDTO.getRequest_grade());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }

        return true;
    }

    public void update(UserGradeRequestDTO userGradeRequestDTO) {
        String query = "UPDATE `userGradeRequest` SET `status` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, userGradeRequestDTO.getStatus());
            pstmt.setInt(2, userGradeRequestDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `userGradeRequest` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<UserGradeRequestDTO> selectByUserId(int user_id) {
        ArrayList<UserGradeRequestDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `userGradeRequest` WHERE `user_id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, user_id);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                UserGradeRequestDTO userGradeRequestDTO = new UserGradeRequestDTO();
                userGradeRequestDTO.setId(resultSet.getInt("id"));
                userGradeRequestDTO.setUser_id(resultSet.getInt("user_id"));
                userGradeRequestDTO.setRequest_grade(resultSet.getInt("request_grade"));
                userGradeRequestDTO.setRequest_date(resultSet.getTimestamp("request_date"));
                userGradeRequestDTO.setStatus(resultSet.getString("status"));

                list.add(userGradeRequestDTO);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public UserGradeRequestDTO selectById(int id) {
        UserGradeRequestDTO userGradeRequestDTO = null;
        String query = "SELECT * FROM `userGradeRequest` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                userGradeRequestDTO = new UserGradeRequestDTO();
                userGradeRequestDTO.setId(resultSet.getInt("id"));
                userGradeRequestDTO.setUser_id(resultSet.getInt("user_id"));
                userGradeRequestDTO.setRequest_grade(resultSet.getInt("request_grade"));
                userGradeRequestDTO.setRequest_date(resultSet.getTimestamp("request_date"));
                userGradeRequestDTO.setStatus(resultSet.getString("status"));
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userGradeRequestDTO;
    }

    public ArrayList<UserGradeRequestDTO> selectByStatus(String status) {
        ArrayList<UserGradeRequestDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `userGradeRequest` WHERE `status` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, status);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                UserGradeRequestDTO userGradeRequestDTO = new UserGradeRequestDTO();
                userGradeRequestDTO.setId(resultSet.getInt("id"));
                userGradeRequestDTO.setUser_id(resultSet.getInt("user_id"));
                userGradeRequestDTO.setRequest_grade(resultSet.getInt("request_grade"));
                userGradeRequestDTO.setRequest_date(resultSet.getTimestamp("request_date"));
                userGradeRequestDTO.setStatus(resultSet.getString("status"));

                list.add(userGradeRequestDTO);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
