<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import = "java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>배려콘 관리자 페이지</title>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layout/board.css">
</head>
<body>
	<jsp:include page="layout/top.jsp" flush="false"/>
	<div class="nav-wrapper">
		<div class="nav pagewidth">
			<ul>	
				<!-- MENU -->
				<li><a href="index.jsp">Home</a></li>
				<li><a href="certMng.jsp">임산부 인증처리</a></li>
				<li class="selected"><a href="usedInfo.jsp">사용이력조회</a></li>			
				<!-- END MENU -->
			</ul>
		</div>
	</div>                          


<div class="pagewidth">
	<div class="page-wrap">
		<div class="content">
		
		<%	Class.forName("com.mysql.jdbc.Driver"); 
				String DB_URL = "jdbc:mysql://localhost:3306/swpj?useUnicode=true&characterEncoding=utf8";
				String DB_USER = "swpjid"; 				
				String DB_PASSWORD= "swpjpass";
			
				Connection conn= null;				
				Statement stmt = null;				
				ResultSet rs   = null;		
				int i = 1;
				
				try {			
				    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);		
				    stmt = conn.createStatement();				
				    String query = "SELECT a.userName, a.userId, c.bTrainNo, c.beaconNum, b.seatInTime, b.seatOutTime FROM member a INNER JOIN usedInfo b INNER JOIN seat c ON a.userId = b.member_userId and b.seat_beaconNum = c.beaconNum ORDER BY b.seatInTime ASC;"; 
				    rs = stmt.executeQuery(query);
	
				%><table border="1" cellspacing="0">
				
				<tr>								
					<td>순번</td>		
					<td>성명</td>							
					<td>이메일주소</td>		
					<td>열차번호</td>						
					<td>비콘번호</td>					
					<td>착석시간</td>				
					<td>퇴석시간</td>					
							
				</tr>
				
				<%				
				    while(rs.next()) {
				    	
				
				%><tr>		
					<!-- 순번 -->					
					<td><%=i%></td>		
					<!-- 이메일 -->
					<td><%= rs.getString(1)%></td>
					<!-- 전화번호 -->
					<td><%= rs.getString(2)%></td>
					
					<!-- 확인서업로드여부 -->
					<td><%=rs.getString(3)%></td>			    		
			    		
					<!-- 승인여부 -->					
					<td><%= rs.getString(4)%></td>
						
					<!-- 인증파일 -->
					<td><%= rs.getString(5)%></td>
						
						
					<!-- 인증종료날짜 -->
					<td><%=rs.getString(6)%></td>

				</tr>
				
				<%	i++;			
				    } // end while				
				%></table>
								
				<%
					rs.close();     
				    stmt.close();  
				    conn.close(); 	
				} catch (SQLException e) {
				      out.println("err:"+e.toString());
				} 
				
				%>
		
		
		
		
		
		
		
		
		
		
		
		</div>
	<div class="sidebar">	
			
			<!-- SIDEBAR -->	
			
			
			<!-- SIDEBAR -->
	
		</div>
	
		<div class="clear"></div>		
	</div>
	</div>
	<jsp:include page="layout/bottom.jsp" flush="false"/>
</body>
</html>