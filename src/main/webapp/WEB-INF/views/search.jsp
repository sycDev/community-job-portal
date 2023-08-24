<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

		<style>
			.card:hover {
				background-color: rgba(251, 133, 0, .2);
			}
		</style>
		
		<title>Search</title>
	</head>
	<body>
		<div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>

			<!-- Main Contents -->
			<!-- Search Results Listing Start -->
			<c:if test="${not empty userResultList}">
				<section class="my-5">
					<div class="container">
						<div class="row d-flex justify-content-center">
							<div class="col-md-10 col-lg-8 col-xl-6">
								<div class="mb-2">
									<c:if test="${totalUserFound != 0}">
										${totalUserFound} user(s) found
									</c:if>
								</div>
								<c:forEach items="${userResultList}" var="userProfile">
									<a href="${contextRoot}profile/${userProfile.profileId}" style="color: #555;">
										<div class="card mb-3" style="box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2);">
											<div class="card-body">
												<div class="d-flex flex-start align-items-center">
													<img class="rounded-circle shadow-1-strong me-3" src="${contextRoot}images/default-profile-pic.png" alt="User Profile Picture" width="60" height="60">
													<div>
														<h6 class="fw-bold mb-1">${userProfile.firstName} ${userProfile.lastName}</h6>
														<p>
															<c:if test="${userProfile.location.city != null}">
																${userProfile.location.city},
															</c:if>
															${userProfile.location.country}
														</p>
													</div>
												</div>
											</div>
										</div>
									</a>
								</c:forEach>
							</div>
						</div>
					</div>
				</section>
			</c:if>
			<c:if test="${empty userResultList}">
				<div class="text-center mt-5">
					<img class="d-block mx-auto" src="${contextRoot}images/search-not-found.png" alt="User Not Found" width="320">
					<h3>No Result Found</h3>
				</div>
			</c:if>
			<!-- Search Results Listing End -->
		</div>
	</body>
	<!-- MDB JS -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
</html>