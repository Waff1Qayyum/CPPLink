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
    	<%@include file="/assets/css/adaptation.css"%>
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
            <div class="content-container">
                <div class="left-title">
                    <h3>Adaptation</h3>
                </div>
                <div class="left-content">
                    <h3>Our Goals</h3>
                    <p>Pledges to increase the city's 
                        climate resilience by espousing 
                        the Sendai Framework's targets of 
                        substantially reducing mortality, 
                        economic loses and damage to 
                        infrastructure</p>
                    <h3>Expected Weather</h3>
                    <img src="${pageContext.request.contextPath}/assets/images/weather map.png">
                </div>
                <div class="right-content">
                    <h3>Current Weather</h3>
                    <img src="${pageContext.request.contextPath}/assets/images/weather.png">
                    <h3>Safety Precautions</h3>
                    <div class="content-box">
                        <p class="center">Extreme Precipitation: Monsoon</p>
                        <h3 class="center" id="highlight">23 July 2023</h3>
                        <div class="social-impact">
                            <p class="big center">Social Impact </p>
                            <p class = "center">Increased demand for public services
                            (e.g. local government assistant to flood victims) / 
                            farmers
                        </div>
                        <p class="big">What should do?</p>
                        <p>1. Stay informed and follow weather updates.</p>
                        <p>2. Prepare an emergency kit with essential supplies.</p>
                        <p>3. Follow evacuation orders and seek safe shelter.</p>
                        <p>4. Avoid flooded areas and flowing water.</p>
                        <p>5. Ensure food and water safety.</p>
                        <p>6. Practice electrical safety.</p>
                        <p>7. Learn basic first aid techniques. </p>
                    </div>
                </div>
            </div>
</body>
</html>