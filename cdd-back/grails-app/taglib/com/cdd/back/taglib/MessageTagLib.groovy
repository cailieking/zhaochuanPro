package com.cdd.back.taglib

import groovy.util.logging.Slf4j
import groovy.xml.MarkupBuilder

@Slf4j
class MessageTagLib {
	static namespace = 'message'

	def errors = { attrs ->
		MarkupBuilder builder = new MarkupBuilder(out)
		builder.ul('class': 'errorMsgs') {
			try {
				flash.errors?.allErrors?.each { error ->
					String msg = g.message(code:error.codes[0]).toString()
					li(msg)
				}
				flash.errors?.msgs?.each { msg ->
					li(msg)
				}
			} catch(e) {
			}
		}
	}
	
	def infos = { attrs ->
		MarkupBuilder builder = new MarkupBuilder(out)
		builder.ul('class': 'infoMsgs') {
			flash.msgs.each { msg ->
				li(msg)
			}
		}
	}
}
