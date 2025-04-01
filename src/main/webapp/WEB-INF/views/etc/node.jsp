<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script>
  function view()
  {
	  var imsi=document.getElementById("aa");
	  
	  //alert(imsi.childNodes.length);
	  
	  //imsi.childNodes[1].innerText="메롱";
	  //imsi.childNodes[1].style.color="red";
	  
	  imsi.childNodes[2].style.color="red";
  }
  
 </script>
</head>
<body> <!-- etc/node.jsp -->
  <input type="button"  onclick="view()" value="클릭"> <hr>
  <div>하하하 호호호 <b>차니</b> ㅁㄴㅇㄻ</div>
  
  <ul id="aa"><li> 하하하 </li><li> 호호호 </li><li> 헤헤헤 </li></ul>
  
  
  <div id="grand">
  	할아버지 입니다
  	<div id="father">
  		아버지 입니다
  		<div id="channy" onclick="test(this)">
  			나는 차니
  		</div>
  	</div>
  </div>
  
  <script>
  	function test(my)
  	{
    	//my.style.color="blue";
    	//my.parentNode.style.color="blue";
  		//my.parentNode.parentNode.style.color="blue";
  		my.parentNode.parentNode.parentNode.style.color="red";
  	}
  
  </script>
  
  
  
  
  
  
  
  
</body>
</html>