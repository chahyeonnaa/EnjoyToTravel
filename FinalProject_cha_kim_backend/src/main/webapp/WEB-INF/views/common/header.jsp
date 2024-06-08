<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${root}/assets/css/styles.css" />
<title>EnjoyTrip</title>
</head>
<body>
	<c:if test="${not empty userInfo}">
		<nav class="navbar navbar-expand-lg navbar-light bg-light shadow">
			<div class="container">
				<a class="navbar-brand fw-bold" href="${root}">
					EnjoyTrip </a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-lg-0">
						<li class="nav-item"></li>
					</ul>
					<ul id="navbar-logout" class="navbar-nav mb-2 me-2 mb-lg-0"
						style="display: flex; align-items: center">
						<li class="nav-item">
							<a class="nav-link" aria-current="page" href="${root}/trip/mvTrip">관광지</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" aria-current="page" href="#">여행계획</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" aria-current="page" href="${root}/article/list">게시판</a>
						</li>
						<li class="nav-item">
							<%-- <a class="nav-link" aria-current="page" href="${root}/feed?action=mvFeed">피드</a> --%>
							<a class="nav-link" aria-current="page" href="${root}/feed/list">피드</a>
						</li>
						<li class="nav-item dropdown">
							<img class="nav-link dropdown-toggle" style="width: 3rem; margin: auto" src="${userInfo.imgUrl}" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" />
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="${root}/user/mvmyPage">마이페이지</a></li>
								<li id="logout-button"><a class="dropdown-item" href="#">로그아웃</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</c:if>

	<c:if test="${empty userInfo}">
		<script>
			alert("로그인이 필요한 페이지입니다.");
			location.href = "${root}";
		</script>
	</c:if>

	<script>
	 	// 로그아웃 버튼 클릭 시 처리
	    const logoutButton = document.querySelector("#logout-button");
	    logoutButton.addEventListener("click", () => {
	      window.location.href="${root}/user/logout";
	    });
    </script>
</body>
</html>