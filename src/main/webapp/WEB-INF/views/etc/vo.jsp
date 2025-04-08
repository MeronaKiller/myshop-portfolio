<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Voice Recognition</title>
 
<script>
// 전역 변수로 recognition 선언
let recognition;
window.addEventListener("load", function () 
{
   availabilityFunc();
   
   function availabilityFunc() 
   {
    // webkitSpeechRecognition 또는 SpeechRecognition을 생성
    recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
    recognition.lang = "ko"; // 음성인식에 사용될 언어 설정
    recognition.maxAlternatives = 5; // 음성 인식결과를 5개까지 보여준다.

    // 음성 인식 기능을 지원하지 않으면 경고 메시지
    if (!recognition) 
    {
        alert("현재 브라우저는 음성 인식을 지원하지 않습니다.");
    }
   }
});


// --- 음성녹음을 실행하는 함수
function startRecord() {

 console.log("음성 인식 시작");

 // ⏺️ 클릭 시 음성 인식을 시작한다.
 recognition.addEventListener("speechstart", () => {
     console.log("음성 인식 시작");
 });

 // 음성 인식이 끝나면 종료된다.
 recognition.addEventListener("speechend", () => {
     console.log("음성 인식 종료");
 });

 // 음성 인식 결과를 반환
recognition.addEventListener("result", (e) => {
  // e.results가 존재하는지, 그리고 첫 번째 항목이 있는지 확인
  //alert(e.results);
  //alert(e.results[0]);
  //alert(e.results[0][0].transcript);
  if (e.results && e.results[0] && e.results[0][0]) {
    // 정상적으로 결과가 있다면 searchConsole에 값 할당
    document.getElementById("search_console").value =e.results[0][0].transcript
  } else {
    // 결과가 없다면 경고 메시지 또는 빈 문자열 설정
    console.log("음성 인식 결과가 없습니다.");
    document.getElementById("search_console").value = ""; // 음성 인식 결과가 없을 경우 빈 문자열로 처리
  }
});


 recognition.start();
}

// 🛑 클릭 시 종료
function endRecord() {
 console.log("음성 인식 종료");
 recognition.stop(); // 음성 인식 중지
}

function speak(text) {
	var text=document.getElementById("search_console").value;
    const speech = new SpeechSynthesisUtterance(text);
    speech.lang = "ko-KR";  // 한국어 설정
    speech.rate = 1.0;      // 속도 (0.1 ~ 10, 기본값: 1)
    speech.pitch = 0.0;     // 음조 (0 ~ 2, 기본값: 1)
    speech.volume = 1.0;    // 볼륨 (0 ~ 1, 기본값: 1)

    window.speechSynthesis.speak(speech);
}
</script>
</head>
<body>
<article class="form">
    <input type="text" id="search_console" size="100" />
    <button type="button" onclick="startRecord()">⏺️</button>
    <button type="button" onclick="endRecord()">🛑</button>
</article>
<input type="button" onclick="speak()" value="클릭">
</body>
</html>
 