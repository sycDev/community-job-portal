<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false" %>
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
		
		<title>ABC Jobs</title>
	</head>
	<body>
		<div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>
	
			<!-- Hero Banner -->
			<div class="px-4 py-5 my-5 text-center mobile-only">
				<h1 class="display-5 fw-bold mb-4">
					A Big Family of <br> Software Developers.
				</h1>
				<a href="${contextRoot}showRegister" class="btn btn-warning hero-banner-btn">Join Us</a>
				<div class="col-lg-6 mx-auto my-4">
					<img class="d-block mx-auto mb-4" src="${contextRoot}images/homepage-hero-banner.png" width="320" height="262" alt="Hero Banner">
				</div>
			</div>
	
			<div class="container my-5 hidden-mobile">
				<div class="row" id="hero-banner-pc">
					<div class="col-lg-6">
						<div class="p-5 mt-4">
							<h1 class="display-5 fw-bold text-start">A Big Family of</h1>
							<h1 class="display-5 fw-bold mb-4 text-start">Software Developers.</h1>
							<a href="${contextRoot}showRegister" class="btn btn-warning hero-banner-btn">Join Us</a>
						</div>
					</div>
					<div class="col-lg-6">
						<img class="w-100" src="${contextRoot}images/homepage-hero-banner.png" alt="Hero Banner">
					</div>
				</div>
			</div>
		</div>
	</body>
	
	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</html>
