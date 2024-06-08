const content1 = "새로운 모험을 위한 출발,";
const content2 = "함께하는 여정의 시작";
const text1 = document.querySelector("#typing-text1");
const text2 = document.querySelector("#typing-text2");
let i = 0;
let i2 = 0;

function typing() {
  if (i < content1.length) {
    let txt = content1.charAt(i);
    text1.innerHTML += txt;
    i++;
    setTimeout(typing, 100);
  }
}

function typing2() {
  if (i2 < content2.length) {
    let txt = content2.charAt(i2);
    text2.innerHTML += txt;
    i2++;
    setTimeout(typing2, 100);
  }
}

typing();

setTimeout(typing2, content1.length * 120); // 첫번째 텍스트가 모두 출력된 후에 두번째 텍스트 출력 시작

