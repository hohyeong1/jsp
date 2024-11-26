<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.util.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>송금 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F4F4F9;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        input[type="number"], input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45A049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>송금하기</h2>
        <form action="transferProcess.jsp" method="post">
            <input type="hidden" name="fromAccountId" value="<%= request.getParameter("fromAccountId") %>">
            <label for="toAccountId">받는 계좌 번호:</label>
            <input type="text" id="toAccountId" name="toAccountId" required>
            <label for="amount">송금액:</label>
            <input type="number" id="amount" name="amount" required>
            <button type="submit">송금</button>
        </form>
        <p><a href="accountList.jsp">계좌 목록으로 돌아가기</a></p>
    </div>
</body>
</html>
