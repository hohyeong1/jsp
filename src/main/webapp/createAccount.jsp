<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.util.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>계좌 개설</title>
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
        input[type="text"], input[type="number"], select {
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
        <h2>계좌 개설</h2>
        <form action="createAccountProcess.jsp" method="post">
            <%
                String accountId = null;
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                // 계좌 ID 중복 체크
                do {
                    accountId = String.format("%010d", (int)(Math.random() * 1_000_000_0000L));
                    String checkQuery = "SELECT COUNT(*) FROM ACCOUNTS WHERE ACCOUNT_ID = ?";
                    try {
                        conn = DBConnection.getConnection();
                        pstmt = conn.prepareStatement(checkQuery);
                        pstmt.setString(1, accountId);
                        rs = pstmt.executeQuery();
                        if (rs.next() && rs.getInt(1) > 0) {
                            accountId = null; // 중복된 경우 null로 설정
                        }
                    } catch (SQLException e) {
                        out.println("<p>SQL 에러: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                    }
                } while (accountId == null); // 중복되지 않을 때까지 반복

            %>
            <input type="text" name="accountId" value="<%= accountId %>" readonly>
            <input type="text" name="userId" placeholder="사용자 ID" required>
            <input type="number" name="initialBalance" placeholder="초기 잔액" required>
            <label for="accountType">계좌 유형:</label>
            <select name="accountType" id="accountType" required>
                <option value="Savings">저축 예금</option>
                <option value="Checking">당좌 예금</option>
                <option value="Fixed Deposit">정기 예금</option>
                <option value="Loan">대출 계좌</option>
            </select>
            <button type="submit">계좌 개설</button>
        </form>
        <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
    </div>
</body>
</html>
