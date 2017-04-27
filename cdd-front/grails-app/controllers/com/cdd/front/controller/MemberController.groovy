package com.cdd.front.controller

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured

import com.cdd.base.domain.Order
import com.cdd.front.constant.Constant
import com.itextpdf.awt.AsianFontMapper
import com.itextpdf.text.Chunk
import com.itextpdf.text.Document
import com.itextpdf.text.Element
import com.itextpdf.text.Font
import com.itextpdf.text.PageSize
import com.itextpdf.text.pdf.BaseFont
import com.itextpdf.text.pdf.ColumnText
import com.itextpdf.text.pdf.PdfContentByte
import com.itextpdf.text.pdf.PdfImportedPage
import com.itextpdf.text.pdf.PdfReader
import com.itextpdf.text.pdf.PdfWriter


@Secured(['ROLE_CLIENT'])
class MemberController implements ExceptionHandler {

	SpringSecurityService springSecurityService

	def tools() {
		render view: "/member/tools/${params.id}"
	}

}
