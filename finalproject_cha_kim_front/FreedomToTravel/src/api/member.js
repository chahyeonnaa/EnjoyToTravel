import { localAxios } from "@/util/http-commons";

const local = localAxios();

function signMember(member, success, fail) {
  console.log("member", member);
  console.log(local);
  local.post(`/user/sign`, JSON.stringify(member)).then(success).catch(fail);
}

function loginMember(credentials, success, fail) {
  local
    .get(`/user/login`, {
      params: {
        id: credentials.id,
        password: credentials.password,
      },
    })
    .then(success)
    .catch(fail);
}

export { signMember, loginMember };
