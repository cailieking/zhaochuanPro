package com.cdd.front.databinding

class UploadedFile {
	byte[] file
	
	static constraints = {
			file maxSize: 1024 * 1024 * 2
	}
}
