<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
 function speak(text) {
	    const speech = new SpeechSynthesisUtterance(text);
	    speech.lang = "ko-KR";  // 한국어 설정
	    speech.rate = 1.0;      // 속도 (0.1 ~ 10, 기본값: 1)
	    speech.pitch = 1.0;     // 음조 (0 ~ 2, 기본값: 1)
	    speech.volume = 1.0;    // 볼륨 (0 ~ 1, 기본값: 1)

	    window.speechSynthesis.speak(speech);
	}

 

 </script>
</head>
<body>
 <input type="button" onclick="speak('윤영제씨 일찍 주무시고 열심히 공부합시다.')" value="클릭">
</body>
</html>