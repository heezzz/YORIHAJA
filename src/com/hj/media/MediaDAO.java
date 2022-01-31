package com.hj.media;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MediaDAO {
	
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
	
	// insertMedia(mdto)
		public void insertMedia(MediaDTO mdto) {

			int bno = 0; // 글번호 저장

			try {
				con = getCon();
				System.out.println("디비연결완료");

				// 글번호 계산
				// 3. sql 생성 & pstmt 객체
				sql = "select max(bno) from hj_media";
				pstmt = con.prepareStatement(sql);

				// 4. sql 구문 실행
				rs = pstmt.executeQuery();
				// 5. 데이터 처리
				if (rs.next()) {
					// 기존의 글번호(저장된최대값) + 1
					bno = rs.getInt(1) + 1;
				}
				
				System.out.println(" 글 번호 : " + bno);
				///////////////////////////////////////////////////////////////////////
				// 전달받은 글정보를 DB insert 
				
				// 3. sql 작성 (insert) & pstmt 객체 생성
				sql = "insert into hj_media(bno,name,pass,title,content,readcount,"
						+ "date,ip,file) "
						+ "values(?,?,?,?,?,?,now(),?,?)";
				
				pstmt = con.prepareStatement(sql);
				
				// ?
				pstmt.setInt(1, bno);
				pstmt.setString(2, mdto.getName());
				pstmt.setString(3, mdto.getPass());
				pstmt.setString(4, mdto.getTitle());
				pstmt.setString(5, mdto.getContent());
				pstmt.setInt(6, 0);// 조회수 0으로 초기화
				pstmt.setString(7, mdto.getIp());
				pstmt.setString(8, mdto.getFile());
				
				// 4. sql 실행
				pstmt.executeUpdate();
				
				System.out.println(" DAO : 글작성 완료! ");

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

		}
		// insertMedia(mdto)
		
		// getBoardCount()
		public int getBoardCount(){
			int cnt = 0;
			
			try {
				// 1,2 디비연결
				con = getCon();
				// 3 sql 작성(select) & pstmt 객체
				sql = "select count(*) from hj_media";
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
				sql = "select * from hj_media";
				pstmt = con.prepareStatement(sql);
				// 4 sql 실행
				rs = pstmt.executeQuery();
				// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
				while(rs.next()){
					//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
					MediaDTO mdto = new MediaDTO();
					
					mdto.setContent(rs.getString("content"));
					mdto.setDate(rs.getDate("date"));
					mdto.setFile(rs.getString("file"));
					mdto.setIp(rs.getString("ip"));
					mdto.setName(rs.getString("name"));
					mdto.setBno(rs.getInt("bno"));
					mdto.setPass(rs.getString("pass"));
					mdto.setReadcount(rs.getInt("readcount"));
					mdto.setTitle(rs.getString("title"));
					
					// DTO 객체를 ArrayList 한칸에 저장
					boardList.add(mdto);				
					
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
				sql = "select * from hj_media order by bno desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				
				//?
				pstmt.setInt(1, startRow-1); // 시작행-1  (시작 ROW인덱스 번호)
				pstmt.setInt(2, pageSize); // 페이지크기  (한번에 출력되는 수)
				
				// 4 sql 실행
				rs = pstmt.executeQuery();
				// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
				while(rs.next()){
					//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
					MediaDTO mdto = new MediaDTO();
					
					mdto.setContent(rs.getString("content"));
					mdto.setDate(rs.getDate("date"));
					mdto.setFile(rs.getString("file"));
					mdto.setIp(rs.getString("ip"));
					mdto.setName(rs.getString("name"));
					mdto.setBno(rs.getInt("bno"));
					mdto.setPass(rs.getString("pass"));
					mdto.setReadcount(rs.getInt("readcount"));
					mdto.setTitle(rs.getString("title"));
					
					// DTO 객체를 ArrayList 한칸에 저장
					boardList.add(mdto);				
					
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
				sql = "update hj_media set readcount = readcount+1 where bno=?";
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
		public MediaDTO getBoard(int bno){
			MediaDTO mdto = null;
			
			try {
				
				con = getCon();
				sql = "select * from hj_media where bno=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bno);
				
				rs = pstmt.executeQuery();
				
				// 5. 데이터처리
				if(rs.next()){
					mdto = new MediaDTO();
					
					mdto.setContent(rs.getString("content"));
					mdto.setDate(rs.getDate("date"));
					mdto.setFile(rs.getString("file"));
					mdto.setIp(rs.getString("ip"));
					mdto.setName(rs.getString("name"));
					mdto.setBno(rs.getInt("bno"));
					mdto.setPass(rs.getString("pass"));
					mdto.setReadcount(rs.getInt("readcount"));
					mdto.setTitle(rs.getString("title"));
					
				}//if
				
				System.out.println(" DAO : 글정보 저장완료!");			
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return mdto;
		}
		// getBoard(bno)
		
		public MediaDTO updateMedia(MediaDTO mdto){
			
			try {
				con = getCon();
				
				String sql = "select name, title, content, file from hj_media where bno=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mdto.getBno());
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					mdto.setName(rs.getString("name"));
					mdto.setTitle(rs.getString("title"));
					mdto.setContent(rs.getString("content"));
					if(rs.getString("file")!=null){ //파일을 올릴경우
						  mdto.setFile(rs.getString("file"));
					}else{ //파일 올리지 않을 경우
					      mdto.setFile("");
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}		
			
			return mdto;
		}
		
		
		
		// updateMediaF(mdto)
		public int updateMediaF(MediaDTO mdto){
			int flag = -1;
			int result = -1;
			
			try {
				//1.2. 디비연결
				con = getCon();
				//3. sql 구문 & pstmt 객체
				sql = "select pass from hj_media where bno=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, mdto.getBno());
				
				System.out.println(mdto.getBno());
				
				// 4. sql 실행
				rs = pstmt.executeQuery();
				
				if(rs.next()){
				
					if(mdto.getPass().equals(rs.getString("pass"))){

						sql = "update hj_media set name=?,title=?,content=?,file=? "
								+ "where bno=?";
						pstmt = con.prepareStatement(sql);
						
						pstmt.setString(1, mdto.getName());
						pstmt.setString(2, mdto.getTitle());
						pstmt.setString(3, mdto.getContent());
						pstmt.setString(4, mdto.getFile());
						pstmt.setInt(5, mdto.getBno());

						// 4. sql 실행
						pstmt.executeUpdate();
						result = 1;
					}else {
						result=0;
					}
				}
				
				if(result == 0) {
					flag = 0;
				}else if(result == 1) {
					flag = 1;
					/*if ( mdto.getFile() != null && oldfileName != null ){
						//기존 첨부파일이 있고 추가된 첨부파일이 있을 경우 기존 파일은 삭제한다.
						File file = new File( "C:\\fupload"+ oldfileName);
						file.delete();
					}*/
				}				
				
				System.out.println(" DAO : 글 수정완료 "+flag);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

			return flag;
		}
		// updateMediaF(mdto)
		
		// deleteMedia(bno,pass)
		public int deleteMedia(int bno,String pass){
			int result = -1;
			
			try {
				// 1.2. 디비연결
				con = getCon();
				// 3. sql 작성 & pstmt 객체 생성
				sql = "select pass from hj_media where bno=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bno);
				
				// 4. sql 실행
				rs = pstmt.executeQuery();
				
				// 5. 데이터 처리
				if(rs.next()){
					if(pass.equals(rs.getString("pass"))){
						// 3. sql
						sql ="delete from hj_media where bno=?";
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
				
				System.out.println(" DAO : 자료실 글 삭제 완료! "+result);
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}		
			
			return result;
		}
		// deleteMedia(bno,pass) 끝
		
		
		// deleteFile(oldfile)
		public int deleteFile(int bno,String oldfile) {
			
			int result = -1;
			
			try {
				con = getCon();
				
				sql = "select file from hj_media where bno=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bno);
				
				// 4. sql 실행
				rs = pstmt.executeQuery();
				
				// 5. 데이터 처리
				if(rs.next()){
					
					sql ="update hj_media set file='' where bno=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setInt(1, bno);
					// 4. sql 실행
					pstmt.executeUpdate();
					result = 1;
					
				}else {
					result = -1;
				}
				
				
				System.out.println(" DAO : 자료실 파일 삭제 완료! ");
				
			} catch (Exception e) {
				
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return result;
			
		}
		
		// deleteFile(bno) 끝
		
		
		// getSearchList(startRow,pageSize)
		public List getSearchList(String title, int startRow,int pageSize){
			List boardList = new ArrayList();
			
			try {
				// 1,2 디비연결
				con = getCon();
				// 3 sql 작성 & pstmt 객체 생성
				// 글 re_ref 최신글 위쪽(내림차순), re_seq (오름차순)
				// DB데이터를 원하는만큼씩 짤라내기 : limit 시작행-1,페이지크기 
				sql = "select * from hj_media where title like ? order by bno desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				
				//?
				pstmt.setString(1, "%"+title+"%");
				pstmt.setInt(2, startRow-1); // 시작행-1  (시작 ROW인덱스 번호)
				pstmt.setInt(3, pageSize); // 페이지크기  (한번에 출력되는 수)
				
				// 4 sql 실행
				rs = pstmt.executeQuery();
				// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
				while(rs.next()){
					//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
					MediaDTO mdto = new MediaDTO();
					
					mdto.setContent(rs.getString("content"));
					mdto.setDate(rs.getDate("date"));
					mdto.setFile(rs.getString("file"));
					mdto.setIp(rs.getString("ip"));
					mdto.setName(rs.getString("name"));
					mdto.setBno(rs.getInt("bno"));
					mdto.setPass(rs.getString("pass"));
					mdto.setReadcount(rs.getInt("readcount"));
					mdto.setTitle(rs.getString("title"));
					
					// DTO 객체를 ArrayList 한칸에 저장
					boardList.add(mdto);				
					
				}//while
				
				System.out.println(" DAO : 글 정보 저장완료! "+boardList.size());
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}
			
			return boardList;
		}
		// getSearchList(startRow,pageSize) 끝

}
