import { ref, computed } from "vue";
import { defineStore } from "pinia";

export const useAuthStore = defineStore("auth", {
  state: () => ({
    isLoggedIn: false,
    id: "",
  }),
  actions: {
    login(id) {
      this.isLoggedIn = true;
      this.id = id;
    },
    logout() {
      this.isLoggedIn = false;
    },
  },
});
