<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import = "java.sql.*"%>

    
<html>
<head>
    <title>����� ������ ������</title>
 	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layout/board.css">
    
   
</head>
<body>
	<jsp:include page="layout/top.jsp" flush="false"/>
	<div class="nav-wrapper">
		<div class="nav pagewidth">
			<ul>	
				<!-- MENU -->
				<li><a href="index.jsp">Home</a></li>
				<li class="selected"><a href="certMng.jsp">�ӻ�� ����ó��</a></li>
				<li><a href="usedInfo.jsp">����̷���ȸ</a></li>			
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
					<td>����</td>		
					<td>�̸���</td>							
					<td>��ȭ��ȣ</td>		
					<td>Ȯ�μ����⿩��</td>						
					<td>���ο���</td>					
					<td>��������</td>				
					<td>�����Ⱓ</td>					
							
				</tr>
				
				<%				
				    while(rs.next()) {
				    	
				
				%><tr>		
					<!-- ���� -->
					<td><%=rs.getString(2)%></td>		
					<!-- �̸��� -->
					<td><%= rs.getString(1) %></td>
					<!-- ��ȭ��ȣ -->
					<td><%= rs.getString(3)%></td>
					
					<!-- Ȯ�μ����ε忩�� -->
					<td><% 
						boolean uploaded = rs.getBoolean(7);
						String userId = "";
						String result = "";
			    		if (uploaded== true){
			    			userId = rs.getString(1); 
			    			result = "����";
			    			%>
			    			<a href="javascript:void(window.open('aprvPopup.jsp?userId=<%=userId %>','_blank','width=450,height=300'))">
			    			<%=result%>
			    		<%
			    		} else{			    
			    			
			    			result = "������";
			    			%>
			    			
			    			<%=result %></a>
			    		<% } %>	</td>
			    		
					<!-- ���ο��� -->					
					<td><%
						boolean aprv = rs.getBoolean(4);
						String result2 = "";
						if (aprv == true){
							result2 = "����";
						}else{
							result2 = "�̽���";
						}	%> 
						<%=result2%></td>
						
					<!-- �������� -->
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
						
						
					<!-- �������ᳯ¥ -->
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



