package com.example.model1;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO {
   
   @Autowired
   private JdbcTemplate jdbcTemplate;
   
   @Autowired
   private DataSource dataSource;
   
   public TeamTO teamName(String tseq) {
      TeamTO tto = new TeamTO();
      String sql = "select tname from team where tseq = ?";
      tto = jdbcTemplate.queryForObject(sql,new RowMapper<TeamTO>()  {
         
         @Override
         public TeamTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            TeamTO to2 = new TeamTO();         
            to2.setTname(rs.getString("tname"));



            
            return to2;

         } },tseq);      
      
      return tto;
   }
   
   //소모임 게시판 속 공지
   public ArrayList<BoardTO> noticeList() {
      
      String sql = "select bseq, subject, member.name as writer, date_format(wdate, '%Y-%m-%d') wdate, filename, hit from board inner join member on board.seq = member.seq where tseq = 1 order by bseq desc limit 0,20";
      ArrayList<BoardTO> noticeLists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<BoardTO>(BoardTO.class));
      
      return noticeLists;
   }
   
   //소모임 게시판 속 공지 + 검색
   public ArrayList<BoardTO> noticeListSearch(String which, String search) {
      ArrayList<BoardTO> noticeLists = new ArrayList<BoardTO>();
      String sql = "";
      if (which.equals("subject")) {
         sql = "select bseq, subject, member.name as writer, date_format(wdate, '%Y-%m-%d') wdate, filename, hit from board inner join member on board.seq = member.seq where tseq = 1 and subject like '%"+search+"%' order by bseq desc limit 0,20";
         noticeLists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<BoardTO>(BoardTO.class));
      } else if (which.equals("content")) {
         sql = "select bseq, subject, member.name as writer, date_format(wdate, '%Y-%m-%d') wdate, filename, hit from board inner join member on board.seq = member.seq where tseq = 1 and content like '%"+search+"%' order by bseq desc limit 0,20";
         noticeLists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<BoardTO>(BoardTO.class));
      } else if (which.equals("writer")) {
         sql = "select bseq, subject, member.name as writer, date_format(wdate, '%Y-%m-%d') wdate, filename, hit from board inner join member on board.seq = member.seq where tseq = 1 and member.name like '%"+search+"%' order by bseq desc limit 0,20";
         noticeLists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<BoardTO>(BoardTO.class));
      }
      noticeLists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<BoardTO>(BoardTO.class));
      
      return noticeLists;
   }
   
   //somoimboard.do - 소모임 게시판
   public BoardListTO boardList(BoardListTO listTO) {
	  Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      ArrayList<BoardTO> noticeLists = this.noticeList();
      
      int cpage = listTO.getCpage();
      int recordPerPage = listTO.getRecordPerPage();
      int blockPerPage = listTO.getBlockPerPage();

      int skip = (cpage -1)* recordPerPage;
      
      try {
         conn=this.dataSource.getConnection();
         String sql="select bseq, tseq, member.name as writer, subject, filename, date_format(wdate, '%Y-%m-%d') wdate, hit from board inner join member on board.seq = member.seq where tseq = ? order by bseq desc limit ?,?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,listTO.getTseq());
         pstmt.setInt(2,skip);
         pstmt.setInt(3,recordPerPage - noticeLists.size());
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         listTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         listTO.setTotalPage((listTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<BoardTO> lists=new ArrayList<BoardTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            BoardTO to=new BoardTO();
            to.setBseq(rs.getString("bseq"));
            to.setTseq(rs.getString("tseq"));
            to.setWriter(rs.getString("writer"));
            to.setSubject(rs.getString("subject"));
            to.setFilename(rs.getString("filename"));
            to.setWdate(rs.getString("wdate"));
            to.setHit(rs.getString("hit"));

            to.setCmtCount(cmtCount(rs.getString("bseq")));
            
            lists.add(to);
         }
         listTO.setBoardLists(lists);
         listTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         listTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (listTO.getEndBlock()>=listTO.getTotalPage()) {
        	 listTO.setEndBlock(listTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return listTO;
   }
      
   
   //somoimboard.do - 소모임 게시판 + 검색
   public BoardListTO boardListSearch(BoardListTO listTO, String which, String search) {
	  Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      ArrayList<BoardTO> noticeLists = this.noticeListSearch(which, search);
      
      int cpage = listTO.getCpage();
      int recordPerPage = listTO.getRecordPerPage();
      int blockPerPage = listTO.getBlockPerPage();

      int skip = (cpage -1)* recordPerPage;
      
      
      ArrayList<BoardTO> lists = new ArrayList<BoardTO>();
      String sql="";
      
      try {
         conn=this.dataSource.getConnection();
         
         if (cpage==1) {
        	 if (which.equals("subject")) {
        		 sql = "select bseq,tseq, member.name as writer, subject, filename, date_format(wdate, '%Y-%m-%d') wdate, hit from board inner join member on board.seq = member.seq where tseq = ? and subject like '%"+search+"%' order by bseq desc limit ?,?";
        		 pstmt=conn.prepareStatement(sql);
        		 pstmt.setString(1,listTO.getTseq());
                 pstmt.setInt(2,skip);
                 pstmt.setInt(3,recordPerPage - noticeLists.size());
        	 } else if (which.equals("content")) {
        		 sql = "select bseq,tseq, member.name as writer, subject, filename, date_format(wdate, '%Y-%m-%d') wdate, hit from board inner join member on board.seq = member.seq where tseq = ? and content like '%"+search+"%' order by bseq desc limit ?,?";
        		 pstmt=conn.prepareStatement(sql);
        		 pstmt.setString(1,listTO.getTseq());
                 pstmt.setInt(2,skip);
                 pstmt.setInt(3,recordPerPage - noticeLists.size());
        	 } else if (which.equals("writer")) {
        		 sql = "select bseq,tseq, member.name as writer, subject, filename, date_format(wdate, '%Y-%m-%d') wdate, hit from board inner join member on board.seq = member.seq where tseq = ? and member.name like '%"+search+"%' order by bseq desc limit ?,?";
        		 pstmt=conn.prepareStatement(sql);
        		 pstmt.setString(1,listTO.getTseq());
                 pstmt.setInt(2,skip);
                 pstmt.setInt(3,recordPerPage - noticeLists.size());
        	 }
         } else {
        	 if (which.equals("subject")) {
        		 sql = "select bseq,tseq, member.name as writer, subject, filename, date_format(wdate, '%Y-%m-%d') wdate, hit from board inner join member on board.seq = member.seq where tseq = ? and subject like '%"+search+"%' order by bseq desc limit ?,?";
        		 pstmt=conn.prepareStatement(sql);
        		 pstmt.setString(1,listTO.getTseq());
                 pstmt.setInt(2,skip);
                 pstmt.setInt(3,recordPerPage);
        	 } else if (which.equals("content")) {
        		 sql = "select bseq,tseq, member.name as writer, subject, filename, date_format(wdate, '%Y-%m-%d') wdate, hit from board inner join member on board.seq = member.seq where tseq = ? and content like '%"+search+"%' order by bseq desc limit ?,?";
        		 pstmt=conn.prepareStatement(sql);
        		 pstmt.setString(1,listTO.getTseq());
                 pstmt.setInt(2,skip);
                 pstmt.setInt(3,recordPerPage);
        	 } else if (which.equals("writer")) {
        		 sql = "select bseq,tseq, member.name as writer, subject, filename, date_format(wdate, '%Y-%m-%d') wdate, hit from board inner join member on board.seq = member.seq where tseq = ? and member.name like '%"+search+"%' order by bseq desc limit ?,?";
        		 pstmt=conn.prepareStatement(sql);
        		 pstmt.setString(1,listTO.getTseq());
                 pstmt.setInt(2,skip);
                 pstmt.setInt(3,recordPerPage);
        	 }
         }
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         listTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         listTO.setTotalPage((listTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         for (int i=0;i<recordPerPage && rs.next();i++) {
            BoardTO to=new BoardTO();
            to.setBseq(rs.getString("bseq"));
            to.setTseq(rs.getString("tseq"));
            to.setWriter(rs.getString("writer"));
            to.setSubject(rs.getString("subject"));
            to.setFilename(rs.getString("filename"));
            to.setWdate(rs.getString("wdate"));
            to.setHit(rs.getString("hit"));

            to.setCmtCount(cmtCount(rs.getString("bseq")));
            
            lists.add(to);
         }
         listTO.setBoardLists(lists);
         listTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         listTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (listTO.getEndBlock()>=listTO.getTotalPage()) {
        	 listTO.setEndBlock(listTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return listTO;
   }
      
   
   public int boardWriteOk(BoardTO bto) {   

      
      String sql = "insert into board values ( 0, ?, ?, ?, ?, ?, ?, now(), 0)";
      
      int flag = jdbcTemplate.update(sql,bto.getTseq(),bto.getSeq(),bto.getSubject(),bto.getContent(),bto.getFilename(),bto.getFilesize());
      

      
      return flag;
   }
   
   public BoardTO boardView(BoardTO to) {

      
      String sql = "update board set hit=hit+1 where bseq=?";
      jdbcTemplate.update(sql,to.getBseq());

      
      sql = "select bseq,tseq, subject, member.seq, member.name as writer, date_format(wdate, '%Y-%m-%d %H:%i') wdate, hit, content, filename, filesize from board inner join member on board.seq = member.seq where bseq=?";
      to = jdbcTemplate.queryForObject(sql,new RowMapper<BoardTO>()  {
         
               @Override
               public BoardTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                  BoardTO to2 = new BoardTO();
                  to2.setBseq(rs.getString("bseq"));
                  to2.setTseq(rs.getString("tseq"));
                  to2.setSubject(rs.getString("subject"));
                  to2.setSeq(rs.getString("member.seq"));
                  to2.setWriter(rs.getString("writer"));
                  to2.setWdate(rs.getString("wdate"));
                  to2.setHit(rs.getString("hit"));
                  to2.setContent(rs.getString("content") == null ? "" : rs.getString("content").replaceAll("\n","</br>"));
                  to2.setFilename(rs.getString("filename"));
                  to2.setFilesize(rs.getLong("filesize"));


                  
                  return to2;

               } },to.getBseq());      
         

      
            return to;
      }
   
   public int boardDeleteOk(BoardTO to, String uploadPath) {

      
      int flag = 2;

      String sql = "select filename from board where bseq=?";
      String filename = jdbcTemplate.queryForObject(sql, String.class,to.getBseq());
      
      sql = "delete from boardcmt where bseq = ?";
      jdbcTemplate.update(sql,to.getBseq());
      
      sql = "delete from board where bseq=?";
      flag = jdbcTemplate.update(sql,to.getBseq());

      
      if( flag == 0 ) {

      } else if( flag == 1 ) {

         if( filename != null ) {
            File file = new File( uploadPath, filename );
            file.delete();
         }   
      }
      
      return flag;

         
   }
   
   public BoardTO boardModify(BoardTO bto) {


      
      String sql = "select bseq ,tseq, subject, content, filename from board where bseq=?";
      bto = jdbcTemplate.queryForObject(sql,new RowMapper<BoardTO>()  {
         
               @Override
               public BoardTO mapRow(ResultSet rs, int rowNum) throws SQLException {
                  BoardTO bto2 = new BoardTO();
                  bto2.setBseq(rs.getString("bseq"));
                  bto2.setTseq(rs.getString("tseq"));
                  bto2.setSubject(rs.getString("subject"));
                  bto2.setContent(rs.getString("content") == null ? "" : rs.getString("content").replaceAll("\n","</br>"));
                  bto2.setFilename(rs.getString("filename"));


                  return bto2;

               } },bto.getBseq());      
         

      
            return bto;
      }
   
   public int boardModifyOk(BoardTO to, String uploadPath, String trash) {

      
      int flag = 2;
         
         String sql = "select filename from board where bseq=?";

         String oldFilename = jdbcTemplate.queryForObject(sql,String.class,to.getBseq());

         if( to.getFilename() != null ) {
            sql = "update board set subject=?, content=?, filename=?, filesize=? where bseq=?";
            flag = jdbcTemplate.update(sql,to.getSubject(),to.getContent(),to.getFilename(),to.getFilesize(),to.getBseq());
         } else {
            sql = "update board set subject=?, content=? where bseq=?";
            flag = jdbcTemplate.update(sql,to.getSubject(),to.getContent(),to.getBseq());

         }
           
         
         if( flag == 0 ) {

            if( to.getFilename() != null ) {
               File file = new File( uploadPath, to.getFilename() );
               file.delete();
            }
         } else if( flag == 1 ) {
        	 if (trash.equals("deleteImage")) { //휴지통 아이콘 눌리면
            	 File file = new File( uploadPath, oldFilename );
                 file.delete();
                 sql = "update board set filename=null, filesize=0 where bseq=?";
                 flag = jdbcTemplate.update(sql,to.getBseq());
             } else {
            	 if( to.getFilename() != null && oldFilename != null ) {
                     File file = new File( uploadPath, oldFilename );
                     file.delete();
                  }
             }           
         }

      return flag;
   }
   

   
   //관리자페이지 - 공지 - 페이징
   public BoardListTO noticeList(BoardListTO boardListTO) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;

      int cpage=boardListTO.getCpage();
      int recordPerPage=boardListTO.getRecordPerPage();
      int blockPerPage=boardListTO.getBlockPerPage();

      try {
         conn=this.dataSource.getConnection();

         String sql="select bseq, subject, member.name as writer, date_format(wdate, '%Y-%m-%d') wdate, filename, hit from board inner join member on board.seq = member.seq where tseq = 1 order by bseq desc";
         pstmt=conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
         rs=pstmt.executeQuery();

         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         boardListTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         boardListTO.setTotalPage((boardListTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<BoardTO> boardLists=new ArrayList<BoardTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            BoardTO to=new BoardTO();
            to.setBseq(rs.getString("bseq"));
            to.setSubject(rs.getString("subject"));
            to.setWriter(rs.getString("writer"));
            to.setWdate(rs.getString("wdate"));
            to.setHit(rs.getString("hit"));
            to.setFilename(rs.getString("filename"));

            boardLists.add(to);
         }
         boardListTO.setBoardLists(boardLists);
         boardListTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         boardListTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (boardListTO.getEndBlock()>=boardListTO.getTotalPage()) {
            boardListTO.setEndBlock(boardListTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return boardListTO;
   }
   
   //공지 쓰기
   public int noticeWriteOk(BoardTO to) {
      Connection conn=null;
      PreparedStatement pstmt=null;

      int flag=1;
      try {
         conn=this.dataSource.getConnection();

         //String sql2 = "SET foreign_key_checks = 0";
         //pstmt = conn.prepareStatement(sql2);
         //pstmt.executeUpdate();
         
         String sql="insert into board values (0,1,1,?,?,?,?,now(),0)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, to.getSubject());
         pstmt.setString(2, to.getContent());
         pstmt.setString(3, to.getFilename());
         pstmt.setLong(4, to.getFilesize());
         if(pstmt.executeUpdate() == 1) {
            flag = 0;
         }
         
         //String sql3 = "SET foreign_key_checks = 1";
         //pstmt = conn.prepareStatement(sql3);
         //pstmt.executeUpdate();
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
         
      return flag;
   }
   
   //공지 view
   public BoardTO noticeView(BoardTO to) { 
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      try {
         conn=this.dataSource.getConnection();
         
         //조회수 증가
         String sql="update board set hit=hit+1 where bseq=?;";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,to.getBseq());
         rs=pstmt.executeQuery();
         
         //본문 조회
         sql="select bseq, subject, member.name as writer, content, filename, date_format(wdate, '%Y-%m-%d %H:%i') wdate, hit from board inner join member on board.seq = member.seq where tseq = 1 and bseq = ?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,to.getBseq());
         rs=pstmt.executeQuery();
         
         if (rs.next()) {
            to.setBseq(rs.getString("bseq"));         
            to.setSubject(rs.getString("subject"));
            to.setWriter(rs.getString("writer"));
            to.setWdate(rs.getString("wdate"));
            to.setHit(rs.getString("hit"));
            to.setContent(rs.getString("content") ==null ? "" : rs.getString("content").replaceAll("\n", "<br />"));
            to.setFilename(rs.getString("filename"));
            to.setFile("<a href='../../upload/"+rs.getString("filename")+"'>"+rs.getString("filename")+"</a>");
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try{rs.close();} catch (SQLException e) {}
      }
      return to;
   }
   
   //글 수정
   public BoardTO noticeModify(BoardTO to) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      try {
         conn=this.dataSource.getConnection();
         
         String sql="select bseq, subject, content, filename from board where bseq=?;";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,to.getBseq());
         rs=pstmt.executeQuery();
         
         if (rs.next()) {
            to.setBseq(rs.getString("bseq"));
            to.setSubject(rs.getString("subject"));
            to.setContent(rs.getString("content"));
            to.setFilename(rs.getString("filename"));
         }   
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
         if (rs!=null) try{rs.close();} catch(SQLException e) {}
      }
      return to;
   }
   
   //글 modify_ok
   public int noticeModifyOk(BoardTO to, String uploadPath, String trash) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      int flag=2; 
      String oldFilename="";
      try {
         conn=this.dataSource.getConnection();
            
         String sql="select filename from board where bseq=?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,to.getBseq());
         rs=pstmt.executeQuery();
         
         to.setOldFileName("");
         if (rs.next()) { //기존 파일명
             oldFilename=rs.getString("filename");
        	 to.setOldFileName(oldFilename);
         }
         if (to.getNewFileName()!=null) { //새 첨부파일 있는 경우
            sql = "update board set subject=?, content=?, filename=?, filesize=? where bseq=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,to.getSubject());
            pstmt.setString(2,to.getContent());
            pstmt.setString(3,to.getNewFileName());
            pstmt.setLong(4,to.getNewFileSize());
            pstmt.setString(5,to.getBseq());
            
         } else { //새 첨부파일 없는 경우
            sql = "update board set subject=?, content=? where bseq=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,to.getSubject());
            pstmt.setString(2,to.getContent());
            pstmt.setString(3,to.getBseq());
         }
         
         int result=pstmt.executeUpdate();
         if (result==0) {
        	 flag=1; //오류
        	 if( to.getFilename() != null ) {
                 File file = new File( uploadPath, to.getFilename() );
                 file.delete();
              }
         } else if (result==1) { //성공
        	 flag=0;
        	 if (trash.equals("deleteImage")) { //휴지통 아이콘 눌리면
            	 File file = new File( uploadPath, to.getOldFileName() );
                 file.delete();
                 sql = "update board set filename=null, filesize=0 where bseq=?";
                 jdbcTemplate.update(sql,to.getBseq());
             } else {
            	 if( to.getFilename() != null && oldFilename != null ) {
                     File file = new File( uploadPath, to.getOldFileName() );
                     file.delete();
                  }
             } 
         }

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   //게시물 삭제
   public int noticeDelete(String bseq, String uploadPath) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      int flag=2; //비정상
      try {
         conn=this.dataSource.getConnection();
         String sql="select filename from board where bseq=?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,bseq);
         
         rs=pstmt.executeQuery();
         
         BoardTO to=new BoardTO();
         to.setBseq(bseq);
         to.setFilename("");
         if (rs.next()) {
            to.setFilename(rs.getString("filename"));
         }
         
         sql="delete from board where bseq=?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,to.getBseq());
         pstmt.executeUpdate();
         
         flag=0;
         if (to.getFilename()!=null) {
            File file=new File(uploadPath, to.getFilename());
            file.delete();
         }
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   //마이페이지 - 내가 쓴 글 보기 - 페이징
   public BoardListTO myPageList(BoardListTO boardListTO, String seq) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;

      int cpage=boardListTO.getCpage();
      int recordPerPage=boardListTO.getRecordPerPage();
      int blockPerPage=boardListTO.getBlockPerPage();

      try {
         conn=this.dataSource.getConnection();
         String sql="select bseq, board.seq, board.tseq, tname, filename, subject, date_format(wdate, '%Y-%m-%d %H:%i') wdate, hit from board inner join team on (board.tseq=team.tseq) where board.seq=? order by bseq desc";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         boardListTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         boardListTO.setTotalPage((boardListTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<BoardTO> boardLists=new ArrayList<BoardTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            BoardTO to=new BoardTO();
            to.setBseq(rs.getString("bseq"));
            to.setSeq(rs.getString("seq"));
            to.setTseq(rs.getString("tseq"));
            to.setFilename(rs.getString("filename"));
            to.setTname(rs.getString("tname"));
            to.setSubject(rs.getString("subject"));
            to.setWdate(rs.getString("wdate"));
            to.setHit(rs.getString("hit"));
            
            to.setCmtCount(cmtCount(rs.getString("bseq")));

            boardLists.add(to);
         }
         boardListTO.setBoardLists(boardLists);
         boardListTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         boardListTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (boardListTO.getEndBlock()>=boardListTO.getTotalPage()) {
            boardListTO.setEndBlock(boardListTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return boardListTO;
   }
   
   //마이페이지 - 내가 쓴 글 보기 - 페이징 + 검색
   public BoardListTO myPageListSearch(BoardListTO boardListTO, String seq, String which, String search) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;

      int cpage=boardListTO.getCpage();
      int recordPerPage=boardListTO.getRecordPerPage();
      int blockPerPage=boardListTO.getBlockPerPage();
      String sql="";
      try {
         conn=this.dataSource.getConnection();
         
         if (which.equals("subject")) {
        	 sql="select bseq, board.seq, board.tseq, filename, tname, subject, date_format(wdate, '%Y-%m-%d %H:%i') wdate, hit from board inner join team on (board.tseq=team.tseq) where board.seq=? and subject like '%"+search+"%' order by bseq desc";
         } else if (which.equals("tname")) {
        	 sql="select bseq, board.seq, board.tseq, filename, tname, subject, date_format(wdate, '%Y-%m-%d %H:%i') wdate, hit from board inner join team on (board.tseq=team.tseq) where board.seq=? and tname like '%"+search+"%' order by bseq desc";
         }
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         boardListTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         boardListTO.setTotalPage((boardListTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<BoardTO> boardLists=new ArrayList<BoardTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            BoardTO to=new BoardTO();
            to.setBseq(rs.getString("bseq"));
            to.setSeq(rs.getString("seq"));
            to.setFilename(rs.getString("filename"));
            to.setTseq(rs.getString("tseq"));
            to.setTname(rs.getString("tname"));
            to.setSubject(rs.getString("subject"));
            to.setWdate(rs.getString("wdate"));
            to.setHit(rs.getString("hit"));

            to.setCmtCount(cmtCount(rs.getString("bseq")));

            boardLists.add(to);
         }
         boardListTO.setBoardLists(boardLists);
         boardListTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         boardListTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (boardListTO.getEndBlock()>=boardListTO.getTotalPage()) {
            boardListTO.setEndBlock(boardListTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return boardListTO;
   }
   
   //내가쓴글보기 view
   public BoardTO myPageView(BoardTO to) { 
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      try {
         conn=this.dataSource.getConnection();
         
         //조회수 증가
         String sql="update board set hit=hit+1 where bseq=?;";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,to.getBseq());
         rs=pstmt.executeQuery();
         
         //본문 조회
         sql="select bseq, tseq, subject, member.name as writer, content, filename, date_format(wdate, '%Y-%m-%d %H:%i') wdate, hit from board inner join member on board.seq = member.seq where bseq = ?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,to.getBseq());
         rs=pstmt.executeQuery();
         
         if (rs.next()) {
            to.setBseq(rs.getString("bseq"));   
            to.setTseq(rs.getString("tseq"));
            to.setSubject(rs.getString("subject"));
            to.setWriter(rs.getString("writer"));
            to.setWdate(rs.getString("wdate"));
            to.setHit(rs.getString("hit"));
            to.setContent(rs.getString("content") ==null ? "" : rs.getString("content").replaceAll("\n", "<br />"));
            to.setFilename(rs.getString("filename"));
            to.setFile("<a href='../../upload/"+rs.getString("filename")+"'>"+rs.getString("filename")+"</a>");
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try{rs.close();} catch (SQLException e) {}
      }
      return to;
   }
   
   //내가쓴글보기 view
   public String myPageViewTname(String tseq) { 
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      
      String tname="";
      try {
         conn=this.dataSource.getConnection();
         
         String sql="select tname from team where tseq=?";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,tseq);
         rs=pstmt.executeQuery();
         
         if (rs.next()) {
            tname=rs.getString("tname");   
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try{rs.close();} catch (SQLException e) {}
      }
      return tname;
   }
   
   //댓글 개수
   public int cmtCount(String bseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      int cmtCount=0;
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select count(*) from boardcmt where bseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, bseq);
         rs = pstmt.executeQuery();

         if (rs.next()) {
        	 cmtCount=rs.getInt("count(*)");
         }
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return cmtCount;
   }
}