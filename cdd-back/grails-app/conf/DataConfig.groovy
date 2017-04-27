appInfo {
	title='找船网后台管理系统'
	year='2015'
}

superadmin {
	username = 'admin3'
	password = 'rootadmin'
	email = 'admin2@zhao-chuan.com'
	firstname = '系统管理员'
	mobile = '18675528657'
	sex = 'male'
	role {
		name = '系统管理员'
		description = '最高级用户，拥有所有权限'
	}
}

environments {
	development {
		domain = 'localhost:8070'
	}
	
	uat {
		domain = '112.74.81.179:7070'
	}
	
	production {
		superadmin.password = 'r00tadmin'
		domain = 'www.chuandd.com:8080'
	}
}
