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
	section{
	
	}
	section .pform{
		display:none;
	}
	section .tdPay{
		width:1100px;
		height:150px;
		border:1px solid green;
	}
	section .pay{
		display:none;
	}
</style>
<script>
	function addBaesong()
	{
		open("baesongWrite","op","width=520,height=600"); //나타낼문서, 창이름, 창의속성
	}
	function chgBaesong()
	{
		open("baesongWrite","op","width=520,height=600"); // 나타낼문서, 창이름, 창의속성
	}
	window.onpageshow=function()
	{
		document.getElementsByClassName("pform")[0].style.display="block";
		document.getElementsByClassName("pay")[0].style.display="block";
		document.getElementsByClassName("pay")[1].style.display="block";
		document.getElementsByClassName("tdPay")[1].style.height="35px";
	}
	var radioChk=0; // 문서를 읽을 때 보여주는 pform의 인덱스 값
	function chgPay(n)
	{
		var pform=document.getElementsByClassName("pform");
		pform[radioChk].style.display="none";
		pform[n].style.display="block";
		radioChk=n;
		/*
		var pform=document.getElementsByClassName("pform");
		for(i=0;i<pform.length;i++)
			{
				pform[i].style.display="none";
			}
		pform[n].style.display="block";
		*/
	}
	var payChk=0;
	function viewHide()
	{
		// class="pay"의 인덱스 2~5까지의 내용을 전부 보이기 or 전부 숨기기
		var pay=document.getElementsByClassName("pay");
		if(payChk%2==0)
		{
			for(i=2;i<pay.length;i++)
			{
				pay[i].style.display="block";
			}
			document.getElementById("arrow").innerText="▲";
		}
		else
		{
			for(i=2;i<pay.length;i++)
			{
				pay[i].style.display="none";
			}
			document.getElementById("arrow").innerText="▼";
		}
		payChk++;
	}
	
	var myJuk=${mdto.juk};
	function calJuk(my)
	{
		//alert(isNaN(num)); // 문자이면 true, 숫자이면 false
		var num=my.value; //적립된 금액
		if(isNaN(num) || num.length==0)
		{
			alert("숫자를 입력하세요");
			my.value="0";
			//id="dtoJuk"의 금액을 원래상태로
			document.getElementById("dtoJuk").innerText=comma(myJuk);
		}
		else if(num<0)
		{
				alert("0보다 큰 수를 입력하세요");
				my.value="0";
				//id="dtoJuk"의 금액을 원래상태로
				document.getElementById("dtoJuk").innerText=comma(myJuk);
		}
		else
		{
			if(num>myJuk)
			{
				my.value="0";
			}
			else
			{	
		// 보유금액-num을 계산한 금액을 전달하면 된다.
		var result=myJuk-parseInt(num);
		document.getElementById("dtoJuk").innerText=comma(result);
		
		// 총결제금액에서 사용된 적립금을 차감한 뒤 값을 전달
		var ocp=parseInt(document.getElementById("oriChongPrice").value);
		document.getElementById("chongPrice").innertext=comma(ocp-num);
			}
		}
	}
		
	function comma(price)
	{
		return new Intl.NumberFormat().format(price);
	}
	function check()
	{
		var id=document.getElementById("baeId").value;
		if(id.length==0)
		{
			alert("배송지를 선택하세요");
			return false;
		}
		else
		{
			return true;
		}
	}
</script>
</head>
<body> <!-- product/productGumae -->
<!-- 구매자정보 -->
<section>
	<form method="post" action="gumaeOk" onsubmit="return check()">
	<!-- 장바구니에서 1개 이상의 상품이 구매를 위해 넘어온다
	name="pcode"는 상품의 코드별로 /로서 구분하여 만든뒤 전달
	name="su"는 상품의 수량별로 /로 구분 -->
	
		<input type="hidden" name="baeId" value="${bdto.id}">
	<table width="1100" align="center">
		<caption> <h3 align="left"> 구매자 정보 </h3> </caption>
		<tr>
		<td width="140"> 이 름 </td>
		<td> ${mdto.name} </td>
		</tr>
		<tr>
		<td> 이메일 </td>
		<td> ${mdto.email} </td>
		</tr>
		<tr>
		<td> 전화번호 </td>
		<td> ${mdto.phone} </td>
		</tr>
	</table>
