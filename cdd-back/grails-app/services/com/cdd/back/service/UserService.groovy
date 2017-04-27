package com.cdd.back.service

import grails.plugin.springsecurity.SpringSecurityService

import java.text.DecimalFormat

import org.hibernate.SessionFactory

import com.cdd.back.domain.StatStaff
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.CargoShipInformation
import com.cdd.base.domain.FrontAuthority;
import com.cdd.base.domain.FrontUser
import com.cdd.base.domain.Order
import com.cdd.base.exception.BusinessException
import com.cdd.base.service.common.CRUDService

class UserService {
	SessionFactory sessionFactory

	def createPositionLevel(String superiorLevel) {
		String level
		def query
		if(superiorLevel) {
			query = sessionFactory.currentSession.createSQLQuery("""
				select position_level from back_user where position_level like ? 
				order by position_level desc limit 0,1 for update
			""")
			query.setString(0, "${superiorLevel}%")
			level = query.uniqueResult()
		} else {
			query = sessionFactory.currentSession.createSQLQuery("""
				select position_level from back_user where LENGTH(position_level)=3
				order by position_level desc limit 0,1 for update
			""")
			level = query.uniqueResult()
		}
		if(!level || level == superiorLevel) {
			level = '000'
		}
		if(level.length() > 3) {
			level = level.substring(level.length() - 3)
		}
		DecimalFormat df = new DecimalFormat('000')
		int positionLevelNum = df.parse(level) + 1
		return (superiorLevel ?: '') + df.format(positionLevelNum)
	}

	CRUDService CRUDService

	SpringSecurityService springSecurityService

	def getServiceList() {
		CRUDService.list(BackUser, [:]) {
			role { eq 'name', '客服' }
			like 'positionLevel', "${springSecurityService.currentUser.positionLevel}%"
		}
	}

	def getSalesList() {
		CRUDService.list(BackUser, [:]) {
			role { eq 'name', '业务员' }
//			like 'positionLevel', "${springSecurityService.currentUser.positionLevel}%"
		}
	}
	
	def removeUser(BackUser user) {
		def superior = user.superior
//		sessionFactory.currentSession.createSQLQuery("update orders set service_id=${superior?.id} where service_id=${user.id}").executeUpdate()
//		sessionFactory.currentSession.createSQLQuery("update orders set sales_id=${superior?.id} where sales_id=${user.id}").executeUpdate()
//		sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set service_id=${superior?.id} where service_id=${user.id}").executeUpdate()
//		sessionFactory.currentSession.createSQLQuery("update front_user set create_by='${superior?.username}' where create_by='${user.username}'").executeUpdate()
//		sessionFactory.currentSession.createSQLQuery("update orders set create_by='${superior?.username}' where create_by='${user.username}'").executeUpdate()
//		sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set create_by='${superior?.username}' where create_by='${user.username}'").executeUpdate()
		if(Order.countByService(user) > 0 || Order.countBySales(user) > 0 || CargoShipInformation.countByService(user)) {
			throw new BusinessException("请先分配 ${user.firstname} 的工作再删除")
		}
		StatStaff.findByUser(user)?.delete()
		user.delete()
		if(user.hasErrors()){
			println user.errors
			return false
		}else{
			return true
		}
		
	}
	
	def assign(BackUser from, BackUser to) {
		sessionFactory.currentSession.createSQLQuery("update orders set service_id=${to.id} where service_id=${from.id}").executeUpdate()
		sessionFactory.currentSession.createSQLQuery("update orders set sales_id=${to.id} where sales_id=${from.id}").executeUpdate()
		sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set service_id=${to.id} where service_id=${from.id}").executeUpdate()
		sessionFactory.currentSession.createSQLQuery("update front_user set create_by='${to.username}' where create_by='${from.username}'").executeUpdate()
		sessionFactory.currentSession.createSQLQuery("update orders set create_by='${to.username}' where create_by='${from.username}'").executeUpdate()
		sessionFactory.currentSession.createSQLQuery("update cargo_ship_information set create_by='${to.username}' where create_by='${from.username}'").executeUpdate()
	}
	
	def removeFrontUser(FrontUser user) {
		def shipList = CargoShipInformation.findByOwner(user)
		if(shipList) {
			shipList*.delete(flush: true)
		}
		def orderList = Order.findByOwner(user)
		if(orderList) {
			orderList*.delete(flush: true)
		}
		sessionFactory.currentSession.createSQLQuery("delete from front_authority_users where front_user_id=${user.id}").executeUpdate()
		user.delete(flush: true)
	}
}
