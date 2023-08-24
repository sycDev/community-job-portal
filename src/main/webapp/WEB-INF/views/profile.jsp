<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
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
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

		<!-- Google Fonts -->
		<link rel="stylesheet"
			href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">

		<!-- MDB -->
		<link rel="stylesheet"
			href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css">

		<!-- Bootstrap Datepicker -->
		<link rel="stylesheet"
			href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css"
			integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw=="
			crossorigin="anonymous" referrerpolicy="no-referrer">

		<!-- Custom Style -->
		<link rel="stylesheet" href="${contextRoot}css/common-style.css">
		<link rel="stylesheet" href="${contextRoot}css/index-style.css">

		<style>
		.form-select:focus {
			border-color: #FB8500;
			box-shadow: 0 0 0 0.2rem rgba(251, 133, 0, 0.25);
		}
		</style>

		<title>My Profile</title>
	</head>

	<body>
		<div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>

			<!-- Main Content Start -->
			<!-- Profile Banner Background Graphics -->
			<img class="w-100 position-absolute hidden-mobile"
				src="${contextRoot}images/profile-page-bg-transparent.png"
				alt="Profile Page Banner Background"
				style="max-height: 200px; pointer-events: none; -drag: none; user-select: none; -moz-user-select: none; -webkit-user-drag: none; -webkit-user-select: none; -ms-user-select: none; z-index: -100;">

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

			<div class="container h-100">
				<div
					class="row d-flex justify-content-center align-items-center h-100">
					<div class="col col-lg-9 col-xl-7">
						<!-- Profile Top Section Start -->
						<div class="rounded-top text-white d-flex flex-row"
							style="height: 200px;">
							<div class="ms-4 mt-5 d-flex flex-column" style="width: 150px;">
								<div class="avatar-upload">
									<div class="avatar-edit">
										<input type='file' id="imageUpload" name="profilePic"
											accept=".png, .jpg, .jpeg"> <label for="imageUpload"></label>
									</div>
									<div class="avatar-preview">
										<div id="imagePreview"
											style="background-image: url('${contextRoot}images/default-profile-pic.png');">
										</div>
									</div>
								</div>
							</div>
							<div class="ms-3" style="margin-top: 60px;">
								<h4 class="media-heading mt-3">
									${userProfile.firstName} ${userProfile.lastName} <small
										style="font-size: 14px; font-weight: normal"><c:if
											test="${not empty userProfile.pronouns}">(${userProfile.pronouns})</c:if></small>
								</h4>
								<p class="lead" style="font-size: 16px; color: grey;">
									<c:if test="${not empty userProfile.location.city}">${userProfile.location.city}, </c:if>${userProfile.location.country}</p>
							</div>
							<!-- Button to Trigger Edit Profile Basic Details Form Modal -->
							<div class="ms-3 hidden-mobile" style="margin-top: 60px;">
								<span data-mdb-toggle="modal"
									data-mdb-target="#edit-profile-basic-modal">
									<button type="button"
										class="btn btn-sm rounded-pill edit-profile-icon">
										<i class="fas fa-edit"></i>
									</button>
								</span>
							</div>
						</div>
						<!-- Edit Profile Button for Mobile View Only Start -->
						<div class="me-4 mobile-only text-end">
							<span data-mdb-toggle="modal"
								data-mdb-target="#edit-profile-basic-modal">
								<button type="button" class="btn btn-sm">Edit Profile</button>
							</span>
						</div>
						<!-- Edit Profile Button for Mobile View Only End -->

						<!-- Edit Profile Basic Details Form Modal Start -->
						<div class="modal top fade" id="edit-profile-basic-modal"
							tabindex="-1" aria-labelledby="edit-profile-basic-modal-label"
							aria-hidden="true" data-mdb-backdrop="true"
							data-mdb-keyboard="true">
							<div class="modal-dialog modal-xl  modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="edit-profile-basic-modal-label">Edit
											Profile Basic Details</h5>
										<button type="button" class="btn-close"
											data-mdb-dismiss="modal" aria-label="Close"></button>
									</div>

									<form:form id="edit-profile-basic-form"
										modelAttribute="userProfile" action="updateProfile"
										method="post">
										<div class="modal-body">
											<div class="form-group mb-2">
												<label for="editFirstNameInput" class="col-form-label">First
													Name *</label>
												<form:input path="firstName" type="text" class="form-control"
													id="editFirstNameInput" maxlength="100"
													name="firstName" value="${userProfile.firstName}" required="required" />
											</div>
											<div class="form-group mb-2">
												<label for="editLastNameInput" class="col-form-label">Last
													Name</label>
												<form:input path="lastName" type="text" class="form-control"
													id="editLastNameInput" maxlength="100" name="lastName"
													value="${userProfile.lastName}" />
											</div>
											<div class="form-group mb-2">
												<label for="editPronounsSelect" class="col-form-label">Pronouns</label>
												<form:select path="pronouns" class="form-select"
													id="editPronounsSelect" name="pronouns">
													<option value=""
														<c:if test="${empty userProfile.pronouns}">selected</c:if>>How
														others refer to you</option>
													<option value="He/him"
														<c:if test="${userProfile.pronouns == 'He/him'}">selected</c:if>>He/him</option>
													<option value="She/her"
														<c:if test="${userProfile.pronouns == 'She/her'}">selected</c:if>>She/her</option>
													<option value="They/them"
														<c:if test="${userProfile.pronouns == 'They/them'}">selected</c:if>>They/them</option>
												</form:select>
											</div>
											<div class="form-group mb-2">
												<label class="col-form-label">Location *</label>
												<form:select path="location.locationId" class="form-select"
													id="editProfileLocationSelect"
													name="location" required="required" >
													<option value="" disabled="disabled">Select
														Country, City</option>
													<c:forEach var="location" items="${locationList}">
														<option value="${location.locationId}"
															${location.locationId == userProfile.location.locationId ? 'selected="selected"' : ''}>${location.country}<c:if
																test="${not empty location.city}">, ${location.city}</c:if></option>
													</c:forEach>
												</form:select>

											</div>
											<div class="form-group mb-2">
												<label for="editDobInput" class="col-form-label p-0">Date
													of Birth</label>
												<div class="input-group date datepicker">
													<fmt:formatDate value="${userProfile.dateOfBirth}" pattern="yyyy-MM-dd" var="formattedDate" />
													<form:input path="dateOfBirth" type="date" class="form-control" id="editDobInput" name="dateOfBirth" value="${formattedDate}" pattern="yyyy-MM-dd" />
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-mdb-dismiss="modal"
												style="color: #FB8500; background-color: transparent;">Cancel</button>
											<button type="submit" class="btn btn-primary"
												style="background-color: #FB8500;">Save Changes</button>
										</div>
									</form:form>
								</div>
							</div>
						</div>
						<!-- Edit Profile Basic Details Form Modal End -->
						<!-- Profile Top Section End -->

						<!-- Profile Details Section Start -->
						<div class="card-body p-4 text-black">

							<!-- Education Section Start -->
							<div class="panel">
								<!-- Education Listing Start -->
								<div class="panel-heading">
									<span class="panel-icon"> <i class="fa fa-graduation-cap"></i>
									</span> <span class="panel-title">Education</span>
								</div>
								<div class="panel-body">
									<c:forEach items="${educationList}" var="education">
										<div class="row">
											<div class="col-11">
												<h6>${education.courseName}</h6>
												<p class="text-muted">
													${education.schoolName} <br> <i><fmt:formatDate
															value="${education.startDate}" pattern="MMM yyyy" /> - <fmt:formatDate
															value="${education.endDate}" pattern="MMM yyyy" /></i> <br>
													<b>${education.grade}</b>
												</p>
												<p class="text-muted">${education.description}</p>
											</div>
											<div class="col-1 my-auto hidden-mobile">
												<span data-mdb-toggle="modal"
													data-mdb-target="#edit-education-modal">
													<button type="button"
														class="btn btn-sm btn-floating mb-5 edit-edu-btn"
														name="btn-icon" data-mdb-toggle="tooltip"
														data-mdb-placement="right"
														data-id="${education.educationId}" title="Edit">
														<i class="fas fa-edit"></i>
													</button>
												</span> <span data-mdb-toggle="modal"
													data-mdb-target="#delete-education-modal">
													<button type="button"
														class="btn btn-sm btn-floating btn-danger delete-edu-btn"
														name="btn-icon" data-mdb-toggle="tooltip"
														data-mdb-placement="right"
														data-id="${education.educationId}" title="Delete">
														<i class="fas fa-trash"></i>
													</button>
												</span>
											</div>
											<div class="mobile-only">
												<span data-mdb-toggle="modal"
													data-mdb-target="#edit-education-modal"
													data-id="${education.educationId}">
													<button type="button" class="btn btn-sm edit-edu-btn">Edit</button>
												</span> <span data-mdb-toggle="modal"
													data-mdb-target="#delete-education-modal"
													data-id="${education.educationId}">
													<button type="button"
														class="btn btn-sm btn-danger delete-edu-btn">Delete</button>
												</span>
											</div>
										</div>
										<hr class="short br-lighter">
									</c:forEach>

									<!-- Button to Trigger Post New Education Form Modal -->
									<button class="btn btn-block mt-2" id="add-new-education-btn"
										data-mdb-toggle="modal"
										data-mdb-target="#add-new-education-modal">Add
										Education</button>
								</div>
								<!-- Education Listing End -->
							</div>

							<!-- Add New Education Form Modal Start -->
							<div class="modal top fade" id="add-new-education-modal"
								tabindex="-1" aria-labelledby="add-new-education-modal-label"
								aria-hidden="true" data-mdb-backdrop="true"
								data-mdb-keyboard="true">
								<div class="modal-dialog modal-xl  modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="add-new-education-modal-label">Add
												Education</h5>
											<button type="button" class="btn-close"
												data-mdb-dismiss="modal" aria-label="Close"></button>
										</div>

										<form:form id="add-new-education-form"
											modelAttribute="education" action="addEducation" method="post">
											<div class="modal-body">
												<div class="form-group mb-2">
													<label for="schoolNameInput" class="col-form-label">School
														Name *</label>
													<form:input path="schoolName" type="text"
														class="form-control" id="schoolNameInput" name="schoolName"
														maxlength="100"
														placeholder="Eg: Harvard University, Cambridge" />
												</div>
												<div class="form-group mb-2">
													<label for="courseNameInput" class="col-form-label">Course
														Name</label>
													<form:input path="courseName" type="text"
														class="form-control" id="courseNameInput" name="courseName"
														maxlength="200"
														placeholder="Eg: Master of Science in Computer Science" />
												</div>
												<div class="row">
													<div class="col-md-6 col-sm-6">
														<div class="form-group mb-2">
															<label for="edu-start-date" class="col-form-label p-0">Start
																Date *</label>
															<div class="input-group date datepicker">
																<form:input path="startDate" type="date"
																	class="form-control" id="edu-start-date"
																	name="eduStartDate" />
															</div>
														</div>
													</div>
													<div class="col-md-6 col-sm-6">
														<div class="form-group mb-2">
															<label for="edu-end-date" class="col-form-label p-0">End
																Date</label>
															<div class="input-group date datepicker">
																<form:input path="endDate" type="date"
																	class="form-control" id="edu-end-date" name="eduEndDate" />
															</div>
														</div>
													</div>
												</div>
												<div class="form-group mb-2">
													<label for="gradeInput" class="col-form-label">Grade</label>
													<form:input path="grade" type="text" class="form-control"
														id="gradeInput" name="grade" maxlength="250"
														placeholder="Eg: CGPA 3.90/4.00" />
												</div>
												<div class="form-group mb-2">
													<label for="descriptionInput" class="col-form-label">Description</label>
													<form:textarea path="description" class="form-control" id="descriptionInput" name="description" placeholder="Tell us about your education experience..." rows="4"></form:textarea>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-mdb-dismiss="modal"
													style="color: #FB8500; background-color: transparent;">Cancel</button>
												<button type="submit" class="btn btn-primary"
													style="background-color: #FB8500;">Add</button>
											</div>
										</form:form>
									</div>
								</div>
							</div>
							<!-- Add New Education Form Modal End -->

							<!-- Edit Education Form Modal Start -->
							<div class="modal top fade" id="edit-education-modal"
								tabindex="-1" aria-labelledby="edit-education-modal-label"
								aria-hidden="true" data-mdb-backdrop="true"
								data-mdb-keyboard="true">
								<div class="modal-dialog modal-xl  modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="edit-education-modal-label">Edit
												Education</h5>
											<button type="button" class="btn-close"
												data-mdb-dismiss="modal" aria-label="Close"></button>
										</div>
										<form:form id="edit-education-form" modelAttribute="education" action="updateEducation" method="post">
											<div class="modal-body">
												<input type="hidden" id="selectedEduIdEdit">
												<div class="form-group mb-2">
													<label for="schoolNameInput" class="col-form-label">School
														Name *</label> <input type="text" class="form-control"
														id="schoolNameInput" name="schoolName" maxlength="100"
														placeholder="Eg: Harvard University, Cambridge"
														required="required" value="${education.schoolName}">
												</div>
												<div class="form-group mb-2">
													<label for="courseNameInput" class="col-form-label">Course
														Name</label> <input type="text" class="form-control"
														id="courseNameInput" name="courseName" maxlength="200"
														placeholder="Eg: Master of Science in Computer Science"
														value="${education.courseName}">
												</div>
												<div class="row">
													<div class="col-md-6 col-sm-6">
														<div class="form-group mb-2">
															<label for="edu-start-date" class="col-form-label p-0">Start
																Date</label>
															<div class="input-group date datepicker">
																<input type="date" class="form-control"
																	id="edu-start-date" name="eduStartDate"
																	value="<fmt:formatDate value="${education.startDate}" pattern="yyyy-MM-dd"/>"
																	required="required">
															</div>
														</div>
													</div>
													<div class="col-md-6 col-sm-6">
														<div class="form-group mb-2">
															<label for="edu-end-date" class="col-form-label p-0">End
																Date</label>
															<div class="input-group date datepicker">
																<input type="date" class="form-control" id="edu-end-date"
																	name="eduEndDate"
																	value="<fmt:formatDate value="${education.endDate}" pattern="yyyy-MM-dd"/>">
															</div>
														</div>
													</div>
												</div>
												<div class="form-group mb-2">
													<label for="gradeInput" class="col-form-label">Grade</label>
													<input type="text" class="form-control" id="gradeInput"
														name="grade" maxlength="250"
														placeholder="Eg: CGPA 3.90/4.00" value="${education.grade}">
												</div>
												<div class="form-group mb-2">
													<label for="descriptionInput" class="col-form-label">Description</label>
													<textarea class="form-control" id="descriptionInput"
														name="description"
														placeholder="Tell us about your education experience..."
														rows="4">${education.description}</textarea>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-mdb-dismiss="modal"
													style="color: #FB8500; background-color: transparent;">Cancel</button>
												<button type="submit" class="btn btn-primary"
													style="background-color: #FB8500;">Save Changes</button>
											</div>
										</form:form>
									</div>
								</div>
							</div>
							<!-- Edit Education Form Modal End -->

							<!-- Delete Education Confirmation Modal End -->
							<div class="modal fade" id="delete-education-modal" tabindex="-1"
								aria-labelledby="delete-education-modal-label" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<form:form action="deleteEducation" method="post">
											<input type="hidden" name="_method" value="DELETE">
											<div class="modal-header">
												<h5 class="modal-title" id="delete-education-modal-label">Delete
													education</h5>
												<button type="button" class="btn-close"
													data-mdb-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												Are you sure you want to delete this education?
												<input type="hidden" name="eduId" id="selectedEduIdDelete">
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-mdb-dismiss="modal"
													style="color: #818181; background-color: transparent;">Cancel</button>
												<button type="submit" class="btn btn-danger">Delete</button>
											</div>
										</form:form>
									</div>
								</div>
							</div>
							<!-- Education Section End-->
						</div>
						<!-- Profile Details Section End -->
					</div>
				</div>
			</div>
			<!-- Main Content End -->
	</body>

	<!-- MDB JS -->
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.3.js"
		integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
		crossorigin="anonymous"></script>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

	<!-- Bootstrap Datepicker -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"
		integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<script>
		// Temporary Client Side Upload Pic (For Demo)
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#imagePreview')
							.css('background-image', 'url(' + e.target.result + ')')
							.hide()
							.fadeIn(650);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}

		$("#imageUpload").change(function() {
			readURL(this);
		});

		// Reset the add new form after dismiss the modal
		$('#add-new-experience-modal, #add-new-education-modal').on('hidden.bs.modal',
			function() {
				$(this).find("input, textarea").val('').end().find("select")
						.val('').trigger('change').end().find(
								"input[type=checkbox], input[type=radio]")
						.prop("checked", "").end();
			});

		$(document).ready(function() {
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

		/* Reset the form to initial value if modal is dismissed */
		// Get the form element
		var form = document.getElementById('edit-profile-basic-form');

		// Store the original values of the form fields
		var originalValues = {};
		for (let i = 0; i < form.elements.length; i++) {
			var element = form.elements[i];
			originalValues[element.name] = element.value;
		}

		// Listen to the modal's hide.bs.modal event
		var myModal = document.getElementById('edit-profile-basic-modal');
		myModal.addEventListener('hide.bs.modal', function() {
			// Reset the form fields to their original values
			for (let i = 0; i < form.elements.length; i++) {
				var element = form.elements[i];
				element.value = originalValues[element.name];
			}
		});

		// To set the hidden input in the edit education modal form to determine which record been chosen to edit (updating education action)
		$(document).on("click", ".edit-edu-btn", function() {
			var eduId = $(this).data('id');
			$("#selectedEduIdEdit").val(eduId);
		});

		// To get the selected education to delete
		$('.delete-edu-btn').click(function() {
			var eduId = $(this).data('id');
			$('#selectedEduIdDelete').val(eduId);
		});
	</script>
</html>