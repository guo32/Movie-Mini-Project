package controller;

import dbConn.ConnectionMaker;
import model.CinemaDTO;
import model.TheaterDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

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
        String query = "UPDATE `cinema` SET `name` = ?, `country` = ?, `autonomous_district` = ?, `detailed_address` = ?, `phone` = ?, `image` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, cinemaDTO.getName());
            pstmt.setString(2, cinemaDTO.getCountry());
            pstmt.setString(3, cinemaDTO.getAutonomous_district());
            pstmt.setString(4, cinemaDTO.getDetailed_address());
            pstmt.setString(5, cinemaDTO.getPhone());
            pstmt.setString(6, cinemaDTO.getImage());
            pstmt.setInt(7, cinemaDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `cinema` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
        /* 범위에서 벗어나는 페이지 처리 */
        if (pageNo > countTotalPage()) {
            pageNo = countTotalPage();
        } else if (pageNo < 1) {
            pageNo = 1;
        }

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

    public ArrayList<CinemaDTO> selectAll() {
        ArrayList<CinemaDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `cinema` ORDER BY `autonomous_district`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                CinemaDTO cinemaDTO = new CinemaDTO();
                cinemaDTO.setId(resultSet.getInt("id"));
                cinemaDTO.setName(resultSet.getString("name"));
                cinemaDTO.setCountry(resultSet.getString("country"));
                cinemaDTO.setAutonomous_district(resultSet.getString("autonomous_district"));
                cinemaDTO.setDetailed_address(resultSet.getString("detailed_address"));

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

    public int selectTheNewest() {
        int result = -1;
        String query = "SELECT `id` FROM `cinema` ORDER BY `id` DESC LIMIT 1";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                result =  resultSet.getInt("id");
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public ArrayList<String> selectCountry() {
        ArrayList<String> list = new ArrayList<>();
        String query = "SELECT DISTINCT `country` FROM `cinema`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                list.add(resultSet.getString("country"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public HashMap<String, Integer> selectAutonomousDistrictByCountry(String country) {
        HashMap<String, Integer> map = new HashMap<>();
        String query = "SELECT `autonomous_district`, COUNT(`autonomous_district`) AS CNT FROM `cinema` WHERE `country` = ? GROUP BY `autonomous_district`";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, country);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                map.put(resultSet.getString("autonomous_district"), resultSet.getInt("CNT"));
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return map;
    }

    public ArrayList<CinemaDTO> selectCinemaByCountryAndAutonomousDistrict(String country, String autonomousDistrict) {
        ArrayList<CinemaDTO> list = new ArrayList<>();
        String query = "SELECT `id`, `name` FROM `cinema` WHERE `country` = ? AND `autonomous_district` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, country);
            pstmt.setString(2, autonomousDistrict);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                CinemaDTO cinemaDTO = new CinemaDTO();
                cinemaDTO.setId(resultSet.getInt("id"));
                cinemaDTO.setName(resultSet.getString("name"));

                list.add(cinemaDTO);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public ArrayList<CinemaDTO> selectByCountry(String country) {
        ArrayList<CinemaDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `cinema` WHERE `country` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, country);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                CinemaDTO cinemaDTO = new CinemaDTO();
                cinemaDTO.setId(resultSet.getInt("id"));
                cinemaDTO.setName(resultSet.getString("name"));
                cinemaDTO.setCountry(resultSet.getString("country"));

                list.add(cinemaDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public ArrayList<CinemaDTO> searchCinema(String text) {
        ArrayList<CinemaDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `cinema` WHERE `name` LIKE ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, "%" + text + "%");

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                CinemaDTO cinemaDTO = new CinemaDTO();
                cinemaDTO.setId(resultSet.getInt("id"));
                cinemaDTO.setName(resultSet.getString("name"));
                cinemaDTO.setCountry(resultSet.getString("country"));
                cinemaDTO.setAutonomous_district(resultSet.getString("autonomous_district"));
                cinemaDTO.setDetailed_address(resultSet.getString("detailed_address"));
                cinemaDTO.setPhone(resultSet.getString("phone"));

                list.add(cinemaDTO);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}
