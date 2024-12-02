<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>출금</title>
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
            background-color: #f44336;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        form button:hover {
            background-color: #da190b;
        }
        .message {
            margin-top: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div>
        <h1>출금</h1>
        <% 
            String message = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String accountId = request.getParameter("account_id");
                String withdrawAmountStr = request.getParameter("withdraw_amount");
                
                if (accountId == null || withdrawAmountStr == null || accountId.isEmpty() || withdrawAmountStr.isEmpty()) {
                    message = "모든 필드를 입력해 주세요.";
                } else {
                    try {
                        double withdrawAmount = Double.parseDouble(withdrawAmountStr);
                        
                        if (withdrawAmount <= 0) {
                            message = "출금액은 양수이어야 합니다.";
                        } else {
                            // 데이터베이스 연결 정보
                            String url = "jdbc:oracle:thin:@localhost:1521:xe";
                            String user = "hr";
                            String password = "hr";
                            
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            Connection conn = DriverManager.getConnection(url, user, password);
                            
                            // 잔액 확인 후 출금
                            String checkSql = "SELECT BALANCE FROM ACCOUNTS WHERE ACCOUNT_ID = ?";
                            PreparedStatement checkPstmt = conn.prepareStatement(checkSql);
                            checkPstmt.setString(1, accountId);
                            ResultSet rs = checkPstmt.executeQuery();
                            
                            if (rs.next()) {
                                double currentBalance = rs.getDouble("BALANCE");
                                if (currentBalance >= withdrawAmount) {
                                    String updateSql = "UPDATE ACCOUNTS SET BALANCE = BALANCE - ? WHERE ACCOUNT_ID = ?";
                                    PreparedStatement updatePstmt = conn.prepareStatement(updateSql);
                                    updatePstmt.setDouble(1, withdrawAmount);
                                    updatePstmt.setString(2, accountId);
                                    
                                    int rows = updatePstmt.executeUpdate();
                                    
                                    if (rows > 0) {
                                        message = "출금이 성공적으로 완료되었습니다.";
                                    } else {
                                        message = "출금에 실패했습니다.";
                                    }
                                    
                                    updatePstmt.close();
                                } else {
                                    message = "잔액이 부족합니다.";
                                }
                            } else {
                                message = "해당 계좌를 찾을 수 없습니다.";
                            }
                            
                            rs.close();
                            checkPstmt.close();
                            conn.close();
                        }
                    } catch (NumberFormatException e) {
                        message = "출금액은 숫자 형식이어야 합니다.";
                    } catch (Exception e) {
                        message = "오류가 발생했습니다: " + e.getMessage();
                    }
                }
            }
        %>
        <form action="withdraw.jsp" method="post">
            <input type="text" name="account_id" placeholder="계좌 번호" required /><br/>
            <input type="number" name="withdraw_amount" placeholder="출금액" step="0.01" required /><br/>
            <button type="submit">출금하기</button>
        </form>
        <div><%= message %></div>
        <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
    </div>
</body>
</html>