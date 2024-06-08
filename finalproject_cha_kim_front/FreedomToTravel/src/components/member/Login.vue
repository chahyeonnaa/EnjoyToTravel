<script setup>
import { ref } from "vue";
import { useRoute, useRouter } from "vue-router";
import { loginMember } from "@/api/member";
import { useAuthStore } from "@/stores/auth";

const router = useRouter();
const route = useRoute();
const authStore = useAuthStore();

const credentials = ref({
  id: "",
  password: "",
});

const goToMain = () => {
  router.push({ name: "main" });
};

function login() {
  console.log("로그인1111");
  loginMember(
    credentials.value,
    (response) => {
      if (response.data.res === "success") {
        console.log("로그인2222");
        setItemWithExpireTime("freedom_to_trip_user_id", response.data.memberInfo.userId, 180000000);
        goToMain();
        authStore.login(credentials.value.id);
        } else {
        console.error("Login failed:", response.data);
        alert("로그인 실패: 아이디 또는 비밀번호가 잘못되었습니다.");
        // 로그인 실패 시 추가 처리 로직을 여기에 작성하세요.
      }
    },
    (error) => {
      console.error("Login request failed:", error);
      // 로그인 요청 실패 시 추가 처리 로직을 여기에 작성하세요.
    }
  );
}
function setItemWithExpireTime(keyName, keyValue, tts) {
  // localStorage에 저장할 객체  
  const obj = {
    value: keyValue,
    expire: Date.now() + tts
  }
  // 객체를 JSON 문자열로 변환  
  const objString = JSON.stringify(obj);
  // setItem  
  window.localStorage.setItem(keyName, objString);
}

function test() {
  console.log("test");
}
</script>

<template>
  <div class="container">
    <h1 id="mypage-title" class="mb-3 text-center" style="font-size: 50px">
      로그인
    </h1>
    <div class="input-form-backgroud row" style="margin-top: 30px">
      <div class="input-form col-md-12 mx-auto">
        <form
          @submit.prevent="onSubmit"
          id="uform"
          class="validation-form"
          method="GET"
        >
          <div class="row" style="font-size: 22px">
            <div class="col-md-12 mb-3" style="margin-top: 30px">
              아이디
              <input
                v-model="credentials.id"
                style="margin-bottom: 30px; height: 60px"
                name="name"
                id="myName"
                class="info form-control col-md-6 mt-1"
                type="text"
                value=""
              />
            </div>

            <div class="col-md-12 mb-3">
              비밀번호
              <input
                style="margin-bottom: 10px; height: 60px"
                v-model="credentials.password"
                name="id"
                id="myId"
                class="info form-control col-md-6 mt-1"
                type="text"
                value=""
                aria-label="Disabled input example"
              />
            </div>
            <div class="d-flex justify-content-end align-items-center h-100">
              <a
                class="signup-link"
                style="font-size: 20px; margin-bottom: 30px"
                >비밀번호 찾기</a
              >
            </div>

            <button
              type="submit"
              class="btn btn-outline-primary btn-block"
              style="font-size: 25px; height: 60px"
              @click="login"
            >
              로그인
            </button>

            <div class="d-flex justify-content-end align-items-center h-100">
              <router-link
                :to="{ name: 'sign' }"
                class="signup-link"
                style="font-size: 20px; margin-top: 50px"
              >
                <p style="display: inline; color: #808080">
                  계정이 없으신가요?
                </p>
                &nbsp; 회원가입 하기
              </router-link>
            </div>
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
