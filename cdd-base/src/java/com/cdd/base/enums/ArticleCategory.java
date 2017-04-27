package com.cdd.base.enums;

public enum ArticleCategory {
	Tweet("特推"), Stick("置顶"), Draft("草稿");
	
	private String text;
	
	private ArticleCategory(String text) {
		this.text = text;
	}
	
	public String getText() {
		return text;
	}
}



