package com.cdd.front.server;

import java.util.HashMap;
import java.util.Map;

import javax.xml.bind.annotation.adapters.XmlAdapter;

	public class MapAdapter extends XmlAdapter<MapConvertor, Map<String, Object>> {

	    @Override  
	    public MapConvertor marshal(Map<String, Object> map) throws Exception {  
	        MapConvertor convertor = new MapConvertor();  
	        for (Map.Entry<String, Object> entry : map.entrySet()) {  
	        	MapConvertor.MyMapEntry e = new MapConvertor.MyMapEntry(entry);  
	            convertor.addEntry(e);  
	        }  
	        return convertor;  
	    }  
	  
	    @Override  
	    public Map<String, Object> unmarshal(MapConvertor map) throws Exception {  
	        Map<String, Object> result = new HashMap<String, Object>();  
	        for (MapConvertor.MyMapEntry e : map.getEntries()) {  
	            result.put(e.getKey(), e.getValue());  
	        }  
	        return result;  
	    }  
      
//	    @XmlType(name = "Data")  
//	    @XmlRootElement  
//	    public static class Data {
//
//	        private List<Entry> list = new ArrayList<Entry>();
//
//	        public void addEntry(String fieldName, Object fieldValue) {
//	            Entry entry = new Entry();
//	            entry.setKey(fieldName);
//	            entry.setValue(fieldValue);
//	            list.add(entry);
//	        }
//
//	        public List<Entry> getList() {
//	            return list;
//	        }
//
//	        public void setList(List<Entry> list) {
//	            this.list = list;
//	        }
//
//	        public static class Entry {
//
//	            private String key;
//	            private Object value;
//
//	            public String getKey() {
//	                return key;
//	            }
//
//	            public void setKey(String key) {
//	                this.key = key;
//	            }
//
//	            public Object getValue() {
//	                return value;
//	            }
//
//	            public void setValue(Object value) {
//	                this.value = value;
//	            }
//	        }
//	    }
}
