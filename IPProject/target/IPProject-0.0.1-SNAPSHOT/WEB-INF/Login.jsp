<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
  <meta name='viewport' content='width=device-width, initial-scale=1'>

    <style>
    	<%@include file="/assets/css/login.css"%>
    	<%@include file="/assets/js/login.js"%>	
    </style>	
  <title>Login</title>
</head>
 <body>
 
  <div class="center">
    <img style="width: 177px; height: 162px" src="${pageContext.request.contextPath}/assets/images/logo_baru_web.gif" alt="MBIP Logo"/><br>
	<!--C:\Users\User\Documents\workspace-spring-tool-suite-4-4.5.0.RELEASE\IPProject\WebContent\images\mbip_logo.png -->    
    <div class="welcome">
      <h1>Welcome to Carbon Monitoring System Iskandar Puteri</h1>
    </div>
    <div class="box">
      <form onsubmit="validate()" action="<c:url value='/loginCheck' />" method="post">
        <p>Username</p>
        <input type="text" class="input" name="username"><br>
        <p>Password</p>
        <input type="password" class="input" name="password"><br>
        <div class="submit">
          <a href="<c:url value="/register/"/>"><input type="button" value="Register"></a>
          <input type="submit" value="Login">
        </div>
      </form>
    </div>
  </div>
</body>
</html>