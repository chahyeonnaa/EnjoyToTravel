<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<c:if test="${article ne null}">
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"
    ></script>
    <title>EnjoyTrip</title>
  </head>
  <body>
  	<%@ include file="../common/header.jsp" %>
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">
          <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글수정</mark>
          </h2>
        </div>
        <div class="col-lg-8 col-md-10 col-sm-12">
          <form id="form-modify" method="POST" action="">
          	<input type="hidden" name="action" value="modify">
            <div class="mb-3">
              <label for="subject" class="form-label">제목 : </label>
              <input type="text" class="form-control" id="subject" name="subject" value="${article.subject}" />
            </div>
            <div class="mb-3">
              <label for="content" class="form-label">내용 : </label>
              <textarea class="form-control" name="content" id="content" rows="7">
					${article.content}
              </textarea>
            </div>
            <div class="col-auto text-center">
              <button type="button" id="btn-modify" class="btn btn-outline-primary mb-3">
                글수정
              </button>
              <button type="button" id="bnt-list" class="btn btn-outline-danger mb-3">
                목록으로이동...
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script>
      document.querySelector("#btn-modify").addEventListener("click", function () {
        if (!document.querySelector("#subject").value) {
          alert("제목 입력!!");
          return;
        } 
        else if (!document.querySelector("#content").value) {
          alert("내용 입력!!");
          return;
        } 
        else {
          let form = document.querySelector("#form-modify");
          form.setAttribute("action", "${root}/article/modify/${article.articleNo}");
          form.submit();
        }
      });
      document.querySelector("#btn-list").addEventListener("click", function () {
        location.href = "${root}/article/list";
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
