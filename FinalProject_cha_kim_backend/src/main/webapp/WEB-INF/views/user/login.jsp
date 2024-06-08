<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<title>로그인 페이지</title>
	<link rel="stylesheet" href="../css/styles.css" />
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
		rel="stylesheet" />
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" />
	<link rel="stylesheet" href="${root}/assets/css/login.css" />
</head>
<body>
	<!-- 상단 navbar start -->
	<nav
		class="navbar navbar-expand-lg navbar-light bg-light shadow fixed-top">
		<div class="container">
			<a class="navbar-brand fw-bold" href="${root}/index.jsp"> EnjoyTrip </a>
		</div>
	</nav>
	<!-- 상단 navbar end -->

	<form id="form-login" action="${root}/user/login" method="post">
		<div class="login-container">
			<div class="login-title">로그인</div>
			<div class="form-group">
				<label for="id">아이디</label> <input type="text" class="form-control"
					id="id" name="id" placeholder="아이디를 입력하세요" />
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label> 
				<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" />
			</div>
			<button id="login-btn" class="login-button">로그인</button>

			<div class="register-link">
				계정이 없으신가요? <a href="${root}/user/mvsignUp">회원가입</a>
			</div>
			<div class="register-link">
				비밀번호를 잃어버리셨나요? <a href="${root}/user/mvforgotPassword">비밀번호 재발급</a>
			</div>
		</div>
	</form>
	
	<c:if test="${not empty params.loginFail}">
		<script>
			alert('로그인 실패');
		</script>
	</c:if>
	
	<script>
		// 비밀번호 입력란에서 Enter 키 눌렀을 때 이벤트 핸들러 추가
		document.getElementById("password").addEventListener("keypress", function(event) {
		    if (event.key === "Enter") {
		        let form = document.querySelector("#form-login");
		        form.submit();
		    }
		});
	</script>
</body>
</html>
