package com.cdd.base.enums;

public enum Provinces {
	
	BEJ("北京", "A-G", 110000), 
	ANH("安徽", "A-G", 340000), 
	FUJ("福建", "A-G", 350000), 
	GUD("广东", "A-G", 440000), 
	GUX("广西", "A-G", 450000), 
	CHQ("重庆", "A-G", 500000), 
	GUZ("贵州", "A-G", 520000), 
	GAS("甘肃", "A-G", 620000), 
	AOM("澳门", "A-G", 820000),
	
	HEB("河北", "H-J", 130000),
	JIL("吉林", "H-J", 220000), 
	HLJ("黑龙江", "H-J", 230000), 
	JIS("江苏", "H-J", 320000), 
	JIX("江西", "H-J", 360000), 
	HEN("河南", "H-J", 410000), 
	HUB("湖北", "H-J", 420000), 
	HUN("湖南", "H-J", 430000), 
	HAN("海南", "H-J", 460000),
	
	SHX("山西", "L-S", 140000), 
	NMG("内蒙古", "L-S", 150000), 
	LIN("辽宁", "L-S", 210000),  
	SHH("上海", "L-S", 310000),  
	SHD("山东", "L-S", 370000),  
	SIC("四川", "L-S", 510000),  
	SXI("陕西", "L-S", 610000),  
	QIH("青海", "L-S", 630000),  
	NIX("宁夏", "L-S", 640000), 
	
	TIJ("天津", "T-Z", 120000), 
	ZHJ("浙江", "T-Z", 330000),  
	YUN("云南", "T-Z", 530000),  
	XIZ("西藏", "T-Z", 540000),  
	XIJ("新疆", "T-Z", 650000),  
	XIG("香港", "T-Z", 810000);
	
	private String desc;
	private String firstLetter;
	private int code;
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getFirstLetter() {
		return firstLetter;
	}

	public void setFirstLetter(String firstLetter) {
		this.firstLetter = firstLetter;
	}

	Provinces(String desc, String firstLetter, int code){
		this.desc = desc;
		this.firstLetter = firstLetter;
		this.code = code;
	}
	
}
