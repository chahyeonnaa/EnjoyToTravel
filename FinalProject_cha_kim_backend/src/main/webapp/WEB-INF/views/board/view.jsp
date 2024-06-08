<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<c:if test="${article ne null}">
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- 부트스트랩 CDN -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" />
	<!-- 부트스트랩 아이콘 CDN -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" />
	<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="${root}/assets/css/view.css" />	
		
	<title>EnjoyTrip</title>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-md-10 col-sm-12">
				<h2 class="my-3 py-3 shadow-sm bg-light text-center">
					<mark class="sky">글보기</mark>
				</h2>
			</div>
			<div class="col-lg-8 col-md-10 col-sm-12">
				<div class="row my-2">
					<h2 class="text-secondary px-5">${article.articleNo}. ${article.subject}</h2>
				</div>
				<div class="row">
					<div class="col-md-8">
						<div class="clearfix align-content-center">
							<img src="${userInfo.imgUrl}" width="40" height="40" class="rounded-circle mr-3">
							<p>
								<span class="fw-bold">${article.writer}</span> 
								<br /> 
								<span class="text-secondary fw-light"> 
									${article.registerTime} 조회 : ${article.hit} 
								</span>
							</p>
						</div>
					</div>
					<div class="divider mb-3"></div>
					<div class="text-secondary">${article.content}</div>
					<div class="divider mt-3 mb-3"></div>
					<div class="d-flex justify-content-end">
						<button type="button" id="btn-list" class="btn btn-outline-primary mb-3">
							글목록
						</button>
						<button type="button" id="btn-mv-modify" class="btn btn-outline-success mb-3 ms-1">
							글수정
						</button>
						<button type="button" id="btn-delete" class="btn btn-outline-danger mb-3 ms-1">
							글삭제
						</button>
					</div>
				</div>
			</div>

			<section class="comments-section my-5">
                    <!-- Comments Section -->
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Comments</h5>
                                </div>
                                <div class="card-body">
                                    <!-- 댓글 Form -->
                                    <form action="${root}/comment?action=addComment" method="post" class="mb-3">
                                        <input type="hidden" name="boardId" value="${article.articleNo}">
                                        <div class="mb-3">
                                            <input type="text" name="content" class="form-control" placeholder="댓글을 작성해주세요">
                                        </div>
                                        <button type="submit" class="btn btn-primary">댓글 작성</button>
                                    </form>
                                    <!-- 댓글 Form 끝 -->

                                    <!-- 댓글 -->
                                    <c:forEach var="comment" items="${comments}">
                                        <div class="comment">
                                            <!-- 댓글 사용자 정보 -->
                                            <div class="comment-user-info d-flex align-items-center mb-2">
                                                <img src="${comment.userImgUrl}" class="rounded-circle me-2" alt="User Avatar" width="40">
                                                <span class="comment-userNickName fw-bold me-2">${comment.userNickName}</span>
                                                <span class="comment-date text-muted">${comment.createdAt}</span>
                                            </div>
                                            <!-- 댓글 정보 -->
                                            <div class="comment-content mb-2">${comment.content}</div>
                                            <!-- 대댓글 Button -->
                                            <div class="comment-actions">
                                                <button class="btn btn-link reply-btn" onclick="toggleReplyForm(${comment.commentId})">답글</button>
                                                <c:if test="${comment.userId eq userInfo.userId}">
                                                    <form action="${root}/comment?action=deleteComment" method="post" class="d-inline">
                                                        <input type="hidden" name="boardId" value="${article.articleNo}">
                                                        <input type="hidden" name="commentId" value="${comment.commentId}">
                                                        <button class="btn btn-link delete-btn">삭제</button>
                                                    </form>
                                                </c:if>
                                            </div>
                                            <!-- 대댓글 Form -->
                                            <div id="replyForm-${comment.commentId}" class="reply-form mt-2" style="display: none;">
                                                <form action="${root}/comment?action=replyComment" method="post">
                                                    <input type="hidden" name="boardId" value="${article.articleNo}">
                                                    <input type="hidden" name="parentCommentId" value="${comment.commentId}">
                                                    <div class="mb-3">
                                                        <input type="text" name="content" class="form-control" placeholder="답글을 작성해주세요">
                                                    </div>
                                                    <button type="submit" class="btn btn-primary">답변 작성</button>
                                                </form>
                                            </div>
                                            <!-- 대댓글 Form 끝 -->

											<!-- 대댓글 보기 -->
											<div class="d-flex flex-row user-feed mt-2">
											    <c:if test="${comment.replyCnt ne 0}">
											        <button class="ml-3 toggle-replies btn btn-link" onclick="toggleReplyList(${comment.commentId})">답글 ${comment.replyCnt}개</button>
											    </c:if>
											</div>
                                            <!-- 대댓글 리스트 -->
                                            <div id="replyList-${comment.commentId}" class="reply-list mt-3" style="display: none;">
                                                <c:forEach var="reply" items="${comment.replies}">
                                                    <div class="reply">
                                                        <div class="reply-user-info d-flex align-items-center mb-2">
                                                            <img src="${reply.userImgUrl}" class="rounded-circle me-2" alt="User Avatar" width="40">
                                                            <span class="reply-userNickName fw-bold me-2">${reply.userNickName}</span>
                                                            <span class="reply-date text-muted">${reply.createdAt}</span>
                                                        </div>
                                                        <div class="reply-content">${reply.content}</div>
                                                        <div class="reply-actions">
                                                            <c:if test="${reply.userId eq userInfo.userId}">
                                                                <form action="${root}/comment?action=deleteComment" method="post" class="d-inline">
                                                                    <input type="hidden" name="boardId" value="${article.articleNo}">
                                                                    <input type="hidden" name="commentId" value="${reply.commentId}">
                                                                    <button class="btn btn-link delete-btn">삭제</button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <!-- End Reply List -->
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
			
		</div>
	</div>

	<script>
		// 답글 폼 보이기/숨기기
		function toggleReplyForm(commentId) {
			var form = document.getElementById('replyForm-' + commentId);
			form.style.display = form.style.display === 'none' ? 'block' : 'none';

			var list = document.getElementById('replyList-' + commentId);
			list.style.display = 'none'; // 다른 댓글의 목록이 열려있을 경우 닫기
		}

		// 답글 목록 보이기/숨기기
		function toggleReplyList(commentId) {
			var list = document.getElementById('replyList-' + commentId);
			list.style.display = list.style.display === 'none' ? 'block' : 'none';

			var form = document.getElementById('replyForm-' + commentId);
			form.style.display = 'none'; // 다른 댓글의 폼이 열려있을 경우 닫기
		}
		
		document
			.querySelector("#btn-list")
			.addEventListener(
				"click",
				function() {
					location.href = "${root}/article/list";
				});
		document
			.querySelector("#btn-mv-modify")
			.addEventListener(
				"click",
				function() {
					location.href = "${root}/article/mvmodify/${article.articleNo}";
					/* "${root}/article?action=mvmodify&articleNo=${article.articleNo}&pgno=${param.pgno}&key=${param.key}&word=${param.word}" */
				});
		document
			.querySelector("#btn-delete")
			.addEventListener(
				"click",
				function() {
					location.href = "${root}/article/delete/${article.articleNo}";
				});
	</script>
</body>
</html>
</c:if>

<c:if test="${article eq null}">
	<script>
		alert("글이 삭제되었거나 부적절한 URL 접근입니다.");
		location.href = "${root}/article?action=list";
	</script>
</c:if>
