<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
 
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
   section table {
       border-spacing:0px;
    }
    section  table tr td {
       height:40px;
       border-bottom:1px solid black;
       padding-top:6px;
       padding-bottom:6px;
    }
    section table tr:first-child td {
       border-top:2px solid black;
    }
    section table tr:last-child td {
       border-bottom:2px solid black;
    }
    section #email {
       width:200px;
       height:26px;
       font-size:16px;
    }
    section input[type=button] {
       width:95px;
       height:32px;
    }
 </style>
 <script>
 	function chgEmail()
 	{
 		var email=document.getElementById("email").value;
		
 		var chk=new XMLHttpRequest();
 		chk.onload=function()
 		{
 			if(chk.responseText=="0")
 			{
 				location="../login/login";
 			}
 		}
 		chk.open("get","chgEmail?email="+email);
 		chk.send();
 	}
 </script>
</head>
<body> <!-- member/memberInfo -->
  <section>
  
    <table width="700" align="center">
      <caption> <h3> 회원 정보 </h3> </caption>
      <tr>
        <td> 아이디 </td>
        <td> ${mdto.userid} </td>
      </tr>
      <tr>
        <td> 이 름 </td>
        <td> ${mdto.name} </td>
      </tr>
      <tr>
        <td> 이메일 </td>
        <td>
          <input type="text" id="email" value="${mdto.email}">
          <input type="button" value="이메일수정" onclick="chgEmail()">
        </td>
      </tr>
      <tr>
        <td> 전화번호 </td>
        <td>
        	${mdto.phone} <input type="button" value="전화번호수정" id="pbtn" onclick="phoneView(this)">
        	<form id="pform" method="post" action="chgPhone" style="margin-top:10px;">
        	<input type="text" name="phone" value="${mdto.phone}">
        	<input type="submit" value="수정하기">
        	</form>
       	</td>
      </tr>
      <tr>
        <td> 적립금 </td>
        <td> <fmt:formatNumber value="${mdto.juk}" type="number" pattern="#,###"/>원  </td>
      </tr>
      <tr>
        <td> 비밀번호변경 </td>
        <td>
        	<c:if test="${param.err==0}">
        		<div style="color:red;font-size:12px;">현재 비밀번호가 틀립니다</div>
        	</c:if>
          <form method="post" action="chgPwd" onsubmit="return check(this)">
           현재비밀번호 <input type="password" name="oldPwd" id="pwd"> <p>
           새 비밀번호&nbsp;&nbsp; <input type="password" name="newPwd" id="pwd"> <p>
           비밀번호확인 <input type="password" name="newPwd2" id="pwd"> <p>
           <input type="submit" value="비밀번호 변경">
          </form>
        </td>
      </tr>
    </table>
  
  </section>
  <script>
  		function check(my)
  		{
  			var oldPwd=my.oldPwd.value;
  			var newPwd=my.newPwd.value;
  			var newPwd2=my.newPwd2.value;
  			
  			// 1. 현재비밀번호가 같이 입력되었나
  			
  			// 2. 새비밀번호==비밀번호확인 값이 같은지
  			if(oldPwd.trim().length == 0)
  			{
  				alert("현재 비밀번호를 입력하세요");
  				my.oldPwd.value=""; // 빈칸으로 채워져 있다면
  				my.oldPwd.focus();
  				return false;
  			}
  			else if(newPwd.trim() != newPwd2.trim())
  				{
  					alert("비밀번호가 일치하지 않습니다");
  					return false;
  				}
  			else
  				{
  					return true;
  				}
  				
  		}
  </script>
  <style>
  	section #pform
  	{
  		display:none;
  	}
  	section #phone
  	{
  		width:200px;
  		height:26px;
  		font-size:16px;
  	}
  	section #pwd
  	{
  		width:200px;
  		height:26px;
  		font-size:16px;
  	}
  </style>
  <script>
  	function phoneView(my)
  	{
  		document.getElementById("pform").style.display="block";
  		my.value="수정 취소";
  		my.setAttribute("onclick","phoneHide(this)");
  	}
  	function phoneHide(my)
  	{
    	document.getElementById("pform").style.display="none";
    	my.value="전화번호수정";
    	my.setAttribute("onclick","phoneView(this)");
  	}
  </script>
</body>
</html>










