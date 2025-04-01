<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
   section {
     width:1100px;
     height:600px;
     margin:auto;
      position:relative;
   }
   section #mainTable {
       border-spacing:0px;
    }
    section #mainTable tr td {
       height:60px;
       border-bottom:1px solid black;
       padding-top:6px;
       padding-bottom:6px;
    }
    section #mainTable tr:first-child td {
       border-top:2px solid black;
       height:40px;
    }
    section #mainTable tr:last-child td {
       border-bottom:2px solid black;
    }
 
    
    section #calendar {
     position:absolute;
     left:400px;
     top:100px;
    }
    section #calendar #cal2 {
       background:white;
       border-spacing:0px;
    }
    section #calendar #cal2 caption {
       background:white;
       border:1px solid black;
       height:36px;
       line-height:36px;
       padding-top:3px;
    }
    section #calendar  #cal2  tr td {
       width:24px;
       height:24px;
       border:1px solid black;
       background:white;
       padding:2px;
       text-align:center;
       cursor:pointer;
    }
    section #calendar  #cal2  tr td:hover {
       background:purple;
       color:white;
    }
    section input[type=button] {
       border:1px solid black;
       background:white;
       vertical-align:middle;
    }
    section input[type=button]:hover {
       background:#eeeeee;
    }
    section input[type=text] {
       border:1px solid black;
       width:90px;
       height:18px;
       text-align:center;
       padding-bottom:1px;
    }
 </style>
 <script>
   function makeCal(y,m,n) // class='nalJa'의 index
   {
 
	   
	   if(n==0)
	   {
		   document.getElementById("calendar").style.left="400px";
	   }	
	   else
	   {
		   document.getElementById("calendar").style.left="600px";
	   }	   
	   
	   // 달력 => 1일의 요일 , 총일수 , 몇주
	   //var xday=new Date(2022,11,10); // 특정일의 날짜객체
	   //var dday=new Date('2021-02-15');
	   
	   if(y==-1)
	   {
		   var today=new Date(); // 오늘의 요일, 이번달의 총일수
		   y=today.getFullYear();
		   m=today.getMonth(); // 0~11
	   }	

	   if(m==-1) // 1월에서 이전으로 클릭
	   {
		   y--;
		   m=11;
	   }
	   if(m==12) // 12월에서 다음으로 클릭
	   {
		   y++;
		   m=0;
	   }
	   
	   // 1일의 요일을 구하기 위해 today를 이용하여 이번년,이번달,1일 => 날짜객체를 생성
	   var xday=new Date(y,m,1);
	   
	   // 1일의 요일
	   var yoil=xday.getDay(); // 0~6(일~토)
	   
	   // 총일수 => 지원하지 않는 언어에 자주 사용하는 방식
	   var nums=[31,28,31,30,31,30,31,31,30,31,30,31];
	 
	   var chong=nums[m];
	   
	   // 윤년인 경우에는 2월이 29일이다
	   if(m==1) // 2월달인 경우
	   {
		   if( (y%4==0 && y%100!=0) || y%400==0 )
			   chong++;
	   }	   
	   
	   // 몇 주 =>  (1주빈칸+총일수)/7 => ???.???  => 소수점은 무조건 올림으로 처리
	   var ju=Math.ceil((chong+yoil)/7);
	   
	   var calData="<table  align='center' border='0' id='cal2'>";
	   calData=calData+"<caption>";
	   calData=calData+" <a href='javascript:makeCal("+y+","+(m-1)+","+n+")'> 이전 </a> ";
	   calData=calData+y+"년 "+(m+1)+"월 ";
	   calData=calData+" <a href='javascript:makeCal("+y+","+(m+1)+","+n+")'> 다음 </a>";
	   calData=calData+" </caption>";
	   calData=calData+"<tr>";
	   calData=calData+" <td> 일 </td>";
	   calData=calData+" <td> 월 </td>";
	   calData=calData+" <td> 화 </td>";
	   calData=calData+" <td> 수 </td>";
	   calData=calData+" <td> 목 </td>";
	   calData=calData+" <td> 금 </td>";
	   calData=calData+" <td> 토 </td>";
	   calData=calData+"</tr>";
	   
	   var day=1;
	   for(i=0;i<ju;i++)
	   {
		   calData=calData+" <tr> ";
		   
		   for(j=0;j<7;j++)
		   {
			   if( (i==0 && j<yoil) || day>chong ) // (1주차에 1일의 요일이전) ||  day가 총일수보다 크면 
			   {
				   calData=calData+" <td> &nbsp; </td>";
			   }	
			   else
			   {                            // nalJaSend(2025,1,20,0)
				   calData=calData+" <td onclick='nalJaSend("+y+","+m+","+day+","+n+")'> "+day+" </td> ";
				   day++;                     // nalJaSend(0)
			   }			   
		   }	   
		   
		   calData=calData+" </tr> ";
	   }	   
	   
	   calData=calData+"</table>";
	   document.getElementById("calendar").innerHTML=calData;
	   
	   event.stopPropagation(); // 다음 이벤트로 진행을 중지시킨다..
   }
   function nalJaSend(y,m,d,n) // m은 0~11  =>  +1
   {
	   // 년,월,일을 가져와서 시작일과 최종일에 값을 넣어주는것 인덱스에 해당되는 n값도 가져온다
	   m=m+1;
	   // m,d를 문자형으로 변환
	   m=m+"";
	   m=m.padStart(2,"0");
	   //if(m.length==1)
	   //   m="0"+m;
	   
	   d=d+"";
	   d=d.padStart(2,"0");
	   //if(d.length==1)
	   //   d="0"+d;
	   
	   var nalJa=y+"-"+m+"-"+d; // 2025-02-11
	   
	   
	   
	   // 입력하기전 시작일과 최종일의 날짜를 비교해서 => 시작일이 클경우 메시지를 띄운다
	   if(n==0) // 시작일이 클릭되어 시작일 날짜가 들어올 경우
	   {
		   if(document.getElementsByClassName("nalJa")[1].value=="")
		   {
			   document.getElementsByClassName("nalJa")[n].value=nalJa;
		   }	
		   else // 날짜비교
		   {
			    var xday1=new Date(nalJa);
			    var xday2=new Date(document.getElementsByClassName("nalJa")[1].value);
			    
			    if(xday1>xday2)
			    {
			    	// 시작일이 큰 경우
			    	alert("시작일이 최종일 보다 큽니다");	
			    	document.getElementsByClassName("nalJa")[0].value="";
			    }	
			    else
			    {
			    	document.getElementsByClassName("nalJa")[n].value=nalJa;
			    }	
		   }	   
	   }	
	   
	   if(n==1) // 최종일이 클릭되어 최종일 날짜가 들어올 경우
	   {
		   if(document.getElementsByClassName("nalJa")[0].value=="")
		   {
			   document.getElementsByClassName("nalJa")[n].value=nalJa;
		   }	
		   else // 날짜비교  => 시작일이 입력되어 있는 상태에서 최종일이 클릭되었을때
		   {
			    var xday1=new Date(document.getElementsByClassName("nalJa")[0].value);
			    var xday2=new Date(nalJa);
			    
			    if(xday1>xday2)
			    {
			    	// 시작일이 큰 경우
			    	alert("시작일이 최종일 보다 큽니다");	
			    	document.getElementsByClassName("nalJa")[1].value="";
			    }	
			    else
			    {
			    	document.getElementsByClassName("nalJa")[n].value=nalJa;
			    }	
		   }	   
	   }	   
	   
	   
	   
	   // 입력폼에 날짜를 전달한 후 => 달력을 숨기기
	   document.getElementById("calendar").innerHTML="";
   }
   function gigan()
   {
	   var start=document.getElementsByClassName("nalJa")[0].value;
	   var end=document.getElementsByClassName("nalJa")[1].value;
	   
	   location="jumunList?start="+start+"&end="+end;
   }
   
   window.onclick=function()
   {
 
	   document.getElementById("calendar").innerHTML="";
   }
 </script>
