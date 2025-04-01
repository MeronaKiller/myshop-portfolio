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
  function viewSo(my)
  {
	   //alert(my.childNodes.length);
	   my.childNodes[1].style.display="block";
  }
  function hideSo(my)
  {
	  my.childNodes[1].style.display="none";
  }
 </script>
</head>
<body> <!-- etc/node3.jsp -->

  <ul>
    <li onmouseover="viewSo(this)" onmouseout="hideSo(this)"> TV 
      <ul class="soMenu">
        <li> 대형TV </li>
        <li> 중형TV </li>
        <li> 소형TV </li>
        <li> 휴대용TV </li>
      </ul>
    </li>
    <li onmouseover="viewSo(this)" onmouseout="hideSo(this)"> 냉장고 
      <ul class="soMenu">
        <li> 양문형냉장고  </li>
        <li> 김치냉장고 </li>
        <li> 와인냉장고 </li>
        <li> 소형냉장고 </li>
      </ul>  
    </li>
    <li onmouseover="viewSo(this)" onmouseout="hideSo(this)"> 세탁기 
      <ul class="soMenu">
        <li> 드럼세탁기 </li>
        <li> 일반세탁기 </li>
        <li> 미니세탁기 </li>
        <li> 건조기 </li>
      </ul>
    </li>
    <li onmouseover="viewSo(this)" onmouseout="hideSo(this)"> 컴퓨터 
      <ul class="soMenu">
        <li> 데스크탑 </li>
        <li> 노트북 </li>
        <li> 서버 </li>
        <li> 미니PC </li>
      </ul>
    </li>
    <li onmouseover="viewSo(this)" onmouseout="hideSo(this)"> 청소기 
      <ul class="soMenu">
        <li> 유선청소기 </li>
        <li> 무선청소기 </li>
        <li> 휴대용청소기 </li>
      </ul>
    </li>
  </ul>
</body>
</html>