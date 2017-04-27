import com.cdd.front.authentication.AuthenticationSuccessEventHandler
import com.cdd.front.authentication.UserDetailsProvider
import com.google.code.kaptcha.impl.DefaultKaptcha
import com.cdd.front.authentication.MyUrlAuthenticationSuccessHandler

// Place your Spring DSL code here
beans = {
	authenticationSuccessEventHandler(AuthenticationSuccessEventHandler)
	
	detailsAuthenticationProvider(UserDetailsProvider) {
		springSecurityService = ref('springSecurityService')
	}
	
	authenticationSuccessHandler(MyUrlAuthenticationSuccessHandler)
	
	captchaProducer(DefaultKaptcha) {
		config = ref('captchaConfig')
	}
	
	captchaConfig(com.google.code.kaptcha.util.Config) { bean ->
		Properties p = new Properties()
		p.setProperty('kaptcha.image.width', '150')
		p.setProperty('kaptcha.image.height', '60')
		p.setProperty('kaptcha.textproducer.char.string', '0123456789')
		p.setProperty('kaptcha.textproducer.char.length', '4')
		bean.constructorArgs = [p]
	}
	
	
}
