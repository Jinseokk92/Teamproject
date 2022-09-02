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
public class FavoriteDAO {

   @Autowired
   private DataSource dataSource;
   
   @Autowired
   private MapDAO mapdao;
   
   @Autowired
   private MapDAO2 mapdao2;
   
   //즐찾 목록
   public ArrayList<FavoriteTO> favList(String seq) {
      
      ArrayList<FavoriteTO> favList=new ArrayList<FavoriteTO>();
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      
      String rname="";
      String rloc="";
      String rphone="";
      String rtime="";

      try {
         conn = this.dataSource.getConnection();
         
         String sql="select rest from favorite where seq=?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         rs=pstmt.executeQuery();
         
         while(rs.next()) {
        	FavoriteTO to=new FavoriteTO();
        
            to.setRestcode(rs.getString("rest"));
            String restcode=rs.getString("rest");
            
            ArrayList<String> resDetail=mapdao.resDetail(restcode);
            rname = resDetail.get(0);
            rloc = resDetail.get(1);
            rphone = resDetail.get(3);
            rtime = resDetail.get(4);

            to.setRestname(rname);
            to.setRestloc(rloc);
            to.setRestphone(rphone);
            
            favList.add(to);
         }
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(rs != null) try{ rs.close(); } catch(SQLException e) {}
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      
      return favList;
   }
   
   //추가
   public void favAdd(String seq, String restcode) {

       Connection conn = null;
       PreparedStatement pstmt = null;
       try {
          conn = this.dataSource.getConnection();
          
          String sql="insert into favorite values (?, ?)";
          pstmt=conn.prepareStatement(sql);
          pstmt.setString(1,seq);
          pstmt.setString(2,restcode);
          pstmt.executeUpdate();
       } catch(SQLException e) {
          System.out.println("[에러]: " + e.getMessage());
       } finally {
          if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
          if(conn != null) try{ conn.close(); } catch(SQLException e) {}
       }

   }
   
   //취소
   public void favDelete(String seq, String restcode) {

         Connection conn = null;
         PreparedStatement pstmt = null;
         try {
            conn = this.dataSource.getConnection();
            
            String sql="delete from favorite where seq=? and rest=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,seq);
            pstmt.setString(2,restcode);
            pstmt.executeUpdate();
         } catch(SQLException e) {
            System.out.println("[에러]: " + e.getMessage());
         } finally {
            if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
            if(conn != null) try{ conn.close(); } catch(SQLException e) {}
         }

   }
   
   //이미 추가되어있는지 확인
   public String onoff(String seq, String restcode) {
	      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String onoff="";
      try {
         conn = this.dataSource.getConnection();
         
         String sql="select count(*) from favorite where seq=? and rest=?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         pstmt.setString(2,restcode);
         rs=pstmt.executeQuery();
         
         if(rs.next()) {
            if (rs.getInt("count(*)")==1) {
            	onoff="checked"; //즐찾되어있으면
            }
         
         }
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(rs != null) try{ rs.close(); } catch(SQLException e) {}
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      
      return onoff;
   }
}