package com.cdd.base.enums;

public enum ArticleType {
	ForeignTrade("外贸"), Transportation("运输"), Company("公司");
	
	private String text;
	
	private ArticleType(String text) {
		this.text = text;
	}
	
	public String getText() {
		return text;
	}
}



