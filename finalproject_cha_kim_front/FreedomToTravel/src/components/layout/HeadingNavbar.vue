<script setup>
import { useRouter } from "vue-router";
import { useAuthStore } from '@/stores/auth';

const authStore = useAuthStore();

const router = useRouter();

const goToLogin = () => {
  router.push({ name: "login" });
};

const handleLogout = () => {
  setItemWithExpireTime("freedom_to_trip_user_id", authStore.id, 0);
  authStore.logout();
  alert('로그아웃 되었습니다.');
  router.push({ name: "main" });
};


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

function getItemWithExpireTime(keyName) {
  // localStorage 값 읽기 (문자열)  
  const objString = window.localStorage.getItem(keyName);
  // null 체크  
  if (!objString) { return null; }
  // 문자열을 객체로 변환  
  const obj = JSON.parse(objString);    
  // 현재 시간과 localStorage의 expire 시간 비교  
  if (Date.now() > obj.expire) {    // 만료시간이 지난 item 삭제    
    window.localStorage.removeItem(keyName);
    // null 리턴    
    return null;
  }
  // 만료기간이 남아있는 경우, value 값 리턴  
  return obj.value;
}
</script>

<template>
  <div class="row container-fluid d-flex">
    <nav class="navbar navbar-expand-lg sticky-top">
      <div class="container-fluid">
        <router-link :to="{ name: 'main' }" class="col-md-4 navbar-brand">
          <img
            src="../../../public/img/logo.png"
            class="rounded mx-auto d-block"
            alt="..."
          />
        </router-link>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarScroll"
          aria-controls="navbarScroll"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarScroll">
          <ul
            class="navbar-nav me-auto my-4 my-lg-0 navbar-nav-scroll"
            style="--bs-scroll-height: 100px"
          >
            <li class="nav-item">
              <router-link :to="{ name: 'tripinfo' }" class="nav-link"
                >관광정보</router-link
              >
            </li>
            <li class="nav-item">
              <router-link :to="{ name: 'courseview' }" class="nav-link"
                >코스추천</router-link
              >
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">공지사항</a>
            </li>
            <!-- <li class="nav-item dropdown">
            <a
              class="nav-link dropdown-toggle"
              href="#"
              role="button"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              HELP DESK
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">공지사항</a></li>
              <li><a class="dropdown-item" href="#">FAQ</a></li>
              <li><hr class="dropdown-divider" /></li>
              <li><a class="dropdown-item" href="#">학사규정</a></li>
            </ul>
          </li> -->
            <!-- <li class="nav-item">
            <router-link :to="{ name: 'board' }" class="nav-link">게시판</router-link>
          </li>
          <li class="nav-item">
            <router-link :to="{ name: 'estations' }" class="nav-link">전기차충전소</router-link>
          </li> -->
          </ul>
          <!-- <form class="d-flex" role="search">
          <input
            class="form-control me-2"
            type="search"
            placeholder="검색..."
            aria-label="Search"
          />
          
        </form> -->
        <!-- <button v-if="authStore.isLoggedIn" class="btn btn-outline-dark" type="button" @click="handleLogout">로그아웃</button>
        <button v-else class="btn btn-outline-dark" type="button" @click="goToLogin">로그인</button> -->
        <button v-if="authStore.isLoggedIn || getItemWithExpireTime(`freedom_to_trip_user_id`)" class="btn btn-outline-dark" type="button" @click="handleLogout">로그아웃</button>
        <button v-else class="btn btn-outline-dark" type="button" @click="goToLogin">로그인</button>
        </div>
      </div>
    </nav>
  </div>
</template>

<style scoped>
@font-face {
  font-family: "pretandard";
  src: url("../../../public/fonts/Pretendard-SemiBold.otf");
}

#navbarScroll {
  font-family: "pretandard";
  font-size: 18px;
}

.navbar-nav .nav-link {
  color: black; /* 검은색으로 변경 */
}

.container-fluid {
  text-align: center; /* 네비게이션 바 가운데 정렬 */
}

.nav-item {
  margin-right: 80px; /* 각 요소 사이의 간격 조절 */
}

.btn-outline-dark {
  margin-right: 100px;
}
</style>
