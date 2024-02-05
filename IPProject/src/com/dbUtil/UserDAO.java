package com.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Model.*;

import dbUtil.DBConnect;

public class UserDAO {
	Connection conn = DBConnect.openConnection();
	
	public ResultSet getAll() throws SQLException {
		String sql = "SELECT * FROM user";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		return rs;
	}
	
	public void insertUser(User u) throws SQLException {
		String sql = "INSERT INTO user (username, password, name, ic, email, phone, address) VALUES (?,?,?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, u.getUsername());
		stmt.setString(2, u.getPassword());
		stmt.setString(3, u.getName());
		stmt.setString(4, u.getIc());
		stmt.setString(5, u.getEmail());
		stmt.setString(6, u.getPhone());
		stmt.setString(7, u.getAddress());
		
		stmt.executeUpdate();
	}
	
	public ResultSet getByUsername(String username) throws SQLException {
		String sql = "SELECT * FROM user WHERE username = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, username);
		
		ResultSet rs = stmt.executeQuery();
		return rs;
	}
	
	public ResultSet getByNotName(String name) throws SQLException {
		String sql = "SELECT * FROM user WHERE NOT name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, name);
		
		ResultSet rs = stmt.executeQuery();
		return rs;
	}
	
	public ResultSet getByName(String name) throws SQLException {
		String sql = "SELECT * FROM user WHERE name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, name);
		
		ResultSet rs = stmt.executeQuery();
		return rs;
	}
	
	public void updateUser(String column,String colValue, String name) throws SQLException {
		String sql = "UPDATE user SET ? = ? where name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, column);
		stmt.setString(2, colValue);
		stmt.setString(3, name);
		
		stmt.executeUpdate();
	}
}
