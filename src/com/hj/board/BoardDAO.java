package com.hj.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;



public class BoardDAO {
	
	Connection con = null;
	String sql = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private Connection getCon() throws Exception{
		Context initCTX = new InitialContext();
		DataSource ds = (DataSource)initCTX.lookup("java:comp/env/jdbc/mysqldb");
		con = ds.getConnection();
		return con;
	}
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
	
	// insertBoard(bto)
	public void insertBoard(BoardDTO bto) {

		int bno = 0; // 글번호 저장

		try {
			con = getCon();
			System.out.println("디비연결완료");

			// 글번호 계산
			// 3. sql 생성 & pstmt 객체
			sql = "select max(bno) from hj_board";
			pstmt = con.prepareStatement(sql);

			// 4. sql 구문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if (rs.next()) {
				// 기존의 글번호(저장된최대값) + 1
				bno = rs.getInt(1) + 1;
				// getInt(인덱스) -> 컬럼의 값을 리턴, 만약에 SQL null이면 0리턴
			}
				
			System.out.println(" 글 번호 : " + bno);
				
			// 전달받은 글정보를 DB insert				
			// 3. sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into hj_board(bno,name,pass,title,content,readcount,"
						+ "re_ref,re_lev,re_seq,date,ip,file) "
						+ "values(?,?,?,?,?,?,?,?,?,now(),?,?)";
				
			pstmt = con.prepareStatement(sql);
				
			// ?
			pstmt.setInt(1, bno);
			pstmt.setString(2, bto.getName());
			pstmt.setString(3, bto.getPass());
			pstmt.setString(4, bto.getTitle());
			pstmt.setString(5, bto.getContent());
			pstmt.setInt(6, 0);// 조회수 0으로 초기화
			pstmt.setInt(7, bno);  // re_ref 그룹번호
			pstmt.setInt(8, 0);   //re_lev 레벨값
			pstmt.setInt(9, 0);   // re_seq 순서
			pstmt.setString(10, bto.getIp());
			pstmt.setString(11, bto.getFile());
				
			// 4. sql 실행
			pstmt.executeUpdate();
				
			System.out.println(" DAO : 글작성 완료! ");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

	}
	// insertBoard(bto)
		
	// getBoardCount()
	public int getBoardCount(){
		int cnt = 0;
			
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성(select) & pstmt 객체
			sql = "select count(*) from hj_board";
			pstmt = con.prepareStatement(sql);
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터 처리
			if(rs.next()){
				//데이터 있을때 (글개수)
				cnt = rs.getInt(1);	
			}
				
			System.out.println(" DAO : 글개수 ("+cnt+")");
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
			
		return cnt;
	}
	// getBoardCount()
		
		
	// getBoardList()
	public List getBoardList(){
		List boardList = new ArrayList();
			
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성 & pstmt 객체 생성
			sql = "select * from hj_board";
			pstmt = con.prepareStatement(sql);
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
			while(rs.next()){
				//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
				BoardDTO bto = new BoardDTO();
					
				bto.setContent(rs.getString("content"));
				bto.setDate(rs.getDate("date"));
				bto.setFile(rs.getString("file"));
				bto.setIp(rs.getString("ip"));
				bto.setName(rs.getString("name"));
				bto.setBno(rs.getInt("bno"));
				bto.setPass(rs.getString("pass"));
				bto.setRe_lev(rs.getInt("re_lev"));
				bto.setRe_ref(rs.getInt("re_ref"));
				bto.setRe_seq(rs.getInt("re_seq"));
				bto.setReadcount(rs.getInt("readcount"));
				bto.setTitle(rs.getString("title"));
					
				// DTO 객체를 ArrayList 한칸에 저장
				boardList.add(bto);				
					
			}//while
				
			System.out.println(" DAO : 글 정보 저장완료! "+boardList.size());
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
			
		return boardList;
	}
	// getBoardList()
		
		
	// getBoardList(startRow,pageSize)
	public List getBoardList(int startRow,int pageSize){
		List boardList = new ArrayList();
			
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성 & pstmt 객체 생성
			// 글 re_ref 최신글 위쪽(내림차순), re_seq (오름차순)
			// DB데이터를 원하는만큼씩 짤라내기 : limit 시작행-1,페이지크기 
			sql = "select * from hj_board order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
				
			//?
			pstmt.setInt(1, startRow-1); // 시작행-1  (시작 ROW인덱스 번호)
			pstmt.setInt(2, pageSize); // 페이지크기  (한번에 출력되는 수)
				
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
			while(rs.next()){
				//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
				BoardDTO bto = new BoardDTO();
					
				bto.setContent(rs.getString("content"));
				bto.setDate(rs.getDate("date"));
				bto.setFile(rs.getString("file"));
				bto.setIp(rs.getString("ip"));
				bto.setName(rs.getString("name"));
				bto.setBno(rs.getInt("bno"));
				bto.setPass(rs.getString("pass"));
				bto.setRe_lev(rs.getInt("re_lev"));
				bto.setRe_ref(rs.getInt("re_ref"));
				bto.setRe_seq(rs.getInt("re_seq"));
				bto.setReadcount(rs.getInt("readcount"));
				bto.setTitle(rs.getString("title"));
					
				// DTO 객체를 ArrayList 한칸에 저장
				boardList.add(bto);				
				
			}//while
				
			System.out.println(" DAO : 글 정보 저장완료! "+boardList.size());
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
			
		return boardList;
	}
	// getBoardList(startRow,pageSize)
		
