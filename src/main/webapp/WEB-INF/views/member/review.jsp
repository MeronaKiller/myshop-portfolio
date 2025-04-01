<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  	function chgStar(n) //나의 별점 n+1
  	{
  		//0~n까지는 노란별
  		var star=document.getElementsByClassName("star");
  		
  		for(i=0;i<=n;i++)
  		{
  			star[i].src="../static/star1.png";
  		}
  		
  		//n+1~끝(4)까지는 회색별
  		for(i=n+1;i<star.length;i++)
  		{
  			star[i].src="../static/star2.png";
  		}
  		
  		document.rform.star.value=n+1;
  		
  	}
  </script>
</head>
<body> <!-- review.jsp -->
	<section>
		<form name="rform" method="post" action="reviewOk">
		
      <!-- 별점을 가져가는 input태그를 추가 -->
		<input type="hidden" name="star">
		<input type="hidden" name="id" value="${gid}"> <!-- gumae테이블의 id를 reviewDto.id에저장 -->
		<input type="hidden" name="pcode" value="${pcode}">
		<h3 align="center"> 상품평 쓰기 </h3>
		
		
		<!-- 별점 -->
		<div>
		<img src="../static/star2.png" onclick="chgStar(0)" class="star">
		<img src="../static/star2.png" onclick="chgStar(1)" class="star">
		<img src="../static/star2.png" onclick="chgStar(2)" class="star">
		<img src="../static/star2.png" onclick="chgStar(3)" class="star">
		<img src="../static/star2.png" onclick="chgStar(4)" class="star">
		</div>
		
		
		<!-- 한줄평 -->
		<div> <input type="text" name="title" id="title" placeholder="한줄 제목 입력"></div>
		
		<!-- 내용 -->
		<div> <textarea name="content" id="content" placeholder="상품평 내용"></textarea> </div>
		
		<!-- 상품평 쓰기 -->
		<div><input type="submit" id="submit" value="상품평 쓰기"></div>
		
		</form>
	</section>
</body>
</html>