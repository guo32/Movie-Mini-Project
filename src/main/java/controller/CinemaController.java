package controller;

import dbConn.ConnectionMaker;
import model.CinemaDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CinemaController {
    private Connection connection;
    private final int PAGE_SIZE = 6;

    public CinemaController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public boolean insert(CinemaDTO cinemaDTO) {
        String query = "INSERT INTO `cinema`(`name`, `country`, `autonomous_district`, `detailed_address`, `phone`, `image`) VALUES(?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, cinemaDTO.getName());
            pstmt.setString(2, cinemaDTO.getCountry());
            pstmt.setString(3, cinemaDTO.getAutonomous_district());
            pstmt.setString(4, cinemaDTO.getDetailed_address());
            pstmt.setString(5, cinemaDTO.getPhone());
            pstmt.setString(6, cinemaDTO.getImage());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public void update(CinemaDTO cinemaDTO) {

    }

    public void delete(int id) {

    }

    public CinemaDTO selectById(int id) {
        CinemaDTO cinemaDTO = null;
        String query = "SELECT * FROM `cinema` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                cinemaDTO = new CinemaDTO();
                cinemaDTO.setId(resultSet.getInt("id"));
                cinemaDTO.setName(resultSet.getString("name"));
                cinemaDTO.setCountry(resultSet.getString("country"));
                cinemaDTO.setAutonomous_district(resultSet.getString("autonomous_district"));
                cinemaDTO.setDetailed_address(resultSet.getString("detailed_address"));
                cinemaDTO.setPhone(resultSet.getString("phone"));
                cinemaDTO.setImage(resultSet.getString("image"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cinemaDTO;
    }

    public ArrayList<CinemaDTO> selectAll(int pageNo) {
        ArrayList<CinemaDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `cinema` ORDER BY `name` LIMIT ?, ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, (pageNo - 1) * PAGE_SIZE);
            pstmt.setInt(2, PAGE_SIZE);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                CinemaDTO cinemaDTO = new CinemaDTO();
                cinemaDTO.setId(resultSet.getInt("id"));
                cinemaDTO.setName(resultSet.getString("name"));
                cinemaDTO.setCountry(resultSet.getString("country"));
                cinemaDTO.setAutonomous_district(resultSet.getString("autonomous_district"));
                cinemaDTO.setDetailed_address(resultSet.getString("detailed_address"));
                cinemaDTO.setPhone(resultSet.getString("phone"));
                cinemaDTO.setImage(resultSet.getString("image"));

                list.add(cinemaDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countTotalPage() {
        int totalPage = 0;
        String query = "SELECT COUNT(*) FROM `cinema`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            int count = 0;
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }

            totalPage = count / PAGE_SIZE;
            if (count % PAGE_SIZE != 0) {
                totalPage++;
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalPage;
    }
}
