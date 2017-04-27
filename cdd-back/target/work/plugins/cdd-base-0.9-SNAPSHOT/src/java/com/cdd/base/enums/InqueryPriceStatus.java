package com.cdd.base.enums;

public enum InqueryPriceStatus {
	
			NotAccepted("未受理"),Acceptance("受理中"),Accepted("已完成"),Revoked("已撤销");
			
			private String text;
			
			private InqueryPriceStatus(String text) {
				this.text = text;
			}
		
			public String getText() {
				return this.text;
			}
}
