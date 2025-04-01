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
     height:${height}px;
     margin:auto;
  }
  section  #number {
       display:inline-block;
       width:74px;
       height:29px;
       border:1px solid #cccccc;
       padding-top:2px;
       border-radius:3px;
    }
  section  .su {
       width:20px;
       text-align:center;
       border:none;
       outline:none;
       font-weight:600;
    }
  section table{
  	margin-top:40px;
  	margin-bottom:40px;
  	border-spacing:0px;
  }
  section table tr td{
  	height:110px;
  	border-bottom:1px solid purple;
  }
  section table tr:first-child td{
  	height:60px;
  }
  section table tr:nth-child(2) td{
  	border-top:2px solid purple;
  }
  section table tr:last-child td{
  	border-bottom:2px solid purple;
  }
  #hPrice, #bPrice, #AllPrice{
  	font-size:18px;
  	color:red;
  }
 </style>
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
		totalPrice();
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
		totalPrice();
	}
	function totalPrice() // 실행되면 체크된 상품의 할인상품금액*수량 누적시켜서 표시한다.
	{
		var subChk=document.getElementsByClassName("subChk");
		var hPrice=document.getElementsByClassName("hPrice");	//상품할인된 금액
		var bPrice=document.getElementsByClassName("bPrice");	//배송비
		var su=document.getElementsByClassName("su");			//수량
		
		//할인된 상품금액을 누적할 변수
		var hPriceTotal=0;
		//배송비를 누적할 변수
		var bPriceTotal=0;
		
		for(i=0;i<subChk.length;i++)
		{
			if(subChk[i].checked)
			{
				//계산을 한다
				var danga=hPrice[i].value*su[i].value;
				hPriceTotal=hPriceTotal+danga;
				
				//배송비 추가
				bPriceTotal=bPriceTotal+parseInt(bPrice[i].value);
			}
			//alert(hPriceTotal+" "+bPriceTotal);
		}
		//상품금액, 배송비, 총결제금액을 전달하면 된다.
		document.getElementById("hPriceAll").innerText=comma(hPriceTotal)+"원";
		document.getElementById("bPriceAll").innerText=comma(bPriceTotal)+"원";
		document.getElementById("AllPrice").innerText=comma(hPriceTotal+bPriceTotal)+"원";
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
		location="cartDel?ids="+ids;
	}
	function comma(price)
	{
		return new Intl.NumberFormat().format(price);
	}
	window.onpageshow=function()
	{
		totalPrice();
	}
	 function downSu(n,id)
	 {
	 	 // class="su" 몇번째 인덱스인가
	 	var su=document.getElementsByClassName("su");
	 	var num=su[n].value;
	 	if(num>1)
	 	{
			num--;
	 		su[n].value=num;
	 		//비동기방식으로 cart테이블에서 값을 빼기
	 		var chk=new XMLHttpRequest();
	 		chk.onload=function()
	 		{
	 			
	 		}
	 		chk.open("get","chgSu?num="+num+"&id="+id);
	 		chk.send();
	 	}
	 	totalPrice();
	 }
	 function upSu(n,id)
	 {
		 var su=document.getElementsByClassName("su");
		 var num=su[n].value;
		 num++;
		 su[n].value=num;
		 
		//비동기방식으로 cart테이블에서 값을 더하기
			var chk=new XMLHttpRequest();
	 		chk.onload=function()
	 		{
	 			
	 		}
	 		chk.open("get","chgSu?num="+num+"&id="+id);
	 		chk.send();
		 
		 totalPrice();
	 }
	 function gumae()
	 {
		  var pcodes=""; //선택된 상품의 상품코드를 ,로 구분하여 문자열로 저장
		  var sus="";    //   "     "   수량을   "   "    "
		  
		  var subChk=document.getElementsByClassName("subChk");
		  var pcode=document.getElementsByClassName("pcode");
		  var su=document.getElementsByClassName("su");
		  
		  for(i=0;i<subChk.length;i++)
		  {
			  if(subChk[i].checked)
			  {
				  pcodes=pcodes+pcode[i].value+",";
				  sus=sus+su[i].value+",";
			  }	  
		  }
		  //alert(pcodes);
		  if(pcodes.length!=0)
		  location="../product/productGumae?pcode="+pcodes+"&su="+sus;
		  else
			  alert("선택상품이 없습니다");
	 }
 </script>
