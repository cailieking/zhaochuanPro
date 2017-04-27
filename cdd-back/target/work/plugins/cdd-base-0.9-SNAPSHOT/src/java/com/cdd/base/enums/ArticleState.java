package com.cdd.base.enums;

public enum ArticleState {
	Issue("发布"), Draft("草稿"), Repeal("撤销");
	
	private String text;
	
	private ArticleState(String text) {
		this.text = text;
	}
	
	public String getText() {
		return text;
	}
}
