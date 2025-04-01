<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   .soMenu {
     display:none;
   }
 </style>
 <script>
  function viewSo(n)
  {
	  document.getElementsByClassName("soMenu")[n].style.display="block";
  }
  function hideSo(n)
  {
	  document.getElementsByClassName("soMenu")[n].style.display="none";
  }
 </script>
</head>
<body> <!-- etc/node2.jsp -->

  <ul>
    <li onmouseover="viewSo(0)" onmouseout="hideSo(0)"> TV 
      <ul class="soMenu">
        <li> 대형TV </li>
        <li> 중형TV </li>
        <li> 소형TV </li>
        <li> 휴대용TV </li>
      </ul>
    </li>
    <li onmouseover="viewSo(1)" onmouseout="hideSo(1)"> 냉장고 
      <ul class="soMenu">
        <li> 양문형냉장고  </li>
        <li> 김치냉장고 </li>
        <li> 와인냉장고 </li>
        <li> 소형냉장고 </li>
      </ul>  
    </li>
    <li onmouseover="viewSo(2)" onmouseout="hideSo(2)"> 세탁기 
      <ul class="soMenu">
        <li> 드럼세탁기 </li>
        <li> 일반세탁기 </li>
        <li> 미니세탁기 </li>
        <li> 건조기 </li>
      </ul>
    </li>
    <li onmouseover="viewSo(3)" onmouseout="hideSo(3)"> 컴퓨터 
      <ul class="soMenu">
        <li> 데스크탑 </li>
        <li> 노트북 </li>
        <li> 서버 </li>
        <li> 미니PC </li>
      </ul>
    </li>
    <li onmouseover="viewSo(4)" onmouseout="hideSo(4)"> 청소기 
      <ul class="soMenu">
        <li> 유선청소기 </li>
        <li> 무선청소기 </li>
        <li> 휴대용청소기 </li>
      </ul>
    </li>
  </ul>
</body>
</html>