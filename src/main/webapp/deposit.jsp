<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>입금</title>
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
        form {
            margin-bottom: 20px;
        }
        input {
            padding: 10px;
            width: 80%;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .message {
            margin-top: 20px;
            font-size: 14px;
            color: #333;
        }
    </style>
</head>
<body>
    <div>
        <h1>입금</h1>
        <% 
            String message = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String accountId = request.getParameter("account_id");
                String depositAmountStr = request.getParameter("deposit_amount");
                
                if (accountId == null || depositAmountStr == null || accountId.isEmpty() || depositAmountStr.isEmpty()) {
                    message = "모든 필드를 입력해 주세요.";
                } else {
                    try {
                        double depositAmount = Double.parseDouble(depositAmountStr);
                        
                        if (depositAmount <= 0) {
                            message = "입금액은 양수이어야 합니다.";
                        } else {
                            // 데이터베이스 연결 정보
                            String url = "jdbc:oracle:thin:@localhost:1521:xe";
                            String user = "hr";
                            String password = "hr";
                            
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            Connection conn = DriverManager.getConnection(url, user, password);
                            
                            // 계좌 존재 확인 및 잔액 업데이트
                            String sql = "UPDATE ACCOUNTS SET BALANCE = BALANCE + ? WHERE ACCOUNT_ID = ?";
                            PreparedStatement pstmt = conn.prepareStatement(sql);
                            pstmt.setDouble(1, depositAmount);
                            pstmt.setString(2, accountId);
                            
                            int rows = pstmt.executeUpdate();
                            
                            if (rows > 0) {
                                message = "입금이 성공적으로 완료되었습니다.";
                            } else {
                                message = "해당 계좌를 찾을 수 없습니다.";
                            }
                            
                            pstmt.close();
                            conn.close();
                        }
                    } catch (NumberFormatException e) {
                        message = "입금액은 숫자 형식이어야 합니다.";
                    } catch (Exception e) {
                        message = "오류가 발생했습니다: " + e.getMessage();
                    }
                }
            }
        %>
        <form action="deposit.jsp" method="post">
            <input type="text" name="account_id" placeholder="계좌 번호" required /><br/>
            <input type="number" name="deposit_amount" placeholder="입금액" step="0.01" required /><br/>
            <button type="submit">입금하기</button>
        </form>
        <div><%= message %></div>
        <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
    </div>
</body>
</html>