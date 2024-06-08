<script setup></script>

<template>
  <footer class="footer text-center">
    <div style="background-color: #0f172a">
      <div class="row" style="padding: 30px">
        <h3 style="margin-bottom: 30px; color: aliceblue">여행할 자유</h3>
        <div class="line"></div>
        <p
          class="small mb-4 mb-lg-0"
          style="margin-top: 20px; color: aliceblue"
        >
          &copy; Your Website 2024. All Rights Reserved by 김정현 차현아
        </p>
      </div>
    </div>
  </footer>
</template>

<style scoped>
footer {
  margin-top: 200px;
  padding: 50px;
  margin-bottom: 50px;
  font-family: pretandard;
}
.line {
  width: 70%; /* 가로선의 길이를 조절 */
  height: 1px; /* 가로선의 두께를 조절 */
  background-color: #fff; /* 가로선의 색상 */
  margin: 20px auto; /* 가로선을 중앙에 위치시킵니다. */
  opacity: 0.3;
}
@font-face {
  font-family: "pretandard";
  src: url("../../../public/fonts/Pretendard-ExtraBold.otf");
}
</style>
