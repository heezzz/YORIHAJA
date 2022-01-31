package comment;

import java.sql.Date;

public class CommentDTO {
	
	private int cno;
	private int bno;
	private String uid;
	private String ctext;
	
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	private Date reg_date;
	
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getCtext() {
		return ctext;
	}
	public void setCtext(String ctext) {
		this.ctext = ctext;
	}
	@Override
	public String toString() {
		return "CommentDTO [cno=" + cno + ", bno=" + bno + ", uid=" + uid + ", ctext=" + ctext + ", reg_date="
				+ reg_date + "]";
	}
	
	
	
	
	

}
