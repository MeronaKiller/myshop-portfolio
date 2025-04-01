<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function getJung(dae)
	{
		//alert(document.pform.dae.value);
		//alert(dae);
		if(dae=="")
		{
		
		}
		else
		{
			var chk=new XMLHttpRequest();
			chk.onload=function()
			{
				var jungs=JSON.parse(chk.responseText);
				
				document.pform.jung.options.length=jungs.length+1;
				
				var i=1;
				for(jung of jungs)
					{
						document.pform.jung.options[i].value=jung.code;
						document.pform.jung.options[i].text=jung.name;
						i++;
					}
			}
			chk.open("get","getJung?dae="+dae);
			chk.send();
			}
		}
	function getSo(jung)
	{
		if(jung=="")
		{
			
		}
		else
		{
			//대분류 코드 읽어오기
			var dae=document.pform.dae.value;
			
			var daejung=dae+jung;
			
			var chk=new XMLHttpRequest();
			chk.onload=function()
			{
				//alert(chk.responseText);
				var sos=JSON.parse(chk.responseText);
				
				//select태그의 길이를 정해준다
				document.pform.so.options.length=sos.length+1;
				var i=1;
				for(so of sos)
					{
						document.pform.so.options[i].value=so.code;
						document.pform.so.options[i].text=so.name;
						i++;
					}
				
			}
			chk.open("get","getSo?daejung="+daejung);
			chk.send();
		}
	}
	function getPcode()
	{
		//대, 중, 소, 제 코드를 읽어오기
		var dae=document.pform.dae.value;
		var jung=document.pform.jung.value;
		var so=document.pform.so.value;
		var company=document.pform.company.value;
		
		var pcode="p"+dae+jung+so+company;
		
		//alert(pcode);
		
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			//alert(chk.responseText);
			document.pform.pcode.value=chk.responseText;
		}
		chk.open("get","getPcode?pcode="+pcode);
		chk.send();
	}
	   function chgNumber(my)  
	   {
	   	my.value=my.value.replace(/[^0-9]/g,"");
	   }
</script>
</head>
<body>
  <!-- 
    상품등록 : 상품코드 , 상품이미지(메인그림, 상품상세) , 상품명 , 상품가격
             별점, 상품할인율, 수량, 배송비 , 배송기간 , 적립율
   -->
<form name="pform" method="post" action="proWriteOk" enctype="multipart/form-data">
	<table width="800" align="center">
	<caption> <h3> 상품 등록 </h3> </caption>
	<tr>
		<td> 상품코드 </td>
		<td>
			<input type="text" name="pcode" readonly>
			<select name="dae" onchange="getJung(this.value)">
				<option value=""> 대분류 </option>
				<c:forEach items="${dlist}" var="ddto">
				<option value="${ddto.code}"> ${ddto.name} </option>
				</c:forEach>
			</select>
			<select name="jung" onchange="getSo(this.value)">
				<option value=""> 중분류 </option>
			</select>
			<select name="so">
				<option> 소분류 </option>
			</select>
			<select name="company">
				<option> 제조회사 </option>
             <c:forEach items="${clist}" var="cdto">
              <option value="${cdto.code}"> ${cdto.name} </option>
              </c:forEach>
			</select>
			<input type="button" onclick="getPcode()" value="상품코드생성">
		</td>
	</tr>
	<tr>
		<td> 메인그림 </td>
		<td>
			<input type="file" name="expimg0"> <br>
			<input type="file" name="expimg1"> <br>
			<input type="file" name="expimg2"> <br>
			<input type="file" name="expimg3"> <br>
		</td>
	</tr>
	<tr>
		<td> 상세그림 </td>
		<td> <input type="file" name="exdimg"> </td>
	</tr>
	<tr>
		<td> 상품명 </td>
		<td> <input type="text" name="title"> </td>
	</tr>
	<tr>
		<td> 상품가격 </td>
		<td> <input type="text" name="price" onkeyup="chgNumber(this)"> </td>
	</tr>
	<tr>
		<td> 할인율 </td>
		<td> <input type="text" name="halin" onkeyup="chgNumber(this)"> </td>
	</tr>
	<tr>
		<td> 수 량 </td>
		<td> <input type="text" name="su" onkeyup="chgNumber(this)"> </td>
	</tr>
	<tr>
		<td> 배송비 </td>
		<td> <input type="text" name="baeprice" onkeyup="chgNumber(this)"> </td>
	</tr>
	<tr>
		<td> 배송기간(일) </td>
		<td> <input type="text" name="baeday" onkeyup="chgNumber(this)"> </td>
	</tr>
	<tr>
		<td> 적립률 </td>
		<td> <input type="text" name="juk" onkeyup="chgNumber(this)"> </td>
	</tr>
	<tr align="center">
		<td colspan="2"> <input type="submit" value="상품등록"> </td>
	</tr>
	</table>
</form>

</body>
</html>