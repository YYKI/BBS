package bbs;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;



public class Article {
	private int id;
	private int pid;
	private int rootid;
	private String title;
	private String cont;
	private Date pdate;
	private boolean leaf;
	private int grade;
	
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getRootid() {
		return rootid;
	}
	public void setRootid(int rootid) {
		this.rootid = rootid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	
	
	
	public void initFromRs(ResultSet rs) {
		try {
			setId(rs.getInt("id"));
			setPid(rs.getInt("pid"));
			setRootid(rs.getInt("rootid"));
			setTitle(rs.getString("title"));
			setLeaf(rs.getInt("leaf") == 0 ? true : false);
			setPdate(rs.getTimestamp("pdate"));
			setCont(rs.getString("cont"));
			setGrade(0);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	

}
