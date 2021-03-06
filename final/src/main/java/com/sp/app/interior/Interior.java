package com.sp.app.interior;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Interior {
	private int num;
	private int filenum;
	private String userId;
	private String subject;
	private String content;
	private String category;
	private String register_date;
	private int hitCount;
	private String saveFilename;
	private int mainnum;
	private String mainImg;
	private int interiorLikeCount;
	private int interiorZzimCount;
	private String replycontent;
	private String replyuserId;
	private int replyCount;
	private String profileMsg;
	
	// 프로 필 이미지 들 
	private String profileImg;
	private String replyProfileImg;
	
	private List<MultipartFile> upload;
	
	private MultipartFile mainUpload; 
	
	
	
	
	
	
	
	
	public String getProfileMsg() {
		return profileMsg;
	}
	
	public void setProfileMsg(String profileMsg) {
		this.profileMsg = profileMsg;
	}
	public int getInteriorZzimCount() {
		return interiorZzimCount;
	}
	
	public void setInteriorZzimCount(int interiorZzimCount) {
		this.interiorZzimCount = interiorZzimCount;
	}
	public String getProfileImg() {
		return profileImg;
	}
	
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	
	public String getReplyProfileImg() {
		return replyProfileImg;
	}
	
	public void setReplyProfileImg(String replyProfileImg) {
		this.replyProfileImg = replyProfileImg;
	}
	public int getReplyCount() {
		return replyCount;
	}
	
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public String getReplyuserId() {
		return replyuserId;
	}
	
	public void setReplyuserId(String replyuserId) {
		this.replyuserId = replyuserId;
	}
	public String getReplycontent() {
		return replycontent;
	}
	
	public void setReplycontent(String replycontent) {
		this.replycontent = replycontent;
	}
	public int getInteriorLikeCount() {
		return interiorLikeCount;
	}
	
	public void setInteriorLikeCount(int interiorLikeCount) {
		this.interiorLikeCount = interiorLikeCount;
	}
	

	public String getMainImg() {
		return mainImg;
	}

	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}

	public MultipartFile getMainUpload() {
		return mainUpload;
	}

	public void setMainUpload(MultipartFile mainUpload) {
		this.mainUpload = mainUpload;
	}

	public String getSaveFilename() {
	
	
		return saveFilename;
	}
	
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	
	

	
	
	
	public int getMainnum() {
		return mainnum;
	}

	public void setMainnum(int mainnum) {
		this.mainnum = mainnum;
	}

	public int getFilenum() {
		return filenum;
	}
	public void setFilenum(int filenum) {
		this.filenum = filenum;
	}
	private String userName;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
