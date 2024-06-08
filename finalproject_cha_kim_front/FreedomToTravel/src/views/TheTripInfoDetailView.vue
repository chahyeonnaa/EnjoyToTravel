<script setup lang="ts">
import { ref, onMounted, watch } from "vue";
import "bootstrap-icons/font/bootstrap-icons.css";
import { fetchPlace, fetchPlaceOperationInfo } from "@/api/tripinfo";
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome';
import { fas } from '@fortawesome/free-solid-svg-icons';
import { useSpeechSynthesis } from "@vueuse/core";
import OpenAI from 'openai'

const voice = ref();
const text = ref("Hello, everyone! Good morning!");
const pitch = ref(1);
const rate = ref(1);

const speech = useSpeechSynthesis(text, {
  voice,
  pitch,
  rate,
});

let synth;

const voices = ref([]);

const props = defineProps(["contentId"]);
const contentId = ref(props["contentId"]);
const contentData = ref(null);
const contentOperationInfoData = ref(null);
const scriptForBlind = ref('');

console.log(contentId);

const getPlace = () => {
  fetchPlace(
    contentId.value,
    (response) => {
      contentData.value = response.data.data;
      console.log(contentData.value);
    },
    (error) => {
      console.error(error);
    }
  );
};

const getPlaceOperationInfo = () => {
  fetchPlaceOperationInfo(
    contentId.value,
    (response) => {
      contentOperationInfoData.value = response.data.data;
      console.log(contentOperationInfoData.value);
    },
    (error) => {
      console.error(error);
    }
  );
};

watch([contentData, contentOperationInfoData], ([newContentData, newContentOperationInfoData]) => {
    if (newContentData !== null && newContentOperationInfoData !== null) {
      const newData = {
          place: createFilteredObject(contentData.value.place),
          barrierFreeInfo: createFilteredObject(contentData.value.barrierFreeInfo),
          operationInfo: createFilteredObject(contentOperationInfoData.value)
      };
      const jsonString = JSON.stringify(newData, null, 2);

      const promptString = "우리 홈페이지는 장애인, 영유아 동반 가족, 고령자 등 여행을 갈 때 여행지 선택에 제약사항이 있는 사람들을 대상으로 여행지 정보를 제공하고 있어. 홈페이지에서 제공하는 정보를 시각장애인도 이용할 수 있도록 음성으로 제공하려고 해. 너는 음성으로 읽어줄 스크립트를 만들어줘. 아래 데이터를 활용해서 자연스럽게 한국어로 구성해줘. 인삿말이나홈페이지는 장애인, 영유아 동반 가족, 고령자 등 여행을 갈 때 여행지 선택에 제약사항이 있는 사람들을 대상으로 여행지 정보를 제공하고 있어. 홈페이지에서 제공하는 정보를 시각장애인도 이용할 수 있도록 음성으로 제공하려고 해. 너는 음성으로 읽어줄 스크립트를 만들어줘. 아래 데이터를 활용해서 자연스럽게 한국어로 구성해줘. 인삿말이나 형식적인 내용은 빼고 분량이 길지 않게 해줘.\n\n";
      console.log(jsonString);

      // 아래 둘 중에 하나만 실행하기
      scriptForBlind.value = "대본대본";
      // getGPTResponse(jsonString + promptString);
    }
}); 

watch(scriptForBlind, () => {
  console.log("대본 준비 완료");
  console.log(scriptForBlind);
}); 

const getGPTResponse = async (prompt) => {
  try {
    const openai = new OpenAI({
      apiKey: import.meta.env.VITE_OPENAI_API_KEY,
      dangerouslyAllowBrowser: true,
    })
// const prompt = `안녕?`

const response = await openai.chat.completions.create({
  messages: [
    {
      role: 'user',
      content: prompt,
    },
  ],
  model: 'gpt-3.5-turbo',
})
console.log('chatGPT 결과: ', response.choices[0].message.content)
scriptForBlind.value = response.choices[0].message.content;
  } catch (error) {
    console.log('chatGPT: :rotating_light: 에러가 발생했습니다.')
  }
}

function createFilteredObject(data) {
    const excludeList = [
        "addr2", "areaCode", "bookTour", "cat1", "cat2", "cat3", "contentId",
        "contentTypeId", "createdTime", "firstImage", "firstImage2", "cpyrhtDivCd",
        "mapx", "mapy", "mlevel", "modifiedTime", "sigunguCode", "zipcode"
    ];
    const newObj = {};
    for (const key in data) {
        if (data[key] !== "" && data[key] !== null && data[key] !== undefined && !excludeList.includes(key)) {
            newObj[key] = data[key];
        }
    }
    return newObj;
}

