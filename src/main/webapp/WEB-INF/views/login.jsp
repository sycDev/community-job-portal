<%@ page contentType="text/html; charset=ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<%-- Get context root --%>
		<c:url var="contextRoot" value="/" />
		<link rel="icon" href="${contextRoot}images/abcjobs-logo-only.png">
		
		<!-- Bootstrap 5 -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
		
		<!-- Bootstrap Icons -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
		
		<!-- Custom Style-->
		<link rel="stylesheet" href="${contextRoot}css/common-style.css">
		<link rel="stylesheet" href="${contextRoot}css/form-style.css">
		
		<style>
			/* Media Queries */
			/* For Laptops and Desktops */
			@media screen and (min-width: 1024px) {
				/* Desktop Login Page */
				body {
					background-image: url("${contextRoot}images/login-bg.png");
				}
			}
		</style>
		
		<title>Login</title>
	</head>
	
	<body>
		<div class="container-fluid">
			<div class="d-flex justify-content-center align-items-center">
				<div class="text-center form-header">
					<c:url value="/" var="indexUrl" />
					<a class="my-2" href="${indexUrl}">
						<img src="${contextRoot}images/abcjobs-logo.png" alt="ABC Jobs Logo" width="198" height="54">
					</a>
					<h2 class="mt-4">Login</h2>
					<p>
						Don't have an account? <a href="${contextRoot}showRegister">Register</a>
					</p>
				</div>
			</div>
		</div>
	
		<div class="form d-flex">
			<div class="container">
				<form:form class="mb-5 h-100" action="login" method="post">
					<!--  Display the invalid login message Start -->
					<c:if test="${param.error != null}">
						<div class="input-group">
							<div class="alert alert-danger w-100">
								<div class="d-flex align-items-center">
									<div class="me-3">
										<i class="bi bi-exclamation-circle-fill me-2 align-middle" style="font-size: 20px;"></i>
									</div>
									<div class="d-flex justify-content-between w-100">
										Invalid email or password
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<!--  Display the invalid login message End -->

					<!--  Display the session expired message Start -->
					<c:if test="${param.expired != null}">
						<div class="input-group">
							<div class="alert alert-warning w-100">
								<div class="d-flex align-items-center">
									<div class="me-3">
										<i class="bi bi-exclamation-triangle-fill me-2 align-middle" style="font-size: 20px;"></i>
									</div>
									<div class="d-flex justify-content-between w-100">
										Expired session, please login again
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<!--  Display the session expired message End -->

					<!--  Display the success logout message Start -->
					<c:if test="${param.logout != null}">
						<div class="input-group">
							<div class="alert alert-success w-100">
								<div class="d-flex align-items-center">
									<div class="me-3">
										<i class="bi bi-check-circle-fill me-2 align-middle" style="font-size: 20px;"></i>
									</div>
									<div class="d-flex justify-content-between w-100">
										You are successfully logged out!
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<!--  Display the success logout message End -->

					<div class="input-group">
						<input type="email" class="form-control" name="email" id="emailInput" placeholder="Email">
					</div>
					<div class="error">
						<p id="error-emailInput"></p>
					</div>
	
					<div class="input-group">
						<input type="password" class="form-control" name="password" id="pwdInput" placeholder="Password">
						<i class="bi bi-eye" id="eyeToggle"></i>
					</div>
					<div class="error">
						<p id="error-pwdInput"></p>
					</div>
	
					<div class="m-auto" id="btnLink">
						<div class="text-end m-auto">
							<a href="${contextRoot}showForgotPassword">Forgot your password?</a>
						</div>
						<button type="submit" class="btn btn-lg btn-warning mt-3 w-100" name="Login" id="btnSubmit">Login</button>
					</div>
				</form:form>
			</div>
		</div>
	</body>
	
	<!-- Bootstrap 5 JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
	
	<script>
		let pwdInput = document.getElementById('pwdInput');
	
		// Function to toggle password visibility for password field
		function togglePwdVisible() {
			if (pwdInput.type === 'password') {
				// When the password is hidden, show the password
				pwdInput.type = 'text';
			} else {
				// When the password is visible, hide the password
				pwdInput.type = 'password';
			}
		}
	
		// Toggle password visibility when user click on the eye icon of password fields
		$('#pwdInput + #eyeToggle').on('click', function() {
			// Change the eye icon to eye with slash icon
			$(this).toggleClass('bi-eye').toggleClass('bi-eye-slash');
			togglePwdVisible();
		});
	
		// Data validation onBlur

		// Checking for empty input field after blur the field
		// Change the bottom border color of the input that is empty
		$('form input').blur(function(e) {
			if (!$(this).val()) {
				e.preventDefault(); // Prevent the form to submit
				$(this).addClass('invalid-input');
				$(this).removeClass('valid-input');
				$('#error-' + ($(this).attr('id'))).html(
						'Please fill out this field');
			} else {
				$(this).addClass('valid-input');
				$(this).removeClass('invalid-input');
				$('#error-' + ($(this).attr('id'))).html('');
			}
		});
	
		// Validate email on blur if the input is not empty
		$('#emailInput').on('blur', function() {
			if ($(this).val() !== '') {
				validateEmail(this.value);
			}
		});
	
		/*
		 *  Input validation of email address
		 *  - must contain @ and dot
		 *  - at least two characters after the dot
		 *  - cannot start or end with a dot or a @
		 *  - should not contain spaces into the string
		 *  - should not contain special chars (<:, *,ecc)
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
		$('#pwdInput').on('input', function() {
			if (!$(this).val()) {
				showError('pwdInput', 'Please fill out this field');
			} else {
				hideError('pwdInput');
			}
		});
	
		// Data validation onInput
		// When user is typing in the email field, and it has invalid input class (means not the first time user made error)
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
	
		// Data validation onSubmit
		$('#user-login').submit(function(e) {
			e.preventDefault(); // Prevent the form to submit
			var formData = $("#user-login").serializeArray();
			var totalError = 0;
			var element, valid;
	
			// Loop through all input fields to find out the input with invalid input
			for ( let input in formData) {
				element = $("#" + formData[input]['name']);
				valid = element.hasClass('valid-input');
				if (!valid) {
					totalError++;
				}
			}

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