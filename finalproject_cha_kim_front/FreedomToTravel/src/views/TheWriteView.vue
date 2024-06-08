<script setup>
import { ref, onMounted } from "vue";
import AreaComponent from "@/components/course/AreaComponent.vue";
import { useAuthStore } from "@/stores/auth";
import { writeCourse } from "@/api/course";
import { useRouter } from "vue-router";

const router = useRouter();

const areaComponents = ref([]);
const collectedData = ref({});
const title1 = ref("");
const date = ref("");
const authStore = useAuthStore();
const sidoCode = ref("");
const gugunCode = ref("");
const courseCards = ref([]);

const userId = ref("");
const tripDate = ref("");
const title = ref("");
const selectedTourismType = ref("");

const keywordIndices = ref([]);
const keywordValues = ref("");

const updateComponentData = (data) => {
  data.title = title1.value;
  data.date = date.value;
  data.userId = authStore.id;
  collectedData.value[data.uniqueId] = data;
};

const callSendDataToServer = () => {
  console.log("Collected Data:", collectedData.value);
  console.log(collectedData.value[0].date);
  userId.value = authStore.id;
  tripDate.value = collectedData.value[0].date;
  title.value = collectedData.value[0].title;
  console.log("제목", title.value);

  courseCards.value = Object.values(collectedData.value).map((data) => {
    sidoCode.value = data.selectedArea; // selectedArea를 sidoCode에 할당
    gugunCode.value = data.selectedCountry; // selectedCountry를 gugunCode에 할당

    keywordIndices.value = data.selectedButtonIndices; // selectedButtonIndices를 keywordIndices에 할당
    keywordValues.value = Array(12).fill(false); // 모든 keyword 값을 false로 초기화

    // keywordIndices에 해당하는 index의 keyword 값을 true로 설정
    keywordIndices.value.forEach((index) => {
      keywordValues[index - 1] = true; // keyword의 인덱스는 0부터 시작하므로 index에서 1을 빼줍니다.
    });

    console.log("ff");
    console.log(data);
    
    return {
      contentId: data.contentId, // selectedArea 값을 contentId로 사용하거나 원하는 값으로 설정합니다.
      contentTypeId: data.selectedTourismType, // 선택한 관광 타입을 contentTypeId로 사용하거나 원하는 값으로 설정합니다.
      text: data.review, // 리뷰 내용을 text로 사용하거나 원하는 값으로 설정합니다
      placeTitle: data.inputValue,
      firstImage: data.imgUrl,
      keyword01: keywordValues[0], // keywordValues의 각 요소를 keyword에 설정
      keyword02: keywordValues[1],
      keyword03: keywordValues[2],
      keyword04: keywordValues[3],
      keyword05: keywordValues[4],
      keyword06: keywordValues[5],
      keyword07: keywordValues[6],
      keyword08: keywordValues[7],
      keyword09: keywordValues[8],
      keyword10: keywordValues[9],
      keyword11: keywordValues[10],
      keyword12: keywordValues[11],
    };
  });

  const requestBody = {
    userId: userId.value,
    title: title.value,
    tripDate: tripDate.value,
    sidoCode: sidoCode.value,
    gugunCode: gugunCode.value,
    courseCards: courseCards.value,
  };

  console.log("requestBody", requestBody);
  // 여기서 서버로 데이터를 전송하는 로직을 구현하면 됩니다.
  writeCourse(
    requestBody,
    (response) => {
      goToCourseList();
    },
    (error) => console.log(error)
  );
};

const goToCourseList = () => {
  router.push({ name: "courseview" });
};

const addAreaComponent = () => {
  areaComponents.value.push({}); // 새로운 AreaComponent 추가
};
</script>

<template>
  <section class="testimonials text-start">
    <div class="container p-5">
      <p style="color: #0064ff; font-size: 20px">여행한 장소를 추천해주세요!</p>
      <h2 class="mb-5" style="font-size: 40px">여행 후기 작성</h2>

      <div class="row">
        <form @submit.prevent="onSubmit">
          <div class="mb-3">
            <label for="userid" class="form-label" style="font-size: 20px"
              >제목
            </label>
            <input
              v-model="title1"
              style="margin-bottom: 30px; height: 50px"
              type="text"
              class="form-control"
            />
          </div>
          <div class="mb-3">
            <label for="subject" class="form-label" style="font-size: 20px"
              >여행 날짜
            </label>
            <input
              v-model="date"
              style="margin-bottom: 30px; height: 50px"
              type="text"
              class="form-control"
              placeholder="YYYY.MM.DD"
            />
          </div>
        </form>
      </div>
    </div>
  </section>
  <div class="container p-5 d-flex justify-content-center">
    <div class="row">
      <AreaComponent
        v-for="(component, index) in areaComponents"
        :key="index"
        :uniqueId="index"
        @update="updateComponentData"
      />
    </div>
  </div>

  <div class="col-auto text-center">
    <button
      type="button"
      class="btn btn-outline-danger mb-3 ms-1"
      @click="addAreaComponent"
    >
      장소 등록하기
    </button>
    <button
      type="button"
      class="btn btn-dark mb-3 ms-1"
      @click="callSendDataToServer"
    >
      글쓰기
    </button>
  </div>
</template>

<style scoped>
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
</style>