function startVoiceGuide() {
  console.log("음성안내버튼누름");
  console.log(scriptForBlind.value);
  speakAddress(scriptForBlind.value);
}

onMounted(() => {
  getPlace();
  getPlaceOperationInfo();
  if (speech.isSupported.value) {
    // load at last
    setTimeout(() => {
      synth = window.speechSynthesis;
      voices.value = synth.getVoices();
      // voice.value = voices.value.find((voice) => voice.lang === "(ko-KR)");
      // 12
      voice.value = voices.value[12];
    });
  }
  openPopup();
});

function openPopup() {
  // 팝업을 열 때 새로운 창의 속성 설정
  const popup = window.open(
    "", // URL을 지정하지 않음
    "여행할 자유 - 관광 정보 상세 안내", // 팝업의 이름
    "width=400,height=400, top=200,left=500"
  );

  // 팝업 내용 추가
  popup.document.write(`
    <html>
      <head>
        <title>여행할 자유 - 관광 정보 상세 안내</title>
      </head>
      <style>

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

        body {
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          height: 100vh;
          overflow: hidden;
          }

          img {
      margin-bottom: 50px; /* 사진과 텍스트 간격 조정 */
    }

    p {
      margin-bottom: 50px; /* 사진과 텍스트 간격 조정 */
      text-align: center;
    }


        button {
          font-size: 15px;
          padding: 10px 20px;
          background-color: black;
          color: white;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          transition: background-color 0.3s;
           }

    button:hover {
      background-color : #0064ff;
    }

    /* 추가한 스타일 */
  .highlight {
    color: #0064ff;
  }
      </style>
      <body>
        <img
            src="../../../public/img/logo.png"
            class="rounded mx-auto d-block"
            alt="..."
            style="margin-top: 20px;"
          />
          <p style="font-size: 18px">
          해당 페이지 내의 <span class="highlight">모든 정보를 클릭</span>하면 <br /><br /> <span class="highlight">음성 서비스 </span>
           가 제공 됩니다.
  </p>
        <button onclick="window.close()">닫기</button>
      </body>
    </html>
  `);
}

function play() {
  if (speech.status.value === "pause") {
    console.log("resume");
    window.speechSynthesis.resume();
  } else {
    speech.speak();
  }
}

function pause() {
  window.speechSynthesis.pause();
}

function stop() {
  speech.stop();
}

function speakAddress(content) {
  text.value = content;
  speech.speak();
}
</script>

