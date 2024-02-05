package com.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.Model.User;
import com.dbUtil.UserDAO;

import dbUtil.DBConnect;

@Controller
@RequestMapping("/")
public class UserController {
	UserDAO ud = new UserDAO();
	
	@RequestMapping("")
	protected ModelAndView getIntro(){
		ModelAndView model = new ModelAndView("intro");
		return model;
	}
	
	protected Boolean validateAccount(User u, HttpServletRequest request) throws SQLException {

		ResultSet rs = ud.getAll();
		
		while(rs.next()) {
			if(rs.getString("username").equals(u.getUsername())) {
				request.setAttribute("unameExist", "Username Exist");
			}
			if(rs.getString("ic").equals(u.getIc())) {
				request.setAttribute("icExist", "IC Exist");
			}
			if(rs.getString("email").equals(u.getEmail())) {
				request.setAttribute("emailExist", "Email Exist");
			}
			if(rs.getString("phone").equals(u.getPhone())) {
				request.setAttribute("phoneExist", "Phone Exist");
			}
			if(rs.getString("address").equals(u.getAddress())) {
				request.setAttribute("addressExist", "Address Exist");
			}	
		}
		
		if(request.getAttribute("addressExist") == null && request.getAttribute("phoneExist") == null && request.getAttribute("email") == null && request.getAttribute("icExist") == null && request.getAttribute("unameExist") == null) {
			return true;
		}
		
		return false;
	}
	
	protected Boolean formatUsername(User u, HttpServletRequest request) {
		String format_username = "^[a-zA-Z0-9]+$";
		if (!u.getUsername().matches(format_username)) {
	        request.setAttribute("uname_format", "Invalid Username (no space allowed)");
	        return false;
		}
		return true;
	}
	
	protected Boolean formatNumber(User u, HttpServletRequest request) {
		String format_number = "[0-9]*";
		if (!u.getPhone().matches(format_number)) {
	        request.setAttribute("phone_format", "Invalid Phone Number (Numbers only)");
	        return false;
		}
		return true;
	}
	
	protected Boolean formatIc(User u, HttpServletRequest request) {
		String format_number = "[0-9]*";
		if (!u.getIc().matches(format_number)) {
	        request.setAttribute("ic_format", "Invalid Phone Number (Numbers only)");
	        return false;
		}
		return true;
	}   
		
	protected Boolean formatEmail(User u, HttpServletRequest request) {
		String format_email ="^(.+)@(.+)$";
		if (!u.getEmail().matches(format_email)) {
	        request.setAttribute("email_format", "Invalid Email Format");
	        return false;
	    }
		return true;
	}   
		
	protected Boolean formatName(User u, HttpServletRequest request) {
		String format_name = "^[a-zA-Z]+$";
		if (!u.getName().matches(format_name)) {
	        request.setAttribute("name_format", "Invalid Name Format");
	        return false;
	    }
		return true;
	}  
	
	@PostMapping("/registerAccount")
	protected String registerAccount(HttpServletRequest request) throws SQLException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String ic = request.getParameter("ic");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");	
		
		if(username.equals("") || password.equals("") || name.equals("") || ic.equals("") || email.equals("") || phone.equals("") || address.equals("")) {
			request.setAttribute("nullInput", "Please Fill In All Blank Field");
			return "register";
		}
		
		User u = new User();
		
		u.setUsername(username);
		u.setIc(ic);
		u.setEmail(email);
		u.setPhone(phone);
		u.setAddress(address);
		
		Boolean valid = validateAccount(u, request);
		
		if(valid == false) {
			return "/register";
		}
		
		u.setName(name);
		u.setPassword(password);
		
		Boolean userFormat = formatUsername(u, request);
		Boolean nameFormat = formatName(u, request);
		Boolean icFormat = formatIc(u, request);
		Boolean emailFormat = formatEmail(u, request);
		Boolean phoneFormat = formatName(u, request);
		
		if(userFormat == false || nameFormat == false || icFormat == false || emailFormat == false || phoneFormat == false) {
			return "/register";
		}
		
