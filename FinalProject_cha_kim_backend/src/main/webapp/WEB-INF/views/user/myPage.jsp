<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>마이페이지</title>
<!-- 부트스트랩 CDN -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
<!-- 부트스트랩 아이콘 CDN -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${root}/assets/css/mypage.css" />

<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>

	<div class="container mt-5">
		<!-- 비밀번호 변경 폼 -->
		<div class="card mb-4">
			<div class="card-header">내 정보</div>
			<div class="card-body">
				<div id="userInfo">
					<p>
						<strong>이름:</strong> <span id="name">${userInfo.name}</span>
					</p>
					<p>
						<strong>이메일:</strong> <span id="email">${userInfo.email}</span>
					</p>
					<button class="btn btn-primary" onclick="editUserInfo()">정보 수정</button>
				</div>
				<form id ="updateUser" action="${root}/user/updateUser" method="POST">
					<div id="editUserInfo" style="display: none">
						<input type="hidden" id="userId" name="userId"
							value="${userInfo.userId}" /> <input type="text"
							class="form-control mb-2" id="newName" name="newName"
							placeholder="새 이름" /> <input type="email"
							class="form-control mb-2" id="newEmail" name="newEmail"
							placeholder="새 이메일" />
						<button class="btn btn-success" type="submit">수정</button>
					</div>
				</form>
			</div>
		</div>

		<!-- 회원 탈퇴 버튼 -->
		<form id="deleteUser" action="${root}/user/deleteUser" method="POST">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">회원 탈퇴</h5>
					<p class="card-text">정말로 탈퇴하시겠습니까? 탈퇴하시면 모든 정보가 삭제됩니다.</p>
					<input type="hidden" name="userId" value="${userInfo.userId}" />
					<button class="btn btn-danger" type="submit">회원 탈퇴</button>
				</div>
			</div>
		</form>
	</div>
	<script>
		function editUserInfo() {
			// 사용자 정보 수정 창을 보이게 함
			document.getElementById("userInfo").style.display = "none";
			document.getElementById("editUserInfo").style.display = "block";

			// 현재 사용자 정보를 입력란에 기본값으로 설정
			document.getElementById("newName").value = document
					.getElementById("name").innerText;
			document.getElementById("newEmail").value = document
					.getElementById("email").innerText;
		}

		const updateForm = document.getElementById('updateUser');
		updateForm.addEventListener('submit', function(event) {
		    alert("회원 정보 수정 완료되었습니다");
		});

		const deleteForm = document.getElementById('deleteUser');
		deleteForm.addEventListener('submit', function(event) {
		    alert("회원 탈퇴 완료되었습니다");
		});
		
	</script>
</body>
</html>
