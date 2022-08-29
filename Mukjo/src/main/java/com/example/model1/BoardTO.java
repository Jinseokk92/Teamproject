package com.example.model1;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardTO{
		private String bseq;
		private String tname;
		private String tseq;
		private String seq;
		private String writer;
		private String subject;
		private String content;
		private String filename;
		private long filesize;
		private String file;
		private String wdate;
		private String hit;
		private long newFileSize;
		private String newFileName;
		private String oldFileName;
		private int cmtCount;
}
