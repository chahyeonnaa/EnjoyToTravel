<template>
  <div class="popup">
    <div class="popup-content">
      <h2>선택할 장소를 클릭하세요</h2>
      <ul>
        <li v-for="place in this.places.data" :key="place.contentId" @click="this.selectPlace(place)">
          {{ place.title }}
        </li>
      </ul>
      <button @click="this.closePopup">닫기</button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    places: {
      type: Array,
      required: true
    }
  },
  methods: {
    selectPlace(place) {
      console.log(this.places); // 여기에 추가
      this.$emit('place-selected', place);
    },
    closePopup() {
      console.log(this.places); // 여기에 추가
      this.$emit('close-popup');
    }
  }
}


</script>

<style scoped>
.popup {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}
.popup-content {
  background: white;
  padding: 20px;
  border-radius: 5px;
}
</style>
