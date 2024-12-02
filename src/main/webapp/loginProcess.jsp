<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.util.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 처리</title>
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
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String query = "SELECT * FROM USERS WHERE USER_ID = ? AND PASSWORD = ?";
            try {
                conn = DBConnection.getConnection();
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, userId);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    session.setAttribute("userId", userId); // 세션에 사용자 ID 저장
                    response.sendRedirect("main.jsp");
                } else {
                    out.println("<p>아이디 또는 비밀번호가 잘못되었습니다.</p>");
                    out.println("<a href='login.jsp'>로그인 페이지로 돌아가기</a>");
                }
            } catch (SQLException e) {
                out.println("<p>SQL 에러: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</body>
</html>