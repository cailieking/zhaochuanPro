package com.cdd.base.service

import com.aliyun.oss.OSSClient
import com.aliyun.oss.model.ObjectMetadata

class OssService {
	OSSClient ossClient

	def uploadFile(InputStream is, String bucketName, String filePath) {
		if(is) {
			try {
				ossClient.putObject(bucketName, filePath, is, new ObjectMetadata())
			} finally {
				is.close()
			}
		}
	}
	
	def deleteFile(String bucketName,String filePath) {
		
		ossClient.deleteObject(bucketName,filePath)
	}
	
	def isExist(String bucketName,String filePath){
		return ossClient.doesObjectExist(bucketName,filePath)
	}
}

