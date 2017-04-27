package com.cdd.front.server;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
//import java.util.Map;
//import javax.xml.bind.annotation.XmlAccessorType;
//import javax.xml.bind.annotation.XmlType;

public class MapConvertor {  
  
	private List<MyMapEntry> entries = new ArrayList<MyMapEntry>();  
  
    public void addEntry(MyMapEntry entry) {  
        entries.add(entry);  
    }  
  
    public void setEntries(List<MyMapEntry> entries) {  
        this.entries = entries;  
    }  
  
    public List<MyMapEntry> getEntries() {  
        return entries;  
    }  
  
    public static class MyMapEntry {  
  
        private String key;  
  
        private Object value;  
  
        public MyMapEntry() {  
            super();  
        }  
  
        public MyMapEntry(Map.Entry<String, Object> entry) {  
            super();  
            this.key = entry.getKey();  
            this.value = entry.getValue();  
        }  
  
        public MyMapEntry(String key, Object value) {  
            super();  
            this.key = key;  
            this.value = value;  
        }  
  
        public String getKey() {  
            return key;  
        }  
  
        public void setKey(String key) {  
            this.key = key;  
        }  
  
        public Object getValue() {  
            return value;  
        }  
  
        public void setValue(Object value) {  
            this.value = value;  
        }  
    }

}  