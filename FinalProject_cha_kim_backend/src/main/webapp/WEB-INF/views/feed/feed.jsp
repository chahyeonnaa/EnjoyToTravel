<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- 부트스트랩 CDN -->
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
	<!-- 부트스트랩 아이콘 CDN -->
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" />
	<link rel="stylesheet" href="${root}/assets/css/feed.css" />
	<script defer
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<title>EnjoyTrip</title>
</head>
<body>
	<%@ include file="/common/header.jsp"%>

	<div class="container">
		<div class="row justify-content-center mt-5">
			<div class="col-md-6">
				<div class="text-end me-5 mb-5">
					<button type="button" class="btn btn-primary"
						data-bs-toggle="modal" data-bs-target="#addFeedModal">
						Add Feed</button>
				</div>
				<div id="feedContainer">
					<!-- Feeds will be dynamically added here -->
					<c:forEach var="feed" items="${feedList}">
						<div class="card mb-4">
							<c:choose>
							    <c:when test="${not empty feed.imgUrl}">
							        <!-- condition이 true일 때 실행할 코드 -->
							        <img src="${feed.imgUrl}" class="card-img-top" alt="...">
							    </c:when>
							    <c:otherwise>
							        <!-- condition이 false일 때 실행할 코드 -->
							        <img src="${root}/assets/img/noimgs.png" class="card-img-top" alt="...">
							    </c:otherwise>
							</c:choose>
							
							<div class="card-body">
								<h5 class="card-title">${feed.title}</h5>
								<p class="card-text">${feed.content}</p>
								<form method="POST" action="${root}/feed?action=like">
									<input type="hidden" name="feedId" value="${feed.feedId}">
									<button type="submit" class="btn btn-unstyled">
									    <img src="${root}/assets/img/like.png" alt="Like" class="like-btn">
									</button>
																		
									<span class="like-count">${feed.likeCount}</span> 
								</form>
								
								<img src="${root}/assets/img/comment.png" alt="Comment" class="comment-btn" onclick="showComments('${feed.feedId}')"> 
								<span id="comment-count_${feed.feedId}" class="comment-count">0</span>
								<!-- 댓글 수를 나타내는 요소 -->
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="addFeedModal" data-bs-backdrop="false">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Add Feed</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<form id="form-register" method="POST" action="">
					<input type="hidden" name="action" value="addFeed">
					<div class="modal-body">
						<div class="mb-3">
							<input type="text" id="feedTitle" name="title" class="form-control" placeholder="Title" />
						</div>
						<div class="mb-3">
							<textarea id="feedContent" name="content" class="form-control" placeholder="Content" rows="4"></textarea>
						</div>
						<div class="mb-3">
							<input type="text" id="feedImage" name="imgUrl" class="form-control" placeholder="Image URL" />
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btn-register" class="btn btn-primary" onclick="addFeed()">
							Add Feed
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	 <script>
      document.querySelector("#btn-register").addEventListener("click", function () {
        if (!document.querySelector("#feedTitle").value) {
          alert("제목 입력!!");
          return;
        } else if (!document.querySelector("#feedContent").value) {
          alert("내용 입력!!");
          return;
        } else {
          let form = document.querySelector("#form-register");
          form.setAttribute("action", "${root}/feed");
          form.submit();
        }
      });
       	  
    </script>
</body>
</html>
