package com.cdd.base.service

import org.springframework.web.client.RestTemplate

class SmsService {
	RestTemplate client = new RestTemplate()

	def sendMsg(String mobile, String msg) {
		
		String url = "http://106.ihuyi.cn/webservice/sms.php?method=Submit&account=cf_zhaochuan&password=zhaochuan&mobile=${mobile}&content=${msg}"

		String response = client.postForObject(url, null, String)

		if(log.debugEnabled) {
			log.debug response
		}
	}
}
