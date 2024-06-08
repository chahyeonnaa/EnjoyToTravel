<script setup>
import { ref, onMounted, watch } from "vue";
import TripCard from "@/components/tripinfo/TripCard.vue";
import "bootstrap-icons/font/bootstrap-icons.css";
import {
  fetchSiDoList,
  fetchSiGunGuList,
  fetchPlacesList,
} from "@/api/tripinfo";

// 상태 변수
const selectedType = ref(""); // 관광지 유형 선택 상태
const selectedOption = ref(""); // 정사각형 버튼 선택 상태
const selectedSiDo = ref(""); // 시도 선택 상태
const selectedSiGunGu = ref(""); // 시군구 선택 상태
const siDoOptions = ref([]);
const siGunGuOptions = ref([]);
const inputKeyword = ref(""); // 시도 선택 상태
const contentCards = ref([]);

// 데이터 로드 함수 (여기서는 예제 데이터를 사용)
const loadCardDatas = () => {
  contentCards.value = exampleData;
};

const types = {
  "관광지·명소": 0,
  음식점: 39,
  숙박: 32,
};

const options = {
  지체장애: 1,
  시각장애: 2,
  청각장애: 3,
  "영유아 가족": 4,
  고령자: 5,
};

const imgOptions = {
  지체장애: "wheelchair",
  시각장애: "hide",
  청각장애: "deafness",
  "영유아 가족": "baby",
  고령자: "walker",
};

// 클릭 핸들러 함수
const handleTypeClick = (type) => {
  selectedType.value = type;
};

const handleOptionClick = (option) => {
  selectedOption.value = option;
};

const loadSiDoList = () => {
  fetchSiDoList(
    (response) => {
      siDoOptions.value = response.data.data;
      console.log(siDoOptions.value);
    },
    (error) => {
      console.error("Failed to fetch siDo list:", error);
    }
  );
};

const loadSiGunGuList = (sidoCode) => {
  console.log(sidoCode);
  fetchSiGunGuList(
    sidoCode,
    (response) => {
      siGunGuOptions.value = response.data.data;
      console.log(siGunGuOptions.value);
    },
    (error) => {
      console.error("Failed to fetch siGunGu list:", error);
    }
  );
};

const getSidoNameByCode = (code) => {
  const result = siDoOptions.value.find((sido) => sido.sidoCode === code);
  return result ? result.sidoName : null;
};

const getGugunNameByCode = (code) => {
  const result = siGunGuOptions.value.find((gugun) => gugun.gugunCode === code);
  return result ? result.gugunName : null;
};

const searchPlaces = () => {
  fetchPlacesList(
    selectedType.value,
    selectedOption.value,
    selectedSiDo.value,
    selectedSiGunGu.value,
    inputKeyword.value,
    (response) => {
      contentCards.value = response.data.data;
      console.log(contentCards.value);
      const areaName =
        getSidoNameByCode(selectedSiDo.value) +
        " " +
        getGugunNameByCode(selectedSiGunGu.value);
      contentCards.value.forEach((card) => {
        card.areaCode = areaName;
      });
      if (contentCards.value.length > 0) {
        makeMarkList(contentCards.value);
      } else {
        alert("검색 결과가 없습니다.");
      }
    },
    (error) => {
      console.error(error);
    }
  );
};

let positions = [];
let centerLatlng = "";
const makeMarkList = (dataList) => {
  positions = []; // 이전 마커 정보 초기화
  let averageY = 0;
  let averageX = 0;
  dataList.forEach((data) => {
    let mark = {
      firstImage: data.firstImage,
      title: data.title,
      addr1: data.areaCode,
      latlng: new kakao.maps.LatLng(
        parseFloat(data.mapy),
        parseFloat(data.mapx)
      ), // 문자열을 실수형으로 변환
    };
    positions.push(mark);
    averageY += parseFloat(data.mapy); // 문자열을 실수형으로 변환
    averageX += parseFloat(data.mapx); // 문자열을 실수형으로 변환
  });
  console.log(averageX, averageY);
  averageX = averageX / dataList.length;
  averageY = averageY / dataList.length;
  centerLatlng = new kakao.maps.LatLng(averageY, averageX);
  displayMarker();
};

