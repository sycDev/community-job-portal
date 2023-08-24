<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

		<!-- Bootstrap 5 -->
		<link
			href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
			rel="stylesheet"
			integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
			crossorigin="anonymous">

		<!-- Bootstrap Icons -->
		<link rel="stylesheet"
			href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

		<!-- Custom Style -->
		<link rel="stylesheet" href="${contextRoot}css/common-style.css">
		<link rel="stylesheet" href="${contextRoot}css/form-style.css">
		<style>
		/* Media Queries */
		/* For Laptops and Desktops */
		@media screen and (min-width: 1024px) {
			/* Desktop Register Page */
			body {
				background-image: url("${contextRoot}images/register-bg.png");
			}
		}
		</style>

		<title>Register</title>
	</head>
	<body>
		<div class="container-fluid">
			<div class="d-flex justify-content-center align-items-center">
				<div class="text-center form-header">
					<c:url value="/" var="indexUrl" />
					<a class="my-2" href="${indexUrl}"> <img
						src="${contextRoot}images/abcjobs-logo.png" alt="ABC Jobs Logo" width="198"
						height="54">
					</a>
					<h2 class="mt-4">Register</h2>
					<p>
						Already have an account? <a href="${contextRoot}showLogin">Login</a>
					</p>
				</div>
			</div>
			<div class="form d-flex">
				<div class="container">
					<form:form class="mb-5 h-100" id="user-registration"
						modelAttribute="registrationDto" action="register" method="post">
						<form:hidden path="role" value="SOFTWARE_PROGRAMMER"/>
	
						<!--  Display Error Message Start -->
						<c:if test="${errMsg != null}">
							<div class="input-group">
								<div class="alert alert-danger w-100">
									<div class="d-flex align-items-center">
										<div class="me-3">
											<i class="bi bi-exclamation-circle-fill me-2 align-middle" style="font-size: 20px;"></i>
										</div>
										<div class="d-flex justify-content-between w-100">${errMsg}</div>
									</div>
								</div>
							</div>
						</c:if>
						<!--  Display Error Message End -->
	
						<div class="input-group">
							<form:input path="email" type="text" class="form-control"
								name="email" id="emailInput" placeholder="Email" required="required" />
						</div>
						<div class="error">
							<p id="error-emailInput"></p>
						</div>
	
						<div class="input-group">
							<form:input path="password" type="password" class="form-control"
								name="password" id="pwdInput" placeholder="Password"
								data-bs-toggle="tooltip" data-bs-placement="right"
								title="Minimum 8 characters" required="required" />
							<i class="bi bi-eye" id="eyeToggle"></i>
						</div>
						<div class="error">
							<p id="error-pwdInput"></p>
						</div>
	
						<div class="input-group">
							<form:input path="confirmPassword" type="password"
								class="form-control" name="confirmPassword" id="pwdRepeatInput"
								placeholder="Confirm Password" required="required" />
							<i class="bi bi-eye" id="eyeToggle"></i>
						</div>
						<div class="error">
							<p id="error-pwdRepeatInput"></p>
						</div>
	
						<div class="input-group">
							<form:input path="firstName" type="text" class="form-control"
								name="firstName" id="firstNameInput" maxlength="100"
								 placeholder="First Name" required="required" />
						</div>
						<div class="error">
							<p id="error-firstNameInput"></p>
						</div>
	
						<div class="input-group mb-2">
							<form:input path="lastName" type="text" class="form-control"
								name="lastName" id="lastName" maxlength="100"
								placeholder="Last Name" />
						</div>
	
						<div class="input-group mb-2">
							Location
							<div class="bi bi-info-circle text-secondary ms-1" id="info-icon"
								data-bs-toggle="tooltip" data-bs-placement="right"
								title="Your current location or where you from"></div>
						</div>
	
						<div class="input-group mb-2">
							<form:select path="locationId" class="form-select" id="userLocationSelect" name="location"
										 title="Select Country, City" required="required">
								<form:option value="" disabled="true" selected="selected">Select Country, City</form:option>
								<c:forEach items="${locationList}" var="location">
									<form:option value="${location.locationId}">${location.country}<c:if
											test="${not empty location.city}">, ${location.city}</c:if>
									</form:option>
								</c:forEach>
							</form:select>
						</div>
	
						<div class="m-auto" id="btnLink">
							<button class="btn btn-lg btn-warning mt-3 w-100 submit-btn" type="submit" id="btnSubmit">Submit</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</body>

	<!-- Bootstrap 5 JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			// To activate the tooltip for showing password requirement
			var myTooltipEl = document.getElementById('pwdInput');
			new bootstrap.Tooltip(myTooltipEl);
	
			// To activate the tooltip for info icon
			var infoTooltip = document.getElementById('info-icon');
			new bootstrap.Tooltip(infoTooltip);
		});
	
		let pwdInput = document.getElementById('pwdInput');
		let rePwdInput = document.getElementById('pwdRepeatInput');
	
		// Function to toggle password visibility for password field
		function togglePwdVisible() {
			if ($('#pwdInput').attr('type') === 'password') {
				// When the password is hidden, show the password
				pwdInput.type = 'text';
			} else {
				// When the password is visible, hide the password
				pwdInput.type = 'password';
			}
		}
	
		// Function to toggle password visibility for confirm password field
		function toggleRePwdVisible() {
			if (rePwdInput.type === 'password') {
				// When the repeat password is hidden, show the password
				rePwdInput.type = 'text';
			} else {
				// When the repeat password is visible, hide the password
				rePwdInput.type = 'password';
			}
		}
	
		// Toggle password visibility when user click on the eye icon of password fields
		$('#pwdInput + #eyeToggle').on('click', function() {
			// Change the eye icon to eye with slash icon
			$(this).toggleClass('bi-eye').toggleClass('bi-eye-slash');
			togglePwdVisible();
		});
	
		// Toggle password visibility when user click on the eye icon of confirm password fields
		$('#pwdRepeatInput + #eyeToggle').on('click', function() {
			// Change the eye with slash icon to eye icon
			$(this).toggleClass('bi-eye').toggleClass('bi-eye-slash');
			toggleRePwdVisible();
		});
	
		// Validate form with empty required fields
		function validateEmptyRequired() {
			var isValid = true;
			$('form input, form select').each(function() {
				if ($(this).attr("required") === "required") {
					if (!$(this).val()) {
						isValid = false;
						$(this).addClass('invalid-input');
						$(this).removeClass('valid-input');
						$('#error-' + ($(this).attr('id'))).html(
								'Please fill out this field');
					}
				}
			});
			return isValid;
		}
	
		// Data validation onBlur
	
		// Checking for empty input field after blur the field
		// Change the bottom border color of the input that is empty
		$('form input, form select').blur(function() {
			if ($(this).attr("required") === "required") {
				if (!$(this).val()) {
					$(this).addClass('invalid-input');
					$(this).removeClass('valid-input');
					$('#error-' + ($(this).attr('id'))).html(
							'Please fill out this field');
				} else {
					$(this).addClass('valid-input');
					$(this).removeClass('invalid-input');
					$('#error-' + ($(this).attr('id'))).html('');
				}
			}
		});
	
		// Validate email on blur if the input is not empty
		$('#emailInput').on('blur', function() {
			if ($(this).val() != '') {
				validateEmail(this.value);
			}
		});
	
		/*
		 *  Input validation of email address
		 *  - must contain @ and dot
		 *  - at least two characters after the dot
		 *  - cannot start or end with a dot or a @
		 *  - should not contain spaces into the string
		 *  - should not contain special chars (<:, *)
		 *  - can contain dots in the middle of mail address before the @
		 *  - can contain a double domain
		 */
		function validateEmail(str) {
			var regex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
			if (!regex.test(str)) {
				showError('emailInput', 'Invalid email');
				return false;
			} else {
				hideError('emailInput');
				return true;
			}
		}
	
		// Validate password length on blur if the input is not empty
		$('#pwdInput').on('blur', function() {
			if ($(this).val() !== '') {
				checkPwdLength(this.value);
			}
		});
	
		// Data validation for password - must contains at least 8 characters
		function checkPwdLength(str) {
			if (str.length < 8) {
				showError('pwdInput', 'Password must be at least 8 characters');
				return false;
			} else {
				hideError('pwdInput');
				return true;
			}
		}
	
		// Validate confirm password matched on blur if the input is not empty
		$('#pwdRepeatInput').on('blur', function() {
			if ($(this).val() !== '') {
				checkMatchedPwd(this.value);
			}
		});
	
		// Data validation for confirm password - must matched the password field
		function checkMatchedPwd(str) {
			if (str !== $('#pwdInput').val()) {
				showError('pwdRepeatInput', 'Passwords must match')
				return false;
			} else {
				hideError('pwdRepeatInput');
				return true;
			}
		}
	
		// Data validation onInput
		// When user is typing in the email field and it has invalid input class (means not the first time user made error)
		// Then do validation checking of email on the spot
		$('#emailInput').on('input', function() {
			if ($(this).hasClass('invalid-input')) {
				$(this).on('input', function() {
					if ($(this).val() !== '') {
						validateEmail($(this).val());
					}
				});
			}
		});
	
		// When user is typing in the password field
		$('#pwdInput').on('input', function() {
			// If it has invalid input class (means not the first time user made error)
			// Then do validation checking of min length on the spot
			if ($(this).hasClass('invalid-input')) {
				$(this).on('input', function() {
					if ($(this).val() !== '') {
						checkPwdLength($(this).val());
					}
				});
			}
	
			// If the confirm password field is not empty
			// Then on the spot compare the password value with the confirm password fields whether is the same or not
			if ($('#pwdRepeatInput').val() !== '') {
				checkMatchedPwd($('#pwdRepeatInput').val());
			}
		});
	
		// When user is typing in the confirm password field and it has invalid input class (means not the first time user made error)
		// Then do validation checking of matching password on the spot
		$('#pwdRepeatInput').on('input', function() {
			if ($(this).hasClass('invalid-input')) {
				$(this).on('input', function() {
					if ($(this).val() != '') {
						checkMatchedPwd($(this).val());
					}
				});
			}
		});
	
		// Data validation onSubmit
		$('#user-registration').submit(function(e) {
			e.preventDefault(); // Prevent the form to submit
			validateEmptyRequired();

			var totalError = 0;
			var element, invalid;

			// Loop through all input fields to find out the input with invalid input
			$("#user-registration input, #user-registration select").not(
					":hidden").each(function() {
				element = $("#" + $(this).attr("id"));
				invalid = element.hasClass('invalid-input');
				if (invalid) {
					totalError++;
				}
			});

			// If there is at least one invalid input
			if (totalError !== 0) {
				e.preventDefault(); // Prevent the form to submit
			} else {
				this.submit();
			}
		});
	
		// Function to show error message and change border bottom colour to red
		function showError(selector, msg) {
			$('#error-' + selector).html(msg);
			$('#' + selector).addClass('invalid-input');
			$('#' + selector).removeClass('valid-input');
		}
	
		// Function to hide error message and change border bottom colour to green
		function hideError(selector) {
			$('#error-' + selector).html('');
			$('#' + selector).addClass('valid-input');
			$('#' + selector).removeClass('invalid-input');
		}
	</script>
</html>