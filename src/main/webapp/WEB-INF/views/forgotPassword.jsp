<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
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
	    <link rel="stylesheet" href="${contextRoot}css/form-style.css">
		
		<title>Forgot Password</title>
	</head>
	<body>
		<div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>
	
	        <div class="container-fluid">
	            <div class="form d-flex">
	                <div class="container">
	                    <form class="mb-5 h-100" id="user-forgotPwd">
	                        <div class="input-group">
	                            <div class="d-flex justify-content-center align-items-center">
	                                <div class="form-header">
	                                	<div class="text-center">
	                                		<h2 class="mb-4">Forgot Password?</h2>
	                                	</div>
	                                    <p>Enter the email address that associated to your account and we'll send you a link to reset your password</p>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="input-group">
	                            <input type="text" class="form-control" name="emailInput" id="emailInput" placeholder="Email">
	                        </div>
	                        <div class="error">
	                            <p id="error-emailInput"></p>
	                        </div>
	                        <div class="m-auto" id="btnLink">
	                            <button type="submit" class="btn btn-lg btn-warning mt-3 w-100" id="btnSubmit">Send</button>
	                            <div class="text-center m-auto pt-3">
	                                <a href="${contextRoot}showLogin">Back to login</a>
	                            </div>
	                        </div>
	                    </form>
	                </div>
	            </div>
	        </div>
	    </div>
	</body>
	
	<!-- Bootstrap 5 JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
	
	<script>
	    // Data validation onBlur
	    // Checking for empty input field after blur the field
	    // Change the bottom border color of the input that is empty
	    $('form input').blur(function(e) {
	        if (!$(this).val()) {
	            e.preventDefault(); // Prevent the form to submit
	            $(this).addClass('invalid-input');
	            $(this).removeClass('valid-input');
	            $('#error-' + ($(this).attr('id'))).html('Please fill out this field');
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
	
	    // Data validation onSubmit
	    $('#user-forgotPwd').submit(function(e) {
	        e.preventDefault(); // Prevent the form to submit
	        var formData = $("#user-forgotPwd").serializeArray();
	        var totalError = 0;
	        var element, valid;
	
	        // Loop through all input fields to find out the input with invalid input
	        for (let input in formData){
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
	            // do the business logic
	            alert("All inputs are valid. Form will be submitted");
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