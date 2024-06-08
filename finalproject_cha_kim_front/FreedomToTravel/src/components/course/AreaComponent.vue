<template>
  <div class="main container-fluid bg-grey d-flex justify-content-center align-items-center" style="height: 500px">
    <div class="row" style="border: 2px solid black; padding: 20px">
      <div class="col-sm-6">
        <div style="margin-bottom: 20px">
          <div class="mb-3">
            <label for="content" class="form-label" style="font-size: 20px">장소 선택 &nbsp;</label>
            <span style="color: #0064ff">{{ inputValue }}</span>
            <div class="row">
              <form class="d-flex mt-3" role="search" @submit.prevent="openPopup">
                <select v-model="selectedArea" id="search-area" @change="getselect" class="form-select col" aria-label="Default select example" style="width: 100%; font-size: 13px">
                  <option value="0" selected>검색 할 지역 선택</option>
                  <option v-for="area in areas" :key="area.code" :value="area.code">{{ area.name }}</option>
                </select>

                <select v-model="selectedTourismType" id="search-content-id" class="form-select mx-2 col" aria-label="Default select example" @change="onTourismTypeSelected($event.target.value)" style="width: 100%; font-size: 13px">
                  <option value="0" selected>관광지 유형</option>
                  <option value="12">관광지</option>
                  <option value="32">숙박</option>
                  <option value="39">음식점</option>
                </select>

                <select v-model="selectedCountry" id="search-country" class="form-select mx-2 col" aria-label="Default select example" style="width: 100%; font-size: 13px">
                  <option value="0" selected>상세 지역 선택</option>
                  <option v-for="country in countries" :key="country.code" :value="country.code">{{ country.name }}</option>
                </select>

                <input v-model="inputValue" class="form-control mx-2 col" placeholder="장소이름" style="width: 100%; font-size: 13px" />

                <button class="btn btn-primary" @click.prevent="searchPlacesOfCard">검색</button>
              </form>
            </div>
          </div>
        </div>

        <input v-model="review" style="margin-top: 20px; height: 200px; width: 100%" name="name" id="myName" class="info form-control col-md-6 mt-1" type="text" placeholder="후기를 자유롭게 남겨주세요!" />
      </div>

      <div class="keyword col-sm-6 d-flex justify-content-center align-items-center">
        <div style="width: 100%">
          <p style="color: #0064ff; margin-bottom: 20px; font-size: 17px">어울리는 키워드를 골라주세요!</p>
          <div class="row" style="font-family: pretandardmedium">
            <div class="col-sm-4" v-for="(buttonText, index) in buttonContents" :key="index">
              <div class="button-container">
                <button type="button" class="dis btn btn-dark btn-lg btn-block mb-3" style="white-space: nowrap; width: 100%; font-size: 14px; padding: 8px" @click="toggleButtonSelection(index)" :class="{ selected: isSelected(index) }">
                  {{ buttonText }}
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    </div>
  <Popup v-if="showPopup" :places="places" @place-selected="handlePlaceSelected" @close-popup="showPopup = false" />
     
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { fetchPlacesListOfCard } from "@/api/tripinfo";
import Popup from "./Popup.vue";

const selectedArea = ref("0");
const selectedTourismType = ref("0");
const selectedCountry = ref("0");
const contentId = ref("");
const inputValue = ref("");
const imgUrl = ref("");
const review = ref("");
const areas = ref([]);
const countries = ref([]);
const places = ref([]);
const showPopup = ref(false);
const selectedPlace = ref({});

const props = defineProps({
  uniqueId: {
    type: Number,
    required: true,
  },
});

const emit = defineEmits(["update"]);

watch([selectedArea, selectedTourismType, selectedCountry, contentId, inputValue, imgUrl, review], () => {
  emit("update", {
    uniqueId: props.uniqueId,
    selectedArea: selectedArea.value,
    selectedTourismType: selectedTourismType.value,
    selectedCountry: selectedCountry.value,
    contentId: contentId.value,
    inputValue: inputValue.value,
    imgUrl: imgUrl.value,
    review: review.value,
    selectedButtonIndices: selectedButtonIndices.value,
  });
});

const selectId = ref("");

onMounted(() => {
  selectId.value = "search-area-" + props.uniqueId;
  fetchAreaData();
});

const fetchAreaData = () => {
  fetch("https://apis.data.go.kr/B551011/KorService1/areaCode1?numOfRows=17&MobileOS=ETC&MobileApp=EnjoyTrip&_type=json&serviceKey=MqvkkUa5Fb0NdwSmt4xxd1YjN%2B8bHE3V3PODaIX%2FQE9kJGQWAitgr4vKE1EqVrYVaULTPkLj%2BWZHOxT6W9aYzQ%3D%3D", { method: "GET" })
    .then((response) => response.json())
    .then((data) => makeOption(data));
};

