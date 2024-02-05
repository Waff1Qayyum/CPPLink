<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Profile</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style><%@include file="/assets/css/profile.css"%></style>	
</head>

<body>
    <div class="sidebar">
        <div class="logo">
            <img src="assets/logo_baru_web.gif" width="85px" height="85px">
            <div class="company">
                <h1>IPRK</h1>
                <h3>Iskandar Puteri Rendah Karbon</h3>
            </div>
        </div>
        <div class="profile">
            <i class="fa-solid fa-user"></i>
            <p>Profile</p>
        </div>
        <div class="profile" id="not_profile">
            <i class="fa-solid fa-gauge"></i>
            <p>Dashboard</p>
        </div>
        <div class="profile" id="not_profile">
            <i class="fa-solid fa-calendar-days"></i>
            <p>Calender</p>
        </div>
    </div>
    <div class="title">
        PROFILE
    </div>
    <div class="container">
        <div class="back">
            <a href="">
                <p>
                    < back</p>
            </a>
            <h3>Welcome back, name</h3>
        </div>
        <div class="personal_detail">
            <h3>Personal Detail</h3>
            <p>Username</p>
            <input type="text"></input>
            <p>Name</p>
            <input type="text"></input>
            <p>IC Number</p>
            <input type="text"></input>
            <p>Email</p>
            <input type="text"></input>
            <p>Phone Number</p>
            <input type="text"></input>
            <p>Address</p>
            <input type="text"></input>
            <div class="save_change">
                <input type="button" class="changes" id="discard" value="Discard Changes">
                <input type="button" class="changes" value="Save Changes">
            </div>
        </div>
    </div>
</body>

</html>