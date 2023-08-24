<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<%-- Get context root --%>
		<c:url var="contextRoot" value="/" />
	    <link rel="icon" href="${contextRoot}images/abcjobs-logo-only.png">
	    
	    <!-- Bootstrap 5 -->
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
		
		<!-- Custom Style -->    
	    <link rel="stylesheet" href="${contextRoot}css/common-style.css">
	    <link rel="stylesheet" href="${contextRoot}css/index-style.css">
	
	    <title>Thanks for your registration</title>
	</head>
	<body>
	    <div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>
	
	        <!-- Content -->
	        <div class="my-4 text-center">
	            <div class="col-lg-6 mx-auto">
	                <img class="d-block mx-auto" src="${contextRoot}images/thank-you.png" alt="Registration Thank You" width="360">
	            </div>
	            <h2>Thank you for registering!</h2>
	            <p>Welcome to the community!<br>Start to build your network now...</p>
	            <a href="${contextRoot}showLogin">Proceed to login</a>
	        </div>
	    </div>
	</body>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</html>
