package com.example.model1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FoodDAO {
	

	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	
	public static JSONObject jsonParser(String content) {
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = null;
		
		
		try {
			Object obj = parser.parse(content);
			jsonObj = (JSONObject)obj;
			

		} catch(Exception e) {
			e.printStackTrace();
		}
		return jsonObj;
	}

	public  ArrayList<FoodTO> crawler(String search, String tseq) {
		
		
		
		
		
		
		ArrayList<FoodTO> lists = new ArrayList<FoodTO>();
		Document doc = null;

		try {
			if(search == null) {
				doc = Jsoup.connect("https://m.map.naver.com/search2/search.nhn?query=강남역 맛집&sm=hty&style=v5").get();
			} else {
				doc = Jsoup.connect("https://m.map.naver.com/search2/search.nhn?query=" + search + " 맛집&sm=hty&style=v5").get();
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		Elements scripts = doc.getElementsByTag("script");

		String a = null;

		for(Element element : scripts) {
			if(element.data().contains("var searchResult")) {
				Pattern pattern = Pattern.compile(".*var searchResult = ([^;]*);");
				Matcher matcher = pattern.matcher(element.data());
				if(matcher.find()) {
					a = matcher.group(1);
					break;
				} else {
					System.err.println("No match found!");
				}
				break;
			}
		}
		
		
		
		String sql = "select round(avg(star),2) from review where rest = ? and tseq = ?";
		
		for (Object i : (ArrayList<Object>)jsonParser(jsonParser(a).get("site").toString()).get("list")){
			FoodTO to = new FoodTO();
			to.setId(jsonParser(i.toString()).get("id").toString().replaceAll("[^0-9]",""));
			to.setName(jsonParser(i.toString()).get("name").toString());
			to.setCategory(jsonParser(i.toString()).get("category").toString());
			to.setLatitude(jsonParser(i.toString()).get("y").toString());
			to.setLongitude(jsonParser(i.toString()).get("x").toString());
			to.setThumurl(jsonParser(i.toString()).get("thumUrl").toString());			
			to.setAvgStar(jdbcTemplate.queryForObject(sql, String.class,to.getId(),tseq));
			
			
			
			lists.add(to);
		}
		
		
		return lists;
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
	
	// 평점 평균
	public String avg(String rest, String tseq) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String avg="";
		try {
			conn = this.dataSource.getConnection();
			
			String sql = "select round(avg(star),2) as avg from review where rest = ? and tseq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rest);
			pstmt.setString(2, tseq);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				avg=rs.getString("avg");
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]:"+e.getMessage());
		} finally {
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			if(rs != null) try { rs.close(); } catch(SQLException e) {}
		}
		return avg;
	}
}
