<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*"%>

    
<html>
<head>
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
				<li class="selected"><a href="certMng.jsp">임산부 인증처리</a></li>
				<li><a href="usedInfo.jsp">사용이력조회</a></li>			
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
				
				try {			
				    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);		
				    stmt = conn.createStatement();				
				    String query = "SELECT userId, userName, userPhone, certAprvTF, certPath, certPeriod, certUploadTF FROM member"; 
				    rs = stmt.executeQuery(query);
	
				%><table border="1" cellspacing="0">
				
				<tr>								
					<td>성명</td>		
					<td>이메일</td>							
					<td>전화번호</td>		
					<td>확인서제출여부</td>						
					<td>승인여부</td>					
					<td>인증파일</td>				
					<td>인증기간</td>					
							
				</tr>
				
				<%				
				    while(rs.next()) {
				    	
				
				%><tr>		
					<!-- 성명 -->
					<td><%=rs.getString(2)%></td>		
					<!-- 이메일 -->
					<td><%= rs.getString(1) %></td>
					<!-- 전화번호 -->
					<td><%= rs.getString(3)%></td>
					
					<!-- 확인서업로드여부 -->
					<td><% 
						boolean uploaded = rs.getBoolean(7);
						String userId = "";
						String result = "";
			    		if (uploaded== true){
			    			userId = rs.getString(1); 
			    			result = "제출";
			    			%>
			    			<a href="javascript:void(window.open('aprvPopup.jsp?userId=<%=userId %>','_blank','width=450,height=300'))">
			    			<%=result%>
			    		<%
			    		} else{			    
			    			
			    			result = "미제출";
			    			%>
			    			
			    			<%=result %></a>
			    		<% } %>	</td>
			    		
					<!-- 승인여부 -->					
					<td><%
						boolean aprv = rs.getBoolean(4);
						String result2 = "";
						if (aprv == true){
							result2 = "승인";
						}else{
							result2 = "미승인";
						}	%> 
						<%=result2%></td>
						
					<!-- 인증파일 -->
					<td><%				
						String path =  rs.getString(5);
						if(path!=null){
							path = rs.getString(5).substring(1); %>
							<a href="javascript:void(window.open('<%=path%>','_blank','width=700,height=900'))">
							<%=rs.getString(5)%> </a>
						<%	}else{	%> 
						<%=rs.getString(5)%>					
						<%}  %>
						</td>
						
						
					<!-- 인증종료날짜 -->
					<td><%=rs.getString(6)%></td>

				</tr>
				
				<%				
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



