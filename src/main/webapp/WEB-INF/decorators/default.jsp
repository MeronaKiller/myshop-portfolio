<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <!-- https://noonnu.cc/index -->
  <style>
   @font-face {
    font-family: 'GongGothicMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/GongGothicMedium.woff') format('woff');
    font-weight: 100;
    font-style: normal;
   } 
   @font-face {
    font-family: 'GmarketSansBold';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
   @font-face {
    font-family: 'GmarketSansLight';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
   @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
   }
    body {
       margin:0px;
       font-family:'GmarketSansMedium';
    }
    #fouter {
       width:100%;
       height:40px;
       background:#5F007F;
       display:none;
    }
    #fouter #xx {
       cursor:pointer;
    }
    #fouter #first {
       width:1100px;
       height:40px;
       margin:auto;
       background:#5F007F;
    }
    #fouter #first #left {
       display:inline-block;
       width:1000px;
       height:40px;
       line-height:40px;
       text-align:center;
       color:white;
    }
    #fouter #first #right {
       display:inline-block;
       width:80px;
       height:40px;
       line-height:40px;
       text-align:right;
       color:white;
    }

    header {
       width:1100px;
       height:70px;
       margin:auto;
    }
    header #myMain {
       position:relative;
    }
    header #mySub { /* ul태그 */
       position:absolute;
       left:-18px;
       top:2px;
       padding-left:0px;
       background:white;
       visibility:hidden;
       /* box-shadow: 10px 10px 20px rgba(0, 0, 0, 0.3) */
       z-index:100;
    }
    header #mySub > li {
       list-style-type:none;
       width:90px;
       height:30px;
       line-height:30px;
       text-align:center;
       border:1px solid purple;
       border-bottom:none;
    }
   
    header #mySub > li:last-child {
       border-bottom:1px solid purple;
    }
    header a {
       text-decoration:none;
       color:black;
    }
    header #cartNum {
       color:white;
       background:purple;
       /* padding:1px 4px 0px 2px; */
       border:1px solid purple;
       border-radius:14px;
       padding-left:3px;
       padding-right:3px;
       font-size:14px;
    }
    header #logo {
       display:inline-block;
       width:280px;
       height:70px;
       line-height:70px;
    }
    header #search {
       display:inline-block;
       width:460px;
       height:70px;
       line-height:70px;
    }
    header #search #searchForm {
       width:350px;
       height:44px;
       border:1px solid black;
       line-height:44px;
       border-radius:15px;
    }
    header #search #searchForm input[type=text] {
       width:200px;
       border:none;
       outline:none;
       margin-left:10px;
    }
    header #memMenu { 
       display:inline-block;
       width:330px;
       height:70px;
       line-height:70px;
    }
    header #xpng {
       /* display:none; */
       visibility:hidden;
    }
    nav {
       width:1100px;
       height:60px;
       margin:auto;
       
    }
    
    nav > ul {
       padding-left:0px;
    }
    nav > ul > li {
       display:inline-block;
       width:150px;
       height:60px;
       line-height:60px;
    }
    nav > ul > li:first-child {
       width:250px;
    }
    nav > ul > li:last-child {
       width:220px;
       text-align:right;
    }
    
    nav #category {
       position:relative;
       /* background:#abcdef; */
       display:inline-block;
       width:100px;
       height:26px;
       line-height:26px;
       text-align:center;
       z-index:100;
    }
    
    nav #category li:hover {
       background:#E8D9FF;
    }
    
    nav #category #daeMenu { /* ul 태그 */
       position:absolute;
       left:0px;
       top:26px;
       padding-left:0px;
       /* background:#fedcba; */
       background:white;
       visibility:hidden;
       border:1px solid #cccccc;
    }
    
    nav #category #daeMenu > li {
       list-style-type:none;
       width:100px;
       height:26px;
       line-height:26px;
       text-align:center;
       position:relative;
    }
    nav #category #daeMenu > li .jungMenu { /* 중분류 ul태그 */
       position:absolute;
       left:100px;
       top:-1px;
       padding-left:0px;
       /* background:#fedcba; */
       background:white;
       visibility:hidden;
       border:1px solid #cccccc;
    }
    nav #category #daeMenu > li .jungMenu > li { /* 중분류 메뉴 */
       list-style-type:none;
       width:100px;
       height:26px;
       line-height:26px;
       text-align:center;
       position:relative;
    }
    nav #category #daeMenu > li .jungMenu > li > .soMenu { /* 소분류 ul태그 */
       position:absolute;
       left:100px;
       top:-1px;
       padding-left:0px;
      /*  background:#fedcba; */
       background:white;
       visibility:hidden;
       border:1px solid #cccccc;
    }
    nav #category #daeMenu > li .jungMenu > li > .soMenu > li {
       list-style-type:none;
       width:100px;
       height:26px;
       line-height:26px;
       text-align:center;
    }
    nav a {
       text-decoration:none;
       color:black;
    }
    footer {
       width:1100px;
       height:150px;
       margin:auto;
 
    }
  </style>
  <script>
    var h=40;
    function fclose()
    {
    	// id="fouter"내의 모든 걸 숨기기
    	//document.getElementById("fouter").style.display="none";
    	ss=setInterval(function()
    	{
    		h--;
        	document.getElementById("fouter").style.height=h+"px";
        	document.getElementById("first").style.height=h+"px";
        	
        	if(h==0)
        	{
        		clearInterval(ss);
        		document.getElementById("fouter").style.display="none";
        	}	
    	},10);
    	
    	// 쿠키변수에 사용자가 x를 클릭하였으므로 정보를 저장 후 안보여주기
    	var chk=new XMLHttpRequest();
    	chk.onload=function()
    	{
    		if(chk.responseText=="0")
    		{
    			alert("오류");
    		}	
    			
    	}
    	chk.open("get","../firstCookie");
    	chk.send();
    	
    }
    
    // default.jsp는 모든 페이지가 다 사용한다.
    // 비동기방식으로 접근
    
    
    let recognition;
    
    window.onload=function()
    {
     	// 쿠키를 체크하여 보여줄지 말지를 결정한다.
    	var chk=new XMLHttpRequest();
    	chk.onload=function()
    	{
    		var n=chk.responseText;
    		if(n=="0")
    		{
    			document.getElementById("fouter").style.display="block"; // 1층 숨기기
    		}	
    	 
    	}
    	chk.open("get","../fcookOk");
    	chk.send();
    	
    	// 장바구니의 갯수를 가져와서 출력하기
    	getNum();
    	
    	availabilityFunc();
    	   
    	function availabilityFunc() 
    	{
    	    // webkitSpeechRecognition 또는 SpeechRecognition을 생성
    	    recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
    	    recognition.lang = "ko"; // 음성인식에 사용될 언어 설정
    	    recognition.maxAlternatives = 5; // 음성 인식결과를 5개까지 보여준다.

    	    // 음성 인식 기능을 지원하지 않으면 경고 메시지
    	    if (!recognition) 
    	    {
    	        alert("현재 브라우저는 음성 인식을 지원하지 않습니다.");
    	    }
    	}
    }
    function startRecord() {

    	 console.log("음성 인식 시작");

    	 // ⏺️ 클릭 시 음성 인식을 시작한다.
    	 recognition.addEventListener("speechstart", () => {
    	     console.log("음성 인식 시작");
    	 });

    	 // 음성 인식이 끝나면 종료된다.
    	 recognition.addEventListener("speechend", () => {
    	     console.log("음성 인식 종료");
    	 });

    	 // 음성 인식 결과를 반환
    	recognition.addEventListener("result", (e) => {
    	  // e.results가 존재하는지, 그리고 첫 번째 항목이 있는지 확인
    	  alert(e.results);
    	  alert(e.results[0]);
    	  alert(e.results[0][0].transcript);
    	  if (e.results && e.results[0] && e.results[0][0]) {
    	    // 정상적으로 결과가 있다면 searchConsole에 값 할당
    	    document.getElementById("sword").value =e.results[0][0].transcript
    	    endRecord();
    	  } else {
    	    // 결과가 없다면 경고 메시지 또는 빈 문자열 설정
    	    console.log("음성 인식 결과가 없습니다.");
    	    searchConsole.value = ""; // 음성 인식 결과가 없을 경우 빈 문자열로 처리
    	  }
    	});


    	 recognition.start();
    	}

    	// 🛑 클릭 시 종료
    	function endRecord() {
    	 console.log("음성 인식 종료");
    	 recognition.stop(); // 음성 인식 중지
    	}
  
    
    function getNum()
    {
    	var chk=new XMLHttpRequest();
    	chk.onload=function()
    	{
    		document.getElementById("cartNum").innerText=chk.responseText;
    	}
    	chk.open("get","../getCartNum");
    	chk.send();
    }
    
    function chgX(val) // name="sword"인 태그에 입력된 값
    {
    	if(val.length==0)
    	{
    		document.getElementById("xpng").style.visibility="hidden";
    	}
    	else
    	{
    		document.getElementById("xpng").style.visibility="visible";
    		
    		if(event.keyCode==13) // 방금 입력된 키값이 enter키이면
    			search();
    	}	
    }
    
    // x를 클릭하면 name="sword"의 value를 ""으로
    function hideTxt()
    {
    	document.getElementById("sword").value="";
    	document.getElementById("xpng").style.visibility="hidden";
    }
    
    // 카테고리에 마우스오버가 1번만 발생할 수 있게 하기
    var daeChk=0;
    function viewDae()
    {
    	document.getElementById("daeMenu").style.visibility="visible";
    	
    	// 서버에서 1번만 읽으면 된다..
    	if(daeChk==0)
    	{
    		var chk=new XMLHttpRequest();
        	chk.onload=function()
        	{
        		//alert(chk.responseText);
        		var daes=JSON.parse(chk.responseText);
        		var str="";
        		for(dae of daes)
        		{   // dae.code
        			str=str+"<li onmouseover='viewJung("+dae.code+")' onmouseout='hideJung("+dae.code+")'> <a href='../product/productList?pcode=p"+dae.code+"'>"+dae.name+"</a> <ul class='jungMenu'></ul> </li>";
        		}	                                                                                     // 가전제품 => <a href="productList?pcode=p01"> 가전제품 </a>
        		
        		document.getElementById("daeMenu").innerHTML=str;
        		
        		daeChk=1;
        	}
        	chk.open("get","../getDae");
        	chk.send();
    	}	
    	
 
    }
    
    function hideDae()
    {
    	document.getElementById("daeMenu").style.visibility="hidden";
    }
    
    var jungChk=[0,0,0,0,0,0,0];
    
    function viewJung(daecode)   // 
    {
     	document.getElementsByClassName("jungMenu")[daecode-1].style.visibility="visible";
 
     	if(jungChk[daecode-1]==0) // 마우스오버가 계속 발생 => 오버가 발생하면 비동기 방식 X
    	{
    		//alert(daecode); // 가전제품:1  , 패션제품:2  ...... 
        	var chk=new XMLHttpRequest();
        	chk.onload=function()
        	{
        		// alert(chk.responseText);
        		var jungs=JSON.parse(chk.responseText);
        		var str="";
        		for(jung of jungs)
        		{
        			str=str+"<li onmouseover='viewSo(this,"+daecode+jung.code+")' onmouseout='hideSo(this)'><a href='../product/productList?pcode=p"+jung.daecode+jung.code+"'> "+jung.name+" </a><ul class='soMenu'></ul> </li>";
        		}	                                                                               // TV  => <a href="productList?pcode=p0101"> TV </a>
        		 
        		document.getElementsByClassName("jungMenu")[daecode-1].innerHTML=str;
        		jungChk[daecode-1]=1;
        	}
        	chk.open("get","../getJung?daecode="+daecode);
        	chk.send();
    	}	
    	
    }
    function hideJung(daecode)
    {
    	document.getElementsByClassName("jungMenu")[daecode-1].style.visibility="hidden";
    }
    
    function viewSo(my,daejung)
    {
    	my.childNodes[1].style.visibility="visible";
    	
    	if(my.childNodes[1].innerHTML=="")
    	{
    		var chk=new XMLHttpRequest();
        	chk.onload=function()
        	{
        		//alert(chk.responseText);
        		var sos=JSON.parse(chk.responseText);
        		var str="";
        		for(so of sos)
        		{
        			str=str+"<li> <a href='../product/productList?pcode=p"+so.daejung+so.code+"'>"+so.name+"</a></li>";
        			         // 대형TV  =>  <a href="productList?pcode=p010101"> 대형TV </a>
        		}	
        		//alert(my.childNodes.length);
        		my.childNodes[1].innerHTML=str;
        	}
        	chk.open("get","../getSo?daejung="+daejung);
        	chk.send();
    	}
    	
    	
    }
    function hideSo(my)
    {
    	// 모든 class="soMenu"인 것을 지우기
    	// my.childNodes[1].style.visibility="hidden";
    	var soMenu=document.getElementsByClassName("soMenu");
    	var len=soMenu.length;
    	for(i=0;i<len;i++)
    	{
    		soMenu[i].style.visibility="hidden";
    	}	
    }
    
    function viewMy()
    {
     	document.getElementById("mySub").style.visibility="visible";
    }
    function hideMy()
    {
    	document.getElementById("mySub").style.visibility="hidden";
    }
    function search()
    {
    	if(document.getElementById("sword").value.trim() != "") // 검색어가 없는데 전달
    	  location="../product/productList?sword="+document.getElementById("sword").value;
    }
  </script>
  <sitemesh:write property="head"/>
