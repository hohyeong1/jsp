<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
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
        }
        .menu {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .menu button {
            padding: 10px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .menu button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>은행 메인 화면</h1>
        <div class="menu">
            <form action="viewAccount.jsp" method="get">
                <button type="submit">사용자 정보 조회</button>
            </form>
            <form action="createAccount.jsp" method="get">
                <button type="submit">계좌 개설</button>
            </form>
            <form action="deposit.jsp" method="get">
                <button type="submit">입금</button>
            </form>
            <form action="withdraw.jsp" method="get">
                <button type="submit">출금</button>
            </form>
            <form action="balanceCheck.jsp" method="get">
                <button type="submit">잔액 확인</button>
            </form>
            <form action="accountList.jsp" method="get">
                <button type="submit">계좌 조회</button>
            </form>
            <!-- 로그아웃 버튼 추가 -->
            <form action="logout.jsp" method="post">
                <button type="submit">로그아웃</button>
            </form>
        </div>
    </div>
</body>
</html>
