package com.cdd.base.enums;

public enum OrderType {
	Furniture("家居"), Building("建材"), Clothing("服装"), Other("其他");
	
	private String text;
	
	private OrderType(String text) {
		this.text = text;
	}
	
	public String getText() {
		return this.text;
	}
	
	public static OrderType getCodeByText(String str) {
		if (OrderType.Furniture.text.equals(str)) {
			return OrderType.Furniture;
		} else if (OrderType.Building.text.equals(str)) {
			return OrderType.Building;
		} else if (OrderType.Clothing.text.equals(str)) {
			return OrderType.Clothing;
		} else if (OrderType.Other.text.equals(str)) {
			return OrderType.Other;
		} else {
			return null;
		}
	}
	
}
