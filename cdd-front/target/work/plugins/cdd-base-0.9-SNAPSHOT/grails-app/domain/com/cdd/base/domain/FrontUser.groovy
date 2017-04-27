package com.cdd.base.domain

import java.util.Date;

import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority

import com.cdd.base.enums.FrontUserType

class FrontUser extends User {
	String companyName
	City city
	String address
	String qq
	String phone
	FrontUserType type
	boolean hornest;
	boolean safety;
	boolean verified;
    Company company
	
	String comeFrom
	String invitationCode
	boolean isOnline
	Date loginOutTime
	String ip
	
	static belongsTo = FrontAuthority
	static hasMany = [auths: FrontAuthority, recommendedRoutes: RecommendedRoute]
	
	Collection<GrantedAuthority> getAuthorities() {
		auths.collect {
			new SimpleGrantedAuthority(it.authority)
		}
	}
	
	static mapping = {
		table 'front_user'
		username updateable: true
	}
	
	boolean isCargoOwner() {
		type == FrontUserType.Cargo
	}
	
	boolean isShipAgent() {
		type == FrontUserType.Agent
	}
	
	static constraints = {
		username size: 5..255, blank: false, unique: true, nullable: false, matches: '\\d{11}'
		companyName nullable: false, blank: false, unique: false, maxSize: 255
		city nullable: false
		address nullable: true, blank: false, unique: false, maxSize: 500
		phone nullable: true, blank: false, unique: false, maxSize: 50
		qq nullable: true, blank: false, unique: false, maxSize: 50
		type nullable: false
		company nullable: true
		recommendedRoutes nullable: true
		comeFrom nullable: false
		invitationCode nullable: true
		isOnline nullable: false
		loginOutTime nullable: true
		ip nullable: true
	}
	
}
