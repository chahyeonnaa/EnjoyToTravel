<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>비밀번호 찾기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="${root}/assets/css/forgot_password.css" />
</head>
<body>
	<!-- 상단 navbar start -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light shadow">
		<div class="container">
			<a class="navbar-brand fw-bold" href="${root}/index">
				EnjoyTrip </a>
		</div>
	</nav>
	<!-- 상단 navbar end -->


		<div class="container mt-5">
			<h1 class="text-center mb-4">비밀번호 재발급</h1>
			<form id="forgotPasswordForm" 
				action="${root}/user/updatePassword" method="post">
				<div class="mb-3">
					<label for="name" class="form-label">사용자 이름:</label> <input
						type="text" class="form-control" id="name" name="name" />
				</div>
				<div class="mb-3">
					<label for="email" class="form-label">이메일:</label> <input
						type="email" class="form-control" id="email" name="email" />
				</div>
				<button type="submit" class="btn btn-primary" id="findPasswordBtn">
					비밀번호 재발급
				</button>
			</form>
		</div>

	
	<script>
		<c:if test="${not empty notUpdated}">
			alert("회원 정보가 틀렸습니다.");
		</c:if>
	</script>

</body>
</html>