<template>
  <div style="height: 60px"></div>
  <section
    class="testimonials text-center"
    v-if="contentData && contentOperationInfoData"
  >
    <div class="container p-5">
      <h2
        class="mb-5"
        style="font-size: 40px"
        @click="speakAddress(contentData.place.title)"
      >
        {{ contentData.place.title }}
      </h2>
      <p
        style="
          color: #0064ff;
          font-size: 17px;
          font-family: pretandardmedium;
          margin-top: -30px;
        "
        @click="speakAddress(contentData.place.addr1)"
      >
        {{ contentData.place.addr1 }}
      </p>

      <div class="row" style="margin-top: 50px">
        <div class="container d-flex justify-content-center align-items-center">
          <img
            :src="contentData.place.firstImage"
            alt="이미지"
            class="img-fluid"
          />
        </div>
      </div>

      <!-- <div>
        <div v-if="!speech.isSupported">
          Your browser does not support SpeechSynthesis API,
          <a href="https://caniuse.com/mdn-api_speechsynthesis" target="_blank"
            >more details</a
          >
        </div>
        <div v-else>
           <label class="font-bold mr-2">Spoken Text</label>
          <input v-model="text" class="!inline-block" type="text" />

          <br /> 
           <label class="font-bold mr-2">Language</label>
          <div
            bg="$vp-c-bg"
            border="$vp-c-divider 1"
            inline-flex
            items-center
            relative
            rounded
          >
            <i
              i-carbon-language
              absolute
              left-2
              opacity-80
              pointer-events-none
            />
            <select
              v-model="voice"
              px-8
              border-0
              bg-transparent
              h-9
              rounded
              appearance-none
            >
              <option bg="$vp-c-bg" disabled>Select Language</option>
              <option
                v-for="(voice, i) in voices"
                :key="i"
                bg="$vp-c-bg"
                :value="voice"
              >
                {{ `${voice.name} (${voice.lang})` }}
              </option>
            </select>
            <i
              i-carbon-chevron-down
              absolute
              right-2
              opacity-80
              pointer-events-none
            />
          </div>

          <br />
          <div inline-flex items-center>
            <label class="font-bold mr-2">Pitch</label>
            <div class="mt-1" inline-flex>
              <input
                v-model="pitch"
                type="range"
                min="0.5"
                max="2"
                step="0.1"
              />
            </div>
          </div>

          <br />
          <div inline-flex items-center>
            <label class="font-bold mr-3">Rate</label>
            <div class="mt-1" inline-flex>
              <input v-model="rate" type="range" min="0.5" max="2" step="0.1" />
            </div>
          </div>

          <div class="mt-2">
            <button :disabled="speech.isPlaying.value" @click="play">
              {{ speech.status.value === "pause" ? "Resume" : "Speak" }}
            </button>
            <button
              :disabled="!speech.isPlaying.value"
              class="orange"
              @click="pause"
            >
              Pause
            </button>
            <button
              :disabled="!speech.isPlaying.value"
              class="red"
              @click="stop"
            >
              Stop
            </button>
          </div>
        </div> 
      </div>  -->

      <div class="row mt-4 d-flex justify-content-center">
        <!-- 여기야 -->
        <div class="col-md-6 text-start">
          <h4 style="font-family: pretandard; margin-top: 30px">기본 정보</h4>
          <div style="margin-top: 30px">
            <p v-if="contentData.place.addr1" style="display: inline-block">
              주소 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp;
            </p>
            <p
              v-if="contentData.place.addr1"
              style="font-family: pretandardmedium; display: inline-block"
              @click="speakAddress(contentData.place.addr1)"
            >
              {{ contentData.place.addr1 }}
            </p>
            <div></div>
            <p
              v-if="contentOperationInfoData.infoCenterCulture"
              style="display: inline-block"
            >
              문의 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp; &nbsp; &nbsp; &nbsp;
            </p>
            <p
              v-if="contentOperationInfoData.infoCenterCulture"
              style="font-family: pretandardmedium; display: inline-block"
              @click="speakAddress(contentOperationInfoData.infoCenterCulture)"
            >
              {{ contentOperationInfoData.infoCenterCulture }}
            </p>
            <div></div>
            <p
              v-if="contentOperationInfoData.restDateCulture"
              style="display: inline-block"
            >
              휴무일 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              &nbsp; &nbsp;
            </p>
            <p
              v-if="contentOperationInfoData.restDateCulture"
              style="font-family: pretandardmedium; display: inline-block"
              @click="speakAddress(contentOperationInfoData.restDateCulture)"
            >
              {{ contentOperationInfoData.restDateCulture }}
            </p>
            <div></div>
            <p
              v-if="contentOperationInfoData.useTimeCulture"
              style="display: inline-block"
            >
              이용시간 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            </p>
            <p
              v-if="contentOperationInfoData.useTimeCulture"
              style="font-family: pretandardmedium; display: inline-block"
              @click="speakAddress(contentOperationInfoData.useTimeCulture)"
            >
              {{ contentOperationInfoData.useTimeCulture }}
            </p>
          </div>
        </div>
      </div>

      <div class="row d-flex justify-content-center" style="margin-top: 100px">
        <div class="col-md-6 text-start">
          <h4>무장애 편의정보</h4>
          <!-- 여기부터 -->
          <div class="row" style="width: 900px; margin-left: -100px">
            <div
              class="container p-5 shadow-sm"
              style="
                width: 1100px;
                margin-top: 20px;
                margin-bottom: 30px;
                border: 1px solid lightgray;
                border-radius: 20px;
              "
            >
              <div
                class="flex-container"
                style="display: flex; align-items: flex-start"
              >
                <div
                  style="
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    margin-right: 20px;
                  "
                >
                  <img
                    src="/img/barrierIcon/wheelchair.png"
                    style="width: 160px"
                  />
                  <p
                    class="type"
                    style="
                      font-size: 20px;
                      margin-top: 20px;
                      margin-left: -20px;
                    "
                  >
                    지체장애
                  </p>
                </div>
                <div class="disabled1">
                  <ul
                    style="list-style-type: none; padding: 0; margin-left: 50px"
                  >
                    <li
                      v-if="contentData.barrierFreeInfo.parking"
                      style="margin-bottom: 20px"
                      @click="speakAddress(contentData.barrierFreeInfo.parking)"
                    >
                      <span style="color: #0064ff">주차</span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.parking
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.route"
                      style="margin-bottom: 20px"
                      @click="speakAddress(contentData.barrierFreeInfo.route)"
                    >
                      <span style="color: #0064ff">출입경로 </span> &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.route
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.publicTransport"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(
                          contentData.barrierFreeInfo.publicTransport
                        )
                      "
                    >
                      <span style="color: #0064ff">대중교통 </span> &nbsp;
                      &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.publicTransport }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.ticketOffice"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.ticketOffice)
                      "
                    >
                      <span style="color: #0064ff">매표소</span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.ticketOffice }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.promotion"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.promotion)
                      "
                    >
                      <span style="color: #0064ff">홍보물</span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.promotion
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.wheelchair"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.wheelchair)
                      "
                    >
                      <span style="color: #0064ff">휠체어 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.wheelchair
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.exits"
                      style="margin-bottom: 20px"
                      @click="speakAddress(contentData.barrierFreeInfo.exits)"
                    >
                      <span style="color: #0064ff">출구 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.exits }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.elevator"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.elevator)
                      "
                    >
                      <span style="color: #0064ff">엘리베이터 </span> &nbsp;
                      &nbsp; {{ contentData.barrierFreeInfo.elevator }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.restroom"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.restroom)
                      "
                    >
                      <span style="color: #0064ff">화장실 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.restroom
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.auditorium"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.auditorium)
                      "
                    >
                      <span style="color: #0064ff">객석 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.auditorium }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.room"
                      style="margin-bottom: 20px"
                      @click="speakAddress(contentData.barrierFreeInfo.room)"
                    >
                      <span style="color: #0064ff">객실</span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.room
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.handicapEtc"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.handicapEtc)
                      "
                    >
                      <span style="color: #0064ff">기타 </span>&nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.handicapEtc }}
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>

          <div
            v-if="
              contentData.barrierFreeInfo &&
              (contentData.barrierFreeInfo.braileBlock ||
                contentData.barrierFreeInfo.helpDog ||
                contentData.barrierFreeInfo.guideHuman ||
                contentData.barrierFreeInfo.audioGuide ||
                contentData.barrierFreeInfo.bigPrint ||
                contentData.barrierFreeInfo.brailePromotion ||
                contentData.barrierFreeInfo.guideSystem ||
                contentData.barrierFreeInfo.blindHandicapEtc ||
                contentData.barrierFreeInfo.signGuide ||
                contentData.barrierFreeInfo.videoGuide)
            "
          >
            <div class="row" style="width: 900px; margin-left: -100px">
              <div
                class="container p-5 shadow-sm"
                style="
                  width: 1500px;
                  margin-bottom: 30px;
                  margin-top: 20px;
                  border: 1px solid lightgray;
                  border-radius: 20px;
                "
              >
                <div
                  class="flex-container"
                  style="display: flex; align-items: flex-start"
                >
                  <div
                    style="
                      display: flex;
                      flex-direction: column;
                      align-items: center;
                      margin-right: 20px;
                    "
                  >
                    <img src="/img/barrierIcon/hide.png" style="width: 160px" />
                    <p
                      class="type"
                      style="
                        font-size: 20px;
                        margin-top: 20px;
                        margin-left: 5px;
                      "
                    >
                      시각장애
                    </p>
                  </div>
                  <ul
                    style="list-style-type: none; padding: 0; margin-left: 50px"
                  >
                    <li
                      v-if="contentData.barrierFreeInfo.braileBlock"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.braileBlock)
                      "
                    >
                      <span style="color: #0064ff">점자블록 </span> &nbsp;
                      &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.braileBlock }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.helpDog"
                      style="margin-bottom: 20px"
                      @click="speakAddress(contentData.barrierFreeInfo.helpDog)"
                    >
                      <span style="color: #0064ff">도우미견 </span> &nbsp;
                      &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.helpDog
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.guideHuman"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.guideHuman)
                      "
                    >
                      <span style="color: #0064ff">안내인 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.guideHuman }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.audioGuide"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.audioGuide)
                      "
                    >
                      <span style="color: #0064ff">오디오가이드 </span> &nbsp;
                      &nbsp; {{ contentData.barrierFreeInfo.audioGuide }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.bigPrint"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.bigPrint)
                      "
                    >
                      <span style="color: #0064ff">큰 글자 인쇄물 </span> &nbsp;
                      &nbsp; {{ contentData.barrierFreeInfo.bigPrint }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.brailePromotion"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(
                          contentData.barrierFreeInfo.brailePromotion
                        )
                      "
                    >
                      <span style="color: #0064ff">점자 홍보물 </span> &nbsp;
                      &nbsp; {{ contentData.barrierFreeInfo.brailePromotion }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.guideSystem"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.guideSystem)
                      "
                    >
                      <span style="color: #0064ff">안내 시스템 </span> &nbsp;
                      &nbsp; {{ contentData.barrierFreeInfo.guideSystem }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.blindHandicapEtc"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(
                          contentData.barrierFreeInfo.blindHandicapEtc
                        )
                      "
                    >
                      <span style="color: #0064ff">기타 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.blindHandicapEtc }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.signGuide"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.signGuide)
                      "
                    >
                      <span style="color: #0064ff">수화안내 </span> &nbsp;
                      &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.signGuide
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.videoGuide"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.videoGuide)
                      "
                    >
                      <span style="color: #0064ff">비디오 가이드 </span> &nbsp;
                      &nbsp; {{ contentData.barrierFreeInfo.videoGuide }}
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>

          <div
            v-if="
              contentData.barrierFreeInfo &&
              (contentData.barrierFreeInfo.stroller ||
                contentData.barrierFreeInfo.nursingRoom ||
                contentData.barrierFreeInfo.childSeat ||
                contentData.barrierFreeInfo.other)
            "
          >
            <div class="row" style="width: 900px; margin-left: -100px">
              <div
                class="container p-5 shadow-sm"
                style="
                  width: 1500px;
                  margin-top: 20px;
                  border: 1px solid lightgray;
                  border-radius: 20px;
                "
              >
                <div
                  class="flex-container"
                  style="display: flex; align-items: flex-start"
                >
                  <div
                    style="
                      display: flex;
                      flex-direction: column;
                      align-items: center;
                      margin-right: 20px;
                    "
                  >
                    <img src="/img/barrierIcon/baby.png" style="width: 160px" />
                    <p
                      class="type"
                      style="
                        font-size: 20px;
                        margin-top: 20px;
                        margin-left: 0px;
                      "
                    >
                      영유아
                    </p>
                  </div>
                  <ul
                    style="list-style-type: none; padding: 0; margin-left: 50px"
                  >
                    <li
                      v-if="contentData.barrierFreeInfo.stroller"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.stroller)
                      "
                    >
                      <span style="color: #0064ff"> 유모차 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;{{
                        contentData.barrierFreeInfo.stroller
                      }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.lactationRoom"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.lactationRoom)
                      "
                    >
                      <span style="color: #0064ff">수유실</span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.lactationRoom }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.babySpareChair"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(contentData.barrierFreeInfo.babySpareChair)
                      "
                    >
                      <span style="color: #0064ff">유아용 의자</span> &nbsp;
                      &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.babySpareChair }}
                    </li>
                    <li
                      v-if="contentData.barrierFreeInfo.infantsFamilyEtc"
                      style="margin-bottom: 20px"
                      @click="
                        speakAddress(
                          contentData.barrierFreeInfo.infantsFamilyEtc
                        )
                      "
                    >
                      <span style="color: #0064ff">기타 </span> &nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      {{ contentData.barrierFreeInfo.infantsFamilyEtc }}
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <div class="voice-guide-icon" @click="startVoiceGuide">
    <font-awesome-icon 
      :icon="['fas', 'volume-high']" 
      size="3x"
    />
  </div>
