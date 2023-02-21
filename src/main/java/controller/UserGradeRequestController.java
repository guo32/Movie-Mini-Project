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

    }

    public void delete(int id) {

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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
