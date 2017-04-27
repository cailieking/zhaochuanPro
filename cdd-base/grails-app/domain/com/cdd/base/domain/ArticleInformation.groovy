package com.cdd.base.domain

import java.util.Date;

import grails.validation.Validateable

import com.cdd.base.enums.ArticleCategory
import com.cdd.base.enums.ArticleState
import com.cdd.base.enums.ArticleType

@Validateable
class ArticleInformation extends BaseDomain {
	String title
	String content
	int order
	ArticleType articleType
	String image
	String comes
	long readCount
	ArticleState articleState
	String articleCategory
	String toShare 
	String headTitle
	String sourceUrl
	String keyWords
	String pageTag
	String tweetTitle
	String articleSummary
	String description
	String articleImgs
	String newsUrl
	Date issueDate
	
	
	static mapping = {
		table 'article_information'
		content type: 'text'
		order column: 'orders'
	}

	static constraints = {
		title nullable: false, blank: true, unique: false, maxSize: 500
		content nullable: false, blank: true, unique: false
		articleType nullable: false, blank: true, unique: false, maxSize: 50
		image nullable: true, blank: true, unique: false, maxSize: 500
		comes nullable: false, blank: true, unique: false, maxSize: 50
		articleCategory nullable: true, blank: true, unique: false, maxSize: 32
		toShare nullable: true, blank: true, unique: false
		headTitle nullable: true, blank: true, unique: false, maxSize: 64
		sourceUrl nullable: true, blank: true, unique: false, maxSize: 128
		keyWords nullable: true, blank: true, unique: false, maxSize: 64
		pageTag nullable: true, blank: true, unique: false, maxSize: 128
		tweetTitle nullable: true, blank: true, unique: false, maxSize: 64
		articleSummary nullable: true, blank: true, unique: false, maxSize: 64
		description nullable: true, blank: true, unique: false, maxSize: 512
		articleState nullable: true, blank: true, unique: false, maxSize: 50
		articleImgs nullable: true, blank: true, unique: false, maxSize: 2048
		newsUrl nullable: true,black: true,unique: true,mazSize:128
		issueDate nullable: true, blank: true, maxSize: 64
	}
}
