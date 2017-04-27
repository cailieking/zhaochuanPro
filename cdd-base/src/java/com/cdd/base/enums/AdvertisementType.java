package com.cdd.base.enums;

public enum AdvertisementType {
	CargoShip("货代"), Furniture("家居"), Building("建材"), Clothing("服装"), Other("其他"),
	ShipLeft("运价信息左侧"), ShipBottom("运价信息底部"), OrderLeft("货盘信息左侧"), OrderBottom("货盘信息底部"), Corporation("合作伙伴"),
	ShipQueryUp("运价查询上部"), SpecialUp("限时特价上部"), EnterpriseUp("企业名录上部"), ShipDateUp("船期查询上部"), ToolsUp("实用工具上部"),
	MemberRight("会员中心首页右侧"), ForeignTradeRight("外贸资讯右侧"), TransportationRight("运输资讯右侧"), CompanyRight("公司资讯右侧");
	
	private String text;
	
	private AdvertisementType(String text) {
		this.text = text;
	}
	
	public String getText() {
		return text;
	}
}
