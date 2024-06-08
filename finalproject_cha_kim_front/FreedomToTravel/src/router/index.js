import { createRouter, createWebHistory } from "vue-router";
import TheMainView from "../views/TheMainView.vue";
import TheTripInfo from "../views/TheTripInfoView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "main",
      component: TheMainView,
    },
    {
      path: "/write",
      name: "write",
      component: () => import("../views/TheWriteView.vue"),
    },

    {
      path: "/sign",
      name: "sign",
      component: () => import("@/components/member/Sign.vue"),
    },
    {
      path: "/courseview",
      name: "courseview",
      component: () => import("../views/TheCourseView.vue"),
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/TheMemberView.vue"),
      // children: [
      //   {
      //     path: "sign",
      //     name: "sign",
      //     component: () => import("@/components/member/Sign.vue"),
      //   },
      // ],
    },
    {
      path: "/tripinfo",
      name: "tripinfo",
      component: TheTripInfo,
    },
    {
      path: "/tripinfo/:contentId",
      name: "tripinfodetailview",
      component: () => import("../views/TheTripInfoDetailView.vue"),
      props: true
    },
    {
      path: "/coursedetailview/:courseId",
      name: "coursedetailview",
      component: () => import("../views/TheCourseDetailView.vue"),
    },
  ],
});

export default router;
