package com.cdd.front.authentication

import java.util.Date;

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest

import com.cdd.base.domain.BackUser;
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.LoginLog
import com.cdd.front.util.WebServletUtil

import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;

import com.cdd.front.controller.IndexController;
import grails.converters.JSON
class UsersListener  implements HttpSessionBindingListener {  
	
int uid;  
public int getUid() {  
   return uid;  
}  
public void setUid(int uid) {  
   this.uid = uid;  
}  
RestTemplate client = new RestTemplate()
public void valueBound(HttpSessionBindingEvent arg0) {  
	IndexController indexController = new IndexController()
	def ip = indexController.getIp()
	//String url = "http://ip.taobao.com/service/getIpInfo.php?ip=113.99.102.239"
	String url = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip="+ip
	def jsonData = client.postForObject(url, null, String.class)
	def data = JSON.parse(jsonData)
	def city = data.getAt("city")
	println city
	println (uid+"上线")
	FrontUser user = FrontUser.get(uid);
	user.loginTime = new Date()
	user.isOnline = true;
	user.ip=ip
	LoginLog loginLog = new LoginLog()
	loginLog.username = user.username
	loginLog.loginTime = new Date()
	loginLog.ip = ip
	loginLog.city = city
	println user.ip
	loginLog.save();
	user.save();
}  
public void valueUnbound(HttpSessionBindingEvent arg0) {  
	println (uid+"下线")
   FrontUser user = FrontUser.get(uid);
   
   //LoginLog loginLog = LoginLog.findByUsername(user.username)
   def c = LoginLog.createCriteria()
   def results = c{
	   eq("username", user.username)
   }
   
   LoginLog loginLog = results.last()
   	loginLog.loginOutTime = new Date()
	user.isOnline = false;
	user.loginOutTime = new Date()
	
	loginLog.save();
	user.save();
}  
}  