		try {
		Connection conn = DBConnect.openConnection();
		
//		String sql = "SELECT * FROM user WHERE username = ?";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		
//		stmt.setString(1, username);
//		ResultSet rs = stmt.executeQuery();
		
//		if(rs.getString("username").equals(username) || rs.getString("ic").equals(ic) || rs.getString("email").equals(email) || rs.getString("phone").equals(phone)) {
//			return "Account Exist";
//		}
		
//		String sql = "INSERT INTO user (username, password, name, ic, email, phone, address) VALUES (?,?,?,?,?,?,?)";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		
//		stmt.setString(1, username);
//		stmt.setString(2, password);
//		stmt.setString(3, name);
//		stmt.setString(4, ic);
//		stmt.setString(5, email);
//		stmt.setString(6, phone);
//		stmt.setString(7, address);
//		
//		stmt.executeUpdate();
		
		ud.insertUser(u);
		
		System.out.println("test");
		}
		catch(SQLException e) {
			e.printStackTrace();
			request.setAttribute("message", "Account Exist");
			return "register";
		}
		catch(Exception e) {
			e.printStackTrace();
		}

		return "redirect:/login";
	}
	
	@RequestMapping("/login")
	protected ModelAndView getLogin(HttpServletRequest request, HttpSession session) {
			session.invalidate();
		
			ModelAndView model = new ModelAndView("Login");
			return model;
	}
	
	@PostMapping("/login_fail")
	protected String validateLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try {
//		Connection conn = DBConnect.openConnection();
//		String sql = "SELECT * FROM user WHERE username = ?";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		
//		stmt.setString(1, username);
//		
//		ResultSet rs = stmt.executeQuery();
			
		ResultSet rs = ud.getByUsername(username);
			
		if(rs.next()) {
		System.out.println(rs.getString("name"));
		
		if(rs.getString("password").equals(password)) {
		
		User u = new User();
		u.setUsername(rs.getString("username"));
		u.setName(rs.getString("name"));
		u.setIc(rs.getString("ic"));
		u.setEmail(rs.getString("email"));
		u.setPhone(rs.getString("phone"));
		u.setAddress(rs.getString("address"));

		HttpSession session = request.getSession();
		session.setAttribute("user", u);
		if(!rs.getString("id").equals("0"))
		return "redirect:/adaptation";
		else if(rs.getString("id").equals("0")) {
			return "redirect:/admin/home";
			}
		}
		}
		else {
			System.out.println("Setting loginCheck attribute");
			request.setAttribute("loginCheck", "test");
			return "Login";
		}
		}
		catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Setting loginCheck attribute");
			request.setAttribute("loginCheck", "test");
			return "Login";
		}
		System.out.println("Setting loginCheck attribute");
		request.setAttribute("loginCheck", "test");
		return "Login";
	}
	
	@RequestMapping("/register")
	protected ModelAndView getRegister() {
		ModelAndView  model = new ModelAndView("register");
		return model;
	}
	
	@RequestMapping("/profile")
	protected ModelAndView getProfile() {
		ModelAndView model = new ModelAndView("/profile");
		return model;
	}
	
	@RequestMapping("/carbon")
	protected ModelAndView getCarbon() {
		ModelAndView model = new ModelAndView("/carbon");
		return model;
	}
	
	@RequestMapping("/adaptation")
	protected ModelAndView getAdaptation() {
		ModelAndView model = new ModelAndView("/adaptation");
		return model;
	}
	
	@RequestMapping("/join1")
	protected ModelAndView getJoin1() {
		ModelAndView model = new ModelAndView("/join_1");
		return model;
	}
	
	@RequestMapping("/join2")
	protected ModelAndView getJoin2() {
		ModelAndView model = new ModelAndView("/join_2");
		return model;
	}
	
	@RequestMapping("/join3")
	protected ModelAndView getJoin3() {
		ModelAndView model = new ModelAndView("/join_3");
		return model;
	}
	
	protected Boolean validateUsername(User u, HttpServletRequest request) throws SQLException {
		Connection conn = DBConnect.openConnection();
		String sql = "SELECT * FROM user WHERE NOT name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, u.getName());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			if(u.getUsername().equals(rs.getString("username"))) {
				request.setAttribute("username_exist", "Username Exist");
				return false;
			};
		}
		String formatter = "^[a-zA-Z0-9]+$";
		if (!u.getUsername().matches(formatter)) {
	        request.setAttribute("username_exist", "Invalid Username (no space allowed)");
	        return false;
	    }
		return true;
	}
	
	protected Boolean validatePhone(User u, HttpServletRequest request) throws SQLException {
		Connection conn = DBConnect.openConnection();
		String sql = "SELECT * FROM user WHERE NOT name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, u.getName());
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			if(u.getPhone().equals(rs.getString("phone"))) {
				request.setAttribute("phone_exist", "Phone Exist");
				return false;
			};
		}
		if (!u.getPhone().matches("[0-9]*")) {
	        request.setAttribute("phone_exist", "Invalid Phone Number (Numbers only)");
	        return false;
	    }
		return true;
	}
	
	protected Boolean validateEmail(User u, HttpServletRequest request) throws SQLException {
//		Connection conn = DBConnect.openConnection();
//		String sql = "SELECT * FROM user WHERE NOT name = ?";
//		PreparedStatement stmt = conn.prepareStatement(sql);
//		stmt.setString(1, u.getName());
//		
//		ResultSet rs = stmt.executeQuery();
		
		ResultSet rs = ud.getByNotName(u.getName());
		
		while(rs.next()) {
			if(u.getEmail().equals(rs.getString("email"))) {
				request.setAttribute("email_exist", "Email Exist");
				return false;
			};
		}
		String formatter = "^(.+)@(.+)$";
		
		if (!u.getEmail().matches(formatter)) {
	        request.setAttribute("email_exist", "Invalid Email Format");
	        return false;
	    }
		return true;
	}
	
	@RequestMapping("/profile_update")
	protected ModelAndView updateProfile(@ModelAttribute ("user") User user, HttpServletRequest request) {
		try {
			
			Boolean usernameValid = validateUsername(user, request);
			Boolean phoneValid = validatePhone(user, request);
			Boolean emailValid = validateEmail(user, request);

			if(usernameValid == false || phoneValid == false || emailValid == false) {
				ModelAndView model = new ModelAndView("/profile");
				return model;
			}
			
//			Connection conn = DBConnect.openConnection();
//			String sql = "SELECT * FROM user WHERE name = ?";
//			PreparedStatement stmt = conn.prepareStatement(sql);
//			stmt.setString(1, user.getName());
//			
//			ResultSet rs = stmt.executeQuery();
			
			ResultSet rs = ud.getByName(user.getName());
			
			if(rs.next()) {
				if(!user.getUsername().equals(rs.getString("username"))){
//					sql = "UPDATE user SET username = ? where name = ?";
//					stmt = conn.prepareStatement(sql);
//					stmt.setString(1, user.getUsername());
//					stmt.setString(2, user.getName());
//					stmt.executeUpdate();
					ud.updateUser("username", user.getUsername(), user.getName());
					System.out.println("username changed");
					}
				if(!user.getEmail().equals(rs.getString("email"))){
//					sql = "UPDATE user SET email = ? where name = ?";
//					stmt = conn.prepareStatement(sql);
//					stmt.setString(1, user.getEmail());
//					stmt.setString(2, user.getName());
//					stmt.executeUpdate();
					
					ud.updateUser("email", user.getEmail(), user.getName());
					System.out.println("Email changed");
					}
				if(!user.getPhone().equals(rs.getString("phone"))){
//					sql = "UPDATE user SET phone = ? where name = ?";
//					stmt = conn.prepareStatement(sql);
//					stmt.setString(1, user.getPhone());
//					stmt.setString(2, user.getName());
//					stmt.executeUpdate();
					
					ud.updateUser("phone", user.getPhone(), user.getName());
					System.out.println("Phone changed");
					}
				}
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		ModelAndView model = new ModelAndView("/profile");
		request.setAttribute("changesSaved", "true");
		return model;
	}
}
	
