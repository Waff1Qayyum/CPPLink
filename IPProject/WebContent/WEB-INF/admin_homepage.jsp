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
    <%@include file="/assets/css/admin_sidebar.css"%>
    	<%@include file="/assets/css/admin_home.css"%>
    </style>

  <title>Home</title>
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
                <p>Competition</p>
                <i class="fa-solid fa-angle-down" id="down_arrow" style="rotate: 270deg;"></i>
            </div>
            <div class="sub-menu" style="display: none;">
            	<a href="<c:url value='/admin/home' />">Current Competition Winner</a>
            	<a href="<c:url value='/admin/competition' />">Pertandingan Kalendar IPRK 2022</a>
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
            <p id="type">Staff</p>
        </div>
    </div>
    <div class="container">
    	<div class="content">
    		<img src="${pageContext.request.contextPath}/assets/images/pertandigan.jpg">
    		<h3>Competition Winner</h3>
    		<div class="category">
    			<h3>Category A1:</h3>
    			<input type="text" readonly="readonly">
    			<h3>Category A2:</h3>
    			<input type="text" readonly="readonly">
    			<h3>Category B:</h3>
    			<input type="text" readonly="readonly">
    			<h3>MBIP Staff: </h3>
    			<input type="text" readonly="readonly">
    		</div>
    	</div>
    </div>

</body>
</html>