package com.example.model1;

import java.io.File;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public ArrayList<ReviewTO> reviewLists(ReviewTO rto) {
		
		
		String sql = "select rseq,floor(star) as star,member.name as writer,rcontent, review.seq from review inner join member on review.seq = member.seq where rest = ? and tseq = ? order by rseq desc";
		
		ArrayList<ReviewTO> lists = (ArrayList)jdbcTemplate.query(sql, new BeanPropertyRowMapper<ReviewTO>(ReviewTO.class),rto.getRest(),rto.getTseq());
		
		return lists;
	}
	
	public int reviewWrite(ReviewTO rto) {
		String sql = "insert into review values ( 0, ?, ?, ?, ?, ?, now())";

		int flag = jdbcTemplate.update(sql,rto.getTseq(),rto.getSeq(),rto.getRest(),rto.getRcontent(),rto.getStar());

		return flag;
	}
	
	public int reviewDelete(ReviewTO rto) {

		
		int flag = 2;
		
		String sql = "delete from review where rseq=?";
		flag = jdbcTemplate.update(sql,rto.getRseq());

		
		return flag;

		
	}
	

	
	
	
}
