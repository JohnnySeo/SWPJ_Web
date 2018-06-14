package javamysql;

import java.sql.Connection;
import org.json.simple.*;
import java.net.URLEncoder;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectDB {
	// 싱글톤 패턴으로 사용 하기위 한 코드들
	private static ConnectDB instance = new ConnectDB();

	public static ConnectDB getInstance() {
		return instance;
	}

	public ConnectDB() {
		

	}

	private String jdbcUrl = "jdbc:mysql://localhost:3306/swpj"; 
	private String dbId = "swpjid"; 
	private String dbPw = "swpjpass"; 
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt2 = null;
	private ResultSet rs = null;
	private String sql = "";
	private String sql2 = "";
	private String sql2_1 = "";
	
	String returns = "";
	String returns2 = "";
	String returns3 = "";
	
	JSONArray arr = new JSONArray();
	JSONArray arr2 = new JSONArray();
	JSONArray arr3 = new JSONArray();
	
	

	// 데이터베이스와 통신
	public String joindb(String userId, String userName, String userPwd, String userPhone) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "select userId from member where userId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("userId").equals(userId)) { // 이미 아이디가 있는 경우
					returns = "id";
				} 
			} else { // 입력한 아이디가 없는 경우
				sql2 = "insert into member values(?,?,?,?,null,null,null,null)";
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, userId);
				pstmt2.setString(2, userName);
				pstmt2.setString(3, userPwd);
				pstmt2.setString(4, userPhone);
				pstmt2.executeUpdate();

				returns = "ok";
				System.out.println("가입완료 : " + sql2 + " " + userId + userName + userPwd + userPhone);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
			if (pstmt2 != null)try {pstmt2.close();} catch (SQLException ex) {}
			if (rs != null)try {rs.close();} catch (SQLException ex) {}
		}
		return returns;
	}

	public String logindb(String userId, String userPwd) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "select userId,userPwd from member where userId=? and userPwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				//로그인 가능
				if (rs.getString("userId").equals(userId) && rs.getString("userPwd").equals(userPwd)) {
					returns2 = "true";  // 로그인 성공
				} else {
					returns2 = "false"; // 로그인 실패
				}
			} else {
				returns2 = "noId"; // 아이디 또는 비밀번호 존재 X
			}

		} catch (Exception e) {

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}
		return returns2;
	}
	
	
	public String seatInChngdb(String beaconNum) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "UPDATE seat SET seatInfo=0 WHERE beaconNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, beaconNum);
			pstmt.executeUpdate();
			returns2 = "seat in update ok";		
			System.out.println(returns2);

		} catch (Exception e) {

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}
		return returns2;
	}
	
	
	public String seatOutChngdb(String beaconNum) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "UPDATE seat SET seatInfo=1 WHERE beaconNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, beaconNum);			
			pstmt.executeUpdate();
			returns2 = "seat out update ok";	
			System.out.println(returns2);

		} catch (Exception e) {
			

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}
		return returns2;
	}
	
	public String seatInTimedb(String userId, String beaconNum) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "insert into usedInfo(seat_beaconNum, member_userId, seatInTime, seatOutTime, seatInComplete) values (?,?,now(),null, 0);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(2, userId);			
			pstmt.setString(1, beaconNum);		
			pstmt.executeUpdate();
			returns2 = "seat in time insert ok";	
			System.out.println(returns2);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}
		return returns2;
	}
	public String seatOutTimedb(String userId) {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "UPDATE usedInfo SET seatOutTime=now(), seatInComplete=1 WHERE member_userId=? and seatInComplete=0;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);		
			pstmt.executeUpdate();
			
			returns2 = "seat out time update ok";	
			System.out.println(returns2);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}
		return returns2;
	}
	

	
	public JSONArray getUserInfodb(String userId) {				
	    try {  	    	
	    	Class.forName("com.mysql.jdbc.Driver");
	    	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "select userId, userName, userPhone, certAprvTF, certPeriod, certUploadTF from member where userId=?";			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
	        
	         
	        while(rs.next())
	        {
	            userId =rs.getString("userId");
	            String userName = rs.getString("userName");
	            String userPhone = rs.getString("userPhone");
	            Boolean certAprvTF = rs.getBoolean("certAprvTF");
	            Boolean certUploadTF = rs.getBoolean("certUploadTF");
	           
	            JSONObject obj = new JSONObject();
	            obj.put("userId", userId);
	            obj.put("userName", userName);
	            obj.put("userPhone", userPhone);
	            obj.put("certAprvTF", certAprvTF);
	            obj.put("certUploadTF", certUploadTF);
	            
	            if(obj != null)
	                arr.add(obj);
	        }
	        
	    } catch (Exception e) {

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}		
	    return arr;
	}
	
	public JSONArray getSeatInfodb(String bTrainNo) {	
	    try {  	    	
	    	Class.forName("com.mysql.jdbc.Driver");
	    	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			sql = "SELECT beaconNum, seatInfo, bTrainNo FROM seat WHERE bTrainNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bTrainNo);
			rs = pstmt.executeQuery();		
	        
	         
	        while(rs.next())
	        {
	        	bTrainNo =rs.getString("bTrainNo");
	            String beaconNum = rs.getString("beaconNum");
	            Boolean seatInfo = rs.getBoolean("seatInfo");
	            
	            JSONObject obj2 = new JSONObject();	   
	            obj2.clear();
	            obj2.put("beaconNum", beaconNum);
	            obj2.put("seatInfo", seatInfo);	            
	            if(arr2.size()<8) {
	            	if(obj2 != null) 	            
	            		arr2.add(obj2);	            	
	            } else {
	            		
	            }
	        }
	       
	   
	        
	    } catch (Exception e) {
	    	e.printStackTrace();

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}		
	    return arr2;
	}
	
	public JSONArray getBeaconCheckdb(String beaconNum) {	
	    try {  	    	
	    	Class.forName("com.mysql.jdbc.Driver");
	    	conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);	    	
			sql = "SELECT beaconNum, seatInfo FROM seat WHERE beaconNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, beaconNum);
			rs = pstmt.executeQuery();		
	        
	         
	        while(rs.next())
	        {
	        	beaconNum =rs.getString("beaconNum");	            
	            Boolean seatInfo = rs.getBoolean("seatInfo");
	            
	            JSONObject obj3 = new JSONObject();	            
	            obj3.put("beaconNum", beaconNum);
	            obj3.put("seatInfo", seatInfo);	
	            if(obj3 != null)
            		arr3.add(obj3);	            		            
	        }      
	       
	        
	    } catch (Exception e) {
	    	e.printStackTrace();

		} finally {if (rs != null)try {rs.close();} catch (SQLException ex) {}
			if (pstmt != null)try {pstmt.close();} catch (SQLException ex) {}
			if (conn != null)try {conn.close();} catch (SQLException ex) {}
		}		
	    return arr3;
	}
	
	
	
	
	
	
	
}
