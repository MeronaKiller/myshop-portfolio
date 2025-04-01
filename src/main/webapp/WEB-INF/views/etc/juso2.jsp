<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script>
 function juso_search()  // 우편번호 버튼 클릭시 호출 함수명
 {
     // 우편번호 검색 UI를 띄울 컨테이너를 선택
     var container = document.getElementById('postcodeContainer');

     // daum.Postcode API를 사용하여 우편번호 검색을 현재 페이지 내에서 열기
     new daum.Postcode({
         oncomplete: function(data) {
             var addr = ''; // 주소 초기화

             // 도로명 주소 또는 지번 주소를 선택
             if (data.userSelectedType === 'R') {
                 addr = data.roadAddress;  // 도로명 주소
             } else {
                 addr = data.jibunAddress;  // 지번 주소
             }

             // 우편번호와 주소를 폼에 넣기
             document.pkc.zip.value = data.zonecode;  // 우편번호
             document.pkc.juso.value = addr;  // 주소

             // 상세주소 입력 필드로 커서 이동
             document.pkc.jusoEtc.focus();

             // 검색 결과 UI를 숨기기 (검색 후 다시 닫기)
             container.style.display = 'none';
         },
         width: '100%',  // 검색 UI의 너비
         height: '400px',  // 검색 UI의 높이
         autoClose: true  // 선택 후 자동으로 닫기
     }).embed(container);  // 우편번호 검색 UI를 지정된 컨테이너에 띄우기
 }
 </script> 
</head>
<body> <!-- etc/juso -->
<form name="pkc">
  <input type="text" name="zip" placeholder="우편번호">
  <input type="text" name="juso" placeholder="주소">
  <input type="text" name="jusoEtc" placeholder="상세주소">
  <button type="button" onclick="juso_search()">주소검색</button>
</form>

<!-- 우편번호 검색 UI를 표시할 컨테이너 -->
<div id="postcodeContainer" style="display:none;"></div>
   
</body>
</html>