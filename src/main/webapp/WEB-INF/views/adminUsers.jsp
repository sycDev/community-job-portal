<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<%-- Get context root --%>
		<c:url var="contextRoot" value="/" />
		<link rel="icon" href="${contextRoot}images/abcjobs-logo-only.png">
		
		<!-- Font Awesome -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	    
	    <!-- Google Fonts -->
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
	    
	    <!-- MDB -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.css">
	    
	    <!-- Select2 -->
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">
	    
	    <!-- Bootstrap Datepicker -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer">

	    <!-- Custom Style -->
	    <link rel="stylesheet" href="${contextRoot}css/common-style.css">
	    <link rel="stylesheet" href="${contextRoot}css/index-style.css">
		
		<style>
	        .form-check-input[type='checkbox']:checked {
	            background-color: #FB8500;
	            border-color: #FB8500;
	        }

			.form-check-input[type=checkbox]:checked:focus {
				background-color: #FB8500;
			}
	    </style>
		
		<title>Users Data</title>
	</head>
	<body>
		<div class="container-fluid">
			<!-- Header Include -->
			<%@ include file="header.jsp"%>
	
	        <!-- Main Content Start -->
	        <!-- User Data Listing Start -->
	        <h3 class="text-center m-4">User Data</h3>
	        <div class="table-responsive mx-5 mb-5">
	            <table class="table table-striped table-hover align-middle mb-5 bg-white">
	                <thead class="table-light">
	                    <tr>
	                        <th scope="col">
	                            <div class="form-check">
	                                <input class="form-check-input" type="checkbox" id="select-all"/>
	                            </div>
	                        </th>
	                        <th scope="col">ID</th>
	                        <th scope="col">Name</th>
	                        <th scope="col">Date of Birth</th>
	                        <th scope="col">City</th>
	                        <th scope="col">Country</th>
	                        <th scope="col" colspan="2" class="text-center">Actions</th>
	                    </tr>
	                </thead>
	                <tbody>
		                <c:forEach items="${userProfileList}" var="userProfile">
		                	<tr>
		                        <th scope="row">
		                            <div class="form-check">
		                                <input class="form-check-input" type="checkbox" />
		                            </div>
		                        </th>
		                        <td>${userProfile.profileId}</td>
		                        <td>
		                            <div class="d-flex align-items-center">
		                                <img src="${contextRoot}images/default-profile-pic.png" alt="" style="width: 45px; height: 45px" class="rounded-circle" />
		                                <div class="ms-3">
		                                    <p class="fw-bold mb-1">${userProfile.firstName} ${userProfile.lastName} 
		                                    	<span class="text-muted fw-lighter"><c:if test="${not empty userProfile.pronouns}">(${userProfile.pronouns})</c:if></span>
		                                    </p>
		                                    <p class="text-muted mb-0">${userProfile.userAccount.email}</p>
		                                </div>
		                            </div>
		                        </td>
		                        <td><fmt:formatDate value="${userProfile.dateOfBirth}" pattern="yyyy-MM-dd"/></td>
		                        <td>${userProfile.location.city}</td>
		                        <td>${userProfile.location.country}</td>
		                        <td class="p-0 text-center">
		                        	<span data-mdb-toggle="modal" data-mdb-target="#edit-user-modal">
			                            <button type="button" class="btn btn-link btn-sm btn-rounded">
			                                <i class="fa fa-edit" style="color: #FB8500"></i>
			                            </button>
		                            </span>
		                        </td>
		                        <td class="p-0 text-center">
		                        	<span data-mdb-toggle="modal" data-mdb-target="#delete-user-modal">
			                            <button type="button" class="btn btn-link btn-rounded btn-sm fw-bold">
			                                <i class="fa fa-trash" style="color: #FB8500"></i>
			                            </button>
		                            </span>
		                        </td>
		                    </tr>
		                </c:forEach>
	                </tbody>
	            </table>
	        </div>
	        <!-- User Data Listing End -->
	
	        <!-- Edit User Data Form Modal Start -->
	        <div class="modal top fade" id="edit-user-modal" tabindex="-1" aria-labelledby="edit-user-modal-label" aria-hidden="true" data-mdb-backdrop="true" data-mdb-keyboard="true">
	            <div class="modal-dialog modal-xl  modal-dialog-centered">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title" id="edit-user-modal-label">Edit Profile Basic Details</h5>
	                        <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
	                    </div>
	
	                    <form>
	                        <div class="modal-body">
	                            <div class="form-group mb-2">
	                                <label for="editFirstNameInput" class="col-form-label">First Name *</label>
	                                <input type="text" class="form-control" id="editFirstNameInput" maxlength="100" required="required" name="firstName" value="">
	                            </div>
	                            <div class="form-group mb-2">
	                                <label for="editLastNameInput" class="col-form-label">Last Name</label>
	                                <input type="text" class="form-control" id="editLastNameInput" maxlength="100" name="lastName" value="">
	                            </div>
	                            <div class="form-group mb-2">
	                                <label for="editPronounsSelect" class="col-form-label">Pronouns</label>
	                                <select class="form-control" id="editPronounsSelect" name="pronouns">
	                                    <option value="1">He/him</option>
	                                    <option>She/her</option>
	                                    <option>They/them</option>
	                                </select>
	                            </div>
	                            <div class="row">
	                                <label class="col-form-label">Location *</label>
	                                <div class="col-md-6 col-sm-6">
	                                    <div class="form-group mb-2">
	                                        <select class="form-control" id="editProfileCountrySelect" required="required" name="country">
	                                            <option value="1">Malaysia</option>
	                                            <option>United States </option>
	                                        </select>
	                                    </div>
	                                </div>
	                                <div class="col-md-6 col-sm-6">
	                                    <div class="form-group mb-2">
	                                        <select class="form-control" id="editProfileCitySelect" name="city">
	                                            <option value="1">Kuala Lumpur</option>
	                                            <option>New York</option>
	                                            <option>Miami</option>
	                                        </select>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group mb-2">
	                                <label for="editDobInput" class="col-form-label p-0">Date of Birth</label>
	                                <!-- <div class="col-5"> -->
	                                <div class="input-group date datepicker">
	                                    <input type="date" class="form-control" id="editDobInput" name="dateOfBirth" value="">
	                                </div>
	                                <!-- </div> -->
	                            </div>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="button" class="btn btn-secondary" data-mdb-dismiss="modal" style="color:#FB8500; background-color: transparent;">Cancel</button>
	                            <button type="submit" class="btn btn-primary" style="background-color: #FB8500;">Save Changes</button>
	                        </div>
	                    </form>
	                </div>
	            </div>
	        </div>
	        <!-- Edit User Data Form Modal End -->
	
	        <!-- Delete User Confirmation Modal End -->
	        <div class="modal fade" id="delete-user-modal" tabindex="-1" aria-labelledby="delete-user-modal-label" aria-hidden="true">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title" id="delete-user-modal-label">Delete this user</h5>
	                        <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
	                    </div>
	                    <div class="modal-body">
	                        This record will be permanently deleted and cannot be recovered. Are you sure?
	                    </div>
	                    <div class="modal-footer">
	                        <button type="button" class="btn btn-secondary" data-mdb-dismiss="modal" style="color:#818181; background-color: transparent;">Cancel</button>
	                        <button type="button" class="btn btn-danger">Delete</button>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <!-- Delete User Confirmation Modal End -->
	    </div>
	</body>
	
	<!-- MDB JS -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.2.0/mdb.min.js"></script>
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.3.js" integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script>
	
	<!-- Select2 JS -->
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
	
	<!-- Bootstrap Datepicker -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

	<script>
		$('#select-all').click(function() {
			$('tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
		});

		$('tbody input[type="checkbox"]').click(function() {
			if (!$(this).prop('checked')) {
				$('#select-all').prop('checked', false);
			}
		});
	</script>
</html>