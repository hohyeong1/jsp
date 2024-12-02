<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="kr.ac.kopo.util.DBConnection"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>계좌 목록</title>
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
            width: 600px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        button {
            padding: 5px 10px;
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
        <h2>계좌 목록</h2>
        <table>
            <tr>
                <th>계좌 번호</th>
                <th>사용자 ID</th>
                <th>잔액</th>
                <th>계좌 유형</th>
                <th>송금</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                String query = "SELECT * FROM ACCOUNTS";
                try {
                    conn = DBConnection.getConnection();
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();
                    if (!rs.isBeforeFirst()) {
                        out.println("<tr><td colspan='5'>등록된 계좌가 없습니다.</td></tr>");
                    } else {
                        while (rs.next()) {
                            String accountId = rs.getString("ACCOUNT_ID");
                            String userId = rs.getString("USER_ID");
                            double balance = rs.getDouble("BALANCE");
                            String accountType = rs.getString("ACCOUNT_TYPE");
                            %>
                            <tr>
                                <td><%= accountId %></td>
                                <td><%= userId %></td>
                                <td><%= balance %> 원</td>
                                <td><%= accountType %></td>
                                <td>
                                    <form action="transfer.jsp" method="post" style="display:inline;">
                                        <input type="hidden" name="fromAccountId" value="<%= accountId %>">
                                        <button type="submit">송금</button>
                                    </form>
                                </td>
                            </tr>
                            <%
                        }
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
        </table>
        <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
    </div>
</body>
</html>