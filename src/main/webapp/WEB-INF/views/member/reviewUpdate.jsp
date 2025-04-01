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
    }
    section form > div {
      text-align:center;
      margin-top:30px;
    }
    section #title {
      width:600px;
      height:30px;      
    }
    section #content {
      width:600px;
      height:250px;  
    }
    section #submit  { 
      width:606px;
      height:34px;
    }
  </style>
  <script>
   function chgStar(n) // 나의 별점 => n+1
   {
	   var star=document.getElementsByClassName("star");
	   // 0~n까지는 노란별
	   for(i=0;i<=n;i++)
	   {
		   star[i].src="../static/star1.png";
	   }	   
	   // n+1 ~ 끝(4) 까지는 회색별
	   for(i=n+1;i<star.length;i++)
	   {
		   star[i].src="../static/star2.png";
	   }	
	   
	   document.rform.star.value=n+1;
	   //alert(document.rform.star.value);
   }
   window.onpageshow=function()
   {
	   var len=${rdto.star};
	   var star=document.getElementsByClassName("star");
	   
	   for(i=0;i<len;i++)
	   {
		   star[i].src="../static/star1.png";
	   }	   
   }
  </script>
</head>
<body> <!-- review.jsp -->
  <section>
    <form name="rform" method="post" action="reviewUpdateOk">
      
      <!-- reviewList에서 올 경우 chk=1이 존재
           productContent에서 올 경우 chk값이 없다
       -->
     <c:if test="${chk!=null}">   
      <input type="hidden" name="chk" value="${chk}">
     </c:if> 
      <!-- 별점을 가져가는 input태그를 추가 -->
      <input type="hidden" name="id" value="${rdto.id}"> <!-- review테이블의 id -->
      <input type="hidden" name="star" value="${rdto.star}">
      <input type="hidden" name="pcode" value="${rdto.pcode}">
      <h3 align="center"> 상품평 쓰기 </h3>
      <div>
       <%--  <c:forEach begin="1" end="${rdto.star}" var="i" varStatus="sts">
         <img src="../static/star1.png" onclick="chgStar(${sts.index-1})" class="star">
        </c:forEach>
        <c:forEach begin="1" end="${5-rdto.star}" varStatus="sts">
         <img src="../static/star2.png" onclick="chgStar(${sts.index-1})" class="star">
        </c:forEach> --%>
        
        <img src="../static/star2.png" onclick="chgStar(0)" class="star">
        <img src="../static/star2.png" onclick="chgStar(1)" class="star">
        <img src="../static/star2.png" onclick="chgStar(2)" class="star">
        <img src="../static/star2.png" onclick="chgStar(3)" class="star">
        <img src="../static/star2.png" onclick="chgStar(4)" class="star">  
      </div> <!-- 별점 -->
      <div> <input type="text" name="title" id="title" value="${rdto.title}" placeholder="한줄 제목 입력"> </div> <!-- 한줄평 -->
      <div> <textarea name="content" id="content" placeholder="상품평 내용">${rdto.content}</textarea></div> <!-- 내용 -->
      <div> <input type="submit" id="submit" value="상품평 수정"> </div>
    </form>
  </section>
</body>
</html>









