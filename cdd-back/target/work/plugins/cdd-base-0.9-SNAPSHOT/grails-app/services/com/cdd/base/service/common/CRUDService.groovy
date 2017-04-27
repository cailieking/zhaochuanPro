package com.cdd.base.service.common

import java.lang.reflect.Field
import java.text.SimpleDateFormat

import com.cdd.base.exception.BusinessException
import com.cdd.base.util.CommonUtils

class CRUDService {
	def list(Class domainClass, Map params, queryHandler = null) {
		def query = [:]
		query.sort = params.sort ?: 'lastUpdated'
		query.order = params.order ?: 'desc'
		query.putAll CommonUtils.getPagination(params)
		def c = domainClass.createCriteria()
		SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss')
		SimpleDateFormat sdf2 = new SimpleDateFormat('yyyy-MM-dd')
		if(!queryHandler) {
			queryHandler = {
				final def delegator = delegate
				def condition = {
					params.each { String key, Object value ->
						if(key.startsWith('f_')) {
							String field = key.replaceFirst('f_', '')
							int splitIndex = field.indexOf('_')
							String comparator
							if(splitIndex == -1) {
								comparator = 'eq'
							} else {
								comparator = field.substring(0, splitIndex)
								field = field.substring(splitIndex+1)
							}

							def compareValue = value
							if(comparator == 'between') {
								def arr = []
								if(compareValue instanceof String) {
									compareValue = value.toString().split('\\|')
									if(compareValue.length != 2) {
										throw new BusinessException('Between need 2 candidate values')
									}
									Field f = CommonUtils.getField(domainClass, field)
									f.setAccessible(true)
									Class type = f.getType()
									compareValue.each {
										if(type == Date) {
											try {
												arr << sdf.parse(it)
											} catch(e) {
												arr << sdf2.parse(it)
											}
										} else if(type == Integer || type == int.class) {
											arr << Integer.valueOf(it)
										} else if(type == Short || type == short.class) {
											arr << Short.valueOf(it)
										} else if(type == Float || type == float.class) {
											arr << Float.valueOf(it)
										} else if(type == Double || type == double.class) {
											arr << Double.valueOf(it)
										} else if(type == BigDecimal) {
											arr << new BigDecimal(it)
										} else if(type == Boolean || type == boolean.class) {
											arr << Boolean.valueOf(it)
										}
									}
								}
								if(!arr) {
									arr = compareValue
								}
								delegator."$comparator"(field, arr[0], arr[1])
							} else if(compareValue != null) {
								if(compareValue instanceof String) {
									Field f = CommonUtils.getField(domainClass, field)
									f.setAccessible(true)
									Class type = f.getType()
									if(type == Date) {
										try {
											compareValue = sdf.parse(compareValue)
										} catch(e) {
											compareValue = sdf2.parse(compareValue)
										}
									} else if(type == Integer || type == int.class) {
										compareValue = Integer.valueOf(compareValue)
									} else if(type == Short || type == short.class) {
										compareValue = Short.valueOf(compareValue)
									} else if(type == Float || type == float.class) {
										compareValue = Float.valueOf(compareValue)
									} else if(type == Double || type == double.class) {
										compareValue = Double.valueOf(compareValue)
									} else if(type == BigDecimal) {
										compareValue = new BigDecimal(compareValue)
									} else if(type == Boolean || type == boolean.class) {
										compareValue = Boolean.valueOf(compareValue)
									}
								}
								delegator."$comparator"(field, compareValue)
							} else {
								delegator."$comparator"(field)
							}
						}
					}
				}

				if(!params.isDisjunction) {
					condition()
				} else {
					or { condition() }
				}
			}
		}
		def pagedList = c.list(query, queryHandler)
		//		def result = [:]
		//		result.list = pagedList.list
		//		result.total = pagedList.totalCount ?: result.list.size()
		return pagedList
	}

	def getFirst(Class domainClass, Map params, queryHandler = null) {
		def result = list(domainClass, params, queryHandler)
		def data
		if(result.list) {
			data = result.list[0]
		}
		return data
	}
}
