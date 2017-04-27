package com.cdd.base.domain


import grails.transaction.Transactional
import grails.validation.Validateable;

import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.transaction.annotation.Propagation

import com.cdd.base.enums.Sex

@Validateable
class User extends BaseDomain {
	
	// we need a system user that some times system will do a schedule job or something else automatically
	static final String SENSITIVE_NAMES = ["system", "anonymous"]
	static User SYSTEM = new User(id: 0, username:'system')
	static User ANONYMOUS = new User(id: 0, username:'anonymous')
	
	String username // which can not be changed in feature
	String password // should be encrypted
	String salt // a salt used by password
	String email // this can be changed but and no need unique because we are not using it as login user name
	String firstname
	String middlename
	String lastname
	String mobile
	Sex sex
	Date birth
	boolean enabled = true
	Date accountExpiryDate
	int accountLockedCount
	Date passwordExpiryDate
	Date loginTime
	
	static int MAX_LOCK_COUNT = 5
	
	boolean isAccountLocked() {
		return accountLockedCount > MAX_LOCK_COUNT
	}
	
	int getLeftMinutes() {
		Date now = new Date();
		Calendar unlockC = Calendar.getInstance();
		unlockC.setTime(lastUpdated);
		unlockC.add(Calendar.HOUR, 1);
		Date unlockTime = unlockC.getTime();
		return (int) ((unlockTime.getTime() - now.getTime()) / (1000 * 60));
	}
	
	@Transactional(propagation=Propagation.REQUIRES_NEW)
	boolean lockDown() {
		User user = get(id)
		boolean toUpdate = false
		if(accountLockedCount < 5) {
			accountLockedCount++
			toUpdate = true
		}
		if(toUpdate) {
			user.accountLockedCount = accountLockedCount
			user.save()
		}
		return toUpdate
	}
	
	def reset() {
		accountLockedCount = 0
		save(flush: true)
	}
	
	boolean isPasswordExpired() {
		return isExpired(passwordExpiryDate)
	}
	
	boolean isAccountExpired() {
		return isExpired(accountExpiryDate)
	}
	
	private boolean isExpired(date) {
		if(date) {
			Date now = new Date()
			return now.compareTo(date) > 0
		}
		return false
	} 
	
	static constraints = {
		username size: 5..255, blank: false, unique: true, nullable: false, matches: '^\\w+$', // keep username be simple
		// as we having a static user we dont want the name 'system' used by user, so we need to check
		validator: { val, obj, errors ->
			boolean isSensitive = SENSITIVE_NAMES.any {
				val == it
			}
			if (isSensitive) errors.rejectValue('username', 'errors.username.not.allow.using.system')
		}
		
		password maxSize: 255, blank: false, unique: false, nullable: false
		salt maxSize: 20, blank: false, unique: false, nullable: false
		email maxSize: 255, blank: false, unique: true, nullable: true, email: true
		firstname maxSize: 255, blank: false, unique: false, nullable: false
		middlename maxSize: 255, blank: false, unique: false, nullable: true
		lastname maxSize: 255, blank: false, unique: false, nullable: true
		sex maxSize: 255, blank: false, unique: false, nullable: true
		birth nullable: true
		loginTime nullable: true
		accountExpiryDate nullable: true
		passwordExpiryDate nullable: true
		mobile blank: false, nullable: true, matches: '\\d{11}'
  }
	
	static mapping = {
		username updateable: false // set updateable to false to disable changing username
	}	
}
