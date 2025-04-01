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
      width:24px;
      height:24px;
      vertical-align:top;
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
   function genCal(y,m,x)  // 자바스크립트 지역변수에 var을 제외하고 선언시 => 전역변수
   {
	   document.getElementById("cal").style.visibility="visible";
	   
       if(!y || y==0) // y가 없다면 => true
	   {
		   var today=new Date(); // 오늘의 날짜객체를 생성
		   y=today.getFullYear(); // 4자리 연도
		   m=today.getMonth();    // 0~11의 값을 가진다..
	   }	   
	   
       if(m==-1) // 1월에서 이전을 클릭
       {
    	   y--;
    	   m=11; // Date클래스에서 12월의 값은 11
       }	   
       if(m==12) // 12월에서 다음을 클릭
       {
    	   y++;
    	   m=0; // Date클래스에 1월의 값은 0
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
	   calendar=calendar+" <a href='javascript:genCal("+y+","+(m-1)+","+x+")'> 이전 </a>";
	   calendar=calendar+y+"년 "+(m+1)+"월 ";
	   calendar=calendar+" <a href='javascript:genCal("+y+","+(m+1)+","+x+")'> 다음 </a>";
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
            	   calendar=calendar+"<td class='days' onclick='getNalja("+y+","+m+","+day+","+x+")'>"+day+"<br><span class='tt'></span>    </td>";
            	   day++;                                     // onclick='getNalja(2025,1,22)'
               }	   			   		    
		   }	   
		   
		   calendar=calendar+"</tr>";
	   }	   
	   
	   calendar=calendar+"</table>";
	   
	   // id="cal"인 곳에 innerHTML
	   document.getElementById("cal").innerHTML=calendar;
	   
	  
   }
   function getNalja(y,m,d,x) // y는 4자리 년도 , m(0~11)
   {
	   // td가 클릭되면 해당 위치의 년,월,일을 text에 전달 => 2025-01-05
	   m++;
	   m=m+"";
	   d=d+"";
	   
	   m=m.padStart(2,"0");
	   d=d.padStart(2,"0");
	   
	   /*
	   if(m.length==1)
		   m="0"+m;
	   if(d.length==1)
		   d="0"+d;
	   */
	   
	   
	   var days=y+"-"+m+"-"+d;
	   if(x==0)
		   document.getElementById("start").value=days;
	   else
		   document.getElementById("end").value=days;
	   //my.value=days;
	   
	   document.getElementById("cal").style.visibility="hidden";
   }
 </script>
 <style>
   #form {
      position:relative;
      width:350px;
      margin:auto;
   }
   #form #cal {
      position:absolute;
   }
 </style>
</head>
<body> <!-- etc/jsCal2.jsp -->
   <!-- 
      1. type="text"에 커서가 들어오면 달력이 보이기
      2. 날짜를 선택하면 년-월-일이 text에 들어간다
      3. 달력을 숨기기
    -->
   <div id="form">
      <input type="text" name="start" readonly placeholder="시작일" onfocus="genCal(0,0,0)" id="start">
      <input type="text" name="end" readonly placeholder="완료일" onfocus="genCal(0,0,1)" id="end">
      
      <div id="cal"></div>
   </div>
   
   
</body>
</html>












