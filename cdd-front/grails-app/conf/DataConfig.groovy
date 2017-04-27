ceo {
	mail = 'office@zhao-chuan.com'
}

environments {
	development {
		domain = 'localhost:8070'
	}
	
	uat {
		domain = '120.24.19.203:7070'
	}
	
	production {
		superadmin.password = 'r00tadmin'
		domain = 'www.zhao-chuan.com:8080'
	}
}