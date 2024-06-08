<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<!-- 부트스트랩 CDN -->
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
	<!-- 부트스트랩 아이콘 CDN -->
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" />
	
	<script defer
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
	<title>EnjoyTrip</title>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-md-10 col-sm-12">
				<h2 class="my-3 py-3 shadow-sm bg-light text-center">
					<mark class="sky">글목록</mark>
				</h2>
			</div>
			<div class="col-lg-8 col-md-10 col-sm-12">
				<div class="row align-self-center mb-2">
					<div class="col-md-2 text-start">
						<button type="button" id="btn-mv-register"
							class="btn btn-outline-primary btn-sm">글쓰기</button>
					</div>
					<div class="col-md-7 offset-3">
						<form id="form-search" class="d-flex">
							<input type="hidden" name="action" value="list"/>
							<input type="hidden" name="pgno" value="1"/>
							<select id="key" name="key"
								class="form-select form-select-sm ms-5 me-1 w-50"
								aria-label="검색조건">
								<option selected>검색조건</option>
								<option value="article_no">글번호</option>
								<option value="subject">제목</option>
								<option value="writer">작성자</option>
							</select>
							<div class="input-group input-group-sm">
								<input id="word" name="word" type="text" class="form-control"
									placeholder="검색어..." />
								<button id="btn-search" class="btn btn-dark" type="button">검색</button>
							</div>
						</form>
					</div>
				</div>
				<table class="table table-hover">
					<thead>
						<tr class="text-center">
							<th scope="col">글번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">조회수</th>
							<th scope="col">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${articles}">
							<tr class="text-center" id="board-row" data-no="${article.articleNo}" style="cursor: pointer">
								<th scope="row">${article.articleNo}</th>
								<td class="text-start">
									<span class="article-title link-dark" style="text-decoration: none">
										${article.subject} 
									</span>
								</td>
								<td>${article.writer}</td>
								<td>${article.hit}</td>
								<td>${article.registerTime}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="row">
				${navigation.navigator}
			</div>
		</div>
	</div>

	<form id="form-param" method="get" action="">
		<input type="hidden" id="p-action" name="action" value=""> 
		<input type="hidden" id="p-pgno" name="pgno" value=""> 
		<input type="hidden" id="p-key" name="key" value=""> 
		<input type="hidden" id="p-word" name="word" value="">
	</form>
	
	<script>
		let titles = document.querySelectorAll("#board-row");
		titles.forEach(function(title) {
			title.addEventListener("click", function() {
				console.log(this.getAttribute("data-no"));
				location.href = "${root}/article/view/"
						+ this.getAttribute("data-no");
			});
		});

 		document.querySelector("#btn-search").addEventListener("click",
				function() {
					// TODO : 검색 구현
					let form = document.querySelector("#form-search");
					form.setAttribute("action", "${root}/article/list");
					form.submit();
				}); 

		let pages = document.querySelectorAll(".page-link");
		pages.forEach(function(page) {
			page.addEventListener("click", function() {
				document.querySelector("#p-action").value = "list";
				document.querySelector("#p-pgno").value = this.parentNode.getAttribute("data-pg");
				document.querySelector("#p-key").value = "${param.key}";
				document.querySelector("#p-word").value = "${param.word}";
				document.querySelector("#form-param").submit();
			});
		});

		document.querySelector("#btn-mv-register").addEventListener("click",
				function() {
					location.href = "${root}/article/write";
				});
	</script>
</body>
</html>
