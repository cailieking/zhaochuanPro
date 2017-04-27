import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.security.access.vote.RoleVoter

import com.cdd.back.service.dbupdator.SuperAdminSettingService

class BootStrap {

	GrailsApplication grailsApplication

	SuperAdminSettingService superAdminSettingService

	def init = { servletContext ->
		def ctx = grailsApplication.mainContext
		ctx.getBean(RoleVoter).rolePrefix = 'AUTH_'

		superAdminSettingService.update()
	}
	def destroy = {
	}
}
