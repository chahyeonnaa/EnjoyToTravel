import { localAxios } from "@/util/http-commons";

const local = localAxios();

// 시도 목록을 가져오는 API 호출 함수
function fetchSiDoList(success, fail) {
  local.get(`/area/sido`).then(success).catch(fail);
}

// 시군구 목록을 가져오는 API 호출 함수
function fetchSiGunGuList(sidoCode, success, fail) {
  local.get(`/area/gugun?sidocode=${sidoCode}`).then(success).catch(fail);
}

// 장소 목록을 가져오는 API 호출 함수
function fetchPlacesList(
  contentTypeId,
  barrierType,
  areaCode,
  sigunguCode,
  inputKeyword,
  success,
  fail
) {
  local
    .get(`/places/list`, {
      params: {
        contentTypeId,
        barrierType,
        areaCode,
        sigunguCode,
        inputKeyword,
      },
    })
    .then(success)
    .catch(fail);
}

function fetchPlacesListOfCard(
  contentTypeId,
  areaCode,
  sigunguCode,
  inputKeyword,
  success,
  fail
) {
  local
    .get(`/places/list/card`, {
      params: {
        contentTypeId,
        areaCode,
        sigunguCode,
        inputKeyword,
      },
    })
    .then(success)
    .catch(fail);
}

// 장소 하나를 가져오는 API 호출 함수
function fetchPlace(
  contentId,
  success,
  fail
) {
  local
    .get(`/places/${contentId}`)
    .then(success)
    .catch(fail);
}

function fetchPlaceOperationInfo(contentId, success, fail) {
  local.get(`/places/${contentId}/operation`).then(success).catch(fail);
}

export {
  fetchSiDoList,
  fetchSiGunGuList,
  fetchPlacesList,
  fetchPlace,
  fetchPlaceOperationInfo,
  fetchPlacesListOfCard,
};