</head>
<body><!-- member/cartView.jsp -->
<section>
   <form>
	<table width="1100" align="center">
		<caption><h3> 장바구니 현황 </h3></caption>
		<tr>
			<td>
			<c:if test="${allChk==1}">
				<c:set var="achk" value="checked"/>
			</c:if>
			 <input onclick="mainCheck(this)" ${achk} type="checkbox" id="mainChk" style="width:18px;height:18px;">
			</td>
			<td colspan="8" align="left">
			전체선택 <input type="button" value="선택삭제" onclick="cartDel()">
			
			상품금액(<span id="hPriceAll"></span>)+배송비(<span id="bPriceAll"></span>)= 총결제금액(<span id="AllPrice"></span>)
			
			<span style="margin-left:50px;">
			<c:if test="${userid!=null}">
			<input type="button" onclick="gumae()" value="선택구매">
			</c:if>
			<c:if test="${userid==null}">
			<input type="button" onclick="location='../login/login?cart=1;'" value="선택구매">
			</c:if>
		  </span>
		 </td>
		</tr>
		<c:forEach items="${plist}" var="pdto" varStatus="sts">
		<%-- <c:set var="ww" value=""/>
		<c:if test="${pdto.writeday==today}">
			<c:set var="ww" value="checked"/>
		</c:if>--%>		
		<c:set var="tt" value=""/>
        <c:if test="${pdto.wchk==1}">
          <c:set var="tt" value="checked"/>
        </c:if>
        <tr>
          <td width="30"> 
           <c:if test="${userid!=null}">
            <input type="checkbox" ${tt} class="subChk" value="${pdto.id}" onclick="subCheck()">
            <input type="hidden" class="pcode" name="pcode" value="${pdto.pcode}">
           </c:if>
           <c:if test="${userid==null}">
            <input type="checkbox" ${tt} class="subChk" value="${pdto.pcode}" onclick="subCheck()">
           </c:if>
            <input type="hidden" class="hPrice" value="${pdto.price}">
            <input type="hidden" class="bPrice" value="${pdto.baeprice}">
          </td>
		<td width="110"><img src="../static/product/${pdto.pimg}" width="100" height="100"></td>
          <td width="340"> ${pdto.title} </td>
          <td width="140"> ${pdto.baedayStr} </td>
          <td width="120"> ${pdto.halinPriceStr}원 </td>
          <td width="100"> ${pdto.jukPriceStr}원 </td>
          <td width="100"> <fmt:formatNumber value="${pdto.baeprice}" type="number" pattern="#,###"/>원 </td>
          <td width="100">
            <div id="number">
              <img src="../static/minus.png" valign="middle" onclick="downSu(${sts.index},${pdto.id})">
              <input type="text" name="su" value="${pdto.su}" class="su" readonly>
              <img src="../static/plus.png" valign="middle" onclick="upSu(${sts.index},${pdto.id})">
            </div>
            </td>
            <td width="50">
            <c:if test="${userid!=null}">
            <input onclick="location='cartDel?ids=${pdto.id}'" type="button" class="delBtn" value="삭제"></td>
            </c:if>
            <c:if test="${userid==null}">
            <input onclick="location='cartDel?ids=${pdto.pcode}'" type="button" class="delBtn" value="삭제"></td>
            </c:if>
		</tr>
		</c:forEach>
	</table>
	</form>
</section>
</body>
</html>