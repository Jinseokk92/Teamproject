package com.example.model1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SignUpDAO {
	@Autowired
	private DataSource dataSource;
	
	public void SignUp() {
	}
	
	public int SignUpOk(SignUpTO to) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		int flag = 1;
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "insert into member values (0, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to.getEmail());
			pstmt.setString(2, to.getPassword());
			pstmt.setString(3, to.getName());
			pstmt.setString(4, to.getPhone());
			pstmt.setString(5, to.getBirth());
			
			if(pstmt.executeUpdate() == 1) {
				flag = 0;
			}
		} catch(SQLException e) {
			System.out.println("[에러]: " + e.getMessage());
		} finally {
			if(pstmt != null) try{ pstmt.close(); } catch(SQLException e) {}
			if(conn != null) try{ conn.close(); } catch(SQLException e) {}
		}
		return flag;
	}
	
	// 메일 주소
	public boolean CheckMail(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select email from member where email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			// 메일 주소가 있다면 true
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
}