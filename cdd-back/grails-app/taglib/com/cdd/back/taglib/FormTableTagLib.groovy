package com.cdd.back.taglib

import groovy.util.logging.Slf4j
import groovy.xml.MarkupBuilder

@Slf4j
class FormTableTagLib {
	static namespace = 'formTable'

	def table = { attrs, body ->
		MarkupBuilder builder = new MarkupBuilder(out)
		builder.table('class': attrs.className ?: 'form-table') {
			mkp.yieldUnescaped(body())
		}
	}

	def tr = { attrs, body ->
		MarkupBuilder builder = new MarkupBuilder(out)
		builder.tr(attrs) {
			String title = attrs.title
			if(attrs.required) {
				td('class': 'form-title') {
					mkp.yieldUnescaped("${title}<span class='required'></span>")
				}
			} else {
				td('class': 'form-title', "${title}")
			}
			td('class': 'form-input') {
				mkp.yieldUnescaped(body())
			}
		}
	}

	def radio = { attrs ->
		MarkupBuilder builder = new MarkupBuilder(out)
		builder.div() {
			Class.forName(attrs.enumName).values().each { enumValue ->
				def params = [type: 'radio', name: attrs.name, value: enumValue.name()]
				if(attrs.value == enumValue) {
					params.checked = 'checked'
				}
				input(params)
				label('class': 'inputLabel', enumValue.text)
			}
		}
	}
	
}
