package com.cdd.back.schedule

import grails.plugin.mail.MailService
import groovy.util.logging.Slf4j

import java.text.SimpleDateFormat

import org.springframework.web.client.RestTemplate;

import com.cdd.back.cache.JobCache
import com.cdd.base.domain.AccessLog
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.LoginLog
import com.cdd.base.domain.Role
import com.cdd.base.service.common.CRUDService
import grails.converters.JSON
import org.apache.commons.lang.StringUtils
@Slf4j
class AccessLogJob {
	static triggers = {
		cron name: 'AccessLogTrigger', cronExpression: "0 0 17 * * ?"
	}
	RestTemplate client = new RestTemplate()
	CRUDService CRUDService
	def grailsApplication

	def execute(){
		InetAddress addr = InetAddress.getLocalHost();
		def ip=addr.getHostAddress();//获得本机IP
		if(ip =="10.116.49.232"){
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd')
		SimpleDateFormat sdf2 = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
		Date date = new Date()
		def today = sdf.format(date)
		println today
		//def filePath ="E:\\tomcat-front\\logs\\localhost_access_log."+today+".txt"//windows
		def filePath ="/opt/tomcat-front/logs/localhost_access_log."+today+".txt"//linux
		File file = new File(filePath);
		if (file.isFile() && file.exists()) {
			try {
				InputStreamReader read = new InputStreamReader(new FileInputStream(file), "UTF-8");
				BufferedReader reader = new BufferedReader(read);
				String line;
				try {
									  //循环，每次读一行
					while ((line = reader.readLine()) != null) {
						AccessLog accessLog = new AccessLog()
						if(line.split("&&&")[0].size()<3){
							continue
						}else{
							accessLog.ip = line.split("&&&")[0]
						}
						String url = "http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip="+accessLog.ip
						def jsonData = client.postForObject(url, null, String.class)
						def data = JSON.parse(jsonData)
						accessLog.city = data.getAt("city")
						accessLog.url =StringUtils.substringBetween(line.split("&&&")[1],"GET","HTTP");
						
						
						def username = LoginLog.findByIp(accessLog.ip)?.username
						if(username){
							accessLog.visitor = username
							accessLog.type = "登录用户"
						}else{
							if(line.split("&&&")[2].indexOf("Baiduspider")!=-1){
								accessLog.visitor = "百度蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("360Spider")!=-1){
								accessLog.visitor = "360蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("bingbot")!=-1){
								accessLog.visitor = "bing蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("Sogou")!=-1){
								accessLog.visitor = "Sogou蜘蛛"
								accessLog.type = "搜索引擎"
							}else if(line.split("&&&")[2].indexOf("Googlebot")!=-1){
								accessLog.visitor = "Google蜘蛛"
								accessLog.type = "搜索引擎"
							}
							else{
								accessLog.visitor = "游客"
								accessLog.type = "游客"
							}
						}
						def time = line.split("&&&")[3]
						accessLog.time = sdf2.parse(time)
						accessLog.createBy = "cailie"
						accessLog.updateBy = "cailie"
						if( !accessLog.save() ) {   accessLog.errors.each {        println it   }}
						accessLog.save(flush:true);
					}
					reader.close();
					read.close();
				} catch (IOException e) {
					e.printStackTrace();
				}

			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}
	}
  }
}
