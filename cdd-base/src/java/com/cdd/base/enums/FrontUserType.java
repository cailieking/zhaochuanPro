package com.cdd.base.enums;

public enum FrontUserType {
	Agent("货代"), Cargo("货主");

	private String text;

	private FrontUserType(String text) {
		this.text = text;
	}

	public String getText() {
		return text;
	}
	
	public static FrontUserType getCodeByText(String str) {
		if (FrontUserType.Agent.text.equals(str)) {
			return FrontUserType.Agent;
		} else if (FrontUserType.Cargo.text.equals(str)) {
			return FrontUserType.Cargo;
		} else {
			return null;
		}
	}
}
