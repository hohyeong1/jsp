<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>계좌 조회</title>
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
            width: 300px;
            text-align: center;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            padding: 10px 20px;
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
        <h2>계좌 조회</h2>
        <form action="accountProcess.jsp" method="post">
            <input type="text" name="accountId" placeholder="계좌 번호 입력" required>
            <button type="submit">조회</button>
        </form>
    </div>
</body>
</html>