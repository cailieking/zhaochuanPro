package com.cdd.base.enums;

public enum RouteCategory {
	MeiJia("美加线"), OuDi("欧地线"), FeiZhou("非洲线"), ZhongNanMei("中南美线"), YinBa("中东印巴红海线"), YuanDong("日韩港澳台远东线"), DongNanYa(
			"东南亚线"), AoXin("澳新线");

	private String text;

	private RouteCategory(String text) {
		this.text = text;
	}

	public String getText() {
		return text;
	}

	public static RouteCategory getCodeByText(String str) {
		if (RouteCategory.MeiJia.text.equals(str)) {
			return RouteCategory.MeiJia;
		} else if (RouteCategory.OuDi.text.equals(str)) {
			return RouteCategory.OuDi;
		} else if (RouteCategory.FeiZhou.text.equals(str)) {
			return RouteCategory.FeiZhou;
		} else if (RouteCategory.ZhongNanMei.text.equals(str)) {
			return RouteCategory.ZhongNanMei;
		} else if (RouteCategory.YinBa.text.equals(str)) {
			return RouteCategory.YinBa;
		} else if (RouteCategory.YuanDong.text.equals(str)) {
			return RouteCategory.YuanDong;
		} else if (RouteCategory.DongNanYa.text.equals(str)) {
			return RouteCategory.DongNanYa;
		} else if (RouteCategory.AoXin.text.equals(str)) {
			return RouteCategory.AoXin;
		} else {
			return null;
		}
	}
}
