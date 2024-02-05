<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Login</title>
    
    <style><%@include file="/assets/css/intro.css"%></style>
</head>

<body>
    <div class="nav">
        <img src="${pageContext.request.contextPath}/assets/images/logo_baru_web.gif">
        <div class="action">
            <a href="<c:url value="/login"/>"><span>Login</span></a> <a href="<c:url value="/register"/>"><span>Signup</span></a>
        </div>
    </div>
    <div class="content">
        <img src="${pageContext.request.contextPath}/assets/images/logo_baru_web.gif">
        <h3>Majlis Bandaraya Iskandar Puteri Carbon Monitor System</h3>
        <div class="about">
            <div class="box">
                <h5>Who Are We?</h5>
                <p>Majlis Bandaraya Iskandar Puteri (MBIP) under Iskandar
                    Puteri Rendah Karbon (IPRK) initiative aim at gathering data on
                    energy saving among community. This community includes
                    schools, house residence, higher institution, factories and many
                    others. The movement has been progressively made since 2019
                    with the implementation.
                </p>
            </div>
            <div class="box">
                <h5>Our Solution</h5>
                <p>Pertandingan Kalender Rendah Karbon Iskandar Puteri is one of the
                    most resourceful competition that MBIP used to collect data on energy
                    saving. This competition with a total amount of RM30, 000 as cash
                    prize money is an incentive provided to the communities in Iskandar
                    Puteri Region for their collective efforts for electricity and energy
                    saving and waste management.
                </p>
            </div>
        </div>
        <div class="start">
            <a href="<c:url value='/login' />">
                <p>Get Started</p>
            </a>
        </div>
    </div>
</body>

</html>