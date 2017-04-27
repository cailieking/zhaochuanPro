package com.cdd.base.enums;

public enum Sex {
	female("女"), male("男");

	private String text;

	private Sex(String text) {
		this.text = text;
	}

	public String getText() {
		return this.text;
	}

	public static Sex getCodeByText(String text) {
		if (text.equals(female.text)) {
			return female;
		} else if (text.equals(male.text)) {
			return male;
		} else {
			return null;
		}
	}
}
