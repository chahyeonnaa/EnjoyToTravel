<script setup>
import { ref, onMounted } from "vue";
import CourseComponent from "@/components/course/CourseComponent.vue";
import { useRouter } from "vue-router";
import { listCourse } from "@/api/course";

import { defineProps } from "vue";

onMounted(() => {
  getCourseList();
});

const param = ref([]);
const router = useRouter();

const goToWriter = () => {
  console.log("fsfsdfsd");
  router.push({ name: "write" });
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
</script>

<template>
  <section class="testimonials text-center">
    <div class="container p-5">
      <p style="color: #0064ff; font-size: 20px">떠나요, 자유롭게!</p>
      <h2 class="mb-5" style="font-size: 40px">여행 코스 추천</h2>
      <div class="row">
        <div class="col-md-6"></div>
        <!-- 비어있는 여백 -->
        <div class="col-md-6 text-md-end" style="margin-bottom: 60px">
          <button
            style="width: 120px; height: 45px; font-size: 20px"
            class="btn btn-outline-dark"
            type="button"
            @click="goToWriter"
          >
            글쓰기
          </button>
        </div>
      </div>
    </div>

    <div
      class="container d-flex flex-wrap justify-content-between align-items-center"
    >
      <div
        v-for="course in param"
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
            style="width: 400px"
            :title="course.title"
            :imgUrl="course.courseCards[0].firstImage"
            :tag="course.tag"
          ></CourseComponent>
        </router-link>
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
