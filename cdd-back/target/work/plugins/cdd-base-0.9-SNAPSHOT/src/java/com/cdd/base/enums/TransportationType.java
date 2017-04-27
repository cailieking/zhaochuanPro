package com.cdd.base.enums;

public enum TransportationType {
	Whole("整箱"), Together("拼箱");
	
	private String text;
	
	private TransportationType(String text) {
		this.text = text;
	}
	
	public String getText() {
		return text;
	}
	
	public static TransportationType getCodeByText(String str) {
		if (TransportationType.Whole.text.equals(str)) {
			return TransportationType.Whole;
		} else if (TransportationType.Together.text.equals(str)) {
			return TransportationType.Together;
		} else {
			return null;
		}
	}
	
}
