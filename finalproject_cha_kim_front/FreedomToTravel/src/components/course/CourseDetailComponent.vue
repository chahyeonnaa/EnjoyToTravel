<template>
  <div class="container p-5 d-flex justify-content-center align-items-center">
    <div class="row">
      <div
        class="container p-5 shadow-sm"
        style="
          width: 1000px;
          margin-top: 40px;
          border: 1px solid lightgray;
          border-radius: 20px;
        "
      >
        <h4
          class="area"
          style="margin-top: 20px; font-size: 24px; font-weight: bold"
        >
          {{ place.placeTitle }}
        </h4>
        <p class="type" style="font-size: 20px; color: #0064ff">
          {{ place.contentTypeId == 12 ? "관광지" : "" }}
          {{ place.contentTypeId == 39 ? "음식점" : "" }}
          {{ place.contentTypeId == 32 ? "숙박" : "" }}
        </p>

        <div class="row mt-3">
          <div class="col-sm">
            <div class="button-container">
              <div
                v-for="keyword in trueKeywords"
                :key="keyword"
                type="button"
                class="dis btn bg-light btn-lg mb-3 border shadow-sm"
                style="
                  margin-right: 12px;
                  font-family: pretandardmedium;
                  font-size: 17px;
                "
              >
                <font-awesome-icon
                  :icon="getKeywordIcon(keyword)"
                  :style="{ color: getKeywordColor(keyword) }"
                />
                {{ buttonContents[keyword - 1] }}
              </div>
            </div>
          </div>
        </div>

        <img
          class="img-fluid rounded mb-3 thumbnail"
          :src="place.firstImage"
          alt="..."
          style="margin-top: 20px; width: 700px; height: 520px; 
  object-fit: cover;;"
        />
        <div class="card" style="width: 700px; margin-left: 100px">
          <p
            class="review"
            style="
              font-family: pretandardregular;
              font-size: 20px;
              margin-top: 20px;
            "
          >
            {{ place.text }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
library.add(fas);

const props = defineProps({
  place: {
    type: Object,
    required: true,
  },
});

const trueKeywords = ref([]);
const buttonContents = ref([]);

const extractTrueKeywords = (place) => {
  const keywords = [];
  for (const key in place) {
    if (place[key] === true) {
      const keywordNumber = parseInt(key.replace("keyword", ""));
      keywords.push(keywordNumber);
    }
  }
  trueKeywords.value = keywords;

  switch (place.contentTypeId) {
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

const getKeywordIcon = (keyword) => {
  if (keyword >= 1 && keyword <= 9) {
    const icons = [
      "wheelchair",
      "parking",
      "braille",
      "dog",
      "baby",
      "baby-carriage",
      "elevator",
      "hand-holding-heart",
      "coins",
    ];
    return ["fas", icons[keyword - 1]];
  } else if (keyword == 10) {
    if (props.place.contentTypeId == 32) {
      return ["fas", "bed"];
    } else if (props.place.contentTypeId == 39) {
      return ["fas", "utensils"];
    } else {
      return ["fas", "landmark"];
    }
    // "맛있어요",
    // "사진이 잘나와요",
    // "양이 많아요",
  } else if (keyword == 11) {
    if (props.place.contentTypeId == 32) {
      return ["fas", "volume-xmark"];
    } else if (props.place.contentTypeId == 39) {
      return ["fas", "image"];
    } else {
      return ["fas", "image"];
    }
  } else if (keyword == 12) {
    if (props.place.contentTypeId == 32) {
      return ["fas", "house"];
    } else if (props.place.contentTypeId == 39) {
      return ["fas", "bowl-food"];
    } else {
      return ["fas", "face-smile"];
    }
  } else {
    return ["fas", "question-circle"];
  }
};

const getKeywordColor = (keyword) => {
  const colors = [
    "pink",
    "blue",
    "green",
    "purple",
    "orange",
    "brown",
    "red",
    "yellow",
    "teal",
    "cyan",
    "indigo",
  ];

  return colors[keyword - 1];
};

onMounted(() => {
  extractTrueKeywords(props.place);
});
</script>

<style scoped>
* {
  font-family: "pretandard";
}
.thumbnail {
  width: 100%;
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
</style>
