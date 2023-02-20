package dbConn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConnectionMaker implements ConnectionMaker {

    private final String ADDRESS = "";
    private final String USERNAME = "";
    private final String PASSWORD = "";
    @Override
    public Connection makeConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(ADDRESS, USERNAME, PASSWORD);
            return connection;
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
