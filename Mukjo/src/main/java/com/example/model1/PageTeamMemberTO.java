package com.example.model1;

import java.util.ArrayList;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageTeamMemberTO {
	private int cpage;
	private int recordPerPage;
	private int blockPerPage;
	private int totalPage;
	private int totalRecord;
	private int startBlock;
	private int endBlock;
	private ArrayList<MemberTO> teamMemberLists;

	public PageTeamMemberTO() {
		this.cpage=1;
		this.recordPerPage=20;
		this.blockPerPage=5;
		this.totalPage=1;
		this.totalRecord=0;
	}

}