</template>

<style>
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

button.btn {
  margin-right: 0.5rem;
}
button.btn:last-child {
  margin-right: 0;
}
div.border {
  border: 1px solid #ced4da;
}
div.border:hover {
  background-color: #e9ecef;
}
#map {
  width: 100%;
  height: 500px;
}

.card {
  border: 1px solid #e0e0e0;
  border-radius: 10px;
}
.card-body {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}
.card-text {
  margin-bottom: 10px;
}
.info-window {
  width: 200px;
  text-align: center;
  padding: 10px;
  background-color: #ffffff;
  border: 1px solid #cccccc;
}

.info-title {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 5px;
}

.info-address {
  font-size: 14px;
  margin-bottom: 5px;
}

.info-image img {
  width: 150px;
}

.info-coordinates {
  font-size: 12px;
  color: #666666;
}

.voice-guide-icon {
  position: fixed; /* 아이콘을 페이지에 고정합니다. */
  top: 80px; /* 페이지 하단으로부터의 거리를 조절합니다. */
  right: 40px; /* 페이지 우측으로부터의 거리를 조절합니다. */
  z-index: 9999; /* 다른 요소 위에 표시되도록 z-index 값을 설정합니다. */
  cursor: pointer; /* 마우스 커서를 포인터로 변경합니다. */
  /* 아이콘의 스타일을 여기에 추가하세요 */
}
</style>
