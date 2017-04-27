package com.cdd.base.domain

import java.text.DecimalFormat

import org.hibernate.SessionFactory
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority

import com.cdd.base.enums.Position
import com.cdd.base.domain.User
import com.cdd.base.domain.BackDepartment
import com.cdd.base.domain.NewRoute
import com.cdd.base.domain.JobTitle

class BackUser extends User {
	
	static {
		transients << 'sessionFactory'
	}
	
	Position position
	String positionLevel
	String jobNum
	String qq
	String extNum
	String enName
	String inviteCode
	boolean deleteTag
	boolean isOnline
	
	
	static belongsTo = [role: Role, department: BackDepartment,jobTitle: JobTitle]
	
	static hasMany = [routes : NewRoute]
	Collection<GrantedAuthority> getAuthorities() {
		role.authorities.collect {
			new SimpleGrantedAuthority(it.map.authority)
		}
	}
	
	void setRole(Role role) {
		this.role = role
		Position position = Position.values().find { position ->
			position.text == role.name
		}
		this.position = position
	}
	
	boolean isAdmin() {
		return role.name == '系统管理员'
	}
	
	boolean isSupervisor() {
		return role.name == Position.Inspector.text
	}
	
	boolean isManager() {
		return role.name == Position.Manager.text
	} 
	
	boolean isSales() {
		return role.name == Position.Sales.text
	} 
	
	boolean isService() {
		return role.name == Position.Service.text
	}
	
	static mapping = {
		table 'back_user'
	}
	
	static constraints = {
		department nullable: true
		jobTitle nullable: true
		position nullable: true, unique: false, blank: true, maxSize: 50
		positionLevel nullable: true, unique: false, blank: true, maxSize: 50
		jobNum nullable: true, unique: false, blank: false, maxSize: 50
		qq nullable: true, unique: false, blank: false, maxSize: 50
		extNum nullable: true, unique: false, blank: false, maxSize: 50
		enName nullable: true, unique: false, blank: false, maxSize: 50
		inviteCode nullable:true, maxSize:32
		deleteTag nullable:false
		isOnline nullable:false
	}
	
	String getSuperiorLevel() {
		positionLevel?.substring(0, positionLevel ? positionLevel.length() - 3 : 0)
	}
	
	BackUser getSuperior() {
		BackUser.findByPositionLevel(getSuperiorLevel())
	}
	
}
