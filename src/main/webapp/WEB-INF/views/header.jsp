<sec:authorize access="!isAuthenticated()">
	<!-- Top Navigation Bar Start -->
	<nav class="navbar sticky-top bg-body-tertiary" id="navbar">
		<div class="container-fluid">
			<a class="navbar-brand my-2 hidden-mobile" href=".">
				<img src="${contextRoot}images/abcjobs-logo.png" alt="ABC Jobs Logo" width="198" height="54">
			</a>
			<a class="navbar-brand my-2 mobile-only" href=".">
				<img src="${contextRoot}images/abcjobs-logo-only.png" alt="ABC Jobs Logo" width="60" height="54">
			</a>
			<div>
				<a href="${contextRoot}showLogin" class="btn btn-outline-warning" id="btn-login">Login</a>
				<a href="${contextRoot}showRegister" class="btn btn-outline-warning" id="btn-register">Register</a>
			</div>
		</div>
	</nav>
	<!-- Top Navigation Bar End -->
</sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authorize access="hasRole('SOFTWARE_PROGRAMMER')">
		<!-- Software Programmer Top Navigation Bar Start -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light" id="home-nav">
			<div class="container-fluid justify-content-between">
				<!-- Left Section Start -->
				<div class="d-flex ms-3 ms-lg-5">
					<!-- Logo Start -->
					<a class="navbar-brand my-2 hidden-mobile" href="${contextRoot}home">
						<img src="${contextRoot}images/abcjobs-logo.png" alt="ABC Jobs Logo" width="164" height="45">
					</a>

					<a class="navbar-brand my-2 mobile-only" href="${contextRoot}home">
						<img src="${contextRoot}images/abcjobs-logo-only.png" alt="ABC Jobs Logo" width="50" height="45">
					</a>
					<!-- Logo End -->
					<!-- Search Form Start -->
					<form:form class="input-group w-auto my-auto d-none d-sm-flex" id="search-user-form" action="${contextRoot}search" method="get">
						<input autocomplete="off" id="searchInput" name="q" type="search" class="form-control rounded" placeholder="Search" style="min-width: 125px;">
						<span class="input-group-text border-0 d-none d-lg-flex">
					<label for="searchIcon">
						<i class="fas fa-search"></i>
					</label>
					<input class="d-none" type="submit" id="searchIcon">
				</span>
					</form:form>
					<!-- Search Form End -->
				</div>
				<!-- Left Section End -->

				<!-- Right Section Start -->
				<ul class="navbar-nav flex-row">
					<li class="nav-item me-3 me-lg-1 me-md-1 me-sm-1 my-auto active hidden-mobile">
						<a class="nav-link" href="${contextRoot}home">
							<span> Home </span>
						</a>
					</li>

					<!-- For mobile navbar -->
					<li class="nav-item me-3 me-lg-1 my-auto active">
						<form:form class="input-group w-auto my-auto d-flex d-sm-none" action="${contextRoot}search" method="get">
							<a class="dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLinkSPMobile" role="button" data-mdb-toggle="dropdown" aria-expanded="false" style="color: grey">
								<i class="fas fa-search"></i>
							</a>
							<ul class="dropdown-menu dropdown-menu-left" aria-labelledby="navbarDropdownMenuLinkSPMobile">
								<li>
									<div class="input-group mt-2 mx-2">
										<div class="form-outline w-auto">
											<input type="search" id="searchInputMobile" name="q" class="form-control-dropdown">
											<label class="form-label" for="searchInputMobile"></label>
										</div>
									</div>
								</li>
							</ul>
						</form:form>
					</li>

					<li class="nav-item me-3 me-lg-1 my-auto">
						<a class="nav-link" href="#">
					<span>
						<i class="fas fa-briefcase fa-lg"></i>
					</span>
						</a>
					</li>

					<li class="nav-item me-3 me-lg-1 my-auto">
						<a class="nav-link" href="#">
							<i class="fas fa-comments fa-lg"></i>
							<!-- <span class="badge rounded-pill badge-notification bg-danger">6</span> -->
						</a>
					</li>

					<li class="nav-item dropdown me-3 me-lg-5 me-sm-4">
						<a class="nav-link dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLinkSP" role="button" data-mdb-toggle="dropdown" aria-expanded="false">
							<img src="${contextRoot}images/default-profile-pic.png" alt="User Profile Picture" class="rounded-circle" height="35">
							<i class="fas fa-caret-down"></i>
						</a>

						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLinkSP">
							<li>
								<a class="dropdown-item" href="${contextRoot}viewProfile">View Profile</a>
							</li>
							<li>
								<form:form action="${contextRoot}logout" method="post">
									<button class="dropdown-item" type="submit">Log out</button>
								</form:form>
							</li>
						</ul>
					</li>
				</ul>
				<!-- Right Section End -->
			</div>
		</nav>
		<!-- Software Programmer Top Navigation Bar End -->
	</sec:authorize>

	<sec:authorize access="hasRole('ADMINISTRATOR')">
		<!-- Administrator Top Navigation Bar Start -->
		<nav class="navbar navbar-expand-lg navbar-light bg-light" id="home-nav">
			<div class="container-fluid justify-content-between">
				<!-- Left Section Start -->
				<div class="d-flex ms-3 ms-lg-5">
					<!-- Logo Start -->
					<a class="navbar-brand my-2 hidden-mobile" href="${contextRoot}admin/">
						<img src="${contextRoot}images/abcjobs-logo.png" alt="ABC Jobs Logo" width="164" height="45">
					</a>
					<a class="navbar-brand my-2 mobile-only" href="${contextRoot}admin/">
						<img src="${contextRoot}images/abcjobs-logo-only.png" alt="ABC Jobs Logo" width="50" height="45">
					</a>
					<!-- Logo End -->
				</div>
				<!-- Left Section End -->

				<!-- Right Section Start -->
				<ul class="navbar-nav flex-row">
					<li class="nav-item me-3 me-lg-1 me-sm-3 my-auto active hidden-mobile">
						<a class="nav-link" href="${contextRoot}admin/">
							<span>
								Home
							</span>
						</a>
					</li>

					<li class="nav-item me-3 me-lg-1 me-sm-3 my-auto active hidden-mobile">
						<a class="nav-link" href="${contextRoot}admin/users">
							<span>
								<i class="fas fa-users" style="font-size: 20px"></i>
							</span>
						</a>
					</li>

					<!-- For mobile navbar -->
					<li class="nav-item dropdown me-3 me-lg-5 me-sm-4">
						<a class="nav-link dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLinkAdminMobile"
						   role="button" data-mdb-toggle="dropdown" aria-expanded="false">
							<img src="${contextRoot}images/default-profile-pic.png" alt="User Profile Picture" class="rounded-circle" height="35">
							<i class="fas fa-caret-down"></i>
						</a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLinkAdminMobile">
							<li>
								<a class="dropdown-item" href="#">Edit Profile</a>
							</li>
							<li>
								<form:form action="${contextRoot}logout" method="post">
									<button class="dropdown-item" type="submit">Log out</button>
								</form:form>
							</li>
						</ul>
					</li>
				</ul>
				<!-- Right Section End -->
			</div>
		</nav>
		<!-- Administrator Top Navigation Bar End -->
	</sec:authorize>
</sec:authorize>