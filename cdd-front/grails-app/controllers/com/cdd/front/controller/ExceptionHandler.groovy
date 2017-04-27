package com.cdd.front.controller

trait ExceptionHandler {
	Random r = new Random()
	
	def handleException(Exception e) {
		def refid = r.nextInt(999999)
		log.info "Refid=${refid}", e
		render view: '/error', model: [refid: refid]
	}
}
