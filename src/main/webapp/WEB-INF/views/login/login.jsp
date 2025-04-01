<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	section{
		width:1100px;
		height:500px;
		margin:auto;
		text-align:center;
	}
	section div{
		margin-top:10px;
	}
	section #txt{
		width:420px;
		height:42px;
	}
	section #submit{
		width:427px;
		height:46px;
		background:#5F007F;
		color:white;
	}
	section #txt2{
		width:200px;
		height:30px;
	}
	section #submit2{
		width:206px;
		height:33px;
		background:#5F007F;
		color:white;
	}
	section #uform{
		display:none;
	}
	section #pform{
		display:none;
	}
	section .sear{
		cursor:pointer;
	}
</style>
<script>
function viewUform()
{
	document.getElementById("uform").style.display="block";
	document.getElementById("pform").style.display="none";
	//폼의 입력값 초기화
	document.getElementById("pform").userid.value="";
	document.getElementById("pform").name.value="";
	document.getElementById("pform").email.value="";
}
function viewPform()
{
	document.getElementById("pform").style.display="block";
	document.getElementById("uform").style.display="none";
	//폼의 입력값 초기화
	document.getElementById("uform").name.value="";
	document.getElementById("uform").email.value="";
}
function getUserid(form)
{
	var name=form.name.value;
	var email=form.email.value;
	
	var chk=new XMLHttpRequest();
	chk.onload=function()
	{
		document.getElementById("uform").style.display="none";	
		document.getElementById("uform").name.value="";	
		document.getElementById("uform").email.value="";	
		document.getElementById("view").innerText="아이디: "+chk.responseText;	
	}
	chk.open("get","getUserid?name="+name+"&email="+email);
	chk.send();
}
function getPwd(form)
{
	
	var userid=form.userid.value;
	var name=form.name.value;
	var email=form.email.value;
	
	var chk=new XMLHttpRequest();
	chk.onload=function()
	{
		   document.getElementById("pform").style.display="none";
		   document.getElementById("pform").userid.value="";
		   document.getElementById("pform").name.value="";
		   document.getElementById("pform").email.value="";
		   
		   document.getElementById("view").innerText="비밀번호 : "+chk.responseText;
	}
	chk.open("get","getPwd?name="+name+"&email="+email+"&userid="+userid);
	chk.send();
}
</script>
</head>
<body> <!-- login.jsp -->
<section>

<h3 align="center"> 로그인 </h3>
<form method="post" action="loginOk">
	<c:if test="${su!=null}"> <!-- su의 값이 없으면 구현클래스에 null로 체크를 할 수 있다 -->
		<input type="hidden" name="su" value="${su}">
	</c:if>
	<input type="hidden" name="pcode" value="${pcode}">
	<div> <input type="text" name="userid" id="txt" placeholder="아이디"> </div>
	<div>
	<input type="password" name="pwd" id="txt" placeholder="비밀번호">
	<c:if test="${err==1}">
	<br> <span style="font-size:12px;color:red;"> 아이디 혹은 비밀번호가 틀립니다 </span>
	</c:if>
	</div>
	<div> <input type="submit" value="로그인" id="submit"> </div>
	<div>
	<span class="sear" onclick="viewUform()"> 아이디 찾기 </span> &nbsp;&nbsp;&nbsp;
	<span class="sear" onclick="viewPform()"> 비밀번호 찾기 </span>
	</div>
	</form>
	
	<div id="view"></div>
	
	    <form id="uform">
      <h4> 아이디 찾기 </h4> 
      <div> <input type="text" name="name" id="txt2" placeholder="이 름"> </div>
      <div> <input type="text" name="email" id="txt2" placeholder="이 메 일"> </div>
      <div> <input type="button" value="아이디 찾기" id="submit2" onclick="getUserid(this.form)"> </div>
    </form>
    
    <form id="pform">
      <h4> 비밀 번호 찾기 </h4>
      <div> <input type="text" name="userid" id="txt2" placeholder="아이디"> </div>
      <div> <input type="text" name="name" id="txt2" placeholder="이 름"> </div>
      <div> <input type="text" name="email" id="txt2" placeholder="이 메 일"> </div>
      <div> <input type="button" value="비밀번호 찾기" id="submit2" onclick="getPwd(this.form)"> </div>
    </form>
	
	
</form>
</section>
</body>
</html>














