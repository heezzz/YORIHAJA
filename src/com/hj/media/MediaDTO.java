package com.hj.media;

import java.util.Date;

public class MediaDTO {
	
	private int bno;
	private String name;
	private String pass;
	private String title;
	private String content;
	private int readcount;
	private Date date;
	private String ip;
	private String file;
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	@Override
	public String toString() {
		return "MediaDTO [bno=" + bno + ", name=" + name + ", pass=" + pass + ", title=" + title + ", content="
				+ content + ", readcount=" + readcount + ", date=" + date + ", ip=" + ip + ", file=" + file + "]";
	}
	
	
	
	
}