</head>
<body> <!-- member/jumunList.jsp  -->
  <section>
     <div id="calendar"></div>
     <table id="mainTable" width="1100" align="center">
        <caption> 
          <h3 align="left"> 주문 목록 </h3>
          <div id="search" align="center" style="height:40px;line-height:40px;">
            <input type="button" value="3개월" onclick="location='jumunList?month=3'">
            <input type="button" value="6개월" onclick="location='jumunList?month=6'">
            <input type="button" value="12개월" onclick="location='jumunList?month=12'">
            <input type="text" class="nalJa" value="${start}" name="start" placeholder="시작일" onclick="makeCal(-1,-1,0)"> -
            <input type="text" class="nalJa" value="${end}" name="end" placeholder="최종일" onclick="makeCal(-1,-1,1)"> 
            <input type="button" value="기간검색" onclick="gigan()">
          </div> 
        </caption>
        <c:forEach items="${mapAll}" var="map">
          <c:set var="dis" value=""/>
          <tr>
            <td> ${map.writeday} </td>
            <td> <img src="../static/product/${map.pimg}" width="40" height="40"> </td>
            <td width="400"> ${map.title} </td>
            <td> ${map.name} </td>
            <td> ${map.stateStr} </td>
            <td>
             <c:if test="${map.state==0 or map.state==1}">
              <input type="button" value="취소신청" onclick="location='chgState?id=${map.id}&state=2'">
             </c:if>
             
             <c:if test="${map.state==5}">
              <input type="button" value="반품신청" onclick="location='chgState?id=${map.id}&state=6'">
              <input type="button" value="교환신청" onclick="location='chgState?id=${map.id}&state=8'">
              <c:if test="${map.review==1}">
                <c:set var="dis" value="disabled"/>
              </c:if>
              <input type="button" ${dis} value="상품평쓰기" onclick="location='review?id=${map.id}&pcode=${map.pcode}'">
             </c:if>
             
             <c:if test="${map.state==2}"> 
              <input type="button" value="신청취소" onclick="location='chgState?id=${map.id}&state=0'">
             </c:if>
             <c:if test="${map.state==6 || map.state==8}">
              <input type="button" value="신청취소" onclick="location='chgState?id=${map.id}&state=5'">
             </c:if>
             </td>
          </tr>
        </c:forEach>      
     </table>
  </section>
  
</body>
</html>






