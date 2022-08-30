package com.example.model1;

import java.util.ArrayList;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardListTO {
	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalRecord;
	private int startBlock;
	private int endBlock;
	private String tseq;
	
	private ArrayList<BoardTO> boardLists;
	
	public BoardListTO() {
		// TODO Auto-generated constructor stub
		this.cpage = 1;
		this.recordPerPage = 20;
		this.blockPerPage = 5;
		this.totalPage = 1;
		this.totalRecord = 0;
	}
	
	
}
