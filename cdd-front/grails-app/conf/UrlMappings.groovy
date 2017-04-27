
class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?(.$format)?"{ constraints { // apply constraints here
			} }

		"/"("/index")
		
		"/index" ("/index.html")
		
		"/new" ("/new.html")
		
//		"/"(view:"/index") 
//		
//		"/index" (view:"/index")
		
		"/register"(view: '/register/step1')

		"/register/step1"(view: '/register/step1')

		"/register/step2"(view: '/register/step2')

		"/register/step3"(view: '/register/step3')
		
		"/register/registerMobile"(view: '/register/registerMobile')
		
		"/register/registerMobile2"(view: '/register/registerMobile2')
		
		"/register/registerMobile3"(view: '/register/registerMobile3')
		
		"/forgetpass/step1"(view: '/forgetpass/step1')
		
		"/forgetpass/step2"(view: '/forgetpass/step2')

		"/forgetpass/step3"(view: '/forgetpass/step3')
				
	//	"/myLogin" (controller: 'myLogin', action: 'auth')

		"/publish/findcargo"(controller: 'publish', action: 'pubship')

		"/publish/findship"(controller: 'publish', action: 'pubcargo')
		
		"/publish/pubship"(view: '/publish/pubship')
		
		"/publish/pubcargo"(view: '/publish/pubcargo')
		
		"/member"(view: '/member/index')
		
		"/member/cargo"(view: '/member/cargo')
		
		"/member/ship"(view: '/member/ship')
		
		"/member/uploadcargo"(view: '/member/uploadcargo')
		
		"/member/uploadship"(view: '/member/uploadship')
		
		"/member/cargolist"(view: '/member/cargolist')
		
		"/member/bookingform"(view: '/member/bookingform')
		
		"/member/shiplist"(view: '/member/shiplist')
		
		"/member/shipcargolist"(view: '/member/shipcargolist')
		
		"/member/account"(view: '/member/account')
		
		"/member/changepassword"(view: '/member/changepassword')
		
		"/member/certificate"(view: '/member/certificate')

		"/cargo"(view: '/cargo/index')
		
		"/ships"(view: '/ships/index')
		
		"/building"(view: '/building/index')
		
		"/company" (view: '/company/index')
		
		"/special" (controller: 'index' ,action:'dataInfoSix')
		
		"/certificate/index" (view: '/certificate/index')
		"/enterpriseDirectory" (controller: 'enterpriseDirectory' ,action:'list')
	}
}



