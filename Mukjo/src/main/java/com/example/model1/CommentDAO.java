package com.example.model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private DataSource dataSource;
	
	public int commentWrite(CommentTO cto) {
		String sql = "insert into boardcmt values (0,?,?,?,now())";
		
		int flag = jdbcTemplate.update(sql,cto.getBseq(),cto.getSeq(),cto.getCContent());
		
		String seq=seqFromBseq(cto.getBseq());
		String name=nameFromSeq(cto.getSeq());
		String tname=tnameFromBseq(cto.getBseq());
		String subject=subjectFromBseq(cto.getBseq());

		if (!seq.equals(cto.getSeq())) {
			String words="'"+name+"'님이 ["+tname+"] 소모임의 '"+subject+"' 게시물에 댓글을 달았습니다.";
			sql = "insert into notice values (?, ?, now())";
			jdbcTemplate.update(sql,seq,words);
		}
		
		return flag;
	}
	
	public ArrayList<CommentTO> commentView(String bseq) {
		
		String sql = "select cseq,boardcmt.seq, member.name as writer, bseq,ccontent,date_format(cdate, '%Y-%m-%d %H:%i') cdate from boardcmt inner join member on boardcmt.seq = member.seq where bseq = ? order by cseq";
		ArrayList<CommentTO> commentLists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<CommentTO>(CommentTO.class),bseq);
		
		return commentLists;
	}
	
	public int commentDelete(CommentTO cto) {

		String sql = "delete from boardcmt where cseq=?";		
		
		int flag = jdbcTemplate.update(sql, cto.getCseq());

		
		return flag;
	}
	
	// bseq로 seq 알아내기
   public String seqFromBseq(String bseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String seq="";
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select seq from board where bseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, bseq);
         rs = pstmt.executeQuery();

         if (rs.next()) {
        	 seq=rs.getString("seq");
         }
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return seq;
   }
   
   // seq로 name 알아내기
   public String nameFromSeq(String seq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String name="";
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select name from member where seq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         rs = pstmt.executeQuery();

         if (rs.next()) {
        	 name=rs.getString("name");
         }
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return name;
   }
   
   //bseq로 tname 알아내기
   public String tnameFromBseq(String bseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String tname="";
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select tname from board inner join team on (team.tseq=board.tseq) where bseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, bseq);
         rs = pstmt.executeQuery();

         if (rs.next()) {
        	 tname=rs.getString("tname");
         }
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return tname;
   }
   
   // bseq로 subject 알아내기
   public String subjectFromBseq(String bseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String subject="";
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select subject from board where bseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, bseq);
         rs = pstmt.executeQuery();

         if (rs.next()) {
        	 subject=rs.getString("subject");
         }
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return subject;
   }
}
