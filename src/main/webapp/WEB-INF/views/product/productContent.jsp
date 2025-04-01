<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
  	html
  	{
    scroll-behavior: smooth;
	}
    section {
      width:1100px;
      margin:auto;
      margin-top:60px;
      position:relative;
    }
    section #cartLayer {
      position:absolute;
      left:500px;
      top:200px;
      background:white;
      font-size:12px;
      width:200px;
      height:60px;
      border:1px solid #5F007F;
      text-align:center;
      padding-top:5px;
      visibility:hidden;
    }
    section #cartLayer input {
      font-size:12px;
      background:#5F007F;
      color:white;
    }
    section #first {
    
    }
    section #first #left {
       display:inline-block;
       width:500px;
       height:500px;
    }
    section #first #right {
       display:inline-block;
       width:590px;
       height:500px;
       vertical-align:top;
    }
    section #first #right #titleDiv {
       font-size:28px;
    }
    section #first #right #titleDiv img {
       margin-left:30px;
    }
    section #first #right #starDiv {
       border-bottom:1px solid grey;
       margin-bottom:30px;
    }
    section #first #right #halinDiv {
       font-size:17px;
    }
    section #first #right #halinDiv s {
       color:#aaaaaa;
    }
    
    section #first #right #halinPriceDiv {
       font-size:24px;
       color:red;
       border-bottom:1px solid grey;
       margin-bottom:30px;
    }
    section #first #right #baedayStrDiv {
       font-size:20px;
       color:blue;
    } 
    section #first #right #baepriceDiv {
       font-size:18px;
       border-bottom:1px solid grey;
       margin-bottom:30px;
    } 
    section #first #right #jukpriceDiv {
       font-size:18px;
       border-bottom:1px solid grey;
       margin-bottom:30px;
    } 
    
    section #first #number {
       display:inline-block;
       width:74px;
       height:29px;
       border:1px solid #cccccc;;
       padding-top:2px;
       border-radius:3px;
    }
    section #first #cartBtn {
       width:180px;
       height:32px;
       vertical-align:middle;
       background:white;
       color:#5F007F;
       border:1px solid #5F007F;
       border-radius:3px;
    }
    section #first #gumaeBtn {
       width:180px;
       height:32px;
       vertical-align:middle;
       background:#5F007F;
       color:white;
       border:1px solid #5F007F;
       border-radius:3px;
    }
    section #first #su {
       width:20px;
       text-align:center;
       border:none;
       outline:none;
       font-weight:600;
    }
    section #menu {
       width:1100px;
       height:50px;
       margin:auto;
       margin-top:50px;
       margin-bottom:40px
    }
    section #menu ul {
       width:1100px;
       height:50px;
       padding-left:0px;
       margin-left:6px;
    }
    section #menu ul li {
       display:inline-block;
       list-style-type:none;
       width:273px;
       height:50px;
       text-align:center;
       border:1px solid black;
       margin-left:-6px;
       line-height:50px;
    }
    section #second {
    
    }
    section #third {
    
    }
    section #third .inReview {
       width:1080px;
       height:150px;
       overflow:auto;
       border:1px solid black;
       margin-top:20px;
       padding:10px;
    }
 
    section #third .inReview #userid {
       font-size:17px;
       font-weight:900;
       margin-top:10px;
    }
    section #third .inReview #title {
       font-weight:900;
       margin-top:10px;
    }
    section #third .inReview #content {
       margin-top:10px;
    }
 
    section #fourth {
       width:1100px;
       margin:auto;
       margin-top:50px;
    }
    section #fourth #left {
       float:left;
       font-size:20px;
       height:60px;
    }
    section #fourth #right {
       float:right;
       height:60px;
    }
    section #fourth table{
    	cell-spacing:0px;
    }
    section #fourth table tr td{
    	height:60px;
    	border-bottom:1px solid black;
    }
    section #fourth table tr:first-child td{
    	border-top:2px solid black;
    }
    section #fourth table tr:last-child td{
    	border-bottom:2px solid black;
    }
    section #fourth #q{
    	background:#999999;
    	color:white;
    	padding:2px;
    }
    section #fourth #a{
    	background:blue;
    	color:white;
    	padding:2px;
    	margin-left:20px;
    }
    section #fifth {
       
    }
    section #modal {
       display: none;   
       position:fixed;
       left:0px;
       top:0px;
       width:100%;
       height:100%;
       background-color:rgba(0,0,0,0.6);
    }
    section #qnaForm {
       width:300px;
       height:400px;
       border:1px solid black;
       background:white;
       position:fixed;
       left:300px;
       top:200px;
       visibility:hidden;
    }
    section #qnaForm form > div {
       text-align:center;
       margin-top:8px;
    }
    section #qnaForm form > div input[type=submit] {
       width:286px;
       height:30px;
    }
    section #qnaForm form > div textarea {
       width:280px;
       height:220px;
    }
    section #qnaForm #ptitle {
       border:none;
       outline:none;
       width:96%;
       text-align:center;
       overflow:hidden;
       height:40px;
       font-weight:900;
       resize:none; /* textarea의 크기변경 불가 */
    }
     #space1, #space2,#space3,#space4 {
       width:1100px;
       height:60px;
       }
    section #menu li
    {
    	background:white;
    }
    #menu-space{
    	height:50px;
    	display:none;
    }
  </style>
  <script>
	function downSu()
	{
	var num=document.getElementById("su").value;
	if(num>1)
		{
		//num--;
    	//document.getElementById("su").value=num;
		document.getElementById("su").value=--num;
		}	
	
	}
	function upSu()
	{
	var num=document.getElementById("su").value;
	//num++;
	//document.getElementById("su").value=num;
	document.getElementById("su").value=++num;
	}
	function jjimOk()
	{
		<c:if test="${userid!=null}">
		// 로그인을 했으면 비동기방식으로 찜테이블에 추가
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			if(chk.responseText=="0")
				{
					location="../login/login";
				}
			else
				{
				//로그인 후 jjim테이블에 저장 => 빨간하트
				document.getElementById("heart").src="../static/jjim2.png";
				document.getElementById("heart").setAttribute("onclick","jjimDel()");
				}
		}
		chk.open("get","jjimOk?pcode=${pdto.pcode}");
		chk.send();
		</c:if>
		
		<c:if test="${userid==null}">
		// 로그인을 하지 않았으면 login으로 이동
		location="../login/login?pcode=${pdto.pcode}";
		</c:if>
	}
	function jjimDel()
	{
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			if(chk.responseText=="0")
				{
					location="../login/login";
					
				}
			else
				{
					document.getElementById("heart").src="../static/jjim1.png";
					document.getElementById("heart").setAttribute("onclick","jjimOk()");
			}
		}
		chk.open("get","jjimDel?pcode=${pdto.pcode}");
		chk.send();
	}
	function addCart()
	{
		var su=document.getElementById("su").value;
		
		//cart 테이블에 비동기방식으로 상품코드, 아이디(세션), 수량을 저장
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			if(chk.responseText!="1")
				{
					alert("오류발생");
				}
			else
				{
					//장바구니 메시지 띄우기
					document.getElementById("cartLayer").style.visibility="visible";
					
					//setTimeout("함수명,시간");==setTimeout(function(){},시간)
					ss=setTimeout(function()
					{
					document.getElementById("cartLayer").style.visibility="hidden";
					clearTimeout(ss);
					},3000); //3초
				}
			}
		chk.open("get","addCart?pcode=${pdto.pcode}&su="+su);
		chk.send();
	}
	function cookieDel()
	{
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			
		}
		chk.open("get","/product/cookieDel");
		chk.send();
	}
	function cookieView()
	{
		var chk=new XMLHttpRequest();
		chk.onload=function()
		{
			document.getElementById("cookieView").innerText=chk.responseText;
		}
		chk.open("get","cookieView");
		chk.send();
	}
	function chgImg(src)
	{
		
	}
	window.onscroll=function()
	{
		var menu=document.getElementById("menu");
		var space=document.getElementById("menu-space");
		var top=document.documentElement.scrollTop;
		
		if(top>=730)
		{
			menu.style.position="fixed";
			menu.style.top="-66px";
			space.style.display="block";
		}
		else
		{
			menu.style.position="relative";
			menu.style.top="-66px";
			space.style.display="none";
		}
	}
