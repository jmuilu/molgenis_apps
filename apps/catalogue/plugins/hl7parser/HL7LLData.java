/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package plugins.hl7parser;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import plugins.hl7parser.GenericDCM.HL7GenericDCM;
import plugins.hl7parser.GenericDCM.HL7OrganizerDCM;
import plugins.hl7parser.StageLRA.HL7OrganizerLRA;
import plugins.hl7parser.StageLRA.HL7StageLRA;
import plugins.hl7parser.StageLRA.HL7ValueSetAnswerLRA;
import plugins.hl7parser.StageLRA.HL7ValueSetLRA;

/**
 *
 * @author roankanninga
 * based on 3 files from LifeLines
 */
public class HL7LLData implements HL7Data{

	
	private static final String ORGANIZER = "/urn:hl7-org:v3:catalog/urn:hl7-org:v3:component/urn:hl7-org:v3:organizer/urn:hl7-org:v3:code";
	private static final String VALUESET = "/urn:hl7-org:v3:valueSets/urn:hl7-org:v3:valueSet";
	private HashMap<String, HL7ValueSetLRA> hashValueSetLRA = new HashMap<String, HL7ValueSetLRA>();
	
	XPath xpath;
    public HL7GenericDCM hl7GenericDCM = null;
    
	public HL7StageLRA hl7StageLRA = null;
    

	private NodeList readFile(String file, XPath xpath,String xpathExpres) throws Exception{
        
        DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
        domFactory.setNamespaceAware(true);
        DocumentBuilder builder = domFactory.newDocumentBuilder();
        Document doc = builder.parse(file);
        NodeList nodesFile = (NodeList)xpath.compile(xpathExpres).evaluate(doc, XPathConstants.NODESET);
        return nodesFile;
    }
    
    public HL7LLData(String file1,String file2) throws Exception{
    	ArrayList<Node> allOrganizerNodes = new ArrayList<Node>();
        XPathFactory factory = XPathFactory.newInstance();
        this.xpath = factory.newXPath();
       
        //Normal xml file
        NodeList nodesFile1 = readFile(file1,xpath, ORGANIZER);

       
        for (int i = 0; i < nodesFile1.getLength(); i++) {
            
        	if(nodesFile1.item(i).getAttributes().getNamedItem("code").getNodeValue().equals("Generic")){
               hl7GenericDCM = new HL7GenericDCM (nodesFile1.item(i).getParentNode(),xpath);

            }
            else if(nodesFile1.item(i).getAttributes().getNamedItem("code").getNodeValue().equals("LRA")){
                hl7StageLRA = new HL7StageLRA (nodesFile1.item(i).getParentNode(),xpath);
            }
            else{
                System.out.println("Error");
            }
            allOrganizerNodes.add(nodesFile1.item(i));
        }
       
        
        //Valuesets xml file
        NodeList nodesFile2 = readFile(file2,xpath, VALUESET);
        
     
        for (int i = 0; i < nodesFile2.getLength(); i++) {
        	
        	HL7ValueSetLRA valueSetLRA = new HL7ValueSetLRA(nodesFile2.item(i), xpath);
        	hashValueSetLRA.put(valueSetLRA.getValueSetsName(), valueSetLRA);
        	System.out.println("protocol "+i+": " +valueSetLRA.getValueSetsName());
        	for(HL7ValueSetAnswerLRA r : valueSetLRA.getListOFAnswers()){
        		System.out.println("ValuesetAnswer: " + r.getName()+"\t"+r.getCodeValue());
        	}
//            
        }
        
        System.out.println("Damn it!------------->" + hashValueSetLRA.size());
    }


    public HashMap<String, HL7ValueSetLRA> getHashValueSetLRA() {
		return hashValueSetLRA;
	}
    
	public ArrayList<HL7OrganizerLRA> getHL7OrganizerLRA(){
        
        return hl7StageLRA.getHL7OrganizerLRA();
    }
    public ArrayList<HL7OrganizerDCM> getHL7OrganizerDCM(){
        
        return hl7GenericDCM.getHL7OrganizerDCM();
    }
    
    public HL7GenericDCM getHl7GenericDCM() {
		return hl7GenericDCM;
	}
    public HL7StageLRA getHl7StageLRA() {
		return hl7StageLRA;
	}

}
