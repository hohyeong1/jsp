<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.util.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 처리</title>
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
            String userId = request.getParameter("userId");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            Connection conn = null;
            PreparedStatement pstmt = null;
            String query = "INSERT INTO USERS (USER_ID, PASSWORD, NAME, EMAIL, PHONE) VALUES (?, ?, ?, ?, ?)";
            try {
                conn = DBConnection.getConnection();
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, userId);
                pstmt.setString(2, password);
                pstmt.setString(3, name);
                pstmt.setString(4, email);
                pstmt.setString(5, phone);
                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    out.println("<p>회원가입이 성공적으로 완료되었습니다.</p>");
                    response.sendRedirect("login.jsp");
                } else {
                    out.println("<p>회원가입에 실패했습니다.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>SQL 에러: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</body>
</html>