const displayMarker = () => {
  const mapContainer = document.getElementById("map");
  const mapOption = {
    center: new kakao.maps.LatLng(37.500613, 127.036431),
    level: 5,
  };

  const map = new kakao.maps.Map(mapContainer, mapOption);
  const markers = [];
  const imageSrc =
    "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
  const imageSize = new kakao.maps.Size(24, 35);
  const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
  const infowindow = new kakao.maps.InfoWindow({});

  positions.forEach((position) => {
    const marker = new kakao.maps.Marker({
      map: map,
      position: position.latlng,
      title: position.title,
      image: markerImage,
    });

    markers.push(marker);

    kakao.maps.event.addListener(marker, "click", function () {
      infowindow.close();
      const content = `
        <div class="info-window">
          <div class="info-image"><img src="${position.firstImage}" alt="Image"></div>
          <div class="info-title">${position.title}</div>
          <div class="info-address">${position.addr1} </div>
        </div>
      `;
      infowindow.setContent(content);
      infowindow.open(map, marker);

      const infoWindowContainer =
        document.querySelector(".info-window").parentNode.parentNode;
      infoWindowContainer.style.background = "none";
      infoWindowContainer.style.border = "none";
    });
  });

  kakao.maps.event.addListener(map, "click", function () {
    infowindow.close();
  });

  if (positions.length > 0) {
    map.setCenter(positions[0].latlng);
  }
  map.setCenter(centerLatlng);
};

const appKey = import.meta.env.VITE_KAKAOMAP_APPKEY;

const loadScript = () => {
  const script = document.createElement("script");
  script.onload = () => kakao.maps.load(initMap);
  script.src = `//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=${appKey}&libraries=services,clusterer,drawing`;
  document.head.appendChild(script);
};

const initMap = () => {
  const container = document.getElementById("map");
  const options = {
    center: new kakao.maps.LatLng(36.35559977190671, 127.29859991863871),
    level: 5,
  };
  const map = new kakao.maps.Map(container, options);
  const zoomControl = new kakao.maps.ZoomControl();
  map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

  const marker = new kakao.maps.Marker({
    position: map.getCenter(),
  });

  marker.setMap(map);
};

onMounted(() => {
  loadSiDoList();
  if (window.kakao && window.kakao.maps) {
    initMap();
  } else {
    loadScript();
  }
});
</script>

