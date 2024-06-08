<template>
  <div class="card h-100">
    <img
      :src="trip.firstImage ? trip.firstImage : '/img/no-image.jpg'"
      height="200px"
      class="card-img-top"
      alt="썸네일"
    />

    <div class="card-body">
      <h5 style="font-family: pretandard" class="card-title">
        {{ trip.title }}
      </h5>
      <p style="font-family: pretandardmedium" class="card-text">
        {{ trip.areaCode }}
      </p>
      <div class="d-flex flex-wrap">
        <font-awesome-icon
          v-if="trip.isAvailableToBlind == 1"
          :icon="['far', 'eye-slash']"
          size="2x"
          color="#2F92F5"
        ></font-awesome-icon>
        <div v-if="trip.isAvailableToBlind == 1" style="width: 10px"></div>
        <font-awesome-icon
          v-if="trip.isAvailableToPhysicalDisablity == 1"
          :icon="['fas', 'wheelchair']"
          size="2x"
          color="#C4B7F7"
        />
        <div
          v-if="trip.isAvailableToPhysicalDisablity == 1"
          style="width: 10px"
        ></div>
        <font-awesome-icon
          v-if="trip.isAvailableToChildren == 1"
          :icon="['fas', 'baby']"
          size="2x"
          color="#4089F5"
        ></font-awesome-icon>
        <div v-if="trip.isAvailableToChildren == 1" style="width: 10px"></div>
        <font-awesome-icon
          v-if="trip.isAvailableToSenior == 1"
          :icon="['fas', 'person-cane']"
          size="2x"
          color="#2FBEF5"
        ></font-awesome-icon>
        <div v-if="trip.isAvailableToSenior == 1" style="width: 10px"></div>
        <font-awesome-icon
          v-if="trip.isAvailableToHardOfHearing == 1"
          :icon="['fas', 'ear-deaf']"
          size="2x"
          color="#287DFA"
        ></font-awesome-icon>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  trip: Object,
  required: true,
});
</script>

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
</style>
