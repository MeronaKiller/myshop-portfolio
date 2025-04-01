<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function mainCheck(my)
	{
		// 전체선택 체크박스가 체크되었는지 여부를 확인
		var subChk=document.getElementsByClassName("subChk");
		if(my.checked) // if(document.getElementById("mainChk").checked)
		{
			for(i=0;i<subChk.length;i++)
			{
				subChk[i].checked=true;
			}
		}
		else
		{
			for(i=0;i<subChk.length;i++)
			{
			subChk[i].checked=false;
			}
		}
	}
	function subCheck()
	{
		// class="subChk"가 모두 체크되면  id="mainChk"를 checked true
		var subChk=document.getElementsByClassName("subChk");
		var chkNum=0;
		for(i=0;i<subChk.length;i++)
		{
			if(subChk[i].checked)
			{
				chkNum++;
			}
		}
		if(chkNum==subChk.length)
		{
			document.getElementById("mainChk").checked=true;
		}
		else
		{
			document.getElementById("mainChk").checked=false;
		}
	}
	function cartDel()
	{
		// class="subChk" 인 요소중 선택된(체크되) 요소의 상품 id값을 ,로 구분하여 저장
		var subChk=document.getElementsByClassName("subChk")
		var ids="";
		for(i=0;i<subChk.length;i++)
		{
			if(subChk[i].checked) // 체크된 요소의 id만 저장
			{
				ids=ids+subChk[i].value+",";
			}
		}
		alert(ids);
	}
</script>
</head>
<body> <!-- etc/chkbox.jsp -->
  <input type="checkbox" class="subChk" onclick="subCheck()" value="11"> 상품1 <p>
  <input type="checkbox" class="subChk" onclick="subCheck()" value="13"> 상품2 <p>
  <input type="checkbox" class="subChk" onclick="subCheck()" value="14"> 상품3 <p>
  <input type="checkbox" class="subChk" onclick="subCheck()" value="16"> 상품4 <p>
  <input type="checkbox" class="subChk" onclick="subCheck()" value="17"> 상품5 <p>
  <input type="checkbox" class="subChk" onclick="subCheck()" value="19"> 상품6
  
  <hr>

  <input type="checkbox" id="mainChk" onclick="mainCheck(this)"> 전체선택
  <input type="button" value="선택삭제" onclick="cartDel()"> 
</body>

</html>
<!-- 
    1. 전체선택을 클릭하면 모든 체크박스가 체크도기
    2. 상품1~상품4를 클릭했을대
       - 4개가 모두 선택되었다면 전체선택이 체크되게 하기
       - 4개중에 하나라도 선택이 되지 않았다면 전체선택이 체크해제
  -->
















