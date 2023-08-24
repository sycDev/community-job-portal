<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
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
		<link rel="stylesheet" href="${contextRoot}css/form-style.css">

		<title>Error</title>
	</head>
	<body>
	    <div class="container-fluid">
	        <div class="text-center">
	            <img class="d-block mx-auto" src="${contextRoot}images/error-404.png" alt="Error" width="320">
	            <h3>${errMsg}</h3>
	            <div class="form mb-5">
					<sec:authorize access="isAnonymous()">
						<a class="btn btn-lg btn-warning mt-3" id="btnSubmit" href="${contextRoot}">Back to Home</a>
					</sec:authorize>
					<sec:authorize access="hasRole('SOFTWARE_PROGRAMMER')">
						<a class="btn btn-lg btn-warning mt-3" id="btnSubmit" href="${contextRoot}home">Back to Home</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ADMINISTRATOR')">
						<a class="btn btn-lg btn-warning mt-3" id="btnSubmit" href="${contextRoot}admin/">Back to Home</a>
					</sec:authorize>
	            </div>
	        </div>
	    </div>
	</body>
	
	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</html>
