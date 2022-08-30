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
import org.springframework.jdbc.core.RowMapper;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private JavaMailSender mailSender;
	
	   public int forgotPw(MemberTO mto) {
		      String sql = "select * from member where email=? and name=?";
		      
		      ArrayList<MemberTO> lists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<MemberTO>(MemberTO.class),mto.getEmail(),mto.getName());
		      
		      int flag = 10;
		      
		      if(lists.size() == 0 ) {
		         flag = 0;
		         
		      } else {

		         
		      SimpleMailMessage simpleMessage = new SimpleMailMessage();
		      
		      simpleMessage.setTo(mto.getEmail());
		      simpleMessage.setSubject("[Mukjo] 임시 비밀번호");
		      
		      int index = 0;
		      char[] charSet = new char[] {
		            '0','1','2','3','4','5','6','7','8','9',
		            'a','b','c','d','e','f','g','h','i','j',
		            'k','l','m','n','o','p','q','r','s','t',
		            'u','v','w','x','y','z','A','B','C','D',
		            'E','F','G','H','I','J','K','L','M','N',
		            'O','P','Q','R','S','T','U','V','W','X',
		            'Y','Z' };
		      
		      StringBuilder sb = new StringBuilder();
		      for(int i=0; i<8; i++) {
		         index = (int) (charSet.length * Math.random());
		         sb.append(charSet[index]);
		      }
		      
		      simpleMessage.setText("비밀번호가 " + sb.toString() + "으로 변경되었습니다.");

		      
		      mailSender.send(simpleMessage);
		      
		      sql = "update member set password = ? where email = ? and name=?";
		      flag = jdbcTemplate.update(sql,sb.toString(),mto.getEmail(),mto.getName());
		      
		      }
		      
		      
		      return flag;
		   }


	public int CheckedLogin(MemberTO mto) {
		int flag = 10;

		String sql = "select seq from member where email=? and password=?";

		ArrayList<MemberTO> lists = (ArrayList<MemberTO>) jdbcTemplate.query(sql,
				new BeanPropertyRowMapper<MemberTO>(MemberTO.class), mto.getEmail(), mto.getPassword());

		if (lists.size() == 1) {
			flag = 1;
		} else {
			sql = "select seq from member where email=?";
			lists = (ArrayList<MemberTO>) jdbcTemplate.query(sql, new BeanPropertyRowMapper<MemberTO>(MemberTO.class),
					mto.getEmail());
			if (lists.size() == 1) {
				flag = 2;

			} else {
				flag = 3;
			}
		}
		return flag;
	}

	public MemberTO MemberLogin(MemberTO mto) {

		String sql = "select seq, name from member where email=? and password=?";

		mto = jdbcTemplate.queryForObject(sql, new RowMapper<MemberTO>() {
			@Override
			public MemberTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberTO to = new MemberTO();
				to.setSeq(rs.getString("seq"));
				to.setName(rs.getString("name"));
				return to;
			}
		}, mto.getEmail(), mto.getPassword());
		
		

		return mto;
	}

	public MemberTO EmailLogin(MemberTO mto) { //소셜 로그인이라 이메일만 검사
		
		String sql = "select seq, name from member where email=?";
		
		mto = jdbcTemplate.queryForObject(sql,new RowMapper<MemberTO> () {

			@Override
			public MemberTO mapRow(ResultSet rs, int rowNum) throws SQLException {
				MemberTO to = new MemberTO(); 
				to.setSeq(rs.getString("seq"));				
				to.setName(rs.getString("name"));
				return to;
			}

		},mto.getEmail());
		
		return mto;
	}
	
	//소셜로그인 후 회원가입된 이메일인지 확인
	public int EmailCheck(String email) {

		String sql="select count(*) from member where email=?";
		int count=jdbcTemplate.queryForObject(sql, new Object[] {email}, int.class);
		
		return count;
	}
	
	//전체 회원리스트 - 페이징
	public PageMemberTO memberList(PageMemberTO pageMemberTO) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int cpage=pageMemberTO.getCpage();
		int recordPerPage=pageMemberTO.getRecordPerPage();
		int blockPerPage=pageMemberTO.getBlockPerPage();

		try {
			conn=this.dataSource.getConnection();

			String sql="select seq, name, email, date_format(birth,'%y%m%d') as birth from member";
			pstmt=conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
				to.setEmail(rs.getString("email"));
				to.setBirth(rs.getString("birth"));

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
	
	//전체 회원리스트 - 페이징 + 검색
	public PageMemberTO memberListSearch(PageMemberTO pageMemberTO, String search) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int cpage=pageMemberTO.getCpage();
		int recordPerPage=pageMemberTO.getRecordPerPage();
		int blockPerPage=pageMemberTO.getBlockPerPage();

		try {
			conn=this.dataSource.getConnection();

			String sql="select seq, name, email, date_format(birth,'%y%m%d') as birth from member where name like '%"+search+"%'";
			pstmt=conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
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
				to.setEmail(rs.getString("email"));
				to.setBirth(rs.getString("birth"));

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

	//회원 추방
	public int adDeleteMember(String seq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	
		int flag=1;
		
		if (seq.equals("1")) {
			flag=50;
		} else {
			try {
				conn = this.dataSource.getConnection();
				
				String sql = "SET foreign_key_checks = 0";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
				
				sql = "delete from favorite where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from teammember where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from team where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from boardcmt where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from board where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				/*
				sql = "delete from reviewcmt where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				*/
				
				sql = "delete from review where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				String sql2 = "delete from member where seq=?";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, seq);
				if(pstmt.executeUpdate() == 1) {
					flag = 0;
				}
				
				String sql3 = "SET foreign_key_checks = 1";
				pstmt = conn.prepareStatement(sql3);
				pstmt.executeUpdate();				
			} catch(SQLException e) {
				System.out.println("[에러]: " + e.getMessage());
			} finally {
				if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
				if(conn != null) try{ conn.close(); } catch(SQLException e) {}
			}
		}
		return flag;
	}
	
	//내 정보 수정
	public MemberTO myPageModify(String seq) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		MemberTO to=new MemberTO();
		try {
			conn=this.dataSource.getConnection();
			
			String sql="select seq, email, birth, phone, password from member where seq=?;";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,seq);
			rs=pstmt.executeQuery();
			
			if (rs.next()) {
				to.setSeq(rs.getString("seq"));
				to.setEmail(rs.getString("email"));
				to.setBirth(rs.getString("birth"));
				to.setPhone(rs.getString("phone"));
				to.setPassword(rs.getString("password"));
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
	
	//myPage modify_ok
	public int myPageModifyOk(MemberTO to) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		int flag=2; 
		try {
			conn=this.dataSource.getConnection();
				
			String sql = "update member set birth=?, phone=?, password=? where seq=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,to.getBirth());
			pstmt.setString(2,to.getPhone());
			pstmt.setString(3,to.getPassword());
			pstmt.setString(4,to.getSeq());
				
			int result=pstmt.executeUpdate();
			if (result==1) {
				flag=0;
			}
		} catch (SQLException e) {
			System.out.println("[에러]:"+e.getMessage());
		} finally {
			if (conn!=null) try{conn.close();} catch(SQLException e) {}
			if (pstmt!=null) try{pstmt.close();} catch(SQLException e) {}
		}
		return flag;
	}

	// 소모임 회원 리스트
	public ArrayList<MemberTO> teamMemberList(String tseq) {
		ArrayList<MemberTO> lists = new ArrayList<MemberTO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql="select tm.tseq, tm.seq, tm.accept, t.tname, m.name, m.email, date_format(m.birth,'%y%m%d') as birth from teammember as tm join team as t on tm.tseq = t.tseq join member as m on tm.seq = m.seq where tm.tseq = ?";
			pstmt=conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			pstmt.setInt(1, Integer.parseInt(tseq));
			pstmt.executeUpdate();
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberTO to = new MemberTO();
				to.setSeq(rs.getString("tm.seq"));
				to.setName(rs.getString("m.name"));
				to.setEmail(rs.getString("m.email"));
				to.setBirth(rs.getString("birth"));
				to.setTname(rs.getString("t.tname"));
				to.setAccept(rs.getString("tm.accept"));
				
				lists.add(to);
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return lists;
	}
	
	// 소모임 회원리스트 - 페이징
	public PageTeamMemberTO teamMemberList(PageTeamMemberTO pageTeamMemberTO, String tseq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int cpage = pageTeamMemberTO.getCpage();
		int recordPerPage = pageTeamMemberTO.getRecordPerPage();
		int blockPerPage = pageTeamMemberTO.getBlockPerPage();

		try {
			conn = this.dataSource.getConnection();
			String sql="select tm.tseq, tm.seq, tm.accept, t.tname, m.name, m.email, date_format(m.birth,'%y%m%d') as birth from teammember as tm join team as t on tm.tseq = t.tseq join member as m on tm.seq = m.seq where tm.tseq = ?";
			pstmt=conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			pstmt.setInt(1, Integer.parseInt(tseq));
			pstmt.executeUpdate();
			
			rs = pstmt.executeQuery();
			
			rs.last(); //읽기 커서를 맨 마지막 행으로 이동
			pageTeamMemberTO.setTotalRecord(rs.getRow());
			rs.beforeFirst(); //읽기 커서를 맨 첫행으로 이동
			
			//전체 페이지
			pageTeamMemberTO.setTotalPage((pageTeamMemberTO.getTotalRecord()-1)/recordPerPage+1);
			//시작번호 - 읽을 데이터 위치 지정
			int skip=(cpage-1)*recordPerPage;
			if (skip!=0) rs.absolute(skip); //커서를 주어진 행으로 이동
				ArrayList<MemberTO> teamMemberLists = new ArrayList<MemberTO>();
			for (int i=0;i<recordPerPage && rs.next();i++) {
				MemberTO to = new MemberTO();
				to.setSeq(rs.getString("tm.seq"));
				to.setName(rs.getString("m.name"));
				to.setEmail(rs.getString("m.email"));
				to.setBirth(rs.getString("birth"));
				to.setTname(rs.getString("t.tname"));
				to.setAccept(rs.getString("tm.accept"));
				
				teamMemberLists.add(to);
			}
			pageTeamMemberTO.setTeamMemberLists(teamMemberLists);
			pageTeamMemberTO.setStartBlock((cpage-1)/blockPerPage*blockPerPage+1);
			pageTeamMemberTO.setEndBlock((cpage-1)/blockPerPage*blockPerPage+blockPerPage);
			if (pageTeamMemberTO.getEndBlock()>=pageTeamMemberTO.getTotalPage()) {
				pageTeamMemberTO.setEndBlock(pageTeamMemberTO.getTotalPage());
			}
		} catch (SQLException e) {
			System.out.println("[에러]:"+e.getMessage());
		} finally {
			if (conn!=null) try {conn.close();} catch (SQLException e) {}
			if (pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
			if (rs!=null) try {rs.close();} catch (SQLException e) {}
		}
		return pageTeamMemberTO;
	}
	
//회원 탈퇴
	public int myPage_info_delete(String seq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	
		int flag=1;
		
		if (seq.equals("1")) {
			flag=50;
		} else {
			try {
				conn = this.dataSource.getConnection();
				
				String sql = "SET foreign_key_checks = 0";
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
				
				sql = "delete from favorite where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from teammember where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from team where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from boardcmt where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				sql = "delete from board where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				/*
				sql = "delete from reviewcmt where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				*/
				
				sql = "delete from review where seq=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, seq);
				pstmt.executeUpdate();
				
				String sql3 = "SET foreign_key_checks = 1";
				pstmt = conn.prepareStatement(sql3);
				pstmt.executeUpdate();
				
				String sql2 = "delete from member where seq=?";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, seq);
				if(pstmt.executeUpdate() == 1) {
					flag = 0;
				}
			} catch(SQLException e) {
				System.out.println("[에러]: " + e.getMessage());
			} finally {
				if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
				if(conn != null) try{ conn.close(); } catch(SQLException e) {}
			}
		}
		return flag;
	}
}
