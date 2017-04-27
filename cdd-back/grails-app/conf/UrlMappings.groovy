class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller:"login", action:"auth")
        "500" (controller: 'error')
		"/frontUser/addBackUser"(view: '/frontUser/addBackUser')
		"/frontUser/saveBackUser"(controller:"frontUser", action:"saveBackUser")
		"/booking/importBooking"(controller:"booking",action:"importBooking")
	}
}
