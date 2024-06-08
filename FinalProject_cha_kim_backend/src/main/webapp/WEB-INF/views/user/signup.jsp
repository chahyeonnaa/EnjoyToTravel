<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" />
    <title>EnjoyTrip - 회원가입</title>
    
    <style>
    .navbar {
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000; /* 폼보다 위에 나타나도록 z-index 값 조정 */
    }

    body {
        padding-top: 70px; /* 네비게이션 바의 높이만큼 body의 padding-top 설정 */
    }
</style>
</head>
<body>
	<!-- 상단 navbar start -->
	<div
		class="navbar navbar-expand-lg navbar-light bg-light shadow fixed-top">
		<div class="container">
			<a class="navbar-brand fw-bold" href="${root}/index.jsp"> EnjoyTrip </a>
		</div>
	</div>
	<!-- 상단 navbar end -->
    <form id="join_frm" method="post">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card mt-5">
                        <div class="card-body">
                            <h2 class="card-title text-center">회원가입</h2>
                            <div class="form-group">
                                <label for="name">이름</label>
                                <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요" />
                            </div>
                            <div class="form-group">
                                <label for="id">아이디</label>
                                <input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요" />
                                <span id="idCk" class="text-danger"></span>
                            </div>
                            <div class="form-group">
                                <label for="password">비밀번호</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" />
                            </div>
                            <div class="form-group">
                                <label for="confirm-password">비밀번호 확인</label>
                                <input type="password" class="form-control" id="passwordCk" name="password" placeholder="비밀번호를 다시 입력하세요" />
                            </div>
                            <div class="form-group">
                                <label for="nickName">닉네임</label>
                                <input type="text" class="form-control" id="nickName" name="nickName" placeholder="닉네임을 입력하세요" />
                                <span id="nickNameCk" class="text-danger"></span>
                            </div>
                            <div class="form-group">
                                <label for="email">이메일</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" />
                                	<span id="emailCk" class="text-danger"></span>
                                </div>
                                <div class="input-group">
                                    <button type="button" id="emailAuthBtn" class="btn btn-secondary">인증 번호 받기</button>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="text" id="emailAuthKey" class="form-control" placeholder="인증번호 입력">
                            </div>
                            <div class="form-group">
                                <label for="imgUrl">프로필 이미지 URL</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="imgUrl" name="imgUrl" placeholder="이미지 URL을 입력하세요" />
                                </div>
                            </div>
                            <button id="signUp" type="button" class="btn btn-primary btn-block">회원가입</button>
                            <div class="text-center mt-3">
                                이미 계정이 있으신가요? <a href="${root}/user/mvlogin">로그인</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
<script src="${root}/assets/js/signup.js"></script>
