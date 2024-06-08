<script setup>
import CourseDetailComponent from "@/components/course/CourseDetailComponent.vue";
import { ref, onMounted, computed } from "vue";
import { getCoursePost } from "@/api/course";

const selectedSidoName = ref("");
const sidoName = ref({
  1: "서울",
  2: "인천",
  3: "대전",
  4: "대구",
  5: "광주",
  6: "부산",
  7: "울산",
  8: "세종특별자치시",
  31: "경기도",
  32: "강원도",
  33: "충청북도",
  34: "충청남도",
  35: "경상북도",
  36: "경상남도",
  37: "전라북도",
  38: "전라남도",
  39: "제주도",
});

const param = ref({});
const imgUrl = ref("");

onMounted(() => {
  fetchData();
});

const fetchData = () => {
  const currentURL = window.location.href;
  const courseNumber = currentURL.substring(currentURL.lastIndexOf("/") + 1);

  console.log("코스 번호 : ", courseNumber);
  getCoursePost(
    courseNumber,
    ({ data }) => {
      param.value = data.data;
      console.log("서버에서 글목록 얻어오자!!!", data.data);
      console.log("@@@@@@@@", data.data.sidoCode);
      selectedSidoName.value = sidoName.value[data.data.sidoCode];
      imgUrl.value = data.data.courseCards[0].firstImage;
      //   getGugun(
      //     data.data.sidoCode,
      //     ({ data }) =>{
      //       data.data.
      //     },
      //     (error) => {
      //   console.log(error);
      // }
      //   );
    },
    (error) => {
      console.log(error);
    }
  );
};

const backgroundStyle = computed(() => ({
  backgroundImage: `url('${imgUrl.value}')`,
  backgroundSize: "cover",
  backgroundPosition: "center",
  padding: "20px",
  // opacity: "80%",
  filter: "brightness(80%)",
}));
</script>

<template>
  <section class="testimonials text-center">
    <div class="container p-5">
      <div class="position-relative">
        <div :style="backgroundStyle" style="width: 100%; height: 250px">
          <p
            style="
              color: whitesmoke;
              position: absolute;
              left: 100px;
              top: 70px;
              font-family: pretandardregular;
            "
          >
            여행할 자유 - 코스 추천 게시판
          </p>
          <h3
            class="mb-5"
            style="
              font-size: 30px;
              color: white;
              position: absolute;
              left: 100px;
              top: 100px;
            "
          >
            {{ param.title }}
          </h3>
          <h2
            style="
              color: whitesmoke;
              font-size: 16px;
              font-family: pretandardmedium;
              display: inline-block;
              opacity: 1;
              color: white;
              position: absolute;
              left: 100px;
              top: 150px;
            "
          >
            {{ selectedSidoName }}
          </h2>
        </div>
      </div>
      <div class="row justify-content-center">
        <!-- 장소 객체 넘겨주기, param안의 배열을 돌아야됨  -->
        <CourseDetailComponent
          v-for="place in param.courseCards"
          :key="place.courseId"
          :place="place"
        ></CourseDetailComponent>
      </div>
    </div>
  </section>
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
