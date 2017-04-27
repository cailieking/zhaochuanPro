import grails.plugin.springsecurity.SecurityConfigType

import com.cdd.base.domain.BackUser
import com.cdd.base.domain.Requestmap
import com.cdd.back.domain.PersistentSchema
import com.cdd.base.constant.SpringSecurityConstant
//import com.lhx.base.domain.UserRole

grails.plugin.springsecurity.userLookup.userDomainClassName = BackUser.class.name

grails.plugin.springsecurity.apf.postOnly = false
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.logout.filterProcessesUrl = '/logout'
grails.plugin.springsecurity.password.algorithm='SHA-512'
grails.plugin.springsecurity.rememberMe.persistent = true
grails.plugin.springsecurity.rememberMe.persistentToken.domainClassName = PersistentSchema.class.name
//grails.plugin.springsecurity.logout.handlerNames = [
//	'rememberMeServices'
//]
grails.plugin.springsecurity.providerNames = [
	'detailsAuthenticationProvider',
	'rememberMeAuthenticationProvider',
	'anonymousAuthenticationProvider', 
]

grails.plugin.springsecurity.securityConfigType = SecurityConfigType.Requestmap
grails.plugin.springsecurity.requestMap.className = Requestmap.class.name
grails.plugin.springsecurity.requestMap.configAttributeField = 'authority'
grails.plugin.springsecurity.requestMap.httpMethodField = 'method'

//grails.plugin.springsecurity.rejectIfNoRule = true
//grails.plugin.springsecurity.fii.rejectPublicInvocations = false

grails.plugin.springsecurity.successHandler.defaultTargetUrl=SpringSecurityConstant.DEFAULT_ENTRY_POINT_URI
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true
grails.plugin.springsecurity.dao.reflectionSaltSourceProperty = 'salt'
//grails.plugin.springsecurity.useSessionFixationPrevention = false

