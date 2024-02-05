package com.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dbUtil.DBConnect;

public class ElectricDAO {
	Connection conn = DBConnect.openConnection();
	
	public ResultSet getGroupedUsername() throws SQLException {
		String sql = "SELECT username FROM electricity GROUP BY username";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		return rs;
	}
}
