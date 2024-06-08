<script setup>
import { onMounted, ref } from "vue";

const props = defineProps({
  title: {
    type: String,
  },
  tag: {
    type: String,
  },
  imgUrl: {
    type: String,
  },
});

// const formattedTag = props.tag.split(' ').map(word => `<span>${word}</span>`).join(' ');
const formattedTag = ref('');

const scale = ref(1); // 초기 스케일 값

const courseHover1 = () => {
  // 마우스 오버 시 CourseComponent 확대
  scale.value = 1.1;
};

const courseLeave1 = () => {
  // 마우스 리브 시 CourseComponent 크기 복원
  scale.value = 1.0;
};

onMounted(() => {
  if (props.tag) {
        formattedTag.value = props.tag.split(' ').map(word => `<span>${word}</span>`).join(' ');
      }
});
</script>

<template>
  <div class="col-lg-4" style="width: 400px">
    <div
      class="testimonial-item mx-auto mb-5 mb-lg-0"
      @mouseover="courseHover1"
      @mouseleave="courseLeave1"
      :style="{ transform: `scale(${scale})` }"
      style="border-radius: 4%; width: 400px"
    >
      <div class="thumbnail-container">
        <img class="img-fluid rounded mb-3 thumbnail" :src="imgUrl" alt="..." />
      </div>
        <p
          class="title"
          style="margin-top: 20px; font-family: pretandardmedium; font-size: 20px"
        >
          {{ title }}
        </p>
      <div style="height: 100px;">
        <p
          class="tag font-weight-light mb-0"
          style="
            color: #0064ff;
            font-family: pretandardregular;
            font-size: 18px;
            margin-top: 14px;
            padding-bottom: 20px;
            white-space: pre-wrap;
            height: 100px;
          "
          v-html="formattedTag"
        >
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped>
* {
  font-family: "pretandard";
}

.thumbnail-container {
  width: 400px;
  height: 300px;
  overflow: hidden;
}

.thumbnail {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.tag span {
  white-space: nowrap; /* 각 단어가 한 줄로 유지되도록 합니다. */
  word-break: break-word; /* 단어가 길 때 적절히 줄바꿈되도록 합니다. */
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
