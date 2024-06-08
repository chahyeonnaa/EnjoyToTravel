<script setup>
import { ref } from "vue";
import { useRoute, useRouter } from "vue-router";
import { signMember } from "@/api/member";

const router = useRouter();
const route = useRoute();

const member = ref({
  userId: "",
  password: "",
  nickname: "",
  email: "",
  disabledType: "",
  token: "2",
  isAdmin: 1,
});

const goToLogin = () => {
  router.push({ name: "login" });
};

function sign() {
  console.log("sign 함수 호출 확인");
  console.log("회원가입", member.value);
  signMember(
    member.value,
    (response) => {
      goToLogin();
    },
    (error) => console.log(error)
  );
}

function test() {
  console.log("test");
}

function onSubmit() {
  // event.preventDefault();
  sign();
}
</script>

<template>
  <div class="container">
    <h1 id="mypage-title" class="mb-3 text-center" style="font-size: 50px">
      회원가입
    </h1>
    <div class="input-form-backgroud row" style="margin-top: 30px">
      <div class="input-form col-md-12 mx-auto">
        <form id="uform" class="validation-form" @submit.prevent="onSubmit">
          <div class="row" style="font-size: 22px">
            <div class="col-md-12 mb-3" style="margin-top: 30px">
              아이디
              <input
                style="margin-bottom: 30px; height: 60px"
                name="name"
                v-model="member.userId"
                id="myName"
                class="info form-control col-md-6 mt-1"
                type="text"
                value=""
              />
            </div>

            <div class="col-md-12 mb-3">
              비밀번호
              <input
                style="margin-bottom: 30px; height: 60px"
                name="id"
                id="myId"
                class="info form-control col-md-6 mt-1"
                type="text"
                value=""
                v-model="member.password"
                aria-label="Disabled input example"
              />
            </div>

            <div class="col-md-12 mb-3">
              닉네임
              <input
                style="margin-bottom: 30px; height: 60px"
                name="id"
                id="myId"
                class="info form-control col-md-6 mt-1"
                type="text"
                v-model="member.nickname"
                value=""
                aria-label="Disabled input example"
              />
            </div>

            <div class="col-md-12 mb-3">
              이메일
              <input
                style="margin-bottom: 30px; height: 60px"
                name="id"
                id="myId"
                class="info form-control col-md-6 mt-1"
                type="text"
                value=""
                v-model="member.email"
                aria-label="Disabled input example"
              />
            </div>

            <div class="col-md-12 mb-3">
              여행자 유형
              <select
                style="margin-bottom: 50px; height: 60px"
                name="disabilityType"
                id="disabilityType"
                class="info form-select col-md-6 mt-1"
                aria-label="장애유형 선택"
                v-model="member.disabledType"
              >
                <option value="" selected disabled>선택</option>
                <option value="physical">시각장애</option>
                <option value="visual">지체장애</option>
                <option value="auditory">고령자</option>
                <option value="intellectual">영유아가족</option>
              </select>
            </div>

            <button
              type="submit"
              class="btn btn-outline-primary btn-block"
              style="font-size: 25px; height: 60px"
              @click="sign"
            >
              회원가입
            </button>
          </div>

          <div class="mb-4"></div>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>
@font-face {
  font-family: "pretandard";
  src: url("../../../public/fonts/Pretendard-ExtraBold.otf");
}

* {
  font-family: "pretandard";
  background: white;
}

.signup-link {
  text-decoration-line: none;
}

.signup-link:hover {
  color: #4ad395; /* 호버 시 텍스트 색상 변경 */
  cursor: pointer; /* 호버 시 포인터 모양으로 변경 */
}

.input-form {
  max-width: 680px;
  padding: 32px;

  background: #fff;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  border-radius: 10px;
  -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
  -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
  box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
}
.container {
  margin-top: 150px;
  height: auto;
  min-height: 100%;
  padding-bottom: 150px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
</style>
