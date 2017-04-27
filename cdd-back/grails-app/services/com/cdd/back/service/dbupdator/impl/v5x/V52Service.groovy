package com.cdd.back.service.dbupdator.impl.v5x

import grails.transaction.Transactional

import org.hibernate.Query
import org.hibernate.SQLQuery
import org.hibernate.SessionFactory
import org.springframework.transaction.annotation.Propagation

import com.cdd.back.domain.FakeFrontUser
import com.cdd.back.service.UserService


class V52Service {
	
	SessionFactory sessionFactory
	
	UserService userService
	
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	def update() {
		int max = 100
		Query query = sessionFactory.currentSession.createQuery("from FrontUser where username<>createBy")
		query.maxResults = max
		query.firstResult = 0
		def list = query.list()
		list?.each {
			FakeFrontUser data = FakeFrontUser.findByUsername(it.username)
			if(!data) {
				data = new FakeFrontUser(it.properties)
				data.save()
			}
			userService.removeFrontUser(it)
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	def count() {
		SQLQuery query = sessionFactory.currentSession.createSQLQuery("select count(*) from front_user where username<>create_by")
		return query.uniqueResult()
	}
}
