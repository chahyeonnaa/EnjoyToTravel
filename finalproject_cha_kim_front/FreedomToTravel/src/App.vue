<script setup>
import { RouterView } from "vue-router";
import HeadingNavbar from "@/components/layout/HeadingNavbar.vue";
import FooterNavbar from "@/components/layout/FooterNavbar.vue";
</script>

<template>
  <div>
    <HeadingNavbar></HeadingNavbar>
    <router-view></router-view>
    <FooterNavbar></FooterNavbar>
  </div>
</template>

<style scoped></style>
