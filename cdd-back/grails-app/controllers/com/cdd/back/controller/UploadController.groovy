package com.cdd.back.controller


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
  
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.commons.CommonsMultipartFile
class UploadController {
	
	CommonsMultipartFile upload ;
   
	
	def excute()  {  
		int maxSize = 1024 * 1024 * 10
		println(params)
        upload = params.upload
		
		if(upload.size > maxSize) {
			flash.errors = [:]
			flash.errors.msgs = ['图片不能超过10MB']
			redirect uri: "/${model}/data/${data.id ?: 'new'}"
			return 
		}
		
		String  expandedName = upload.fileItem.fileName
        response.setCharacterEncoding("UTF-8");  
        PrintWriter out = response.getWriter();  
        String callback = request.getParameter("CKEditorFuncNum");   
		InputStream is = upload.getInputStream();
        String uploadPath = servletContext.getRealPath("/files/images");  
		File file = new File(uploadPath);
		if (!file.exists()) { 
			file.mkdirs();
		}
        String fileName = java.util.UUID.randomUUID().toString(); 
        fileName += expandedName;  
        OutputStream os = new FileOutputStream(new File(uploadPath, fileName));     
        byte[] buffer = new byte[1024];     
        int length = 0;  
        while ((length = is.read(buffer)) > 0) {     
            os.write(buffer, 0, length);     
        }     
        is.close();  
        os.close();  
          
        out.println("<script type=\"text/javascript\">");    
        out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + "/files/images/" + fileName + "','')");    
        out.println("</script>");  
          
        render null;  
    }  
}
