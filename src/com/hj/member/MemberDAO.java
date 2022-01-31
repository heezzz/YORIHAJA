package com.hj.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	 
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	// 공통으로 사용하는 디비연결동작
	private Connection getCon() throws Exception {
			
		Context initCTX = new InitialContext();
	
		DataSource ds = (DataSource) initCTX.lookup("java:comp/env/jdbc/mysqldb");
	
		// 연결정보를 사용해서 디비 연결
		con = ds.getConnection();
	
		return con;
	}

	// 디비 자원해제 동작
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 회원가입 메서드
	public void insertMember(MemberDTO mto) {

		try {
			// 1. 드라이버 로드
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("드라이버 로드 성공!");

			// 2. 디비 연결
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspdb", "root", "1234");
			System.out.println(" 디비 연결 성공! ");

			// 3. sql 작성 & pstmt 생성
			sql = "insert into hj_member(id,pass,name,email,address,phone,reg_date) values(?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);

			// ??
			pstmt.setString(1, mto.getId());
			pstmt.setString(2, mto.getPass());
			pstmt.setString(3, mto.getName());
			pstmt.setString(4, mto.getEmail());
			pstmt.setString(5, mto.getAddress());
			pstmt.setString(6, mto.getPhone());

			// 4. sql 실행
			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			System.out.println(" 드라이버 로드 실패! ");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println(" 디비연결 실패/SQL구문 오류 ");
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}// insertMember(MemberDTO mto) 끝
	
	
	// loginCheck(id,pass)
	public int loginCheck(String id, String pass){
		int result = -1;
		try {
			con = getCon();
			
			// 3. sql 작성 & pstmt 객체 생성
			sql = "select pass from hj_member where id=?";
			pstmt = con.prepareStatement(sql);
			
			// ?
			pstmt.setString(1, id);
			
			// 4. sql 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 회원정보 있음
				if(pass.equals(rs.getString("pass"))){
					//비밀번호 동일
					result = 1;
				}else{
					//비밀번호 다름
					result = 0;
				}				
			}else{
				// 회원정보 없음
				result = -1;
			}
		
			System.out.println(" 실행결과 : "+result);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return result;		
	}
	// loginCheck(id,pass) 끝
	
	
	// getMember(id)
	public MemberDTO getMember(String id){
		
		MemberDTO mto = null;
		
		try {
			// 1.2. 디비연결
			con = getCon();
			// sql- 전달받은 아이디에 해당하는 회원정보 모두가져오기
			sql = "select * from hj_member where id=?";
			pstmt = con.prepareStatement(sql);
			
			// ?
			pstmt.setString(1, id);
			
			// 4. sql 실행
			rs = pstmt.executeQuery();
			// 5. 데이터처리
			if(rs.next()){
				// 데이터가 있음 -> 회원정보를 저장
				mto = new MemberDTO();
				
				mto.setId(rs.getString("id"));
				mto.setPass(rs.getString("pass"));
				mto.setName(rs.getString("name"));
				mto.setEmail(rs.getString("email"));
				mto.setAddress(rs.getString("address"));
				mto.setPhone(rs.getString("phone"));
				mto.setReg_date(rs.getDate("reg_date"));				
			}
			System.out.println(" 회원정보 : "+mto);		
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return mto;
	}
	// getMember(id) 끝
	
	
	// updateMember(mto)
	public int updateMember(MemberDTO mto) {
		int result = -1;
		
		try {
		// 1.2. 디비연결
		con = getCon();
		// 3. sql 작성(select) & pstmt 객체 생성
		sql = "select pass from hj_member where id=?";
		pstmt = con.prepareStatement(sql);
		// ?
		pstmt.setString(1, mto.getId());
		// 4. sql 실행
		rs = pstmt.executeQuery();
		
		// 5. 데이터 처리
		if(rs.next()) { //데이터 있을때
			
			if(mto.getPass().equals(rs.getString("pass"))) {
				// 3. sql 작성(update) & pstmt 객체 생성
				sql = "update hj_member set name=?, email=?, address=?, phone=? where id=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, mto.getName());
				pstmt.setString(2, mto.getEmail());
				pstmt.setString(3, mto.getAddress());
				pstmt.setString(4, mto.getPhone());
				pstmt.setString(5, mto.getId());
				
				
				// 4. sql 실행
				pstmt.executeUpdate();				
				result = 1;
				
			}else {
				// 아이디는 맞는데 비밀번호가 잘못됨
				result = 0;
			}				
			
		}else {
			//데이터 없을때
			result = -1;
		}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return result;
	}
	
	// updateMember(mto) 끝
	
	
	// deleteMember(id, pass)
	public int deleteMember(String id, String pass) {
		int result = -1;
		
		try {
			// 1.2. 디비연결
			con = getCon();
			// 3. sql 작성(select) & pstmt 객체 생성
			sql = "select pass from hj_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4. sql 실행
			rs = pstmt.executeQuery();
			
			// 5. 데이터 처리
			if(rs.next()) { //데이터 있을때
				
				if(pass.equals(rs.getString("pass"))) { // 본인
					// 3. sql 생성 & pstmt 객체 생성
					sql = "delete from hj_member where id=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, id);						
					// 4. sql 실행 
					result = pstmt.executeUpdate();
					System.out.println("회원삭제 완료");
					
				}else {
					// 아이디는 맞는데 비밀번호가 잘못됨
					result = 0;
				}				
				
			}else {
				//데이터 없을때
				result = -1;
			}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				closeDB();
			}
		
		return result;
	}	
	
	// deleteMember(id, pass) 끝
	
	//아이디중복체크 메서드
	public int joinIdCheck(String id){
		int result = -1;
		try {
			//1. DB연결
			con = getCon();
			//2. sql 구문 & pstmt생성
			sql = "select id from hj_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			//3. 실행 -> select -> rs저장
			rs = pstmt.executeQuery();

			//4. 데이터처리

			if(rs.next()){	
				result = 0;
			}else{
				result = 1;
			}

			System.out.println("아이디 중복체크결과 : "+result);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return result;
	}//joinIdCheck 메서드닫음
	
	

}
