package com.cdd.base.enums;

public enum RouteType {
	Start("始发港"), End("目的港");

	private String text;

	private RouteType(String text) {
		this.text = text;
	}

	public String getText() {
		return text;
	}
	
	public static RouteType getCodeByText(String str) {
		if (RouteType.Start.text.equals(str)) {
			return RouteType.Start;
		} else if (RouteType.End.text.equals(str)) {
			return RouteType.End;
		} else {
			return null;
		}
	}
}
