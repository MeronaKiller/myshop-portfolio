<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script>
    // 부모창을 main으로 이동후 창을 닫기
    //opener.location="../main/main";
    //close();
    
    document.write("<p align='center'> <b> 로그인이 되어있지 않습니다. <br> <a href='javascript:login()'>로그인</a> </b> </p>");
    setTimeout(function()
    {
    	opener.location="../main/main"; //부모창의 주소를 main으로 이동
        close(); 	//현재창을 닫기(자식창 이니까 자식창 닫기)
    },3000);
    
    function login()
    {
    	opener.location="../login/login";
    	close();
    }
  </script>
</head>
<body>
  
</body>
</html>