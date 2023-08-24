<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<%-- Get context root --%>
		<c:url var="contextRoot" value="/" />
		<link rel="icon" href="${contextRoot}images/abcjobs-logo-only.png">
		
		<!-- Font Awesome -->
		<link rel="stylesheet"
			href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
		
		<!-- Google Fonts -->
		<link rel="stylesheet"
			href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
		
		<!-- MDB -->
		<link rel="stylesheet"
			href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css">
		
		<!-- Custom Style -->
		<link rel="stylesheet" href="${contextRoot}css/common-style.css">
		<link rel="stylesheet" href="${contextRoot}css/index-style.css">
		
		<title>Profile</title>
	</head>
	<body>
		<div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>
	
			<!-- Main Contents -->
			<!-- Profile Banner Background Graphics -->
			<img class="w-100 position-absolute hidden-mobile" src="${contextRoot}images/profile-page-bg-transparent.png"
				 alt="Profile Page Banner Background"
				 style="max-height: 200px;
				pointer-events: none;
				-drag: none;
				user-select: none;
				-moz-user-select: none;
				-webkit-user-drag: none;
				-webkit-user-select: none;
				-ms-user-select: none;"
			>

			<div class="container h-100">
				<div class="row d-flex justify-content-center align-items-center h-100">
					<div class="col col-lg-9 col-xl-7">
						<!-- Profile Top Section Start -->
						<div class="rounded-top text-white d-flex flex-row" style="height:200px;">
							<div class="ms-4 mt-5 d-flex flex-column" style="width: 150px;">
								<div class="avatar-upload">
									<div class="avatar-preview">
										<div id="imagePreview" style="background-image: url('${contextRoot}images/default-profile-pic.png');">
										</div>
									</div>
								</div>
							</div>
							<div class="ms-3" style="margin-top: 60px;">
								<h4 class="media-heading mt-3">${userProfile.firstName} ${userProfile.lastName}
									<small style="font-size: 14px; font-weight: normal">
										<c:if test="${not empty userProfile.pronouns}">
											(${userProfile.pronouns})
										</c:if>
									</small>
								</h4>
								<p class="lead" style="font-size: 16px; color: grey;">
									<c:if test="${not empty userProfile.location.city}">
										${userProfile.location.city},
									</c:if> ${userProfile.location.country}</p>
							</div>
						</div>
						<!-- Profile Top Section End -->

						<!-- Profile Details Section Start -->
						<div class="card-body p-4 mb-5 text-black">
							<!-- Education Section Start -->
							<div class="panel">
								<div class="panel-heading">
									<span class="panel-icon">
										<i class="fa fa-graduation-cap"></i>
									</span>
									<span class="panel-title">Education</span>
								</div>
								<div class="panel-body">
									<c:forEach items="${educationList}" var="education" varStatus="status">
										<c:if test="${status.count > 1}">
											<hr class="short br-lighter">
										</c:if>
										<h6>${education.courseName}</h6>
										<p class="text-muted">
											${education.schoolName} <br> 
											<i>
												<fmt:formatDate value="${education.startDate}" pattern="MMM yyyy" /> - 
												<fmt:formatDate	value="${education.endDate}" pattern="MMM yyyy" />
											</i>
											<br>
											<b>${education.grade}</b>
										</p>
										<p class="text-muted">${education.description}</p>
									</c:forEach>
								</div>
							</div>
							<!-- Education Section End-->
						</div>
						<!-- Profile Details Section End -->
					</div>
				</div>
			</div>
		</div>
	</body>
	<!-- MDB JS -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
</html>