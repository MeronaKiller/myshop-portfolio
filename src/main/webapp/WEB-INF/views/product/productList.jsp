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
     margin:auto;
     font-family:'GmarketSansMedium';
   }
   section #halinDiv {
     font-size:12px;
   }
   section #halinDiv s {
     color:#cccccc;
   }
   section #halinPriceDiv {
     font-size:17px;
     color:red;
   }
   section > table {
      border-spacing:20px;
   }
   section > table tr td {
      border:2px solid white;
      vertical-align:top;
   }
   section > table tr td:hover {
      border:2px solid #5F007F;
   }
   section > table tr td div:first-child {
      text-align:center;
      overflow:hidden;
      width:250px;
      height:250px;
   }
   section > table tr td div {
      margin-top:4px;
   }
   @keyframes pkc {
      0% { transform:scale(1,1); }
	  100% { transform:scale(1.2,1.2); }
   }
   @keyframes pkc2 {
      0% { transform:scale(1.2,1.2); }
	  100% { transform:scale(1,1); }
   }
   section table tr:last-child td { /* 페이지 출력되는 td에 외곽선 없애기 */
      border:none;
   }
   section table tr:last-child td a { /* 페이지 링크 a태그 */
      text-decoration:none;
      width:30px;
      height:25px;
      padding-top:5px;
      display:inline-block;
      color:black;
   }
   section table tr:last-child td a:hover {
      background:#5F007F;
      color:white;
   }
   section #orderList {
      text-align:right;
      margin-top:20px;
      margin-bottom:20px;
   }
   section #orderList a {
      text-decoration:none;
      color:black;
      font-size:12px;
   }
   section #orderList a:hover {
      background:#5F007F;
      color:white;
   }
   section #menuList {
      margin-top:40px;
   }
 </style>
 <script>
   function exOut(my)
   {
	   my.style.animationName="pkc2";
	   my.style.animationDuration="0.5s";
	   my.style.animationFillMode="forwards";
   }
   function exOver(my)
   {
	   my.style.animationName="pkc";
	   my.style.animationDuration="0.5s";
	   my.style.animationFillMode="forwards";
   }
   
   window.onpageshow=function()
   {
	   // 정렬순에 해당되는 class="order"의 색을 빨간색으로
	   document.getElementsByClassName("order")[${order-1}].style.color="red";
   }
 </script>
</head>
<body> <!-- product/productList.jsp -->
 <section>
  <div id="menuList">
    ${menuList}
  </div>
  <div id="orderList">
   <a href="productList?order=1&pcode=${pcode}&sword=${sword}" class="order"> 판매량순 </a> |
   <a href="productList?order=2&pcode=${pcode}&sword=${sword}" class="order"> 가격높은순 </a> |
   <a href="productList?order=3&pcode=${pcode}&sword=${sword}" class="order"> 가격낮은순 </a> |
   <a href="productList?order=4&pcode=${pcode}&sword=${sword}" class="order"> 별점높은순 </a> |
   <a href="productList?order=5&pcode=${pcode}&sword=${sword}" class="order"> 최신상품순 </a>
  </div>
 
  <table align="center" width="1100">
    <tr>
  <c:forEach items="${plist}" var="pdto" varStatus="sts">
     <td onclick="location='productContent?pcode=${pdto.pcode}'"> 
          
       <div> <img src="../static/product/${pdto.pimg}" onmouseover="exOver(this)" onmouseout="exOut(this)" width="200" height="200"> </div>
      <c:if test="${pdto.baeprice==0}"> 
       <div> 무료 배송 </div>
      </c:if>
       <div> ${pdto.title} </div>
      <c:if test="${pdto.halin != 0}"> <!-- 할인율, 원래상품금액 -->
       <div id="halinDiv"> ${pdto.halin}% <s>${pdto.priceStr}</s> </div>
      </c:if>
       <div id="halinPriceDiv"> ${pdto.halinPriceStr}원 </div>
       <div> ${pdto.baedayStr} </div>
       <div style="letter-spacing:-3px;"> 
         <c:forEach begin="1" end="${pdto.ystar}">
          <img src="../static/star1.png" width="10">
         </c:forEach>
         <c:forEach begin="1" end="${pdto.hstar}">
          <img src="../static/star3.png" width="10">
         </c:forEach>
         <c:forEach begin="1" end="${pdto.gstar}">
          <img src="../static/star2.png" width="10">
         </c:forEach>
       </div>
       <div>
        <c:if test="${pdto.juk != 0}">
         <span id="outline" style="border:1px solid #444444;padding:3px;border-radius:10px;font-size:12px;">
          <img src="../static/juk.png" width="17" valign="middle">
          최대 ${pdto.jukPriceStr}원 적립
         </span>
        </c:if> 
       </div>
     </td>
   <c:if test="${sts.count%4==0}">
     </tr>
     <tr>
   </c:if> 
   
   <!-- jstl의 format이용하기 -->
  <c:if test="false">
   <tr>
    <td>
     <fmt:formatNumber value="${pdto.price}" type="number" pattern="#,###"/> 
     <fmt:formatNumber value="${pdto.price-(pdto.price*pdto.halin/100)}" type="number" pattern="#,###"/> 
     <fmt:formatNumber value="${ ( pdto.price-(pdto.price*pdto.halin/100) )*pdto.juk/100 }" type="number" pattern="#,###"/>
    </td>
   </tr>  
  </c:if>
   
  </c:forEach>
   
   <!-- 페이지 출력 -->
   <tr height="60">
     <c:if test="${plist.size()==0}">
       <td colspan="4" align="center">
        검색 상품이 존재하지 않습니다.
       </td>
     </c:if>
     <c:if test="${plist.size()!=0}">
       <td colspan="4" align="center">
        <!-- 이전 그룹 -->
         <c:if test="${pstart!=1}">
          <a href="productList?order=${order}&page=${pstart-1}&pcode=${pcode}&sword=${sword}"> ◁◁ </a>
         </c:if>
         <c:if test="${pstart==1}">
          ◁◁
         </c:if>
        
        <!-- 이전 페이지 -->
         <c:if test="${page != 1}">
          <a href="productList?order=${order}&page=${page-1}&pcode=${pcode}&sword=${sword}"> ◁ </a>
         </c:if>
         <c:if test="${page == 1}"> 
          ◁
         </c:if>
         
        <c:forEach var="i" begin="${pstart}" end="${pend}">
         <c:if test="${page == i}"> <!-- 현재페이지랑 출력된 i의 값이 같을때 -->
          <a href="#" style="color:red;"> ${i} </a>
         </c:if>
         <c:if test="${page != i}">
          <a href="productList?order=${order}&page=${i}&pcode=${pcode}&sword=${sword}"> ${i} </a>
         </c:if> 
        </c:forEach>
        
        <!-- 다음페이지 -->
         <c:if test="${page != chong}">
          <a href="productList?order=${order}&page=${page+1}&pcode=${pcode}&sword=${sword}"> ▷ </a>
         </c:if>
         <c:if test="${page == chong}"> 
          ▷
         </c:if>
         
         <!-- 다음 그룹 -->
         <c:if test="${pend!=chong}"> 
          <a href="productList?order=${order}&page=${pend+1}&pcode=${pcode}&sword=${sword}"> ▷▷ </a>
         </c:if>
         <c:if test="${pend==chong}">
          ▷▷
         </c:if>
       </td>
      </c:if>
     </tr> 
  </table>
  
  
  
 </section>
</body>
</html>





