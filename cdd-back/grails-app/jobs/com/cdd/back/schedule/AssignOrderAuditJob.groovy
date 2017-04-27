package com.cdd.back.schedule

import grails.plugin.mail.MailService
import groovy.util.logging.Slf4j
import java.text.SimpleDateFormat

import com.cdd.back.cache.JobCache
import com.cdd.base.domain.BackUser
import com.cdd.base.domain.Order
import com.cdd.base.domain.Role
import com.cdd.base.service.common.CRUDService


@Slf4j
class AssignOrderAuditJob {
	static triggers = {
		cron name: 'AssignOrderAuditTrigger', cronExpression: "0 * * * * ?"
	}

	CRUDService CRUDService
	
	MailService mailService
	
	def grailsApplication

	def execute(){
		int offset = 0
		def list = [0]
		Role role = Role.findByName('客服')
		def c = BackUser.createCriteria()
		def staffs = c.list { eq "role", role }
		if(!JobCache.map.assignOrderAuditJob_pos) {
			JobCache.map.assignOrderAuditJob_pos = 0
		}
		int pos = JobCache.map.assignOrderAuditJob_pos
		if(staffs) {
			while(list) {
				list = CRUDService.list(Order, [offset: offset, max: staffs.size(), "f_isNull_service": null]).list
				list.eachWithIndex { data, index ->
					if(pos == staffs.size()) {
						pos = 0
					}
					data.service = staffs[pos++]
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
					def now = df.format(new Date());// new Date()为获取当前系统时间
					mailService.sendMail {
						async true
						to  data.service.email
						from grailsApplication.config.grails.mail.username
						subject "${grailsApplication.config.appInfo.title}-通知"
						body """
							你好，${data.service.firstname}
							用户 ${data.createBy} 已于 ${now} 发布货盘
							货盘编号: ${data.number}
							链接地址: http://${grailsApplication.config.domain}/orderAudit/data/${data.number}
							联  系  人: ${data.contactName}
							联系方式: ${data.createBy}

								请登录后台及时审核！

							系统后台自动发送，无需回复
							${now}
						"""
					}
				}
				Order.saveAll(list)
				offset += staffs.size()
			}
		}
		JobCache.map.assignOrderAuditJob_pos = pos
	}
}
