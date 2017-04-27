logInfo { rootdir = 'logs/' }

appInfo {
	rootPath = "web-app/"
}

grails {
	mail {
		host = "smtp.mxhichina.com"
//		host = "112.74.81.205"
		port = 25
//		username = "admin@chuanduoduo.com"
		username = "houtai@zhao-chuan.com"
		password = "123456Aa"
//		props = ["mail.smtp.socketFactory.class": "javax.net.ssl.SSLSocketFactory",
//		         "mail.smtp.auth": "true",
//		         "mail.smtp.socketFactory.port": "465",
//		         "mail.smtp.port": "465"]
	}
}

oss {
	endpointDomain = 'oss-cn-shenzhen.aliyuncs.com'
	apikey = 'PUOVv7LJhxe0FgVx'
	password = 'FJH3sNeZx30iFDmxpxeHPwUU3p3SwE'
}


environments {
	development {
		oss {
			publicbucket = 'cdd-public-dev'
		}
	}
	
	uat {
		oss {
			publicbucket = 'cdd-public-uat'
		}
		logInfo { rootdir = '/data/logs/' }
		appInfo {
			rootPath = "/root/apps/"
		}
	}

	production {
		logInfo { rootdir = '/root/logs/' }
		appInfo {
			rootPath = "/root/apps/"
		}
		oss {
			publicbucket = 'cdd-public-prod'
		}
	}
}