</script>
</head>
<body>
<section>
	<div id="cartLayer">
		현재 상품을 장바구니에 담았습니다 <p>
		<a href="/member/cartView";><input type="button" value="장바구니로 이동"></a>
	</div>
	<div id="first">
	<div id="left">
		<img src="../static/product/${pdto.pimg}" width="440" height="440">
	</div>
	<div id="right">
		<div id="titleDiv"> ${pdto.title}
		<c:if test="${ok==0}">
		<img src="../static/jjim1.png" id="heart" onclick="jjimOk()" valign="middle">
		</c:if>
		<c:if test="${ok==1}">
		<img src="../static/jjim2.png" id="heart" onclick="jjimDel()" valign="middle">
		</c:if>
		</div>
		<div id="starDiv">
			<c:forEach begin="1" end="${pdto.ystar}">
				<img src="../static/star1.png" width="20" valign="middle">
			</c:forEach>
			<c:forEach begin="1" end="${pdto.hstar}">
				<img src="../static/star3.png" width="20" valign="middle">
			</c:forEach>
			<c:forEach begin="1" end="${pdto.gstar}">
				<img src="../static/star2.png" width="20" valign="middle">
			</c:forEach>
			${pdto.review} 개 상품평
		</div>
		<c:if test="${pdto.halin != 0}"> <!-- 할인율이 0%이면 불필요 -->
		<div id="halinDiv"> ${pdto.halin}% <s>${pdto.priceStr}원</s> </div>
		</c:if>
		<div id="halinPriceDiv"> ${pdto.halinPriceStr}원</div>
		<div id="baedayStrDiv"> ${pdto.baedayStr} </div> <!-- 배송일자 -->
		<div id="baepriceDiv">
			<c:if test="${pdto.baeprice==0}">
			무료배송
			</c:if>
			<c:if test="${pdto.baeprice!=0}">
				배송비: <fmt:formatNumber value="${pdto.baeprice}" type="number" pattern="#,###"/>원
			</c:if>
		</div>
		<div id="jukPriceDiv"> 적립예정: ${pdto.jukPriceStr}원 </div> <!-- 적립금 -->
		<div>
		<form method="post" action="productGumae"><!-- action="../member/productGumae" -->
		<input type="hidden" name="pcode" value="${pdto.pcode}">
		<div id="number">
			<img src="../static/minus.png" valign="middle" onclick="downSu()">
			<input type="text" name="su" value="1" id="su" readonly>
			<img src="../static/plus.png" valign="middle" onclick="upSu()">
		</div>
		<input type="button" value="장바구니" id="cartBtn" onclick="addCart()">
		<input type="submit" value="바로구매" id="gumaeBtn"> <p>
        <!-- <input type="button" value="쿠키확인" onclick="cookieView()"> -->
		<%-- <div id="cookieView"></div>
		<input type="button" value="cart 쿠키변수 삭제" onclick="cookieDel()"> -->
		<input type="button" value="바로구매" onclick="location='productGumae?pcode=${pdto.pcode}&su='+document.getElementById('su').value" >
		</form> --%>
		</form>
	  </div>
	</div> <!-- 수량, 장바구니, 바로구매 -->
	</div>	<!-- 상품이미지, 정보 -->
	   <div id="menu-space"></div>
	   <div id="menu"> <!-- 현재문서내에서 특정영역으로 이동 -->
     <ul>
       <li> <a href="#space1">상품상세</a><span id="ims"></span> </li>
       <li> <a href="#space2">상품평</a> </li>
       <li> <a href="#space3">상품문의</a> </li>
       <li> <a href="#space4">배송/교환/반품</a> </li>
     </ul>
   </div>
	
	
   <div id="second">
   <div id="space1">&nbsp;</div>
   		<h3 id="menu1"> 상품 상세 </h3>
     <img src="../static/product/${pdto.dimg}" width="1100">
   </div> <!-- 상품상세이미지 -->
	<div id="third"> <!-- review테이블에서 현재상품의 review를 읽어와서 출력 -->
	<div id="space2">&nbsp;</div>
	<h3 id="menu2"> 상품평 </h3>
     <div>
       <c:forEach begin="1" end="${pdto.ystar}">
          <img src="../static/star1.png" width="40" valign="middle">
         </c:forEach>
         <c:forEach begin="1" end="${pdto.hstar}">
          <img src="../static/star3.png" width="40" valign="middle">
         </c:forEach>
         <c:forEach begin="1" end="${pdto.gstar}">
          <img src="../static/star2.png" width="40" valign="middle">
         </c:forEach>
         ${pdto.review}개 상품평
     </div>
     <!-- 각 개인별 상품평 출력 -->
   <c:forEach items="${rlist}" var="rdto">
     <div class="inReview">
   <div>
       <!-- 노란별 출력 -->
   <c:forEach begin="1" end="${rdto.star}">
   		<img src="../static/star1.png" width="20">
   </c:forEach>
   <c:forEach begin="1" end="${5-rdto.star}">
		<img src="../static/star2.png" width="20">   
   </c:forEach>
	(${rdto.writeday})
     </div>
     <div id="userid"> ${rdto.chUserid} </div>
     <div id="title"> ${rdto.title} </div>
     <div id="content"> ${rdto.content} </div>
     <div id="upDel" align="right">
         <c:if test="${userid!=rdto.userid}">
         신고하기
        </c:if>
        <c:if test="${userid==rdto.userid}">
         <a href="../member/reviewUpdate?id=${rdto.id}&pcode=${pdto.pcode}"> 수정 </a> | 
         <a href="../member/reviewDelete?id=${rdto.id}&pcode=${pdto.pcode}&gid=${rdto.gid}"> 삭제 </a>
        </c:if>
       </div>
     </div>
   </c:forEach>
	
	
	</div>	<!-- 상품평 -->
	
	
	<div id="fourth">
	<div id="space3">&nbsp;</div>
	   <div>
		<div id="left"> <span id="menu3">상품문의</span> </div>
		<div id="right"> <input type="button" value="문의하기" onclick="qnaView()"> </div>
		</div> <!-- 상품문의와 문의하기 링크 -->
		<div> 
		
		<table width="1100" align="center">
		<c:forEach items="${qlist}" var="qdto">
			<tr>
			<td width="100"> <!-- 질문인지 답변인지 출력 -->
			<c:if test="${qdto.qna==1}">
			<span id="q">질문</span>
			</c:if>
			<c:if test="${qdto.qna==2}">
			↪ <span id="a">답변</span>
			</c:if>
			</td>
            <td width="150"> ${qdto.userid} </td> <!-- 질문자 -->
            <td> ${qdto.content} </td> <!-- 질문내용 -->
            <td width="180" align="center">
            ${qdto.writeday} <!-- 질문날짜 -->
            <c:if test="${userid==qdto.userid}">
            	<input type="button" value="삭제" onclick="location='qnaDel?id=${qdto.id}&pcode=${qdto.pcode}&ref=${qdto.ref}'">
            </c:if>
            </td>
			</tr>
		</c:forEach>
		
		</table>
		
		 </div> <!-- 상품문의 출력 -->
	   </div> <!-- 상품 문의 -->
	   <div id="fifth">
	   <div id="space4">&nbsp;</div>
	   <h3 id="menu4"> 배송/교환/반품 안내 </h3>
	   <img src="../static/change.png" width="1100">
	   </div> <!-- 배송, 교환, 반품관련 -->
	   
	  <div id="modal">
	   <div id="qnaForm">
	   <form method="post" action="qnaWriteOk">
        <input type="hidden" name="pcode" value="${pdto.pcode}">
	   	<div> <textarea name="ptitle" id="ptitle" readonly>${pdto.title}</textarea>
   		<div> <textarea name="content" id="qnaContent" maxlength="200" onkeyup="wordlen(this)"></textarea> </div>
     	<div> 총글자수(<span id="chongWord">0</span>) </div>
	   	<div> <input type="submit" value="문의저장"> </div>
	   	</form>
	   </div>
	  </div>
</section>
<script>
	function qnaView()
	{
		//브라우저의 가로세로를 구해서 id="qnaForm"을 중앙에 위치 시키기
		var w=window.innerWidth;
		var h=window.innerHeight;
		
		w=w/2;
		h=h/2;
		
		w=w-150;
		h=h-200;
		
		document.getElementById("qnaForm").style.left=w+"px";
		document.getElementById("qnaForm").style.top=h+"px";
		
		document.getElementById("qnaForm").style.visibility="visible";
		
		document.getElementById("modal").style.display="block";
	}
	function wordlen(my)
	{
		var len=my.value.trim().length;
		document.getElementById("chongWord").innerText=len;
	}
</script>
</body>
</html>


























