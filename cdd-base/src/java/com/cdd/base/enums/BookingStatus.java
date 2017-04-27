package com.cdd.base.enums;

public enum BookingStatus {
	
	      Invalid("已失效"),UnCheck("未审核"),NoPass("不通过"),InBooking("订舱中"),
	      ShippingSpaced("已放舱"),FailBooking("订舱失败"),InCheck("审核中");
			
			private String text;
			
			private BookingStatus(String text) {
				this.text = text;
			}
		
			public String getText() {
				return this.text;
			}
}
