<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script>
    var today=new Date(); // 오늘날짜객체
    var today2=new Date(2025,1,21);
    var xday=new Date(2025,1,21); // 특정일날짜객체 => 0~11로 월을 인식
    //var xday2=new Date("2025-02-15");  => 1~12
    
    console.log(today2);
    console.log(xday);
    //console.log(xday2);
  
    alert(today2.getTime()+" "+xday.getTime());
    if(today2.getTime()==xday.getTime())
    {
    	alert("같다");
    }
  </script>

</head>
<body> <!-- etc/form.jsp -->


 <!-- 
 <form method="post" action="formOk">
   <input type="checkbox" name="subChk" value="0">
   <input type="hidden" name="pcode" value="11">
   
   <input type="checkbox" name="subChk" value="1">
   <input type="hidden" name="pcode" value="22">
   
   <input type="checkbox" name="subChk" value="2">
   <input type="hidden" name="pcode" value="33">
   
   <input type="checkbox" name="subChk" value="3">
   <input type="hidden" name="pcode" value="44">
   
   <input type="checkbox" name="subChk" value="4">
   <input type="hidden" name="pcode" value="55">
   <p>
   <input  type="text" name="su"><br>
   <input  type="text" name="su"><br>
   <input  type="text" name="su"><br>
   <input  type="text" name="su"><br>
   <input  type="text" name="su"><br>
   <p>
   <input type="submit" value="구매">
 </form> -->
</body>
</html>