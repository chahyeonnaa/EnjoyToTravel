const root = "http://localhost:8080/enjoytrip";

// 검색 버튼을 누르면..
// 지역, 유형, 검색어 얻기.
// 위 데이터를 가지고 공공데이터에 요청.
// 받은 데이터를 이용하여 화면 구성.
document.getElementById("btn-search").addEventListener("click", () => {
	console.log("하이이ㅣ");
	executeSearch();
	});
document.getElementById("search-keyword").addEventListener("keypress", function (e) {
    if (e.key === "Enter") {
        e.preventDefault(); // 엔터 키의 기본 동작인 폼 제출 방지
        executeSearch();
    }
});

function executeSearch() {
	console.log("안녕 익스큐트서치");
    let baseUrl = `http://localhost:8080/enjoytrip/trip/getlist`;
    let queryString = "";
    let sidoCode = document.getElementById("search-area").value;
    let contentTypeId = document.getElementById("search-content-id").value;
    let keyword = document.getElementById("search-keyword").value || "";

    if (parseInt(sidoCode)) 
    	queryString += `?sidoCode=${sidoCode}`;
    if (parseInt(contentTypeId)) {
		if(queryString.length == 0)
			queryString += `?`;
		else
			queryString += `&`;
    	queryString += `contentTypeId=${contentTypeId}`;
    }

    if (keyword) {
		if(queryString.length == 0)
			queryString += `?`;
		else
			queryString += `&`;
        queryString += `keyword=${keyword}`;
    } 
    let searchUrl = baseUrl + queryString;

    fetch(searchUrl)
        .then((response) => {
			console.log(response);
			return response.json();
			})
        .then((data) => {
			console.log("안녕하시요");
			console.log(data);
			makeList(data);
		})
		.catch((error) => {
			console.error("데이터 가져오는 중 에러", error)
		});
}

var positions = []; // marker 배열.
function makeList(trips) {
    // console.log(data);
    document.querySelector("table").setAttribute("style", "display: ;");
    
    let tripList = ``;
    positions = [];
    trips.forEach((area) => {
        let imageSrc = area.imageSrc ? area.imageSrc : "../img/noimg.jpg";
        tripList += `
            <tr onclick="moveCenter(${area.mapy}, ${area.mapx});">
                <td><img src="${imageSrc}" width="100px"></td>
                <td>${area.title}</td>
                <td>${area.addr1} ${area.addr2}</td>
                <td>${area.mapy}</td>
                <td>${area.mapx}</td>
            </tr>
        `;

        let markerInfo = {
            firstimage: imageSrc,
            title: area.title,
            addr1: area.addr1,
            addr2: area.addr2,
            latlng: new kakao.maps.LatLng(area.mapx, area.mapy),
        };
        positions.push(markerInfo);
    });
    document.getElementById("trip-list").innerHTML = tripList;
    displayMarker();
}

// 카카오지도
var mapContainer = document.getElementById("map"), // 지도를 표시할 div
    mapOption = {
        center: new kakao.maps.LatLng(37.500613, 127.036431), // 지도의 중심좌표
        level: 5, // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

var markers = [];

// displayMarker 함수 내부에 클릭 이벤트를 추가하여 마커를 클릭했을 때 정보를 표시합니다.
function displayMarker() {
    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
    var imageSize = new kakao.maps.Size(24, 35);
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var infowindow = new kakao.maps.InfoWindow({});

    console.log(positions);

    deleteMarkers();

    for (var i = 0; i < positions.length; i++) {
        var marker = new kakao.maps.Marker({
            map: map,
            position: positions[i].latlng,
            title: positions[i].title,
            image: markerImage,
        });

        marker.setMap(map);

        markers.push(marker);

        kakao.maps.event.addListener(
            marker,
            "click",
            (function (marker, i) {
                return function () {
                    infowindow.close();
                    var content = `
                    <div class="info-window">
                        <div class="info-image"><img src="${positions[i].firstimage}"></div>
                        <div class="info-title">${positions[i].title}</div>
                        <div class="info-address">${positions[i].addr1} ${positions[i].addr2}</div>
                        <div class="info-coordinates">위도: ${positions[i].latlng.getLat()}</div>
                        <div class="info-coordinates">경도: ${positions[i].latlng.getLng()}</div>
                    </div>
                    `;
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
                    let infoWindowContainer = document.querySelector(".info-window").parentNode.parentNode; // 정보 창 컨테이너의 DOM 요소 선택
                    infoWindowContainer.style.background = "none"; // 배경 제거
                    infoWindowContainer.style.border = "none"; 
                };
            })(marker, i)
        );
    }

    // 지도의 다른 부분을 클릭하면 정보창이 닫히도록 설정
    kakao.maps.event.addListener(map, "click", function () {
        infowindow.close();
    });

    map.setCenter(positions[0].latlng);
}

function deleteMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }            
}

function moveCenter(lat, lng) {
    map.setCenter(new kakao.maps.LatLng(lat, lng));
}
