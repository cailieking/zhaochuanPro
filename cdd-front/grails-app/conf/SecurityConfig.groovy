import com.cdd.base.domain.FrontUser


grails.plugin.springsecurity.userLookup.userDomainClassName = FrontUser.class.name
grails.plugin.springsecurity.apf.postOnly = false
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.logout.filterProcessesUrl = '/logout'
//grails.plugin.springsecurity.apf.filterProcessesUrl = "/myLogin"
grails.plugin.springsecurity.password.algorithm='SHA-512'
grails.plugin.springsecurity.auth.loginFormUrl = '/myLogin/auth'
grails.plugin.springsecurity.providerNames = [
	'detailsAuthenticationProvider',
	'rememberMeAuthenticationProvider',
	'anonymousAuthenticationProvider',
]
  
//grails.plugin.springsecurity.rejectIfNoRule = true
//grails.plugin.springsecurity.fii.rejectPublicInvocations = false

grails.plugin.springsecurity.successHandler.defaultTargetUrl="/"
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true
grails.plugin.springsecurity.dao.reflectionSaltSourceProperty = 'salt'
grails.plugin.springsecurity.useSwitchUserFilter = true
//grails.plugin.springsecurity.switchUser.targetUrl = "/"
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/':               		['permitAll'],
	'/index':          		['permitAll'],
	'/index.gsp':      		['permitAll'],
	'/index.html':      		['permitAll'],
	'/assets/**':      		['permitAll'],
	'/**/js/**':       		['permitAll'],
	'/**/css/**':      		['permitAll'],
	'/**/images/**':   		['permitAll'],
	'/**/favicon.ico': 		['permitAll'],
	'/myLogin/**':					['permitAll'],
	'/register/**':				['permitAll'],
	'/city/**':			    	['permitAll'],
	'/process/**':        ['permitAll'],
	'/cargo/**':          ['permitAll'],
	'/ships/**':          ['permitAll'],
	'/forgetpass/**':     ['permitAll'],
	'/help/**':       		['permitAll'],
	'/news/**':						['permitAll'],
	'/publish/**':				['permitAll'],
	'/files/adv/**':			['permitAll'],
	'/adv/**':						['permitAll'],
	'/building/**':				['permitAll'],
	'/about.html':				['permitAll'],
	'/ceo_mailbox.html':	['permitAll'],
	'/contact.html':			['permitAll'],
	'/fankui.html':				['permitAll'],
	'/job.html':					['permitAll'],
	'/law.html':					['permitAll'],
	'/protocol.html':			['permitAll'],
	'/tools/**':					['permitAll'],
	'/special/**':					['permitAll'],
	'/certificate/**':          ['permitAll'],
	'/company/**':          ['permitAll'],
	'/InqueryPrice/**':          ['permitAll'],
	'/inquery.html':          ['permitAll'],
	'/cargoInquery.gsp':          ['permitAll'],
	'/cargoInquery.html':          ['permitAll'],
	'/list.gsp':          ['permitAll'],
	'/bookingManage.gsp':          ['permitAll'],
	'/shiplist.gsp':          ['permitAll'],
	'/orderlist.gsp':          ['permitAll'],
	'/Order/**':          ['permitAll'],
	'/enterpriseDirectory/**':          ['permitAll'],
	'/ShowInquery.gsp':          ['permitAll'],
	'/EditInquery.gsp':          ['permitAll'],
	'/bookingView.gsp':          ['permitAll'],
	'/indexPage.html':          ['permitAll'],
	'/shipping.html':          ['permitAll'],
	'/denglu.html':          ['permitAll'],
	'/newsList.html':          ['permitAll'],
	'/newsDetails.html':          ['permitAll'],
	'/times.html':          ['permitAll'],
	'/companys.html':          ['permitAll'],
	'/special.html':          ['permitAll'],
	'/pallet.html':          ['permitAll'],
	'/show/**':          ['permitAll'],
	'/mobile/**':          ['permitAll'],
	'/robots.txt':          ['permitAll'],
	'/sitemap.html':          ['permitAll'],
	'/sitemap.xml':          ['permitAll'],
]