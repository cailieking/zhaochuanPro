
package com.cdd.back.client;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;



/**
 * <p>mapConvertor complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="mapConvertor"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="entries" type="{http://server.front.cdd.com/}myMapEntry" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "mapConvertor", propOrder = {
    "entries"
}, namespace = "")
public class MapConvertor {

    @XmlElement(nillable = true)
    protected List<MyMapEntry> entries = new ArrayList<MyMapEntry>();

    /**
     * Gets the value of the entries property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the entries property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEntries().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link MyMapEntry }
     * 
     * 
     */
    
    public List<MyMapEntry> getEntries() {
        if (entries == null) {
            entries = new ArrayList<MyMapEntry>();
        }
        return this.entries;
    }
    
    
    public void addEntry(MyMapEntry entry) {  
        entries.add(entry);  
    }  
  
    public void setEntries(List<MyMapEntry> entries) {  
        this.entries = entries;  
    }  
}
