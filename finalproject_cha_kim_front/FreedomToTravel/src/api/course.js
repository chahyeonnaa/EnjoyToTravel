import { localAxios } from "@/util/http-commons";

const local = localAxios();

function writeCourse(requestBody, success, fail) {
  console.log("course", requestBody);
  local
    .post(`/course/write`, JSON.stringify(requestBody))
    .then(success)
    .catch(fail);
}

function listCourse(param, success, fail) {
  console.log("course111", param);
  local.get(`/course/list`, { params: param }).then(success).catch(fail);
}

function getCoursePost(courseNumber, success, fail) {
  console.log("course111", courseNumber);
  local.get(`/course/${courseNumber}`).then(success).catch(fail);
}

// 장소 컴포넌트 배열로 받아오기 - 뷰에서 받은 다음 자식 컴포넌트로 넘겨주는게 좋겠네

export { writeCourse, listCourse, getCoursePost };
