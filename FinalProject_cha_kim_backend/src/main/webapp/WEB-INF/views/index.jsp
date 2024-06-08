<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	    
	<%@ taglib prefix="c" uri="jakarta.tags.core" %>
	<c:set var="root" value="${pageContext.request.contextPath}" />
	<!DOCTYPE html>
	<html lang="ko">
	  <head>
	    <meta charset="utf-8" />
	    <title>EnjoyTrip</title>
	    <link rel="stylesheet" href="${root}/assets/css/styles.css" />
	    <link
	      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	      rel="stylesheet"
	      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous"
    />

    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css"
    />

    <script
      defer
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"
    ></script>
    <script defer src="${root}/assets/js/index.js"></script>
  </head>
  <body>
    <!-- 상단 navbar start -->
    <nav class="navbar navbar-expand-lg fixed-top">
      <div class="container text-white">
        <a class="navbar-brand text-white fw-bold" href="${root}"> EnjoyTrip </a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-lg-0">
            <li class="nav-item"></li>
          </ul>
          <!-- 로그인 전 -->
          <c:if test="${empty userInfo}">
          <ul
            id="navbar-login"
            class="navbar-nav mb-2 me-2 mb-lg-0"
            style="display: flex; align-items: center"
          >
            <li class="nav-item">
              <a class="nav-link text-white" aria-current="page" href="${root}/user/mvlogin">
              	로그인
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" aria-current="page" href="${root}/user/mvsignUp">
              	회원가입
              </a>
            </li>
          </ul>
          </c:if>
          <!-- 로그인 후 -->
          <c:if test="${not empty userInfo}">
          <ul
            id="navbar-logout"
            class="navbar-nav mb-2 me-2 mb-lg-0"
            style="display: flex; align-items: center"
          >
            <li class="nav-item">
              <a class="nav-link text-white" aria-current="page" href="${root}/trip/mvTrip">관광지</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" aria-current="page" href="#">여행계획</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" aria-current="page" href="${root}/article/list">게시판</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white" aria-current="page" href="${root}/feed/list">피드</a>
            </li>
            <li class="nav-item dropdown">
              <img
                class="nav-link dropdown-toggle"
                style="width: 3rem; margin: auto"
                src="${userInfo.imgUrl}"
                id="navbarDropdown"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
              />
              <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item" href="${root}/user/mvmyPage">마이페이지</a></li>
                <li id="logout-button"><a class="dropdown-item" href="${root}/user/logout">로그아웃</a></li>
              </ul>
            </li>
          </ul>
          </c:if>
        </div>
      </div>
    </nav>
    <!-- 상단 navbar end -->

    <div class="jb-box">
      <video muted autoplay loop>
        <source src="${root}/assets/img/비행기.mov" type="video/mp4" />
        <strong>Your browser does not support the video tag.</strong>
      </video>
      <div class="jb-text fw-bold" style="margin-bottom: 200px">
        <p id="typing-text1"></p>
        <p id="typing-text2"></p>
      </div>
    </div>
    <script>
	 	// 로그아웃 버튼 클릭 시 처리
	    const logoutButton = document.querySelector("#logout-button");
	    logoutButton.addEventListener("click", () => {
	      window.location.href="${root}/user?action=logout";
	    });
    </script>
  </body>
</html>
