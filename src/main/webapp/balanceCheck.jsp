<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>잔액 확인</title>
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
        form input {
            padding: 10px;
            margin: 5px 0;
            width: 80%;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        form button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #008CBA;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        form button:hover {
            background-color: #007bb5;
        }
        .balance {
            margin-top: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div>
        <h1>잔액 확인</h1>
        <% 
            String balanceInfo = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String accountId = request.getParameter("account_id");
                
                if (accountId == null || accountId.isEmpty()) {
                    balanceInfo = "계좌 번호를 입력해 주세요.";
                } else {
                    try {
                        // 데이터베이스 연결 정보
                        String url = "jdbc:oracle:thin:@localhost:1521:xe";
                        String user = "hr";
                        String password = "hr";
                        
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection conn = DriverManager.getConnection(url, user, password);
                        
                        String sql = "SELECT BALANCE FROM ACCOUNTS WHERE ACCOUNT_ID = ?";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, accountId);  // ACCOUNT_ID는 VARCHAR2이므로 문자열로 처리
                        ResultSet rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            double balance = rs.getDouble("BALANCE");
                            balanceInfo = "현재 잔액: " + balance + "원";
                        } else {
                            balanceInfo = "해당 계좌를 찾을 수 없습니다.";
                        }
                        
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                        balanceInfo = "오류가 발생했습니다: " + e.getMessage();
                    }
                }
            }
        %>
        <form action="balanceCheck.jsp" method="post">
            <input type="text" name="account_id" placeholder="계좌 번호" required /><br/>
            <button type="submit">잔액 확인</button>
        </form>
        <div><%= balanceInfo %></div>
        <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
    </div>
</body>
</html>