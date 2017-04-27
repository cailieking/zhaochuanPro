package com.cdd.test.common

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


// Create output PDF
Document document = new Document(PageSize.A4);
PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream('src/java/com/cdd/front/files/hello.pdf'));
document.open();
PdfContentByte cb = writer.getDirectContent();

// Load existing PDF
PdfReader reader = new PdfReader(new FileInputStream('src/java/com/cdd/front/files/booking_template.pdf'));
PdfImportedPage page = writer.getImportedPage(reader, 1);

// Copy first page of existing PDF into output PDF
document.newPage();
cb.addTemplate(page, 0, 0);

// Add your new data / text here
// for example...
cb.saveState()
printText('1234567890ABCD', 20, 795, cb) // service contract no
printText('2015-08-06 00:00:00', 470, 810, cb) // booking date
printText('ABCDEFG', 450, 793, cb) // booking no
printText('ABCDEFG', 340, 763, cb) // export license no
printText('george', 55, 718, cb) // booked by name
printText('乔治', 60, 702, cb) // booked by contact
printText('feleio@test.com', 190, 702, cb) // booked by email
printText('15688995665', 50, 687, cb) // booked by tel
printText('george', 375, 718, cb) // customer name
printText('乔治', 380, 702, cb) // customer contact
printText('feleio33333333333333@test.com', 492, 720, 575, 600, cb) // customer email
printText('15688995665', 370, 687, cb) // customer tel
printText('george', 55, 655, cb) // shipper name
printText('乔治', 60, 638, cb) // shipper contact
printText('feleio@test.com', 190, 638, cb) // shipper email
printText('15688995665', 50, 622, cb) // shipper tel
printText('george', 55, 592, cb) // notify name
printText('乔治', 60, 575, cb) // notify contact
printText('feleio@test.com', 190, 575, cb) // notify email
printText('15688995665', 50, 559, cb) // notify tel
printText('george', 55, 511, cb) // consignee name
printText('乔治', 60, 494, cb) // consignee contact
printText('feleio@test.com', 190, 494, cb) // consignee email
printText('15688995665', 50, 478, cb) // consignee tel
printText('23423', 405, 542, cb) // O/F
printText('23423', 405, 526, cb) // THC/ORC
printText('23423', 512, 526, cb) // EIR
printText('23423', 405, 510, cb) // DOC
printText('23423', 512, 510, cb) // EBS
printText('23423', 405, 494, cb) // ISPS
printText('23423', 512, 494, cb) // CIC
printText('23423', 405, 478, cb) // SEAL
printText('23423', 512, 478, cb) // TLX
printText('23423', 405, 462, cb) // ENS/AMS
printText('23423', 512, 462, cb) // OTHERS

printText('ASDFLKJ', 20, 416, cb) // place of receipt
printText('ASDFLKJ', 165, 416, cb) // port of loading
printText('√', 426, 416, cb, 12) // origin CY
printText('√', 538, 416, cb, 12) // origin CFS
printText('ASDFLKJ', 20, 384, cb) // port of discharge
printText('ASDFLKJ', 165, 384, cb) // place of delivery
printText('√', 426, 384, cb, 12) // destination CY
printText('√', 538, 384, cb, 12) // destination CFS

printText('SDFSD', 20, 340, cb) // voyage no
printText('啊第三方第三方', 163, 370, 330, 300, cb) // pre-carriage
printText('2015-08-01 00:00:00', 340, 340, cb) // ETD
printText('asdfas', 462, 340, cb) // final destination

printText('2323', 100, 250, cb) // 20 quantity
printText('2323', 100, 234, cb) // 40 quantity
printText('2323', 100, 218, cb) // 40hq quantity
printText('2323', 100, 202, cb) // 45 quantity
printText('2323', 100, 186, cb) // 40hq reefer quantity
printText('2323', 100, 170, cb) // 20 reefer quantity
printText('测试测试测试测试测试测试测试测试测试测试测试测试测试测试', 165, 270, 220, 150, cb) // commodity 
printText('2323', 230, 250, cb) // 20 weight
printText('2323', 230, 234, cb) // 40 weight
printText('2323', 230, 218, cb) // 40hq weight
printText('2323', 230, 202, cb) // 45 weight
printText('2323', 230, 186, cb) // 40hq reefer weight
printText('2323', 230, 170, cb) // 20 reefer weight
printText('2323', 290, 250, cb) // 20 cbm
printText('2323', 290, 234, cb) // 40 cbm
printText('2323', 290, 218, cb) // 40hq cbm
printText('2323', 290, 202, cb) // 45 cbm
printText('2323', 290, 186, cb) // 40hq reefer cbm
printText('2323', 290, 170, cb) // 20 reefer cbm
printText('2323', 340, 250, cb) // 20 temperature
printText('2323', 340, 234, cb) // 40 temperature
printText('2323', 340, 218, cb) // 40hq temperature
printText('2323', 340, 202, cb) // 45 temperature
printText('2323', 340, 186, cb) // 40hq reefer temperature
printText('2323', 340, 170, cb) // 20 reefer temperature
printText('2323', 410, 250, cb) // 20 humidity
printText('2323', 410, 234, cb) // 40 humidity
printText('2323', 410, 218, cb) // 40hq humidity
printText('2323', 410, 202, cb) // 45 humidity
printText('2323', 410, 186, cb) // 40hq reefer humidity
printText('2323', 410, 170, cb) // 20 reefer humidity
printText('2323', 463, 250, cb) // 20 probes
printText('2323', 463, 234, cb) // 40 probes
printText('2323', 463, 218, cb) // 40hq probes
printText('2323', 463, 202, cb) // 45 probes
printText('2323', 463, 186, cb) // 40hq reefer probes
printText('2323', 463, 170, cb) // 20 reefer probes
printText('2323', 515, 250, cb) // 20 volume
printText('2323', 515, 234, cb) // 40 volume
printText('2323', 515, 218, cb) // 40hq volume
printText('2323', 515, 202, cb) // 45 volume
printText('2323', 515, 186, cb) // 40hq reefer volume
printText('2323', 515, 170, cb) // 20 reefer volume

printText('测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试', 20, 155, 330, 50, cb) // remark
printText('乔治', 380, 100, cb, 24) // signature
printText('1236546546', 365, 68, cb) // person in charge tel
printText('feleio@test.com', 500, 68, cb) // person in charge email

cb.restoreState();
document.close();

def printText(text, x, y, canvas, font=10) {
	canvas.setFontAndSize(BaseFont.createFont(AsianFontMapper.ChineseSimplifiedFont,  AsianFontMapper.ChineseSimplifiedEncoding_H, BaseFont.NOT_EMBEDDED), font); // /F1 12 Tf
	canvas.beginText();
	canvas.moveText(x, y);
	canvas.showText(text);
	canvas.endText();
	
}

def printText(text, llx, lly, urx, ury, canvas, font=10) {
//	canvas.beginText();
//	canvas.moveText(x, y);                        
//	canvas.showText(text);                   
//	canvas.endText();
	
	ColumnText ct = new ColumnText(canvas);
	ct.setAlignment(Element.ALIGN_JUSTIFIED);
//	ct.setLeading(14);
	ct.setSimpleColumn(llx, lly, urx, ury)
	
	ct.addText(new Chunk(text, new Font(BaseFont.createFont(AsianFontMapper.ChineseSimplifiedFont,  AsianFontMapper.ChineseSimplifiedEncoding_H, BaseFont.NOT_EMBEDDED), font)))
//	ct.setSimpleColumn(55, 0, 0, 0)
	ct.go()
}