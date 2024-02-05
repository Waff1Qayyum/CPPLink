<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Register</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
  	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style><%@include file="/assets/css/register.css"%></style>	
</head>

<body>
    <div class="container">
        <div class="left">
            <!-- <img src="assets/1068776.jpg"> -->
            <img src="${pageContext.request.contextPath}/assets/images/logo_baru_web.gif">
            <h3>Welcome to Carbon Monitoring System Iskandar Puteri</h3>
            <hr>
            <div class="info">
                <!-- <div class="address">
                    <div class="left-wrap">

                    </div>
                    <div class="right-wrap"></div>
                </div> -->

                <div class="left-info">
                    <p class="address">Address</p>
                    <p class="office">Office No</p>
                    <p class="hotline">Hotline Call Centre</p>
                </div>
                <div class="right-info">
                    <p id="address" class="address">MAJLIS BANDARAYA ISKANDAR PUTERI, JALAN MEDINI SENTRAL 9, BANDAR
                        MEDINI
                        ISKANDAR, 79250, ISKANDAR PUTERI, JOHOR DARUL TA'ZIM</p>
                    <p id="office" class="office">07-5555000</p>
                    <p id="hcc" class="hotline">1300-80-5000</p>
                </div>
            </div>
        </div>
        <div class="right">
            <div class="title-wrap">
                <a href="<c:url value='/login' />"><i class="fa-solid fa-arrow-left" href=></i></a>
                <h3>Registration Form</h3>
            </div>
            <form action="<c:url value='/registerAccount' />" method="post">
                <h5><span>Account Detail</span></h5>
                <p>Username</p>
                <input type="text" name="username" id="username" autocomplete="off">
                <p>Password</p>
                <input type="password" name="password" id="password">
                <hr>
                <h5>Personal Detail</h5>
                <p>Name</p>
                <input type="text" name="name" id="name" autocomplete="off">
                <p>IC Number</p>
                <input type="text" name="ic" id="ic" autocomplete="off">
                <p>Email</p>
                <input type="text" name="email" id="email">
                <p>Phone Number</p>
                <input type="text" name="phone" id="phone" autocomplete="off">
                <p>Current Address</p>
                <textarea name="address" id="address"></textarea>
                <input type="submit" value="Register">
            </form>
        </div>

    </div>
</body>

</html>