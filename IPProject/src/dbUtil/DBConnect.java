package dbUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
	public static Connection openConnection() {
		Connection conn = null;
		
		String dbURL = "jdbc:mysql://localhost:3306/ipproject";
		String username = "root";
		String password = "";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, username, password);
			System.out.println("connection successfully opened :" + conn.getMetaData());
		}
		catch (SQLException ex) {
			ex.printStackTrace();
		}
		catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		return conn;
	}
}
