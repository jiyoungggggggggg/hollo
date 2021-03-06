package com.sp.app.dress;

import java.util.List;

public class Dress {
	private int num;
	private String userId;
	private String userName;
	private int listNum;
	private String subject;
	private String content;
	private String hashtag;
	private String register_date;
	private int hitCount;
	private	List<String> tags;
	
	private int replyCount;
	
	private int DressLikeCount;
	private String saveFilename;
	private String bestlist;
	
	private int thumbColor;
	
	
	public int getThumbColor() {
		return thumbColor;
	}
	public void setThumbColor(int thumbColor) {
		this.thumbColor = thumbColor;
	}
	public String getBestlist() {
		return bestlist;
	}
	public void setBestlist(String bestlist) {
		this.bestlist = bestlist;
	}
	public int getDressLikeCount() {
		return DressLikeCount;
	}
	public void setDressLikeCount(int dressLikeCount) {
		DressLikeCount = dressLikeCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public List<String> getTags() {
		return tags;
	}
	public void setTags(List<String> tags) {
		this.tags = tags;
	}
		
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getUserName() {
	return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHashtag() {
		return hashtag;
	}
	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}
	public String getRegister_date() {
		return register_date;
	}
	public void setRegister_date(String register_date) {
		this.register_date = register_date;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
}
