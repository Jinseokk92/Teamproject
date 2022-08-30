package com.example.model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TeamDAO {
   
   @Autowired
   private DataSource dataSource;

   // 메인페이지 전체소모임리스트 - 페이징
   public PageMainTeamTO mainteamList(PageMainTeamTO pageMainTeamTO) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ResultSet rs2 = null;
         
      int cpage = pageMainTeamTO.getCpage();
      int recordPerPage = pageMainTeamTO.getRecordPerPage();
      int blockPerPage = pageMainTeamTO.getBlockPerPage();

      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select tseq, tname, name from team inner join member where team.seq=member.seq and tseq!=1 order by tname";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageMainTeamTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageMainTeamTO.setTotalPage((pageMainTeamTO.getTotalRecord() - 1) / recordPerPage + 1);
         
         //시작번호 - 읽을 데이터 위치 지정
         int skip = (cpage - 1) * recordPerPage;
         if(skip != 0) rs.absolute(skip); //커서를 주어진 행으로 이동
         ArrayList<TeamTO> mainteamLists = new ArrayList<TeamTO>();
         for(int i = 0 ; i < recordPerPage && rs.next() ; i++) {
            TeamTO to = new TeamTO();
            to.setTseq(rs.getString("tseq"));
            String tseq=rs.getString("tseq");
            to.setTname(rs.getString("tname"));
            to.setName(rs.getString("name"));
               
            sql = "select count(*)-1 from teammember where tseq=? and accept=1";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,tseq);
            rs2=pstmt.executeQuery();
            if (rs2.next()) {
               to.setMemcount(rs2.getInt("count(*)-1"));      
            }
            mainteamLists.add(to);
         }
         
         pageMainTeamTO.setMainTeamLists(mainteamLists);
         pageMainTeamTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageMainTeamTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageMainTeamTO.getEndBlock()>=pageMainTeamTO.getTotalPage()) {
            pageMainTeamTO.setEndBlock(pageMainTeamTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return pageMainTeamTO;
   }
   
   // 메인페이지 전체소모임리스트 - 페이징 + 검색
   public PageMainTeamTO mainteamListSearch(PageMainTeamTO pageMainTeamTO, String search) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ResultSet rs2 = null;
         
      int cpage = pageMainTeamTO.getCpage();
      int recordPerPage = pageMainTeamTO.getRecordPerPage();
      int blockPerPage = pageMainTeamTO.getBlockPerPage();

      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select tseq, tname, name from team inner join member on (team.seq=member.seq) where tname like '%"+search+"%' and tseq!=1 order by tname";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageMainTeamTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageMainTeamTO.setTotalPage((pageMainTeamTO.getTotalRecord() - 1) / recordPerPage + 1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip = (cpage - 1) * recordPerPage;
         if(skip != 0) rs.absolute(skip); //커서를 주어진 행으로 이동
         
         ArrayList<TeamTO> mainteamLists = new ArrayList<TeamTO>();
         for(int i = 0 ; i < recordPerPage && rs.next() ; i++) {
            TeamTO to = new TeamTO();
            to.setTseq(rs.getString("tseq"));
            to.setTname(rs.getString("tname"));
            String tseq=rs.getString("tseq");
            to.setName(rs.getString("name"));
               
            sql = "select count(*)-1 from teammember where tseq=? and accept=1";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,tseq);
            rs2=pstmt.executeQuery();
            if (rs2.next()) {
               to.setMemcount(rs2.getInt("count(*)-1"));
            }
            mainteamLists.add(to);
         }
         pageMainTeamTO.setMainTeamLists(mainteamLists);
         pageMainTeamTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageMainTeamTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageMainTeamTO.getEndBlock()>=pageMainTeamTO.getTotalPage()) {
            pageMainTeamTO.setEndBlock(pageMainTeamTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return pageMainTeamTO;
   }
      
   // 소모임 이름 중복확인
   public boolean CheckTname(String tname, String seq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      boolean result = false;
      
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select tname from team where tname = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tname);
         rs = pstmt.executeQuery();
         
         // 소모임 이름이 있다면 true
         if(rs.next()) {
            result = true;
         } else {
            sql = "insert into team values (0, ?, ?)";
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, tname);
            pstmt.setString(2, seq);
            
            pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            if(rs.next()) {
               // tseq값 가져오기
               int tseq = rs.getInt(1);
               
               if(seq.equals("1")) {
                  String tsql = "insert into teammember values (?, ?, 1)";
                  pstmt = conn.prepareStatement(tsql);
                  pstmt.setString(1, seq);
                  pstmt.setInt(2, tseq);
                  
                  pstmt.executeUpdate();
               } else {
                  String tsql = "insert into teammember values (1, ?, 1), (?, ?, 1)";
                  pstmt = conn.prepareStatement(tsql);
                  pstmt.setInt(1, tseq);
                  pstmt.setString(2, seq);
                  pstmt.setInt(3, tseq);
                  
                  pstmt.executeUpdate();
               }
            }
         }
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(rs != null) try{ rs.close(); } catch(SQLException e) {}
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      return result;
   }
   
   
   
   // 소모임 가입 신청
   public int Jointeam(String tseq, String seq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int flag = 0;
         
      try {
         conn = this.dataSource.getConnection();
         String sql = "select tseq from team where tseq = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
         rs = pstmt.executeQuery();
         
         // 소모임 이름이 있다면 true
         if(rs.next()) {
            sql = "select seq, tseq from teammember where seq = ? and tseq = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, seq);
            pstmt.setString(2, tseq);
            rs = pstmt.executeQuery();
            
            // 소모임 가입 신청 중복 확인
            if(rs.next()) {
               flag = 1;
            } else {
               sql = "insert into teammember values (?, ?, 0)";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, seq);
               pstmt.setString(2, tseq);
               pstmt.executeUpdate();
               
               String jangseq=jangseq(tseq);
               String tname=tnameFromTseq(tseq);
               String name=nameFromSeq(seq);

               String words="'"+name+"'님이 ["+tname+"] 소모임 가입을 신청했습니다.";
               sql = "insert into notice values (?, ?, now())";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, jangseq);
               pstmt.setString(2, words);
               pstmt.executeUpdate();
               
               flag = 2;
            }
         }
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(rs != null) try{ rs.close(); } catch(SQLException e) {}
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      return flag;
   }
   
   //관리자페이지-소모임리스트 - 페이징
   public PageAdminTeamTO teamList(PageAdminTeamTO pageAdminTeamTO) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      ResultSet rs2=null;

      int cpage=pageAdminTeamTO.getCpage();
      int recordPerPage=pageAdminTeamTO.getRecordPerPage();
      int blockPerPage=pageAdminTeamTO.getBlockPerPage();

      try {
         conn=this.dataSource.getConnection();

         String sql="select tseq, tname, name from team inner join member where team.seq=member.seq order by tname";
         pstmt=conn.prepareStatement(sql);
         rs=pstmt.executeQuery();

         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageAdminTeamTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageAdminTeamTO.setTotalPage((pageAdminTeamTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<TeamTO> teamLists=new ArrayList<TeamTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            TeamTO to=new TeamTO();
            to.setTseq(rs.getString("tseq"));
            String tseq=rs.getString("tseq");
            to.setTname(rs.getString("tname"));
            to.setName(rs.getString("name"));

            sql = "select count(*)-1 from teammember where tseq=? and accept=1";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,tseq);
            rs2=pstmt.executeQuery();
            if (rs2.next()) {
               to.setMemcount(rs2.getInt("count(*)-1"));      
            }
            teamLists.add(to);
         }
         
         pageAdminTeamTO.setTeamLists(teamLists);
         pageAdminTeamTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageAdminTeamTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageAdminTeamTO.getEndBlock()>=pageAdminTeamTO.getTotalPage()) {
            pageAdminTeamTO.setEndBlock(pageAdminTeamTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return pageAdminTeamTO;
   }
   
 //관리자페이지-소모임리스트 - 페이징 + 검색
   public PageAdminTeamTO teamListSearch(PageAdminTeamTO pageAdminTeamTO, String search) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      ResultSet rs2=null;

      int cpage=pageAdminTeamTO.getCpage();
      int recordPerPage=pageAdminTeamTO.getRecordPerPage();
      int blockPerPage=pageAdminTeamTO.getBlockPerPage();

      try {
         conn=this.dataSource.getConnection();

         String sql="select tseq, tname, name from team inner join member on (team.seq=member.seq) where tname like '%"+search+"%' order by tname";
         pstmt=conn.prepareStatement(sql);
         rs=pstmt.executeQuery();

         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageAdminTeamTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageAdminTeamTO.setTotalPage((pageAdminTeamTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<TeamTO> teamLists=new ArrayList<TeamTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            TeamTO to=new TeamTO();
            to.setTseq(rs.getString("tseq"));
            String tseq=rs.getString("tseq");
            to.setTname(rs.getString("tname"));
            to.setName(rs.getString("name"));

            sql = "select count(*)-1 from teammember where tseq=? and accept=1";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,tseq);
            rs2=pstmt.executeQuery();
            if (rs2.next()) {
               to.setMemcount(rs2.getInt("count(*)-1"));      
            }
            teamLists.add(to);
         }

         pageAdminTeamTO.setTeamLists(teamLists);
         pageAdminTeamTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageAdminTeamTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageAdminTeamTO.getEndBlock()>=pageAdminTeamTO.getTotalPage()) {
            pageAdminTeamTO.setEndBlock(pageAdminTeamTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return pageAdminTeamTO;
   }
   
   //메인페이지 - 가입한 소모임 - 페이징
   public MainTeamPageTO teamList(MainTeamPageTO mainTeamPageTO, String seq) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      ResultSet rs2=null;
      ResultSet rs3=null;

      int cpage=mainTeamPageTO.getCpage();
      int recordPerPage=mainTeamPageTO.getRecordPerPage();
      int blockPerPage=mainTeamPageTO.getBlockPerPage();

      String jangseq="";
      int accept = 0;
      try {
         conn=this.dataSource.getConnection();
         String sql="select teammember.tseq as tseq, tname, team.seq as jangseq from teammember inner join team on (teammember.tseq=team.tseq and team.tseq!=1) where accept=1 and teammember.seq=? order by tname";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         mainTeamPageTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         mainTeamPageTO.setTotalPage((mainTeamPageTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동
         
         ArrayList<MainTeamTO> teamLists=new ArrayList<MainTeamTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            MainTeamTO to=new MainTeamTO();
            to.setSeq(rs.getString("seq"));
            to.setTseq(rs.getString("tseq"));
            String tseq=rs.getString("tseq");
            to.setTname(rs.getString("tname"));
            to.setJangseq(rs.getString("jangseq"));
            jangseq=rs.getString("jangseq");
            
            sql="select name from member where seq=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,jangseq);
            
            rs2=pstmt.executeQuery();
         
            if (rs2.next()) {
               to.setJangname(rs2.getString("name"));
            }
            
            sql = "select count(*)-1 from teammember where tseq=? and accept=1";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,tseq);
            rs3=pstmt.executeQuery();
            if (rs3.next()) {
               to.setMemcount(rs3.getInt("count(*)-1"));      
            }
            teamLists.add(to);
            
         }
         
         mainTeamPageTO.setTeamLists(teamLists);
         mainTeamPageTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         mainTeamPageTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (mainTeamPageTO.getEndBlock()>=mainTeamPageTO.getTotalPage()) {
            mainTeamPageTO.setEndBlock(mainTeamPageTO.getTotalPage());
         }
         
            
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return mainTeamPageTO;
   }
   
   //메인페이지 - 가입한 소모임 - 페이징 + 검색
   public MainTeamPageTO teamListSearch(MainTeamPageTO mainTeamPageTO, String seq, String search) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      ResultSet rs2=null;
      ResultSet rs3=null;

      int cpage=mainTeamPageTO.getCpage();
      int recordPerPage=mainTeamPageTO.getRecordPerPage();
      int blockPerPage=mainTeamPageTO.getBlockPerPage();

      String jangseq="";
      int accept = 0;
      try {
         conn=this.dataSource.getConnection();
         String sql="select teammember.tseq as tseq, tname, team.seq as jangseq from teammember inner join team on (teammember.tseq=team.tseq and accept=1) where teammember.seq=? and tname like '%"+search+"%' and team.tseq!=1 order by tname";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         mainTeamPageTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         mainTeamPageTO.setTotalPage((mainTeamPageTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<MainTeamTO> teamLists=new ArrayList<MainTeamTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            MainTeamTO to=new MainTeamTO();
            to.setSeq(rs.getString("seq"));
            to.setTseq(rs.getString("tseq"));
            String tseq=rs.getString("tseq");
            to.setTname(rs.getString("tname"));
            to.setJangseq(rs.getString("jangseq"));
            jangseq=rs.getString("jangseq");
            
            sql="select name from member where seq=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,jangseq);
            
            rs2=pstmt.executeQuery();
         
            if (rs2.next()) {
               to.setJangname(rs2.getString("name"));
            }
            
            sql = "select count(*)-1 from teammember where tseq=? and accept=1";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,tseq);
            rs3=pstmt.executeQuery();
            if (rs3.next()) {
               to.setMemcount(rs3.getInt("count(*)-1"));      
            }
            teamLists.add(to);
         }         
         
         mainTeamPageTO.setTeamLists(teamLists);
         mainTeamPageTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         mainTeamPageTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (mainTeamPageTO.getEndBlock()>=mainTeamPageTO.getTotalPage()) {
            mainTeamPageTO.setEndBlock(mainTeamPageTO.getTotalPage());
         }

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return mainTeamPageTO;
   }
   
   //소모임장 페이지 - 소모임 목록 (boss.do)
   public TeamBossPageTO bossTeamList(TeamBossPageTO teamBossPageTO, String seq) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      ResultSet rs2=null;

      int cpage=teamBossPageTO.getCpage();
      int recordPerPage=teamBossPageTO.getRecordPerPage();
      int blockPerPage=teamBossPageTO.getBlockPerPage();

      String jangseq="";
      int accept = 0;
      try {
         conn=this.dataSource.getConnection();
         String sql="select member.seq as seq, tseq, tname, name from team inner join member on (member.seq=team.seq) where member.seq=? order by name";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,seq);
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         teamBossPageTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         teamBossPageTO.setTotalPage((teamBossPageTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<TeamTO> teamLists=new ArrayList<TeamTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            TeamTO to=new TeamTO();
            to.setSeq(rs.getString("seq"));
            to.setTseq(rs.getString("tseq"));
            String tseq=rs.getString("tseq");
            to.setTname(rs.getString("tname"));
            to.setName(rs.getString("name"));
            
            sql = "select count(*)-1 from teammember where tseq=? and accept=1";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,tseq);
            rs2=pstmt.executeQuery();
            if (rs2.next()) {
               to.setMemcount(rs2.getInt("count(*)-1"));      
            }
            teamLists.add(to);
         }
         
         teamBossPageTO.setTeamLists(teamLists);
         teamBossPageTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         teamBossPageTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (teamBossPageTO.getEndBlock()>=teamBossPageTO.getTotalPage()) {
            teamBossPageTO.setEndBlock(teamBossPageTO.getTotalPage());
         }

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return teamBossPageTO;
   }
   
   //소모임장 페이지 - 멤버관리 리스트 (bossmember.do)
   public PageMemberTO bossMember(PageMemberTO pageMemberTO, String tseq) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;

      int cpage=pageMemberTO.getCpage();
      int recordPerPage=pageMemberTO.getRecordPerPage();
      int blockPerPage=pageMemberTO.getBlockPerPage();

      String jangseq="";
      int accept = 0;
      try {
         conn=this.dataSource.getConnection();
         String sql="select member.seq as seq, name, birth, email from member inner join teammember on (teammember.seq=member.seq and member.seq!=1) where tseq=? and accept=1 order by name";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,tseq);
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageMemberTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageMemberTO.setTotalPage((pageMemberTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<MemberTO> memberLists=new ArrayList<MemberTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            MemberTO to=new MemberTO();
            to.setSeq(rs.getString("seq"));
            to.setName(rs.getString("name"));
            to.setBirth(rs.getString("birth"));
            to.setEmail(rs.getString("email"));
            
            memberLists.add(to);
         }
         pageMemberTO.setMemberLists(memberLists);
         pageMemberTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageMemberTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageMemberTO.getEndBlock()>=pageMemberTO.getTotalPage()) {
            pageMemberTO.setEndBlock(pageMemberTO.getTotalPage());
         }

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return pageMemberTO;
   }
   
   //소모임장 페이지 - 멤버관리 리스트 + 검색(bossmember.do)
   public PageMemberTO bossMemberSearch(PageMemberTO pageMemberTO, String tseq, String search) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;

      int cpage=pageMemberTO.getCpage();
      int recordPerPage=pageMemberTO.getRecordPerPage();
      int blockPerPage=pageMemberTO.getBlockPerPage();

      String jangseq="";
      int accept = 0;
      try {
         conn=this.dataSource.getConnection();
         String sql="select member.seq as seq, name, birth, email from member inner join teammember on (teammember.seq=member.seq and member.seq!=1) where tseq=? and accept=1 and name like '%"+search+"%' order by name";
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1,tseq);
         
         rs=pstmt.executeQuery();
      
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageMemberTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageMemberTO.setTotalPage((pageMemberTO.getTotalRecord()-1)/recordPerPage+1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip=(cpage-1)*recordPerPage;
         if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동

         ArrayList<MemberTO> memberLists=new ArrayList<MemberTO>();
         for (int i=0;i<recordPerPage && rs.next();i++) {
            MemberTO to=new MemberTO();
            to.setSeq(rs.getString("seq"));
            to.setName(rs.getString("name"));
            to.setBirth(rs.getString("birth"));
            to.setEmail(rs.getString("email"));
            
            memberLists.add(to);
         }
         pageMemberTO.setMemberLists(memberLists);
         pageMemberTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageMemberTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageMemberTO.getEndBlock()>=pageMemberTO.getTotalPage()) {
            pageMemberTO.setEndBlock(pageMemberTO.getTotalPage());
         }

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try {conn.close();} catch (SQLException e) {}
         if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
         if (rs!=null) try {rs.close();} catch (SQLException e) {}
      }
      return pageMemberTO;
   }
   
   // 소모임장 변경
   public int BossChange(String seq, String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;

      int flag = 0;
         
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "update team set seq=? where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
               
         flag=pstmt.executeUpdate(); //1이면 성공            

         String tname=tnameFromTseq(tseq);
         String words="["+tname+"] 소모임의 소모임장이 되셨습니다.";
         
         sql = "insert into notice values (?, ?, now())";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, words);
         pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   // 소모임으로부터 추방
   public int BossDeleteMember(String seq, String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;

      int flag = 2;
         
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "delete from teammember where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
               
         flag=pstmt.executeUpdate(); //0이면 성공
         
         sql = "delete from boardcmt where bseq=(select board.bseq from boardcmt inner join board on (board.bseq=boardcmt.bseq) where boardcmt.seq=?)";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.executeUpdate();
         
         sql = "delete from board where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
         
         sql = "delete from review where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
         
         String tname=tnameFromTseq(tseq);
         String words="["+tname+"] 소모임으로부터 추방당하셨습니다.";
         sql = "insert into notice values (?, ?, now())";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, words);
         pstmt.executeUpdate();

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   // 소모임장페이지 - 가입요청 리스트
   public PageMemberTO bossAccept(PageMemberTO pageMemberTO, String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
         
      int cpage = pageMemberTO.getCpage();
      int recordPerPage = pageMemberTO.getRecordPerPage();
      int blockPerPage = pageMemberTO.getBlockPerPage();

      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select member.seq, name, birth, email from member inner join teammember on (member.seq=teammember.seq) where tseq=? and accept=0";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
         rs = pstmt.executeQuery();
         
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageMemberTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageMemberTO.setTotalPage((pageMemberTO.getTotalRecord() - 1) / recordPerPage + 1);

         //시작번호 - 읽을 데이터 위치 지정
         int skip = (cpage - 1) * recordPerPage;
         if(skip != 0) rs.absolute(skip); //커서를 주어진 행으로 이동
            ArrayList<MemberTO> memberLists = new ArrayList<MemberTO>();
         for(int i = 0 ; i < recordPerPage && rs.next() ; i++) {
            MemberTO to = new MemberTO();
            to.setSeq(rs.getString("seq"));
            to.setName(rs.getString("name"));
            to.setBirth(rs.getString("birth"));
            to.setEmail(rs.getString("email"));
               
            memberLists.add(to);
         }
         pageMemberTO.setMemberLists(memberLists);
         pageMemberTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageMemberTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageMemberTO.getEndBlock()>=pageMemberTO.getTotalPage()) {
            pageMemberTO.setEndBlock(pageMemberTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return pageMemberTO;
   }
   
   // 소모임 가입 신청 승인
   public int BossAcceptYes(String seq, String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;

      int flag = 0;
         
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "update teammember set accept=1 where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
               
         flag=pstmt.executeUpdate(); //1이면 성공

         String tname=tnameFromTseq(tseq);
         String words="["+tname+"] 소모임 가입 신청이 승인되었습니다.";
         sql = "insert into notice values (?, ?, now())";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, words);
         pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   // 소모임 가입 신청 거절
   public int BossAcceptNo(String seq, String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;

      int flag = 2;
         
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "delete from teammember where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
               
         flag=pstmt.executeUpdate(); //0이면 성공
         
         String tname=tnameFromTseq(tseq);
         String words="["+tname+"] 소모임 가입 신청이 거절되었습니다.";
         
         sql = "insert into notice values (?, ?, now())";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, words);
         pstmt.executeUpdate();

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   // 소모임 이름 변경
   public int BossChangeTname(String tseq, String newname) {
      Connection conn = null;
      PreparedStatement pstmt = null;

      int flag = 0;
         
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "update team set tname='"+newname+"' where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
               
         flag=pstmt.executeUpdate(); //1이면 성공            

      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   // 소모임 이름 중복확인
   public boolean CheckTname(String tname) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      boolean result = false;
      
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select tname from team where tname = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tname);
         rs = pstmt.executeQuery();
         
         // 있다면 true
         if(rs.next()) {
            result = true;
         }
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(rs != null) try{ rs.close(); } catch(SQLException e) {}
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      return result;
   }
   
   // 소모임 삭제
   public int DeleteTeam(String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs=null;
      
      int flag = 2;
         
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "delete from teammember where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         String sql2 = "delete from review where tseq=?";
         pstmt = conn.prepareStatement(sql2);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         String cseq="";
         String sssql = "select cseq from boardcmt inner join board on (boardcmt.bseq=board.bseq) where tseq=?";
         pstmt = conn.prepareStatement(sssql);
         pstmt.setString(1, tseq);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            cseq=rs.getString("cseq");
         }
         
         String sql33 = " delete from boardcmt where cseq=?";
         pstmt = conn.prepareStatement(sql33);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         String sql3 = "delete from board where tseq=?";
         pstmt = conn.prepareStatement(sql3);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         sql = "delete from team where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
               
         flag=pstmt.executeUpdate(); //0이면 성공
         
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   // 관리자 - 소모임 삭제
   public int adDeleteTeam(String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs=null;
      
      int flag = 2;
         
      try {
         conn = this.dataSource.getConnection();
         
         String ssql = "select member.seq from member inner join team on (member.seq=team.seq) where tseq=?";
         pstmt = conn.prepareStatement(ssql);
         pstmt.setString(1, tseq);
         rs = pstmt.executeQuery();
         String seq="";
         if (rs.next()) {
            seq=rs.getString("seq");
         }

         String tname=tnameFromTseq(tseq);
         
         String sql = "delete from teammember where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         String sql2 = "delete from review where tseq=?";
         pstmt = conn.prepareStatement(sql2);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         String cseq="";
         String sssql = "select cseq from boardcmt inner join board on (boardcmt.bseq=board.bseq) where tseq=?";
         pstmt = conn.prepareStatement(sssql);
         pstmt.setString(1, tseq);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            cseq=rs.getString("cseq");
         }
         
         String sql33 = " delete from boardcmt where cseq=?";
         pstmt = conn.prepareStatement(sql33);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         String sql3 = "delete from board where tseq=?";
         pstmt = conn.prepareStatement(sql3);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
         
         sql = "delete from team where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
         pstmt.executeUpdate();
               
         flag=pstmt.executeUpdate(); //0이면 성공 
         
         String words="["+tname+"] 소모임이 관리자에 의해 삭제됐습니다.";
         sql = "insert into notice values (?, ?, now())";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, words);
         pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if (conn!=null) try{conn.close();} catch(SQLException e) {}
         if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
      }
      return flag;
   }
   
   // tseq로 소모임 이름 알아내기
   public String tnameFromTseq(String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String tname="";
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select tname from team where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, tseq);
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
   
   // seq로 이름 알아내기
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
   
   // tseq 넣고 소모임장 seq 받아내기
   public String jangseq(String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      String jangseq="";
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select seq from team where tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,tseq);
         rs = pstmt.executeQuery();
         
         if (rs.next()) {
            jangseq=rs.getString("seq");
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return jangseq;
   }
   
   // 메인페이지 소모임 회원 목록 - 페이징
   public PageTeamMemberTO memberList(PageTeamMemberTO pageTeamMemberTO, String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
         
      int cpage = pageTeamMemberTO.getCpage();
      int recordPerPage = pageTeamMemberTO.getRecordPerPage();
      int blockPerPage = pageTeamMemberTO.getBlockPerPage();

      try {
         conn = this.dataSource.getConnection();
         
         String sql = "select member.seq, name, email, date_format(birth,'%y%m%d') as birth from member inner join teammember on (member.seq=teammember.seq) where tseq=? and accept=1 order by name";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,tseq);
         rs = pstmt.executeQuery();
         
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageTeamMemberTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageTeamMemberTO.setTotalPage((pageTeamMemberTO.getTotalRecord() - 1) / recordPerPage + 1);
         
         //시작번호 - 읽을 데이터 위치 지정
         int skip = (cpage - 1) * recordPerPage;
         if(skip != 0) rs.absolute(skip); //커서를 주어진 행으로 이동
         ArrayList<MemberTO> memberLists = new ArrayList<MemberTO>();
         for(int i = 0 ; i < recordPerPage && rs.next() ; i++) {
            MemberTO to = new MemberTO();
            to.setSeq(rs.getString("seq"));
            to.setName(rs.getString("name"));
            to.setEmail(rs.getString("email"));
            to.setBirth(rs.getString("birth"));
               
            memberLists.add(to);
         }
         
         pageTeamMemberTO.setTeamMemberLists(memberLists);
         pageTeamMemberTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageTeamMemberTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageTeamMemberTO.getEndBlock()>=pageTeamMemberTO.getTotalPage()) {
            pageTeamMemberTO.setEndBlock(pageTeamMemberTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return pageTeamMemberTO;
   }
   
   // 메인페이지 소모임 회원 목록 - 페이징 + 검색
   public PageTeamMemberTO memberListSearch(PageTeamMemberTO pageTeamMemberTO, String tseq, String search) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
         
      int cpage = pageTeamMemberTO.getCpage();
      int recordPerPage = pageTeamMemberTO.getRecordPerPage();
      int blockPerPage = pageTeamMemberTO.getBlockPerPage();

      try {
         conn = this.dataSource.getConnection();

         String sql = "select member.seq, name, email, date_format(birth,'%y%m%d') as birth from member inner join teammember on (member.seq=teammember.seq and accept=1) where tseq=? and name like '%"+search+"%'order by name";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1,tseq);
         rs = pstmt.executeQuery();
         
         rs.last(); //읽기 커서를 맨 마지막 행으로 이동
         pageTeamMemberTO.setTotalRecord(rs.getRow());
         rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동

         //전체 페이지
         pageTeamMemberTO.setTotalPage((pageTeamMemberTO.getTotalRecord() - 1) / recordPerPage + 1);
         
         //시작번호 - 읽을 데이터 위치 지정
         int skip = (cpage - 1) * recordPerPage;
         if(skip != 0) rs.absolute(skip); //커서를 주어진 행으로 이동
         ArrayList<MemberTO> memberLists = new ArrayList<MemberTO>();
         for(int i = 0 ; i < recordPerPage && rs.next() ; i++) {
            MemberTO to = new MemberTO();
            to.setSeq(rs.getString("seq"));
            to.setName(rs.getString("name"));
            to.setEmail(rs.getString("email"));
            to.setBirth(rs.getString("birth"));
               
            memberLists.add(to);
         }
         
         pageTeamMemberTO.setTeamMemberLists(memberLists);
         pageTeamMemberTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
         pageTeamMemberTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
         if (pageTeamMemberTO.getEndBlock()>=pageTeamMemberTO.getTotalPage()) {
            pageTeamMemberTO.setEndBlock(pageTeamMemberTO.getTotalPage());
         }
      } catch (SQLException e) {
         System.out.println("[에러]:"+e.getMessage());
      } finally {
         if(conn != null) try { conn.close(); } catch(SQLException e) {}
         if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
         if(rs != null) try { rs.close(); } catch(SQLException e) {}
      }
      return pageTeamMemberTO;
   }
   
   //소모임 탈퇴
   public int memberExit(String seq, String tseq) {
      Connection conn = null;
      PreparedStatement pstmt = null;
   
      int flag=1;
      try {
         conn = this.dataSource.getConnection();
         
         String sql = "delete from teammember where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
         flag=pstmt.executeUpdate();
         
         String sql2 = "delete from review where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql2);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
         
         String sql33 = "delete from boardcmt where cseq=(select cseq from boardcmt inner join board on (boardcmt.bseq=board.bseq) where tseq=? and boardcmt.seq=?)";
         pstmt = conn.prepareStatement(sql33);
         pstmt.setString(1, tseq);
         pstmt.setString(2, seq);
         pstmt.executeUpdate();
         
         String sql3 = "delete from board where seq=? and tseq=?";
         pstmt = conn.prepareStatement(sql3);
         pstmt.setString(1, seq);
         pstmt.setString(2, tseq);
         pstmt.executeUpdate();
         
         String jangseq=jangseq(tseq);
         String tname=tnameFromTseq(tseq);
         String name=nameFromSeq(seq);

         String words="'"+name+"'님이 ["+tname+"] 소모임을 탈퇴했습니다.";
         sql = "insert into notice values (?, ?, now())";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, jangseq);
         pstmt.setString(2, words);
         pstmt.executeUpdate();
         
      } catch(SQLException e) {
         System.out.println("[에러]: " + e.getMessage());
      } finally {
         if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
         if(conn != null) try{ conn.close(); } catch(SQLException e) {}
      }
      return flag;
   }
}