	// updateReadcount(bno)
	public void updateReadcount(int bno){
		try {
				
			con = getCon();
			sql = "update hj_board set readcount = readcount+1 where bno=?";
			pstmt = con.prepareStatement(sql);
				
			//?
			pstmt.setInt(1, bno);

			pstmt.executeUpdate();
				
			System.out.println("DAO : 조회수 1증가");
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
			
	}
	// updateReadcount(bno)
		
	// getBoard(bno)
	public BoardDTO getBoard(int bno){
		BoardDTO bto = null;
			
		try {
				
			con = getCon();
			sql = "select * from hj_board where bno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
				
			rs = pstmt.executeQuery();
				
			// 5. 데이터처리
			if(rs.next()){
				bto = new BoardDTO();
					
				bto.setContent(rs.getString("content"));
				bto.setDate(rs.getDate("date"));
				bto.setFile(rs.getString("file"));
				bto.setIp(rs.getString("ip"));
				bto.setName(rs.getString("name"));
				bto.setBno(rs.getInt("bno"));
				bto.setPass(rs.getString("pass"));
				bto.setRe_lev(rs.getInt("re_lev"));
				bto.setRe_ref(rs.getInt("re_ref"));
				bto.setRe_seq(rs.getInt("re_seq"));
				bto.setReadcount(rs.getInt("readcount"));
				bto.setTitle(rs.getString("title"));
					
			}//if
				
			System.out.println(" DAO : 글정보 저장완료!");			
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
			
			return bto;
	}
	// getBoard(bno)
		
		
	// updateBoard(bto)
	public int updateBoard(BoardDTO bto){
		int result = -1;
			
		try {
			//1.2. 디비연결
			con = getCon();
			//3. sql 구문 & pstmt 객체
			sql = "select pass from hj_board where bno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bto.getBno());
				
			// 4. sql 실행
			rs = pstmt.executeQuery();
				
			if(rs.next()){
				if(bto.getPass().equals(rs.getString("pass"))){

					sql = "update hj_board set name=?,title=?,content=? "
								+ "where bno=?";
					pstmt = con.prepareStatement(sql);
						
					pstmt.setString(1, bto.getName());
					pstmt.setString(2, bto.getTitle());
					pstmt.setString(3, bto.getContent());
					pstmt.setInt(4, bto.getBno());
						
					// 4. sql 실행
					pstmt.executeUpdate();
					result = 1;
						
				}else{
					result = 0;
				}				
			}else {
				result = -1;
			}
				
			System.out.println(" DAO : 글 수정완료 "+result);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return result;
	}
	// updateBoard(bto)
		
	// deleteBoard(bno,pass)
	public int deleteBoard(int bno,String pass){
		int result = -1;
			
		try {
			// 1.2. 디비연결
			con = getCon();
			// 3. sql 작성 & pstmt 객체 생성
			sql = "select pass from hj_board where bno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
				
			// 4. sql 실행
			rs = pstmt.executeQuery();
				
			// 5. 데이터 처리
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					// 3. sql
					sql ="delete from hj_board where re_ref=?";
					pstmt = con.prepareStatement(sql);
						
					pstmt.setInt(1, bno);
					// 4. sql 실행
					pstmt.executeUpdate();
					result = 1;
				}else{
					result = 0;
				}
			}else{
				result = -1;
			}
				
			System.out.println(" DAO : 게시판 글 삭제 완료! "+result);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
			
		return result;
	}
	// deleteBoard(bno,pass) 끝
		
	
	// replyBoard(bto)
	public void replyBoard(BoardDTO bto) {
		int bno = 0;
			
			
		try {
			// 답글번호 계산(num)
			// 1.2 DB 연결
			con = getCon();
			// 3. sql 작성 & pstmt 객체
			sql = "select max(bno) from hj_board";
			pstmt = con.prepareStatement(sql);
				
			// 4. sql 실행
			rs = pstmt.executeQuery();
				
			// 5. 데이터처리
			if(rs.next()) {
				bno = rs.getInt(1)+1;
			}
			System.out.println("DAO : 답글 번호(bno): "+bno);
				
			// 답글순서 재배치 (re_ref 동일 그룹에서 re_seq기존의 값보다 큰값이 있을 때 re_seq를 1증가)
				
			// 3. sql 작성 & pstmt 
			sql = "update hj_board set re_seq = re_seq + 1 "
							+ "where re_ref=? and re_seq>?";
					
			pstmt = con.prepareStatement(sql);
					
			pstmt.setInt(1, bto.getRe_ref()); // 부모글의 ref
			pstmt.setInt(2, bto.getRe_seq()); // 부모글의 seq
					
			// 4. sql 실행
			pstmt.executeUpdate();			
			// 답글순서 재배치 (re_ref 동일 그룹에서 re_seq기존의 값보다 큰값이 있을 때 re_seq를 1증가)
					
			// 답글 쓰기(insert)
			// 3. sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into hj_board(bno,name,pass,title,content,readcount,"
						+ "re_ref,re_lev,re_seq,date,ip,file) " + "values(?,?,?,?,?,?,?,?,?,now(),?,?)";

			pstmt = con.prepareStatement(sql);

			// ?
			pstmt.setInt(1, bno);
			pstmt.setString(2, bto.getName());
			pstmt.setString(3, bto.getPass());
			pstmt.setString(4, bto.getTitle());
			pstmt.setString(5, bto.getContent());
			pstmt.setInt(6, 0);// 조회수 0으로 초기화
			pstmt.setInt(7, bto.getRe_ref()); // re_ref 그룹번호 = 부모글의 그룹번호
			pstmt.setInt(8, bto.getRe_lev()+1); // re_lev 레벨값 => 부모글 lev + 1
			pstmt.setInt(9, bto.getRe_seq()+1); // re_seq 순서 => 부모글 seq + 1
			pstmt.setString(10, bto.getIp());
			pstmt.setString(11, bto.getFile());

			// 4. sql 실행
			pstmt.executeUpdate();
				
			System.out.println("DAO 글 작성완료");
					
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
			
	}
	// replyBoard(bto) 끝
		
		
	// redeleteBoard(bno,re_seq,pass)
	public int redeleteBoard(int bno,int re_seq,String pass){
		int result = -1;
			
		try {
			// 1.2. 디비연결
			con = getCon();
			// 3. sql 작성 & pstmt 객체 생성
			sql = "select pass from hj_board where bno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
				
			// 4. sql 실행
			rs = pstmt.executeQuery();
				
			// 5. 데이터 처리
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					// 3. sql
					sql ="delete from hj_board where bno=? and re_seq=?";
					pstmt = con.prepareStatement(sql);
						
					pstmt.setInt(1, bno);
					pstmt.setInt(2, re_seq);
					// 4. sql 실행
					pstmt.executeUpdate();
					result = 1;
				}else{
					result = 0;
				}
			}else{
				result = -1;
			}
				
			System.out.println(" DAO : 답글 삭제 완료! "+result);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
			
		return result;
	}
	// redeleteBoard(bno,re_seq,pass) 끝
	
	

}
