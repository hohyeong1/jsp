package kr.ac.kopo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConnection {
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // DB URL
    private static final String USER = "hr"; // DB 사용자 이름
    private static final String PASSWORD = "hr"; // DB 비밀번호
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Oracle JDBC Driver not found.", e);
        }
    }
    
}