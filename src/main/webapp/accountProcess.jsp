<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.util.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>계좌 조회 결과</title>
</head>
<body>
    <h2>계좌 조회 결과</h2>
    <%
        String accountId = request.getParameter("accountId");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String query = "SELECT * FROM ACCOUNTS WHERE ACCOUNT_ID = ?";
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, accountId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                out.println("<p>계좌 번호: " + rs.getString("ACCOUNT_ID") + "</p>");
                out.println("<p>사용자 ID: " + rs.getString("USER_ID") + "</p>");
                out.println("<p>잔액: " + rs.getDouble("BALANCE") + " 원</p>");
                out.println("<p>계좌 유형: " + rs.getString("ACCOUNT_TYPE") + "</p>");
            } else {
                out.println("<p>해당 계좌를 찾을 수 없습니다.</p>");
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
    <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
</body>
</html>