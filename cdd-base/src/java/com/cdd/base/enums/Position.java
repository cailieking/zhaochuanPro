package com.cdd.base.enums;

public enum Position {
	Inspector("总监", 3), Manager("经理", 2), Sales("业务员", 1), Service("客服", 1);
	
	private String text;
	private int level;
	
	private Position(String text, int level) {
		this.text = text;
		this.level = level;
	}
	
	public String getText() {
		return this.text;
	}
	
	public int getLevel() {
		return this.level;
	}
}
