package com.Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.Model.Electric;
import com.Model.User;
import com.dbUtil.ElectricDAO;
import com.dbUtil.UserDAO;

import dbUtil.DBConnect;

@Controller
@RequestMapping("/admin")
public class AdminNavigation {
	UserDAO ud = new UserDAO();
	ElectricDAO ed = new ElectricDAO();
	
	
	@RequestMapping("/home")
	protected ModelAndView getAdminHome() {
		ModelAndView model = new ModelAndView("admin_homepage");
		return model;
	}
	
	@RequestMapping("/competition")
	protected ModelAndView getAdminCompetition(HttpSession session) throws SQLException {
//		Connection conn = DBConnect.openConnection();
//		String sql = "SELECT * FROM electricity";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		
//		ResultSet rs = stmt.executeQuery();
//		ArrayList<Electric> electric = new ArrayList<Electric>();
//		
//		while(rs.next()) {
//			
//			Electric e = new Electric();
//			e.setUsername(rs.getString("username"));
//			e.setMonth(rs.getString("month"));
//			e.setCarbon_footprint(rs.getDouble("carbon_footprint"));
//			e.setProof(rs.getString("proof"));
//			e.setId(rs.getInt("id"));
//			e.setComsumption_data(rs.getDouble("consumption_data"));
//			e.setStatus(rs.getInt("status"));
//			e.setCategory(rs.getString("category"));
//			
//			electric.add(e);
//		}
		
//		Connection conn = DBConnect.openConnection();
//		String sql = "SELECT username FROM electricity GROUP BY username";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		
//		ResultSet rs = stmt.executeQuery();
		
		ResultSet rs = ed.getGroupedUsername();
		ArrayList<Electric> electric = new ArrayList<Electric>();
		
		while(rs.next()) {
			
			Electric e = new Electric();
			e.setUsername(rs.getString("username"));
			
			electric.add(e);
		}
		
		session.setAttribute("electric", electric);
		
		ModelAndView model = new ModelAndView("admin_competition");
		return model;
	}
	
	@RequestMapping("/participant_detail")
	protected ModelAndView getParticipant(HttpServletRequest request, HttpSession session) throws SQLException {
	
//		Connection conn = DBConnect.openConnection();
//		String sql = "SELECT * FROM user WHERE username = ?";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		
//		stmt.setString(1, request.getParameter("username"));
//		
//		ResultSet rs = stmt.executeQuery();
		
		ResultSet rs = ud.getByUsername(request.getParameter("username"));
		
		rs.next();
		
		User u = new User();
		u.setName(rs.getString("name"));
		u.setIc(rs.getString("ic"));
		u.setEmail(rs.getString("email"));
		u.setPhone(rs.getString("phone"));
		u.setAddress(rs.getString("address"));
		u.setUsername(rs.getString("username"));
		
		session.setAttribute("user", u);
		
		ModelAndView model = new ModelAndView("admin_participant");
		return model;
	}
}
