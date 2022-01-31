package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.hj.board.BoardDTO;

public class CommentDAO {

	
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
	
	public int getNext() {
		String SQL = "SELECT cno FROM hj_mcomment ORDER BY cno DESC";
		try {
			con=getCon();
			PreparedStatement pstmt = con.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return 1; //첫번째 댓글인 경우
	}
	
	// insertComment(cdto)
	public void insertComment(CommentDTO cdto) {
		
		int cno = 0;
		
		try {
			con = getCon();
			sql = "select max(cno) from hj_mcomment";
			pstmt = con.prepareStatement(sql);

			// 4. sql 구문 실행
			rs = pstmt.executeQuery();
			// 5. 데이터 처리
			if (rs.next()) {
				// 기존의 글번호(저장된최대값) + 1
				cno = rs.getInt(1) + 1;
				// getInt(인덱스) -> 컬럼의 값을 리턴, 만약에 SQL null이면 0리턴
			}
			
			// 전달받은 글정보를 DB insert				
			// 3. sql 작성 (insert) & pstmt 객체 생성
			sql = "insert into hj_mcomment(cno,bno,uid,ctext,reg_date) "
					+ "values(?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cno);
			pstmt.setInt(2, cdto.getBno());
			pstmt.setString(3, cdto.getUid());
			pstmt.setString(4, cdto.getCtext());

			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}
	// insertComment(cdto)
	
	// getCommentCount()
	public int getCommentCount(){
		int cnt = 0;
		
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성(select) & pstmt 객체
			sql = "select count(*) from hj_mcomment";
			pstmt = con.prepareStatement(sql);
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터 처리
			if(rs.next()){
				//데이터 있을때 (글개수)
				cnt = rs.getInt(1);	
			}
			
			System.out.println(" DAO : 댓글개수 ("+cnt+")");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return cnt;
	}
	// getCommentCount()
	
	
	// getCommentList()
	public List getCommentList(int bno){
		List CommentList = new ArrayList();
		
		try {
			// 1,2 디비연결
			con = getCon();
			// 3 sql 작성 & pstmt 객체 생성
			sql = "select * from hj_mcomment where bno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			// 4 sql 실행
			rs = pstmt.executeQuery();
			// 5 데이터처리 (글 1개의 정보 -> DTO 1개 -> ArrayList 1칸)
			while(rs.next()){
				//데이터 있을때 마다 글 1개의 정보를 저장하는 객체 생성
				CommentDTO cdto = new CommentDTO();
				
				cdto.setCno(rs.getInt("cno"));
				cdto.setBno(rs.getInt("bno"));
				cdto.setUid(rs.getString("id"));
				cdto.setCtext(rs.getString("ctext"));
				cdto.setReg_date(rs.getDate("date"));
				
				// DTO 객체를 ArrayList 한칸에 저장
				CommentList.add(cdto);				
				
			}//while
			
			System.out.println(" DAO : 글 정보 저장완료! "+CommentList.size());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return CommentList;
	}
	// getCommentList()
	
	
	public CommentDTO getComment(int bno){
		CommentDTO cdto = null;
		
		try {
			
			con = getCon();
			sql = "select * from hj_mcomment where bno=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,bno);
			
			rs = pstmt.executeQuery();
			
			// 5. 데이터처리
			if(rs.next()){
				cdto = new CommentDTO();
				
				cdto.setCno(rs.getInt("cno"));
				cdto.setBno(rs.getInt("bno"));
				cdto.setUid(rs.getString("id"));
				cdto.setCtext(rs.getString("ctext"));
				cdto.setReg_date(rs.getDate("date"));
				
			}//if
			
			System.out.println(" DAO : 글정보 저장완료!");			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return cdto;
	}
	
	
	// 댓글 삭제
	public int deleteComment(int cno) {
		String SQL = "DELETE FROM hj_mcomment WHERE cno = ?";
		try {
			con=getCon();
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, cno);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return -1; // 데이터베이스 오류
	}
	
	
	
	
}
