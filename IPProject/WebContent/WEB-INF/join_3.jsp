<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
    	<%@include file="/assets/css/join_1.css"%>
    </style>

  <title>Adaptation</title>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.profile.menu').click(function () {
                $('.sub-menu').toggle();
                $('#down_arrow').toggleClass('rotate-0 rotate-270');
            });
        });
    </script>

		<% session.setAttribute("houseType", request.getParameter("houseType")); %>

        <div class="sidebar">
        <div class="side_content">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo_baru_web.gif" width="85px" height="85px">
                <div class="company">
                    <h1>IPRK</h1>
                    <h3>Iskandar Puteri Rendah Karbon</h3>
                </div>
            </div>
            <a href="<c:url value='/profile' />" style="text-decoration: none;">
            <div class="profile">   	
                <i class="fa-solid fa-user"></i>
                <p>Profile</p>
            </div>
            </a>
            <div class="profile menu" id="is_select"><a class="sub-btn"></a>
                <i class="fa-solid fa-gauge"></i>
                <p>Dashboard</p>
                <i class="fa-solid fa-angle-down" id="down_arrow" style="rotate: 270deg;"></i>
            </div>
            <div class="sub-menu" style="display: none;">
            	<a href="<c:url value='/carbon' />">Carbon Analysis</a>
                <a href="<c:url value='/adaptation' />">Adaptation</a>
                <a href="<c:url value='/join1' />">Join Us</a>
            </div>
            <div class="signout">
                <a href="<c:url value='/login' />"><input type="button" value="Sign Out"></a>
            </div>
        </div>
    </div>
    <div class="title">
        DASHBOARD
        <div class="account">
            <p>${user.name}</p>
            <p id="type">User</p>
        </div>
    </div>
    <div class="container">
            <h3>Join Us</h3>
            <img src="${pageContext.request.contextPath}/assets/images/pertandigan.jpg">
            <h3>Count Me In!</h3>
            <h3>Step 3: Upload Documents</h3>
            <div class="house-container">
                <div class="house bill">
                    <i class="fa-solid fa-droplet"></i>
                    <label for="bill" >Submit Water Bill</p>
                    <a href="<c:url value='/' />"><input type="button" id="bill" style="display: none;"></a>
                </div>
                <div class="house bill">
                    <i class="fa-solid fa-bolt"></i>
                    <label for="bill" >Submit Electricity Bill</p>
                    <a href="<c:url value='/' />"><input type="button" id="bill" style="display: none;"></a>
                </div>
                <div class="house bill">
                    <i class="fa-solid fa-recycle"></i>
                    <label for="bill" >Submit Oil Consumption</p>
                    <a href="<c:url value='/' />"><input type="button" id="bill" style="display: none;"></a>
                </div>
            </div>
			<div class="proceed">
            	<a href="">Complete <i class="fa-solid fa-check"></i></a>
            </div>
        </div>
</body>
</html>