<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.util.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>계좌 개설 처리</title>
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
        a {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: #4CAF50;
        }
        a:hover {
            color: #45A049;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");

            String accountId = request.getParameter("accountId");
            String userId = request.getParameter("userId");
            double initialBalance = Double.parseDouble(request.getParameter("initialBalance"));
            String accountType = request.getParameter("accountType");
            Connection conn = null;
            PreparedStatement pstmt = null;
            String query = "INSERT INTO ACCOUNTS (ACCOUNT_ID, USER_ID, BALANCE, ACCOUNT_TYPE) VALUES (?, ?, ?, ?)";
            try {
                conn = DBConnection.getConnection();
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, accountId);
                pstmt.setString(2, userId);
                pstmt.setDouble(3, initialBalance);
                pstmt.setString(4, accountType);
                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    out.println("<p>계좌가 성공적으로 개설되었습니다.</p>");
                } else {
                    out.println("<p>계좌 개설에 실패했습니다.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>SQL 에러: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
        <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
    </div>
</body>
</html>
