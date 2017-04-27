package com.cdd.base.enums;

public enum CargoBoxType {
	GP20("20GP"), GP40("40GP"), HQ40("40HQ"), HQ45("45HQ");
//	, RF20("20RF"), 
//	RF40("40RF"), OT20("20OT"), OT40("40OT"), FR20("20RF"), TK20("20TK"), 
//	SP20("20SP"), SP40("40SP"), RH40("40RH");
	
	private String text;
	
	CargoBoxType(String text) {
		this.text = text;
	}
	
	public String getText() {
		return this.text;
	}
	
	public static CargoBoxType getCodeByText(String str) {
		if (CargoBoxType.GP20.text.equals(str)) {
			return CargoBoxType.GP20;
		} else if (CargoBoxType.GP40.text.equals(str)) {
			return CargoBoxType.GP40;
		} else if (CargoBoxType.HQ40.text.equals(str)) {
			return CargoBoxType.HQ40;
		} else if (CargoBoxType.HQ45.text.equals(str)) {
			return CargoBoxType.HQ45;
		} else {
			return null;
		}
	}
}
