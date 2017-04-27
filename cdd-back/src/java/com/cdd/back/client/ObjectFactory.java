
package com.cdd.back.client;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.cdd.back.client package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */

@XmlRegistry
public class ObjectFactory {

    private final static QName _Execute_QNAME = new QName("http://server.front.cdd.com/", "__execute");
    private final static QName _ExecuteResponse_QNAME = new QName("http://server.front.cdd.com/", "__executeResponse");
    private final static QName _CreateHtml_QNAME = new QName("http://server.front.cdd.com/", "createHtml");
    private final static QName _CreateHtmlResponse_QNAME = new QName("http://server.front.cdd.com/", "createHtmlResponse");
    private final static QName _CreateNewsDetails_QNAME = new QName("http://server.front.cdd.com/", "createNewsDetails");
    private final static QName _CreateNewsDetailsResponse_QNAME = new QName("http://server.front.cdd.com/", "createNewsDetailsResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.cdd.back.client
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Execute }
     * 
     */
    public Execute createExecute() {
        return new Execute();
    }

    /**
     * Create an instance of {@link ExecuteResponse }
     * 
     */
    public ExecuteResponse createExecuteResponse() {
        return new ExecuteResponse();
    }

    /**
     * Create an instance of {@link CreateHtml }
     * 
     */
    public CreateHtml createCreateHtml() {
        return new CreateHtml();
    }

    /**
     * Create an instance of {@link CreateHtmlResponse }
     * 
     */
    public CreateHtmlResponse createCreateHtmlResponse() {
        return new CreateHtmlResponse();
    }

    /**
     * Create an instance of {@link CreateNewsDetails }
     * 
     */
    public CreateNewsDetails createCreateNewsDetails() {
        return new CreateNewsDetails();
    }

    /**
     * Create an instance of {@link CreateNewsDetailsResponse }
     * 
     */
    public CreateNewsDetailsResponse createCreateNewsDetailsResponse() {
        return new CreateNewsDetailsResponse();
    }

    /**
     * Create an instance of {@link MapConvertor }
     * 
     */
    public MapConvertor createMapConvertor() {
        return new MapConvertor();
    }

    /**
     * Create an instance of {@link MyMapEntry }
     * 
     */
    public MyMapEntry createMyMapEntry() {
        return new MyMapEntry();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Execute }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.front.cdd.com/", name = "__execute")
    public JAXBElement<Execute> createExecute(Execute value) {
        return new JAXBElement<Execute>(_Execute_QNAME, Execute.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link ExecuteResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.front.cdd.com/", name = "__executeResponse")
    public JAXBElement<ExecuteResponse> createExecuteResponse(ExecuteResponse value) {
        return new JAXBElement<ExecuteResponse>(_ExecuteResponse_QNAME, ExecuteResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreateHtml }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.front.cdd.com/", name = "createHtml")
    public JAXBElement<CreateHtml> createCreateHtml(CreateHtml value) {
        return new JAXBElement<CreateHtml>(_CreateHtml_QNAME, CreateHtml.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreateHtmlResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.front.cdd.com/", name = "createHtmlResponse")
    public JAXBElement<CreateHtmlResponse> createCreateHtmlResponse(CreateHtmlResponse value) {
        return new JAXBElement<CreateHtmlResponse>(_CreateHtmlResponse_QNAME, CreateHtmlResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreateNewsDetails }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.front.cdd.com/", name = "createNewsDetails")
    public JAXBElement<CreateNewsDetails> createCreateNewsDetails(CreateNewsDetails value) {
        return new JAXBElement<CreateNewsDetails>(_CreateNewsDetails_QNAME, CreateNewsDetails.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link CreateNewsDetailsResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://server.front.cdd.com/", name = "createNewsDetailsResponse")
    public JAXBElement<CreateNewsDetailsResponse> createCreateNewsDetailsResponse(CreateNewsDetailsResponse value) {
        return new JAXBElement<CreateNewsDetailsResponse>(_CreateNewsDetailsResponse_QNAME, CreateNewsDetailsResponse.class, null, value);
    }

}