function makeOption(data) {
  areas.value = data.response.body.items.item;
}

function getselect() {
  let countryUrl = "https://apis.data.go.kr/B551011/KorService1/areaCode1?numOfRows=17&MobileOS=ETC&MobileApp=EnjoyTrip&";
  var select = document.getElementById("search-area");

  var value = select.options[select.selectedIndex].value;

  countryUrl += `&areaCode=${value}`;
  countryUrl += "&_type=json&serviceKey=MqvkkUa5Fb0NdwSmt4xxd1YjN%2B8bHE3V3PODaIX%2FQE9kJGQWAitgr4vKE1EqVrYVaULTPkLj%2BWZHOxT6W9aYzQ%3D%3D";

  fetch(countryUrl, { method: "GET" })
    .then((response) => response.json())
    .then((data) => makeOption_2(data));

  function makeOption_2(data) {
    let areaItems = data.response.body.items.item;
    countries.value = areaItems;
  }
}

const buttonContents = ref([
  "휠체어를 타고 다니기 편해요",
  "장애인 주차장이 넓어요",
  "점자 안내가 있어요",
  "보조견을 동반할 수 있어요",
  "수유실이 있어요",
  "유아차 대여가 가능해요",
  "엘리베이터가 있어요",
  "친절해요",
  "가성비가 좋아요",
  "볼거리가 많아요",
  "사진이 잘나와요",
  "화장실이 깨끗해요",
]);

const onTourismTypeSelected = (type) => {
  switch (type) {
    case "12":
      buttonContents.value = [
        "휠체어를 타고 다니기 편해요",
        "장애인 주차장이 넓어요",
        "점자 안내가 있어요",
        "보조견을 동반할 수 있어요",
        "수유실이 있어요",
        "유아차 대여가 가능해요",
        "엘리베이터가 있어요",
        "친절해요",
        "가성비가 좋아요",
        "볼거리가 많아요",
        "사진이 잘나와요",
        "화장실이 깨끗해요",
      ];
      break;
    case "32":
      buttonContents.value = [
        "휠체어를 타고 다니기 편해요",
        "장애인 주차장이 넓어요",
        "점자 안내가 있어요",
        "보조견을 동반할 수 있어요",
        "수유실이 있어요",
        "유아차 대여가 가능해요",
        "엘리베이터가 있어요",
        "친절해요",
        "가성비가 좋아요",
        "침구가 좋아요",
        "방음이 잘 돼요",
        "인테리어가 멋져요",
      ];

      break;
    case "39":
      buttonContents.value = [
        "휠체어를 타고 다니기 편해요",
        "장애인 주차장이 넓어요",
        "점자 안내가 있어요",
        "보조견을 동반할 수 있어요",
        "수유실이 있어요",
        "유아차 대여가 가능해요",
        "엘리베이터가 있어요",
        "친절해요",
        "가성비가 좋아요",
        "맛있어요",
        "사진이 잘나와요",
        "양이 많아요",
      ];
      break;
    default:
      buttonContents.value = [
        "휠체어를 타고 다니기 편해요",
        "장애인 주차장이 넓어요",
        "점자 안내가 있어요",
        "보조견을 동반할 수 있어요",
        "수유실이 있어요",
        "유아차 대여가 가능해요",
        "엘리베이터가 있어요",
        "친절해요",
        "가성비가 좋아요",
        "볼거리가 많아요",
        "사진이 잘나와요",
        "화장실이 깨끗해요",
      ];
  }
};

const selectedButtonIndices = ref([]);

const toggleButtonSelection = (index) => {
  const selectedIndex = selectedButtonIndices.value.indexOf(index);
  if (selectedIndex === -1) {
    selectedButtonIndices.value.push(index);
  } else {
    selectedButtonIndices.value.splice(selectedIndex, 1);
  }
};

const isSelected = (index) => {
  return selectedButtonIndices.value.includes(index);
};

const searchPlacesOfCard = () => {
  fetchPlacesListOfCard(selectedTourismType.value, selectedArea.value, selectedCountry.value, inputValue.value, response => {
    places.value = response.data;
    showPopup.value = true;
  }, error => {
    console.error("Failed to fetch places");
  });
};

const handlePlaceSelected = (place) => {
  console.log("선택된")
  console.log(place)
  contentId.value = place.contentId;
  inputValue.value = place.title;
  imgUrl.value = place.firstImage;
  selectedPlace.value = place;
  showPopup.value = false;
};
</script>

<style scoped>
.selected {
  background-color: #0064ff;
  color: white;
}
</style>
