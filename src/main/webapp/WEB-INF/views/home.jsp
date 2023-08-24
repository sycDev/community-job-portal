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
		
		<title>Home</title>
	</head>
	<body>
		<div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>
	
			<!-- Main Contents -->
			<!-- Toast Return Message Start -->
			<div class="toast-container fixed-bottom m-3">
				<div class="toast align-items-center position-relative" role="alert" aria-live="assertive" aria-atomic="true">
					<div class="toast-content">
						<div class="content-body d-flex align-items-center">
							<div class="me-3" id="toast-icon"></div>
								<div class="d-flex justify-content-between w-100" id="toast-message"></div>
								<div>
									<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Toast Return Message End -->
			<!-- Thread Post Feed -->
			<c:forEach items="${threadPostList}" var="threadPost">
				<section class="my-5">
					<div class="container">
						<div class="row d-flex justify-content-center">
							<div class="col-md-10 col-lg-8 col-xl-6">
								<div class="card" style="box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2);">
									<div class="card-body">
										<div class="d-flex flex-start align-items-center">
											<a href="#" class="rounded-circle">
												<img class="rounded-circle shadow-1-strong me-3" src="${contextRoot}images/default-profile-pic.png" alt="User Profile Picture" width="60" height="60">
											</a>
											<div>
												<a href="#" style="color: #555;">
													<h6 class="fw-bold mb-1">${threadPost.userProfile.firstName} ${threadPost.userProfile.lastName}</h6>
												</a>

												<%-- Raw datetime from database in UTC --%>
												<fmt:parseDate var="rawDate" value="${threadPost.threadCreatedAt}" pattern="yyyy-MM-dd HH:mm:ss.S" />

												<%-- Current datetime in UTC --%>
												<c:set var="now" value="<%= new java.util.Date() %>" />
												<c:set var="elapsedTime" value="${now.time - rawDate.time}" />

												<%-- Convert elapsedTime into days --%>
												<c:set var="elapsedDays" value="${elapsedTime / (24 * 60 * 60 * 1000)}" />
												<%-- Convert elapsedTime into hours --%>
												<c:set var="elapsedHours" value="${elapsedTime / (60 * 60 * 1000) % 24}" />
												<%-- Convert elapsedTime into minutes --%>
												<c:set var="elapsedMinutes" value="${elapsedTime / (60 * 1000) % 60}"/>

												<p class="text-muted small mb-0">
													<c:choose>
														<%-- If more than 7 days have passed --%>
														<c:when test="${elapsedDays > 7}">
															<fmt:setTimeZone value="GMT+8" />
															<fmt:formatDate type="both" dateStyle="long" timeStyle="short" value="${rawDate}" />
														</c:when>
														<%-- If between 1 and 7 days have passed --%>
														<c:when test="${elapsedDays >= 1}">
															<c:set var="elapsedDaysInt" value="${(elapsedDays + 0.5) - ((elapsedDays + 0.5) mod 1)}" />
															<fmt:formatNumber value="${elapsedDaysInt}" /> days ago
														</c:when>
														<%-- If between 1 and 24 hours have passed --%>
														<c:when test="${elapsedHours >= 1}">
															<c:set var="elapsedHoursInt" value="${(elapsedHours + 0.5) - ((elapsedHours + 0.5) mod 1)}" />
															<fmt:formatNumber value="${elapsedHoursInt}" /> hours ago
														</c:when>
														<%-- If less than an hour has passed --%>
														<c:when test="${elapsedMinutes >= 1}">
															<c:set var="elapsedMinutesInt" value="${(elapsedMinutes + 0.5) - ((elapsedMinutes + 0.5) mod 1)}" />
															<fmt:formatNumber value="${elapsedMinutesInt}" /> minutes ago
														</c:when>
														<%-- If no time has passed --%>
														<c:otherwise>
															<c:out value="just now"/>
														</c:otherwise>
													</c:choose>
												</p>
                                            </div>
										</div>

										<!-- Thread Post Content -->
										<h5 class="mt-3">${threadPost.threadPostTitle}</h5>
										<p>
											${threadPost.threadPostContent}
										</p>
									</div>

									<!-- Post Thread Reply Section Start -->
									<div class="px-4">
										<!-- Post Reply to Thread Input Start -->
										<div class="d-flex flex-row-reverse justify-content-start align-items-start mb-3">
											<div class="badge align-self-start flex-fill">
												<form>
													<input type="text" class="form-control" name="threadReplyContent" placeholder="Add a comment...">
													<input type="submit" style="display: none;">
												</form>
											</div>
											<div class="badge">
												<img class="img-fluid img-responsive rounded-circle" src="${contextRoot}images/default-profile-pic.png" alt="User Profile Picture" width="38">
											</div>
										</div>
										<!-- Post Reply to Thread Input End -->
									</div>
									<!-- Post Thread Reply Section End -->
								</div>
							</div>
						</div>
					</div>
				</section>
			</c:forEach>

			<section class="my-sm-4">
				<div class="container">
					<div class="row d-flex justify-content-center">
						<div class="col-md-10 col-lg-8 col-xl-6">
							<div class="card" style="box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2);">
								<div class="card-body">
									<div class="d-flex flex-start align-items-center">
										<a href="#" class="rounded-circle">
											<img class="rounded-circle shadow-1-strong me-3" src="${contextRoot}images/Florence.png" alt="User Profile Picture" width="60" height="60">
										</a>
										<div>
											<a href="#" style="color: #555;">
												<h6 class="fw-bold mb-1">Florence Francis</h6>
											</a>
											<p class="text-muted small mb-0">20 hours ago</p>
										</div>
									</div>
	
									<!-- Thread Post Content -->
									<h5 class="mt-3">Best practices for using Git</h5>
									<p>
										To use Git effectively, there are some best practices
										such as write clear commit messages, remember to pull and merge
										regularly from the main branch, create different branches for
										every features or bug fixes.
									</p>
	
									<!-- Thread Post Image -->
									<div class="bg-image hover-overlay ripple shadow-1-strong rounded" data-ripple-color="light">
										<img src="${contextRoot}images/thread-post-image.jpg" class="w-100">
											<a href="#!" data-mdb-toggle="modal" data-mdb-target="#thread-post-image">
											<div class="mask" style="background-color: rgba(251, 251, 251, 0.2);">
											</div>
										</a>
									</div>
	
									<div class="modal fade" id="thread-post-image" tabindex="-1" aria-hidden="true">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">
												<img src="${contextRoot}images/thread-post-image.jpg" class="w-100" alt="Thread1 Image">
											</div>
										</div>
									</div>
								</div>
	
								<!-- Post Thread Reply Section Start -->
								<div class="px-4">
									<!-- Post Reply to Thread Input Start -->
									<div class="d-flex flex-row-reverse justify-content-start align-items-start mb-3">
										<div class="badge align-self-start flex-fill">
											<form>
												<input type="text" class="form-control"
													name="threadReplyContent" placeholder="Add a comment...">
												<input type="submit" style="display: none;">
											</form>
										</div>
										<div class="badge">
											<img class="img-fluid img-responsive rounded-circle" src="${contextRoot}images/default-profile-pic.png" alt="User Profile Picture" width="38">
										</div>
									</div>
									<!-- Post Reply to Thread Input End -->
	
									<!-- Thread Replies list Start -->
									<div class="d-flex flex-start my-4">
										<img class="rounded-circle shadow-1-strong mx-2" src="${contextRoot}images/Edward.jpg" alt="User Profile Picture" height="38">
										<div class="mt-1">
											<div class="d-flex justify-content-between align-items-center">
												<p class="mb-1">
													<a href="#" style="color: #555;">Edward Paul </a> <span class="small">- 2 hours ago</span>
												</p>
											</div>
											<p class="small mb-0">
												Aliquam dolores omnis praesentium
												facere natus saepe similique laborum pariatur delectus
												cupiditate, doloribus impedit maxime accusantium distinctio
												fuga reiciendis molestias aspernatur.
											</p>
										</div>
									</div>
									<!-- Thread Replies list End -->
								</div>
								<!-- Post Thread Reply Section End -->
							</div>
						</div>
					</div>
				</div>
			</section>
	
			<!-- Button to Trigger Post New Thread Form Modal -->
			<div style="position: fixed; bottom: 20px; right: 20px;">
				<span data-mdb-toggle="modal" data-mdb-target="#add-new-post-modal">
					<button type="button" id="add-new-post-btn" class="btn btn-primary btn-floating" data-mdb-toggle="tooltip" title="Post New Thread" style="width: 50px; height: 50px; background-color: #FB8500;">
						<i class="fa fa-add" style="font-size: large;"></i>
					</button>
				</span>
			</div>
	
			<!-- Post New Thread Form Modal -->
			<div class="modal top fade" id="add-new-post-modal" tabindex="-1" aria-labelledby="add-new-post-modal-label" aria-hidden="true" data-mdb-backdrop="true" data-mdb-keyboard="true">
				<div class="modal-dialog modal-xl  modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="add-new-post-modal-label">Post a new thread</h5>
							<button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
						</div>
						<form:form modelAttribute="threadPost" action="createThread" method="post">
							<div class="modal-body">
								<div class="form-group mb-2">
									<label>Title</label>
									<input type="text" class="form-control" id="titleInput" name="threadPostTitle" maxlength="200" required="required">
									<small class="form-text text-muted">0 characters remaining</small>
								</div>
								<div class="form-group mb-2">
									<label>Content</label>
									<textarea class="form-control" id="contentInput" name="threadPostContent" placeholder="Write something here..." rows="4" required="required"></textarea>
								</div>
								<div class="text-start">
									<a href="#"><i class="fa fa-camera"></i></a>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-mdb-dismiss="modal" style="color: #FB8500; background-color: transparent;">Close</button>
								<button type="submit" class="btn btn-primary" style="background-color: #FB8500;">Post</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</body>

	<!-- MDB JS -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>

	<script>
		// For post new thread form
		function markRequired() {
			var control = $(this).children(".form-control");
			var label = $(this).children("label");
			if (control.attr("required") === "required") {
				label.addClass("required");
			}
		}
	
		function countCharacters() {
			var max = $(this).attr("maxlength");
			var length = $(this).val().length;
			var counter = max - length;
			var helper = $(this).next(".form-text");
			// Switch to the singular if there's exactly 1 character remaining
			if (counter !== 1) {
				helper.text(counter + " characters remaining");
			} else {
				helper.text(counter + " character remaining");
			}
			// Make it red if there are 0 characters remaining
			if (counter === 0) {
				helper.removeClass("text-muted");
				helper.addClass("text-danger");
			} else {
				helper.removeClass("text-danger");
				helper.addClass("text-muted");
			}
		}
	
		$(document).ready(function() {
			// Activate tooltip
			var tooltipEl = document.getElementById('add-new-post-btn');
			new mdb.Tooltip(tooltipEl);
	
			// Do checking of achieve maximum characters
			$(".form-group").each(markRequired);
			// Do word count
			$(".form-control").each(countCharacters).keyup(countCharacters);

			// Showing the success message from controller
			<c:if test="${not empty successMsg}">
				showToast("${successMsg}", true);
			</c:if>

			// Showing the error message from controller
			<c:if test="${not empty errMsg}">
			showToast("${errMsg}", false);
			</c:if>
		});

		function showToast(message, isSuccess) {
			if (isSuccess) {
				$('#toast-icon').html('<i class="fa fa-circle-check fa-xl d-flex" style="color: #228B22"></i>');
			} else {
				$('#toast-icon').html('<i class="fa fa-circle-exclamation fa-xl d-flex" style="color: #D90429"></i>');
			}
			$('#toast-message').html(message);
			$('.toast').toast('show');
		}
	</script>
</html>