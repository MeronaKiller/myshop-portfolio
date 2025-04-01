<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		section #email{
			width:130px;
			height:42px;
		}
		section #select{
			width:132px;
			height:47px;
		}
		section #submit{
			width:427px;
			height:46px;
			background:#5F007F;
       		color:white;
		}
		section #umsg{
			font-size:12px;
		}
		section #pmsg{
			font-size:12px;
		}
	</style>
	<script>
		function useridCheck(userid)
		{
			if(userid.length>=6)
			{
			//alert(userid);
			var chk=new XMLHttpRequest();
			chk.onload=function()
			{
				if(chk.responseText=="0")
					{
						document.getElementById("umsg").innerText="사용이 가능한 아이디 입니다.";
						document.getElementById("umsg").style.color="blue";
						uchk=1;
					}
				else
					{
						document.getElementById("umsg").innerText="사용이 불가능한 아이디 입니다.";
						document.getElementById("umsg").style.color="red";
						uchk=0;
					}
			}
			chk.open("get","useridCheck?userid="+userid);
			chk.send();
			}
			else
				{
				document.getElementById("umsg").innerText="아이디의 길이는 6자 이상입니다.";
				document.getElementById("umsg").style.color="red";
				uchk=0;
				}
		}
		var uchk=0; //중복확인완료(중복X)=>1
		var pchk=0;
		function check()
		{
			
			var emailOk=document.mform.uid.value+"@"+document.mform.server.value;
			document.mform.email.value=emailOk;
			
			if(uchk==0)//아이디 중복체크가 되었는지 검사
				{
			return false;
				}
			else if(pchk==0)
			{
				return false;
			}
			else if(document.mform.name.value=="")
			{
				return false;
			}
			else if(document.mform.phone.value.length==0)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		function pwdCheck()
		{
			var pwd=document.mform.pwd.value;
			var pwd2=document.mform.pwd2.value;
			
			if(pwd2.length!=0)
				{
			if(pwd==pwd2)
				{
					document.getElementById("pmsg").innerText="비밀번호가 일치합니다";
					document.getElementById("pmsg").style.color="blue";
					pchk=1;
				}
			else
				{
					document.getElementById("pmsg").innerText="비밀번호가 일치하지 않습니다";
					document.getElementById("pmsg").style.color="red";
					pchk=0;
				}
				}
		}
		function getServer(my)
		{
			//alert(document.mform.dserver[document.mform.dserver.selectedIndex].text);
			//alert(my.text);
			
			//alert(document.mform.dserver.value);
			//alert(my.value);
			document.mform.server.value=my.value;
		}
	</script>
</head>
<body> <!-- member.jsp -->
	<section>
	<div>
		<form name="mform" method="post" action="memberOk" onsubmit="return check()">
		<input type="hidden" name="email">
			<h3> 회원 등록 </h3>
			<div>
			 <input type="text" name="userid" onblur="useridCheck(this.value)" id="txt" placeholder="아이디(6자이상)">
			<br> <span id="umsg"></span>
			</div>
			<div> <input type="text" name="name" id="txt" placeholder="이 름"> </div>
			<div> <input type="password" name="pwd" onkeyup="pwdCheck()" id="txt" placeholder="비밀번호"> </div>
			<div>
			<input type="password" name="pwd2" onkeyup="pwdCheck()" id="txt" placeholder="비밀번호 확인">
			<br> <span id="pmsg"></span>
			</div>
			<div>
				<input type="text" name="uid" id="email">@<input type="text" name="server" id="email">
				<select name="dserver" id="select" onchange="getServer(this)">
				<option value=""> 직접입력 </option>
				<option value="naver.com"> naver.com </option>
				<option value="daum.net"> daum.net </option>
				<option value="hotmail.com"> hotmail.com </option>
				<option value="channy.co.kr"> channy.co.kr </option>
				</select>
			</div>
			<div> <input type="text" name="phone" id="txt" placeholder="전화번호"> </div>
			<div> <input type="submit" value="회원 가입" id="submit"> </div>
		</form>
	</div>
	</section>
</body>
</html>



















