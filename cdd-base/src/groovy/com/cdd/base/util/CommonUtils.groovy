package com.cdd.base.util

import groovy.util.logging.Slf4j

import java.lang.reflect.Field
import java.sql.Time
import java.sql.Timestamp
import java.text.SimpleDateFormat

import com.cdd.base.constant.CommonConstant
import com.cdd.base.json.JsonObject

@Slf4j
class CommonUtils {
	private static final Random RANDOM = new Random()

	def static partition(array, size) {
		if(!array) {
			return null;
		}

		def partitions = []
		int partitionCount = array.size() / size

		partitionCount.times { partitionNumber ->
			def start = partitionNumber * size
			def end = start + size - 1
			partitions << array[start..end]
		}

		if (array.size() % size) partitions << array[partitionCount * size..-1]
		return partitions
	}
	
	def static getPagination(params) {
		def query = [:]
		int max
		if(params.limit) {
			max = params.limit as int
		} else if(params.max) {
			max = params.max as int
		}
		if(max > 0) {
			int offset
			if(params.offset) {
				offset = params.offset as int
			} else {
				try {
					offset = ((Integer.valueOf(params.page) -1) * max)
				} catch(Exception e) {
					offset = 0
				}
			}
			query.offset = offset
			query.max = max
		}
		return query
	}

	def static random(int seed) {
		RANDOM.nextInt(seed)
	}

	def static copyProperties(source, target) {
		def (sProps, tProps) = [source, target]*.properties*.keySet()
		def commonProps = sProps.intersect(tProps) - ['class', 'metaClass']
		commonProps.each { target[it] = source[it] }
	}

	static Class<?> getType(Class clazz, propertyName) {
		return getField(clazz, propertyName)?.getType()
	}
	
	static Field getField(Class clazz, propertyName) {
		def field
		try {
			field = clazz.getDeclaredField(propertyName)
		} catch(e) {
		}
		if(field == null) {
			clazz = clazz.getSuperclass()
			if(clazz != Object) {
				return getField(clazz, propertyName)
			}
			return null
		}
		return field
	}

	static Map tranferToMap(data, excludeFields = [], includeTypes = []) {
		def map = [id : data?.id]
		data?.properties?.each { key, value ->
			if(!excludeFields || !excludeFields.contains(key)) {
				Class<?> clazz = getType(data.class, key)
				if(value instanceof JsonObject) {
					map[key] = tranferToMap(value, excludeFields, includeTypes)
				} else if(clazz && (includeTypes.contains(clazz)
				|| clazz.isPrimitive()
				|| clazz.isEnum()
				|| String.class.isAssignableFrom(clazz)
				|| Time.class.isAssignableFrom(clazz)
				|| Timestamp.class.isAssignableFrom(clazz)
				|| Date.class.isAssignableFrom(clazz)
				|| BigDecimal.class.isAssignableFrom(clazz))) {
					if(!clazz.isEnum()) {
						if(BigDecimal.class.isAssignableFrom(clazz)) {
							map[key] = value?.doubleValue()
						} else {
							map[key] = value
						}
					} else {
						map[key] = value?.text
					}
				}
			}
		}
		return map
	}
	
	static String formatDate(Date date) {
		if(date) {
			return new SimpleDateFormat(CommonConstant.DATE_FORMAT).format(date)
		} else {
			return null
		}
	}
	
	static Date parseDate(String dateStr) {
		if(dateStr) {
			return new SimpleDateFormat(CommonConstant.DATE_FORMAT).parse(dateStr)
		} else {
			return null
		}
	}
	
}
