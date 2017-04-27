package com.cdd.base.enums;

public enum Status {
	UnVerify("未审核"),InVerify("审核中"),VerifyPassed("审核通过"), VerifyFailed("审核未通过"),Expired("已过期"),Revoked("已撤销"),Closed("已关闭");
	private String text;

	private Status(String text) {
		this.text = text;
	}
	

	public String getText() {
		return this.text;
	}
}