</head>
<body> <!-- default.jsp -->

   <div id="fouter">
     <div id="first">
      <div id="left"> 회원가입하고 50%할인 쿠폰 드립니다 </div>
      <div id="right"> <span id="xx" onclick="fclose()"> X </span> </div>
     </div>
   </div>
   <header>
     <div id="logo"> <a href="../main/main"><img src="../static/logo1.png" width="80" valign="middle"> </a></div>
     <div id="search">
       <div id="searchForm">
         <input type="text" name="sword" value="${sword}" id="sword" placeholder="검색어를 입력하세요" onkeyup="chgX(this.value)">
         <img src="../static/x.png" valign="middle" id="xpng" onclick="hideTxt()">
         <img src="../static/s.png" valign="middle" onclick="search()">  <!-- 돋보기 -->
         <button type="button" onclick="startRecord()">⏺️</button>
         <button type="button" onclick="endRecord()">🛑</button>
       </div>
     </div>
     <div id="memMenu">
        <a href="../member/cartView"> 장바구니 <span id="cartNum">&nbsp;&nbsp;</span> </a> | 
      <c:if test="${userid==null}">   
        <a href="../login/login"> 로그인 </a> |
        <a href="../member/member"> 회원가입 </a> |
      </c:if>
      <c:if test="${userid!=null}">  
        <span id="myMain" onmouseover="viewMy()" onmouseout="hideMy()"> ${name}님
          <ul id="mySub">
            <li> <a href="../member/jjimList"> 찜리스트 </a></li>
            <li> <a href="../member/memberInfo"> 회원정보 </a></li>
            <li> <a href="../member/jumunList"> 주문내역 </a> </li>
            <li> <a href="../member/baesongList"> 배송지정보 </a></li>
            <li> <a href="../member/reviewList"> 상품평관리 </a> </li>
            <li> <a href="../member/qnaList"> 상품문의 </a> </li>
          </ul>        
        </span> |
        <a href="../login/logout"> 로그아웃 </a> |
      </c:if>  
        고객센터
     </div>
   </header>
   <nav>
     <ul id="mainMenu">
       <li>
         <span id="category" onmouseover="viewDae()" onmouseout="hideDae()"> 카테고리 
           <ul id="daeMenu">
           </ul>   
         </span>    
       </li>
       <li> 신상품 </li>
       <li> 베스트 </li>
       <li> 알뜰쇼핑 </li>
       <li> 특가/혜택 </li>
       <li> 샛별하루배송 </li>
     </ul>
   </nav>
   
    <sitemesh:write property="body"/>
   
   <footer><img src="../static/footer.png"> </footer>
</body>
</html>




