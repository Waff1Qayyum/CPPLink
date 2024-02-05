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
        PROFILE
    </div>
    <div class="container">
    	<h3>Personal Detail</h3>
        <div class="personal_detail">
        	<form id="personalForm" action="<c:url value='/profile_update' />" method="post">
			<p>Name</p>
            <input type="text" name= "name" id="disable" value="${user.name }" readonly="readonly"></input>
            <p>IC Number</p>
            <input type="text" name= "ic" id="disable" value="${user.ic }" readonly="readonly"></input>
            <p>Address</p>
            <input type="text" name= "address" id="disable" value="${user.address }" readonly="readonly"></input>
            <hr>
            <p>Username</p>
            <input type="text" name= "username" value="${user.username }"></input>
            <p style="color: red;">${username_exist}</p>
            <p>Email</p>
            <input type="text" name= "email" value="${user.email }"></input>
            <p style="color: red;">${email_exist}</p>
            <p>Phone Number</p>
            <input type="text" name= "phone" value="${user.phone }"></input>
            <p style="color: red;">${phone_exist}</p>
            <div class="save_change">
                <a href="<c:url value='/profile' />"><input type="button" class="changes" id="discard" value="Discard Changes"></a>
                <input type="submit" class="changes" value="Save Changes">
            </div>
            </form>
            <c:if test="${not empty changesSaved}">
                <script>
                    alert("Changes saved successfully!");
                </script>
            </c:if>
        </div>
    </div>
    
    <script>
    document.getElementById('discard').addEventListener('click', function() {
        // Reset the form to its initial state
        document.getElementById('personalForm').reset();
    });
</script>
</body>

</html>