<!-- 배송지정보 -->
	<table width="1100" align="center">
	<caption>
	<h3 align="left">
	배송지 정보
       <c:if test="${bdto!=null}">
        <input type="button" value="배송지변경" onclick="chgBaesong()">
       </c:if>
       <c:if test="${bdto==null}">
        <input type="button" value="배송지등록" onclick="addBaesong()">
       </c:if> 
	</caption>
	<tr>
	<td width="140"> 이 름 </td>
	<td id="name"> ${bdto.name} </td>
	</tr>
	<tr>
	<td> 배송주소 </td>
	<td id="juso"> ${bdto.juso} ${bdto.jusoEtc} </td>
	</tr>
	<tr>
	<td> 연락처 </td>
	<td id="phone"> ${bdto.phone} </td>
	</tr>
	<tr>
	<td> 배송요청사항 </td>
	<td id="reqStr"> ${bdto.reqStr} </td>
	</tr>
	</table>

  <!-- 배송상품 : 배송예정일, 상품명, 구매수량, 배송비 -->
  <table width="1100" align="center">
    <caption> <h3 align="left"> 배송상품 </h3> </caption>
    
    
    
    
    <c:set var="priceAll" value="0"/> <!-- 상품가격 누적 -->
    <c:set var="baepriceAll" value="0"/> <!-- 배송비 누적 -->
    <c:set var="imsiPcode" value=""/>
    <c:set var="imsiSu" value=""/>
    <c:forEach items="${plist}" var="pdto">
    <c:set var="priceAll" value="${priceAll+(pdto.price*pdto.su)}"/>
    <c:set var="baepriceAll" value="${baepriceAll+pdto.baeprice}"/>
    <c:set var="imsiPcode" value="${imsiPcode}${pdto.pcode}/"/>
    <c:set var="imsiSu" value="${imsiSu}${pdto.su}/"/>
    
    
    
    
    
    
    <tr>
      <td colspan="2"> ${pdto.baedayStr} </td> <!-- 배송예정일 -->
    </tr>
    <tr>
      <td> ${pdto.title} </td>  <!-- 상품명 -->
      <td>
        수량 ${pdto.su}개  / 
        <c:if test="${pdto.baeprice==0}">
         무료배송
        </c:if>
        <c:if test="${pdto.baeprice!=0}">
         <fmt:formatNumber value="${pdto.baeprice}" type="number" pattern="#,###"/>원
        </c:if>      
      </td>  <!-- 수량, 배송비관련 -->
    </tr>
    </c:forEach>
    	<input type="hidden" id="orChongPrice" value="${priceAll+baepriceAll}">
    	<input type="hidden" name="pcode" value="${imsiPcode}"> <!-- 상품코드1/상품코드2/상품코드3/~ -->
		<input type="hidden" name="sus" value="${imsiSu}">		 <!-- 수량1/수량2/수량3/ -->
  </table>
  <!-- 결제정보 -->
  <table width="1100" align="center">
  <caption><h3 align="left"> 결제 정보 </h3></caption>
  <tr>
  	<td width="140"> 총상품가격 </td>
  	<td> <fmt:formatNumber value="${priceAll}" type="number" pattern="#,###"/>원 </td>
  </tr>
  <tr>
  	<td> 할인쿠폰 </td>
  	<td> 0원 </td>
  </tr>
  <tr>
  	<td> 배송비 </td>
  	<td><fmt:formatNumber value="${baepriceAll}" type="number" pattern="#,###"/>원</td>
  </tr>
  <tr>
  	<td> 적립금 사용 </td>
  	<td>
  		<input type="text" name="useJuk" onblur="calJuk(this)" value="0" size="4" style="text-align:right">원 ||
  		보유: <span id="dtoJuk"><fmt:formatNumber value="${mdto.juk}" type="number" pattern="#,###"/></span>원
  	</td>
  </tr>
  <tr>
  	<td> 총결제금액 </td>
  	<span id="chongPrice">
  	<td> <fmt:formatNumber value="${priceAll+baepriceAll}" type="number" pattern="#,###"/>원</td>
  	</span>
  </tr>
  </table>
  <!-- 결제수단 -->
  <table width="1100" align="center">
  	<caption><h3 align="left"> 결제수단 </h3></caption>
  	<tr>
  	 <td class="tdPay">
  	 <div class="pay">
  		<input type="radio" name="pay" value="0" onclick="chgPay(this.value)"> 신용/체크카드
  		<div class="pform"> <!-- 입력할 폼 생성 -->
  			<select name="card1">
  				<option value="0"> 신한은행 </option>
  				<option value="1"> 우리은행 </option>
  				<option value="2"> 농협은행 </option>
  				<option value="3"> KB은행 </option>
  			</select>
  			<select name="halbu1">
  				<option value="0"> 일시불 </option>
  				<option value="1"> 2개월 </option>
  				<option value="2"> 3개월 </option>
  				<option value="3"> 6개월 </option>
  				<option value="4"> 12개월 </option>
  			</select>
  		</div>
  	</div>
  	<div class="pay">
  		<input type="radio" name="pay" value="1" onclick="chgPay(this.value)"> 차니페이
  		<div class="pform"> <!-- 입력할 폼 생성 -->
  			0원
  		</div>
  		<div class="pay"> 
  	 </td>
  	</tr>
  	<tr>
  	<td class="tdPay"> 
  		<div onclick="viewHide()"> 다른 결제 수단 <span id="arrow">▼</span> </div>
  	 	<div class="pay">
  		<input type="radio" name="pay" value="2" onclick="chgPay(this.value)"> 계좌이체
  		<div class="pform">
  			<select name="bank1">
  				<option value="0"> 신한은행 </option>
  				<option value="1"> 농협은행 </option>
  				<option value="2"> 우리은행 </option>
  				<option value="3"> KB은행 </option>
  			</select>
  		</div>
  	</div>
  		<div class="pay">
  		<input type="radio" name="pay" value="3" onclick="chgPay(this.value)"> 법인카드
  		<div class="pform">
  		 <select name="card2">
               <option value="0"> 신한카드 </option>
               <option value="1"> 우리카드 </option>
               <option value="2"> 농협카드 </option>
               <option value="3"> KB카드 </option>
               </select>
  		</div>
  	</div>
  		<div class="pay">
  		<input type="radio" name="pay" value="4" onclick="chgPay(this.value)"> 휴대폰
  		<div class="pform">
            <select name="tel">
               <option value="0"> SKT </option>
               <option value="1"> KT </option>
               <option value="2"> LG </option>
               <option value="3"> 알뜰통신 </option>
             </select>
  		</div>
  	</div>
  		<div class="pay">
  		<input type="radio" name="pay" value="5" onclick="chgPay(this.value)"> 무통장입금
  		<div class="pform">
            <select name="bank2">
              <option value="0"> 신한은행 </option>
              <option value="1"> 농협은행 </option>
              <option value="2"> 우리은행 </option>
              <option value="3"> KB은행 </option>
            </select>
  		</div>
  	</div>
  	 </td>
  	</tr>
  </table>
  <div align="center"><input type="submit" value="구매하기"></div>
  </form>
 </section>
</body>
</html>



