<script setup>
import { ref, onMounted, watch } from "vue";
import CourseComponent from "@/components/course/CourseComponent.vue";
import { listCourse } from "@/api/course";
import { useRouter } from "vue-router";

onMounted(() => {
  getCourseList();
  animation();
  window.addEventListener("scroll", handleScroll);
});

const param = ref([]);
const router = useRouter();
const title = ref("모두를 위한 장애물 없는 관광,");
const title1 = ref("");
const maincom = ref(null);
const maincom2 = ref(null);
const maincom3 = ref(null);

const handleScroll = () => {
  const offset = window.scrollY;
  const maincomTop = maincom.value.offsetTop;
  const maincom2Top = maincom2.value.offsetTop;
  const maincom3Top = maincom3.value.offsetTop;

  // 스크롤 위치에 따라 요소를 표시하거나 숨깁니다.
  if (offset > maincomTop - window.innerHeight / 2) {
    maincom.value.style.opacity = 1;
  } else {
    maincom.value.style.opacity = 0;
  }

  if (offset > maincom2Top - window.innerHeight / 5) {
    maincom2.value.style.opacity = 1;
  } else {
    maincom2.value.style.opacity = 0;
  }

  if (offset > maincom3Top - window.innerHeight / 6) {
    maincom3.value.style.opacity = 1;
  } else {
    maincom3.value.style.opacity = 0;
  }
};

const getCourseList = () => {
  listCourse(
    param.value,
    ({ data }) => {
      param.value = data.data;
      console.log("서버에서 글목록 얻어오자!!!", data.data);
    },
    (error) => {
      console.log(error);
    }
  );
};

const animation = () => {
  title1.value = "";

  const animate = (index) => {
    if (index < title.value.length) {
      setTimeout(() => {
        title1.value += title.value[index]; // 각 글자 추가
        animate(index + 1); // 다음 글자로 이동
      }, 150);
    }
  };

  animate(0); // 초기 호출
};

watch(title, () => {
  animation(); // title이 변경될 때마다 animation 함수 실행
});

const goToTripInfo = () => {
  router.push({ name: "tripinfo" });
};

const buttonHover = () => {
  // 마우스 오버 시 버튼 확대
  document.querySelector(".dis").style.transform = "scale(1.1)";
  document.querySelector(".dis").style.backgroundColor = "black"; // 변경할 색상 설정
};

const buttonLeave = () => {
  // 마우스 리브 시 버튼 크기 복원
  document.querySelector(".dis").style.transform = "scale(1)";
  document.querySelector(".dis").style.backgroundColor = "#007bff"; // 원래 색상으로 변경
};
</script>

<template>
  <div class="text-center mt-6">
    <h1 style="font-size: 56px">{{ title1 }}</h1>
  </div>

  <transition name="fade">
    <div class="second" v-if="title1.length == 17">
      <div class="text-center mt-5">
        <h1 style="font-size: 36px; color: #0064ff">여행할 자유</h1>
      </div>

      <div class="com text-center mt-4">
        <h1 style="font-size: 26px; font-family: pretandardregular">
          누구든 떠날 자유, 모두가 누릴 행복을 응원합니다!
        </h1>
      </div>
    </div>
  </transition>

  <div class="maincom" ref="maincom" style="opacity: 0">
    <div class="maincom text-center mt-6">
      <h1
        style="font-size: 24px; font-family: pretandardmedium; color: #a6a6a8"
      >
        당신의 편에서 생각합니다
      </h1>
    </div>

    <div class="maincom text-center mt-5" ref="maincom">
      <h1
        style="font-size: 25px; font-family: pretandardmedium; color: #a6a6a8"
      >
        주차는 편리하게, 가는 길은 넓고 완만하게, 화장실 이용은 불편함이 없도록
      </h1>
    </div>
  </div>

  <div class="maincom2" ref="maincom2" style="opacity: 0">
    <div
      class="main container-fluid bg-grey d-flex justify-content-center align-items-center"
      style="height: 600px"
    >
      <div class="row" style="padding: 10px">
        <div class="col-sm-4">
          <span class="glyphicon glyphicon-globe logo">
            <img
              src="../../../public/img/mainphone.png"
              class="rounded mx-auto d-block"
              alt="..."
          /></span>
        </div>
        <div class="col-sm-8 d-flex justify-content-center align-items-center">
          <div style="margin-left: 100px">
            <!-- 간격 조절 -->
            <p style="color: #0064ff">걱정 없이 떠나세요.</p>
            <h1>마음 편히 떠나세요</h1>
            <h1>
              아무도 당신을 <br />
              막지 않을 곳으로.
            </h1>

            <button
              type="button"
              class="dis btn btn-primary btn-lg col-9"
              @click="goToTripInfo"
              @mouseover="buttonHover"
              @mouseleave="buttonLeave"
            >
              무장애 여행지 검색
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <section
    class="testimonials text-center bg-light maincom3"
    ref="maincom3"
    style="opacity: 0"
  >
    <div class="container p-5">
      <p style="color: #0064ff; font-size: 20px">여행할 자유 회원들이 선정한</p>
      <h2 class="mb-5" style="font-size: 40px">이달의 추천 코스</h2>
    </div>
    <div
      class="container d-flex flex-wrap justify-content-between align-items-center"
    >
      <div
        class="col-md-4"
        v-for="course in param.slice(0, 3)"
        :key="course.courseId"
        style="margin-bottom: 120px"
      >
        <router-link
          :to="{
            name: 'coursedetailview',
            params: { courseId: course.courseId },
          }"
          class="nav-link"
        >
          <CourseComponent
            :title="course.title"
            :tag="course.tag"
          ></CourseComponent>
        </router-link>
      </div>
    </div>
  </section>
</template>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 1s; /* 트랜지션 지속 시간 설정 */
  opacity: 0;
}

.fade-enter,
.fade-leave-to {
  opacity: 0.8; /* 시작과 끝의 투명도 설정 */
}

@media screen and (max-width: 768px) {
  .col-sm-4 {
    text-align: center;
    margin: 25px 0;
  }
}

.dis {
  border-radius: 20px;
  margin-top: 40px;
  font-family: "pretandardmedium";
  font-size: 18px;
}
.main,
#custom-cards {
  font-family: "pretandard";
}
.text-center {
  margin-top: 100px;
  font-family: "pretandard"; /* 요소와의 간격 조절 */
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
