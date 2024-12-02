<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 조회</title>
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
        input[type="text"] {
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
        .result {
            text-align: left;
            margin-top: 20px;
        }
        .result p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>사용자 정보 조회</h1>
        <form method="post">
            <label for="accountNumber">계좌 번호 입력:</label><br>
            <input type="text" id="accountNumber" name="accountNumber" required><br>
            <button type="submit">조회</button>
        </form>
        <% 
            // 데이터베이스 연결 정보
            String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Oracle DB 연결 정보
            String user = "hr"; // Oracle 사용자 이름
            String password = "hr"; // Oracle 비밀번호
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                // JDBC 드라이버 로드
                Class.forName("oracle.jdbc.driver.OracleDriver");
                // 데이터베이스 연결
                con = DriverManager.getConnection(url, user, password);
                
                if(request.getMethod().equalsIgnoreCase("POST")) {
                    String accountNumber = request.getParameter("accountNumber");
                    // SQL 쿼리 준비
                    String query = "SELECT a.ACCOUNT_ID, u.NAME, a.BALANCE, a.ACCOUNT_TYPE " +
                                   "FROM ACCOUNTS a " +
                                   "JOIN USERS u ON a.USER_ID = u.USER_ID " +
                                   "WHERE a.ACCOUNT_ID = ?";
                    pstmt = con.prepareStatement(query);
                    pstmt.setString(1, accountNumber);
                    rs = pstmt.executeQuery();
                    
                    if(rs.next()) {
                        String accountId = rs.getString("ACCOUNT_ID");
                        String name = rs.getString("NAME");
                        double balance = rs.getDouble("BALANCE");
                        String accountType = rs.getString("ACCOUNT_TYPE");
        %>
                        <div class="result">
                            <h2>계좌 정보</h2>
                            <p>계좌 ID: <%= accountId %></p>
                            <p>이름: <%= name %></p>
                            <p>잔액: <%= balance %>원</p>
                            <p>계좌 유형: <%= accountType %></p>
                        </div>
        <% 
                    } else {
        %>
                        <p>해당 계좌를 찾을 수 없습니다.</p>
        <% 
                    }
                }
            } catch (Exception e) {
                out.println("<p>오류가 발생했습니다: " + e.getMessage() + "</p>");
                e.printStackTrace(); // 콘솔에 오류 로그 출력
            } finally {
                // 리소스 닫기
                if(rs != null) try { rs.close(); } catch(SQLException e) {}
                if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
                if(con != null) try { con.close(); } catch(SQLException e) {}
            }
        %>
        <p><a href="main.jsp">메인 화면으로 돌아가기</a></p>
    </div>
</body>
</html>
