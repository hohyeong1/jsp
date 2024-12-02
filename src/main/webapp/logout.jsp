<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h1 {
            margin-bottom: 20px;
            color: #333;
        }
        p {
            color: #555;
            margin-bottom: 20px;
        }
        a {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>로그아웃</h1>
        <% 
            // 세션이 존재하는지 확인
            HttpSession currentSession = request.getSession(false);
            if (currentSession != null) {
                currentSession.invalidate(); // 세션 무효화
        %>
            <p>성공적으로 로그아웃되었습니다.</p>
        <%  
            } else {
        %>
            <p>활성 세션이 없습니다. 이미 로그아웃 상태입니다.</p>
        <%  
            }
        %>
        <a href="login.jsp">로그인 페이지로 이동</a>
    </div>
</body>
</html>
