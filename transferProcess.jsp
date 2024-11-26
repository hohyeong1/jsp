<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.util.DBConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>송금 결과</title>
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
        p {
            font-size: 18px;
            margin: 10px 0;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background-color: #45A049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>송금 결과</h2>
        <%
            String fromAccountId = request.getParameter("fromAccountId");
            String toAccountId = request.getParameter("toAccountId");
            double amount = Double.parseDouble(request.getParameter("amount"));
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String message = "";
            boolean success = false;

            try {
                conn = DBConnection.getConnection();
                
                // 잔액 확인 쿼리
                String balanceQuery = "SELECT BALANCE FROM ACCOUNTS WHERE ACCOUNT_ID = ?";
                pstmt = conn.prepareStatement(balanceQuery);
                pstmt.setString(1, fromAccountId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    double balance = rs.getDouble("BALANCE");
                    if (balance >= amount) {
                        // 송금 처리 쿼리
                        conn.setAutoCommit(false); // 트랜잭션 시작

                        // 출금
                        String withdrawQuery = "UPDATE ACCOUNTS SET BALANCE = BALANCE - ? WHERE ACCOUNT_ID = ?";
                        pstmt = conn.prepareStatement(withdrawQuery);
                        pstmt.setDouble(1, amount);
                        pstmt.setString(2, fromAccountId);
                        pstmt.executeUpdate();

                        // 입금
                        String depositQuery = "UPDATE ACCOUNTS SET BALANCE = BALANCE + ? WHERE ACCOUNT_ID = ?";
                        pstmt = conn.prepareStatement(depositQuery);
                        pstmt.setDouble(1, amount);
                        pstmt.setString(2, toAccountId);
                        pstmt.executeUpdate();

                        conn.commit(); // 트랜잭션 커밋
                        message = "송금이 성공적으로 완료되었습니다.";
                        success = true;
                    } else {
                        message = "잔액이 부족하여 송금할 수 없습니다.";
                    }
                } else {
                    message = "송금할 계좌가 존재하지 않습니다.";
                }
            } catch (SQLException e) {
                message = "송금 처리 중 오류가 발생했습니다: " + e.getMessage();
                e.printStackTrace();
                if (conn != null) {
                    try {
                        conn.rollback(); // 오류 발생 시 롤백
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
        <p><%= message %></p>
        <a href="accountList.jsp">계좌 목록으로 돌아가기</a>
    </div>
</body>
</html>
