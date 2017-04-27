package com.cdd.back.util

import java.util.Date;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import com.cdd.base.domain.BackUser;

class UsersListener  implements HttpSessionBindingListener {  
	
int uid;  
public int getUid() {  
   return uid;  
}  
public void setUid(int uid) {  
   this.uid = uid;  
}  
 
public void valueBound(HttpSessionBindingEvent arg0) {  
	println (uid+"上线")
	BackUser user = BackUser.get(uid);
	user.isOnline = true;
	user.save();
}  
public void valueUnbound(HttpSessionBindingEvent arg0) {  
	println (uid+"下线")
   BackUser user = BackUser.get(uid);
	user.isOnline = false;
	user.save();
}  
}  