<template>
  <section class="testimonials text-center">
    <div class="container p-5">
      <p style="color: #0064ff; font-size: 20px">뭐라고 하지?</p>
      <h2 class="mb-5" style="font-size: 40px">관광 정보 검색</h2>

      <div class="row">
        <div class="col-md-6"></div>
        <!-- 비어있는 여백 -->
        <div class="col-md-6 text-md-end" style="margin-bottom: 60px"></div>

        <div class="row">
          <!-- 관광지 유형 버튼들 -->
          <div class="d-flex align-items-center mb-3">
            <h5 class="me-3">관광지 유형</h5>
            <button
              v-for="(typeValue, typeName) in types"
              :key="typeValue"
              @click="handleTypeClick(typeValue)"
              :class="[
                'btn',
                selectedType === typeValue
                  ? 'btn-primary'
                  : 'btn-outline-primary',
                'me-2',
              ]"
            >
              {{ typeName }}
            </button>
          </div>

          <!-- 정사각형 버튼들 -->
          <div class="d-flex mb-3">
            <div
              v-for="(optionValue, optionName) in options"
              :key="optionValue"
              @click="handleOptionClick(optionValue)"
              :class="[
                'd-flex',
                'flex-column',
                'align-items-center',
                'justify-content-center',
                'me-2',
                selectedOption === optionValue
                  ? 'bg-primary text-white'
                  : 'bg-light',
                'border',
              ]"
              style="
                width: 200px;
                cursor: pointer;
                margin-right: 10px;
                margin-bottom: 10px;
                border-radius: 10%;
              "
            >
              <img
                :src="`/img/barrierIcon/${imgOptions[optionName]}.png`"
                alt="Option Image"
                style="
                  max-width: 100px;
                  max-height: 100px;
                  margin-top: 10px;
                  margin-bottom: 10px;
                "
              />
              <span style="font-size: 20px; margin-top: 10px">{{
                optionName
              }}</span>
            </div>
          </div>

          <!-- 지역 -->
          <div class="row" style="margin-bottom: 30px; margin-top: 30px">
            <!-- 첫 번째 div -->
            <div class="col-sm-6">
              <div
                class="d-flex align-items-center"
                style="margin-bottom: 30px"
              >
                <h5 class="me-3">지역선택</h5>
                <select
                  v-model="selectedSiDo"
                  @change="loadSiGunGuList(selectedSiDo)"
                  class="form-select me-2"
                  style="width: 200px"
                >
                  <option value="" disabled>시도 선택</option>
                  <option
                    v-for="siDo in siDoOptions"
                    :key="siDo.sidoCode"
                    :value="siDo.sidoCode"
                  >
                    {{ siDo.sidoName }}
                  </option>
                </select>
                <select
                  v-model="selectedSiGunGu"
                  class="form-select me-2"
                  style="width: 200px"
                >
                  <option value="" disabled>시군구 선택</option>
                  <option
                    v-for="siGunGu in siGunGuOptions"
                    :key="siGunGu.gugunCode"
                    :value="siGunGu.gugunCode"
                  >
                    {{ siGunGu.gugunName }}
                  </option>
                </select>
              </div>
            </div>

            <!-- 두 번째 div -->
            <div class="col-sm-6">
              <div
                class="d-flex align-items-center"
                style="margin-bottom: 30px; margin-left: 30px"
              >
                <h5 class="me-3">키워드</h5>
                <input
                  v-model="inputKeyword"
                  class="form-control me-2"
                  style="width: 230px"
                />
                <button
                  class="btn btn-primary"
                  @click="searchPlaces"
                  style="width: 100px"
                >
                  검색
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="d-flex align-items-center mb-3">
          <div id="map"></div>
        </div>

        <div class="d-flex align-items-center mb-3">
          <div class="row mt-5">
            <template v-for="trip in contentCards">
              <template v-if="trip.firstImage">
                <div class="col-12 col-md-3 mx-5 my-5">
                  <router-link
                    :to="{
                      name: 'tripinfodetailview',
                      params: { contentId: trip.contentId },
                    }"
                    class="nav-link"
                  >
                    <TripCard :trip="trip" style="width: 330px" />
                  </router-link>
                </div>
              </template>
            </template>
          </div>
        </div>
      </div>
    </div>
    <Popup
      v-if="showPopup"
      :places="places"
      @place-selected="handlePlaceSelected"
      @close-popup="showPopup = false"
    />
  </section>
</template>

<style>
* {
  font-family: "pretandard";
}

@font-face {
  font-family: "pretandard";
  src: url("../../../public/fonts/Pretendard-ExtraBold.otf");
}

@font-face {
  font-family: "pretandardregular";
  src: url("../../../public/fonts/Pretendard-Regular.otf");
}

@font-face {
  font-family: "pretandardmedium";
  src: url("../../../public/fonts/Pretendard-Medium.otf");
}

button.btn {
  margin-right: 0.5rem;
}
button.btn:last-child {
  margin-right: 0;
}
div.border {
  border: 1px solid #ced4da;
}
div.border:hover {
  background-color: #e9ecef;
}
#map {
  width: 100%;
  height: 500px;
}

.card {
  border: 1px solid #e0e0e0;
  border-radius: 10px;
}
.card-body {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}
.card-text {
  margin-bottom: 10px;
}
.info-window {
  width: 200px;
  text-align: center;
  padding: 10px;
  background-color: #ffffff;
  border: 1px solid #cccccc;
}

.info-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 5px;
}

.info-address {
  font-size: 14px;
  margin-bottom: 5px;
}

.info-image img {
  width: 150px;
}

.info-coordinates {
  font-size: 12px;
  color: #666666;
}
</style>
