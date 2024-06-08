<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Tourist</title>
        <link rel="stylesheet" href="${root }/assets/css/tourist.css" />
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
        <script defer src="${root }/assets/js/tourist2.js"></script>
        <script>
	        executeSearch("${sidoCode}", "${contentTypeId}", "${keyword}");
	    </script>
    </head>
    <body>
        <!-- 상단 navbar start -->
		<%@ include file="/common/header.jsp"%>
        <!-- 상단 navbar end -->

        <div class="container">
            <!-- 관광지 검색 start -->
            <form class="d-flex mt-3" id="search-form" role="search" action="${root}/trip?action=list" method="post">
                <select id="search-area" class="form-select" name="sidoCode" aria-label="Default select example">
                    <option value="0" ${sidoCode eq 0 ? "selected" : ""}>검색 할 지역 선택</option>
                    <option value="1" ${sidoCode eq 1 ? "selected" : ""}>서울</option>
                    <option value="2" ${sidoCode eq 2 ? "selected" : ""}>인천</option>
                    <option value="3" ${sidoCode eq 3 ? "selected" : ""}>대전</option>
                    <option value="4" ${sidoCode eq 4 ? "selected" : ""}>대구</option>
                    <option value="5" ${sidoCode eq 5 ? "selected" : ""}>광주</option>
                    <option value="6" ${sidoCode eq 6 ? "selected" : ""}>부산</option>
                    <option value="7" ${sidoCode eq 7 ? "selected" : ""}>울산</option>
                    <option value="8" ${sidoCode eq 8 ? "selected" : ""}>세종특별자치시</option>
                    <option value="31" ${sidoCode eq 31 ? "selected" : ""}>경기도</option>
                    <option value="32" ${sidoCode eq 32 ? "selected" : ""}>강원도</option>
                    <option value="33" ${sidoCode eq 33 ? "selected" : ""}>충청북도</option>
                    <option value="34" ${sidoCode eq 34 ? "selected" : ""}>충청남도</option>
                    <option value="35" ${sidoCode eq 35 ? "selected" : ""}>경상북도</option>
                    <option value="36" ${sidoCode eq 36 ? "selected" : ""}>경상남도</option>
                    <option value="37" ${sidoCode eq 37 ? "selected" : ""}>전라북도</option>
                    <option value="38" ${sidoCode eq 38 ? "selected" : ""}>전라남도</option>
                    <option value="39" ${sidoCode eq 39 ? "selected" : ""}>제주도</option>
                </select>
                <select
                    id="search-content-id"
                    class="form-select" 
                    name="contentTypeId" 
                    aria-label="Default select example"
                >
                    <option value="0" ${contentTypeId eq 0 ? "selected" : ""}>관광지 유형</option>
                    <option value="12" ${contentTypeId eq 12 ? "selected" : ""}>관광지</option>
                    <option value="14" ${contentTypeId eq 14 ? "selected" : ""}>문화시설</option>
                    <option value="15" ${contentTypeId eq 15 ? "selected" : ""}>축제공연행사</option>
                    <option value="25" ${contentTypeId eq 25 ? "selected" : ""}>여행코스</option>
                    <option value="28" ${contentTypeId eq 28 ? "selected" : ""}>레포츠</option>
                    <option value="32" ${contentTypeId eq 32 ? "selected" : ""}>숙박</option>
                    <option value="38" ${contentTypeId eq 38 ? "selected" : ""}>쇼핑</option>
                    <option value="39" ${contentTypeId eq 39 ? "selected" : ""}>음식점</option>
                </select>
                <input
                    id="search-keyword"
                    class="form-control me-2" 
                    name="keyword" 
                    type="search"
                    placeholder= "${empty keyword ? "검색어" : keyword}"
                    aria-label="검색어"
                />
                <button id="btn-search" class="btn btn-outline-success" type="submit">검색</button>
            </form>
            <div
                id="map"
                style="margin-top: 15px; width: 100%; height: 500px; border-radius: 20px"
            ></div>
            <div class="row" style="display: flex">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>대표이미지</th>
                            <th>관광지명</th>
                            <th>주소</th>
                            <th>위도</th>
                            <th>경도</th>
                        </tr>
                    </thead>
                    <tbody id="trip-list">
	                    <c:forEach var="trip" items="${trips}">    
			              <tr class="text-center">
			                <td>
			                <img
				                style="width: 200px; height: 150px" margin: auto"
				                src="${trip.imageSrc}"
				              />
				              </td>
			                <td class="text-start">
			                  <a
			                    href="#"
			                    class="article-title link-dark"
			                    data-no="${trip.tripId}"
			                    style="text-decoration: none"
			                  >
			                    ${trip.title}
			                  </a>
			                </td>
			                <td>${trip.addr1}</td>
			                <td>${trip.mapx}</td>
			                <td>${trip.mapy}</td>
			              </tr>            
						</c:forEach>   
                    </tbody>
                </table>
            </div>
            <!-- 관광지 검색 end -->
        </div>
		<%@ include file="/common/footer.jsp"%>
        <script
            type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b4de79c340033c3aa8f7874e058eb283"
        ></script>  
        <script type="text/javascript">
        </script>
    </body>
</html>
