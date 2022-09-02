package com.example.model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AdminDAO {
	@Autowired
	private DataSource dataSource;
	
	//게시물 개수 - 오늘
	public int boardToday() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(now(), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//게시물 개수 - 1일전
	public int boardOne() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 1 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//게시물 개수 - 2일전
	public int boardTwo() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 2 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//게시물 개수 - 3일전
	public int boardThree() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 3 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//게시물 개수 - 4일전
	public int boardFour() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 4 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//게시물 개수 - 5일전
	public int boardFive() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 5 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//게시물 개수 - 6일전
	public int boardSix() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 6 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//게시물 개수 - 7일전
	public int boardSeven() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from board where date_format(wdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 7 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 오늘
	public int reviewToday() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(now(), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 1일전
	public int reviewOne() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 1 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 2일전
	public int reviewTwo() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 2 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 3일전
	public int reviewThree() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 3 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 4일전
	public int reviewFour() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 4 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 5일전
	public int reviewFive() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 5 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 6일전
	public int reviewSix() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 6 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//리뷰 개수 - 7일전
	public int reviewSeven() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int count=0;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select count(*) from review where date_format(rdate,'%Y-%m-%d')=date_format(date_sub(now(),interval 7 day), '%Y-%m-%d')";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return count;
	}
	
	//오늘 날짜
	public String today() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(now(),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
	
	//1일전 날짜
	public String one() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(date_sub(now(),interval 1 day),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
	
	//2일전 날짜
	public String two() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(date_sub(now(),interval 2 day),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
	
	//3일전 날짜
	public String three() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(date_sub(now(),interval 3 day),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
	
	//4일전 날짜
	public String four() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(date_sub(now(),interval 4 day),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
	
	//5일전 날짜
	public String five() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(date_sub(now(),interval 5 day),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
	
	//6일전 날짜
	public String six() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(date_sub(now(),interval 6 day),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
	
	//7일전 날짜
	public String seven() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String date="";
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select date_format(date_sub(now(),interval 7 day),'%Y.%m.%d') as date";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				date=rs.getString("date");
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(rs != null) try{ rs.close(); } catch(SQLException e) {}
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return date;
	}
}