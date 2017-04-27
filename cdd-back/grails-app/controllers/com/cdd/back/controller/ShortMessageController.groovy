package com.cdd.back.controller

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.sms.model.v20160927.SingleSendSmsRequest;
import com.aliyuncs.sms.model.v20160927.SingleSendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import grails.converters.JSON

class ShortMessageController {
	def sendPage(){

		render view :"/shortMessage/sendPage"
	}
	def send(){
		
		println params
//SMS_53260018
//SMS_53920311	
		String code = params.code
		String mobiles = params.mobiles
			try {
				IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", "PUOVv7LJhxe0FgVx", "FJH3sNeZx30iFDmxpxeHPwUU3p3SwE");
				DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", "Sms",  "sms.aliyuncs.com");
				IAcsClient client = new DefaultAcsClient(profile);
				SingleSendSmsRequest request = new SingleSendSmsRequest();
				request.setSignName("找船网");//控制台创建的签名名称
				request.setTemplateCode(code);//控制台创建的模板CODE
				request.setParamString("{\"customer\":\"用户\"}");//短信模板中的变量；数字需要转换为字符串；个人用户每个变量长度必须小于15个字符。"
				//request.setParamString("{}");
				request.setRecNum(mobiles);//接收号码
				SingleSendSmsResponse httpResponse = client.getAcsResponse(request);
				println httpResponse
			} catch (ServerException e) {
				e.printStackTrace();
			}
			catch (ClientException e) {
				e.printStackTrace();
			}
		
		render ([status: "ok"] as JSON)
	}
}
