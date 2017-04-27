package com.cdd.base.enums;

public enum OrderStatus {
	UnTrade("交易未撮合"), InTrade("交易撮合中"), TradeSuccess("交易撮合成功"), CloseTrade("交易关闭"), CertUploaded("凭证待审核"), 
	CertInVerify("凭证审核中"), CertUnupload("凭证未上传"), CertPassed("交易完成"), CertFailed("凭证审核不通过");

	private String text;

	private OrderStatus(String text) {
		this.text = text;
	}

	public String getText() {
		return this.text;
	}
}
