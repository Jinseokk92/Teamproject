package com.example.model1;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {

   @Autowired
   private DataSource dataSource;
   
   public ArrayList<NoticeTO> noticeList(String seq) {
      
      ArrayList<NoticeTO> noticeList=new ArrayList<NoticeTO>();
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      try {
         conn = this.dataSource.getConnection();
         
         String sql="select seq, words, date_format(ndate, '%Y-%m-%d %H:%i:%s') ndate from notice where seq=? order by ndate desc";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         rs=pstmt.executeQuery();
         
         while(rs.next()) {
            NoticeTO to=new NoticeTO();
            to.setSeq(rs.getString("seq"));
            to.setWords(rs.getString("words"));
            to.setNdate(rs.getString("ndate"));
            
            noticeList.add(to);
         }
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(rs != null) try{ rs.close(); } catch(SQLException e) {}
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      
      return noticeList;
   }
   
   public void noticeDeleteOk(String seq) {

         Connection conn = null;
         PreparedStatement pstmt = null;
         try {
            conn = this.dataSource.getConnection();
            
            String sql="delete from notice where seq=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,seq);
            pstmt.executeUpdate();
         } catch(SQLException e) {
            System.out.println("[에러]: " + e.getMessage());
         } finally {
            if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
            if(conn != null) try{ conn.close(); } catch(SQLException e) {}
         }

   }
   
   //알림 몇개 있는지
   public int noticeCount(String seq) {
	      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      int noticeCount=0;
      try {
         conn = this.dataSource.getConnection();
         
         String sql="select count(*) from notice where seq=?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         rs=pstmt.executeQuery();
         
         while(rs.next()) {
        	 noticeCount=rs.getInt("count(*)");            
         }
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(rs != null) try{ rs.close(); } catch(SQLException e) {}
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      
      return noticeCount;
   }
}