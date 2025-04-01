<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   table {
      border-spacing:0px;
      border:1px solid black;
      border-collapse:collapse;
   }
   table td {
      border:1px solid black;
      text-align:center;
      width:50px;
      height:40px;
   }
   table tr td:first-child {
      color:red;
   }
   table tr td:last-child {
      color:blue;
   }
 </style>
 <script>
   // 달력만들기 => 1일의 요일, 총일수, 몇 주
   function genCal(y,m) //자바스크립트 지역변수에 var을 제외하고 선언시 => 전역변수
   {
	   if(!y) // 이동할 년, 월이 온다면
	{
		   var today=new Date(); // 오늘의 날짜객체를 생성
		   y=today.getFullYear(); // 4자리 연도
		   m=today.getMonth();    // 0~11의 값을 가진다..
	}
	   if(m==-1) // 1월에서 이전을 클릭
	{
		y--;
		m=11;	// Date클래스에서 12월의 값은 11
	}
	   if(m==12)// 12월에서 다음을 클릭
	{
		y++;
		m=0;	// Date클래스에 1월의 값은 0
	}
	   

	   
	   // 이번달 1일의 객체를 구하고자 한다면 => new Date(년,월,1);
	   var xday=new Date(y,m,1);
 	   
	   // 요일
	   var yoil=xday.getDay(); // 0~6까지의 (일~토)
	
	   // 총일수 구하기 => 배열을 이용
	   var month=[31,28,31,30,31,30,31,31,30,31,30,31]; // 인덱스와 getMonth()의 값이 0~11로 같다
	   var chong=month[m];
	   
	   // 윤년일 경우 2월달 => 29일
	   if(m==1) // 2월 인 경우 윤년을 계산한다
	   {
		   if( (y%4==0 && y%100!=0) || y%400==0  )  // 윤년이라면 => 년도를 4로 나누었을때 나머지가 0 => 100의 단위는 윤년이 아니다  =>  400의 단위는 윤년이다
		   {
			   chong++; // 1을 더한다. 
		   }	   
	   }
	 
	   // 몇주인가
	   var ju=Math.ceil( (chong+yoil)/7 );
	   
 
	   // 변수에 달력을 위한 태그를 누적
	   var calendar="<table>";
	   calendar=calendar+"<caption>";
	   calendar=calendar+"<a href='javascript:genCal("+y+","+(m-1)+")'> 이전 </a>";
	   calendar=calendar+y+"년 "+(m+1)+"월:";
	   calendar=calendar+"<a href='javascript:genCal("+y+","+(m+1)+")'> 다음 </a>";
	   calendar=calendar+"</caption>";
	   calendar=calendar+"<tr>";
	   calendar=calendar+" <td> 일 </td>";
	   calendar=calendar+" <td> 월 </td>";
	   calendar=calendar+" <td> 화 </td>";
	   calendar=calendar+" <td> 수 </td>";
	   calendar=calendar+" <td> 목 </td>";
	   calendar=calendar+" <td> 금 </td>";
	   calendar=calendar+" <td> 토 </td>";
	   calendar=calendar+"</tr>";
	   
	   var day=1;
	   for(i=0; i<ju; i++)
	   {
		   calendar=calendar+"<tr>";
		   
		   // td 7개 넣기
		   for(j=0;j<7;j++)
		   {
               if( (i==0 && j<yoil) || chong<day )
               {
            	   calendar=calendar+"<td> </td>";
               }	
               else
               {
            	   calendar=calendar+"<td>"+day+"</td>";
            	   day++;
               }	   			   		   
		   }	   
		   
		   calendar=calendar+"</tr>";
	   }	   
	   
	   calendar=calendar+"</table>";
	   
	   // id="cal"인 곳에 innerHTML
	   document.getElementById("cal").innerHTML=calendar;
	   
	   //휴일의 값을 가져와서 달력에 표시하기 => 비동기방식을 이용하여 holiday테이블에서 이번달의 휴일을 읽어온다.
   }
   var chk=new XMLHttpRequest();
   chk.onload=function()
   {
	   var hols=JSON.parse(chk.responseText);
   }
   
   for(hol of hols)
	   {
	   	var n=hol.dday-1; //일
	   	document.getElementsByClassName("days")[n].style.color="red";
	   	document.getElementsByClassName("tt")[n].innerText=hol.title;
	   	document.getElementsByClassName("tt")[n].style.fontSize="10px";
	   }
   
   chk.open("get","getHoliday?y="+y+"&m="+(m+1));
   
   chk.send();
   
   function srcView()
   {
	   document.getElementById("src").innerText=document.getElementById("cal").innerHTML
   }
 </script>
</head>
<body> <!-- etc/jsCal.jsp -->
  <input type="button" onclick="genCal()" value="달력생성">
  <input type="button" onclick="srcView()" value="소스보기">
  <hr>
  <div id="cal"></div>
  <hr>
  <div id="src"></div>
</body>
</html>












