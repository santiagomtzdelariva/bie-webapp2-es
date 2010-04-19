/***************************************************************************
 * Copyright (C) 2009 Atlas of Living Australia
 * All Rights Reserved.
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 ***************************************************************************/
package org.ala.documentmappers;

import java.util.List;

import junit.framework.Assert;
import junit.framework.TestCase;
import org.ala.documentmapper.AusmothsDocumentMapper;
import org.ala.repository.ParsedDocument;
import org.ala.repository.Triple;
import org.ala.util.WebUtils;

/**
 *
 * @author Tommy Wang (twang@wollemisystems.com)
 */
public class AusmothsDocumentMapperTest extends TestCase {

	final String hasScientificName = "ANCYLIS volutana";
	final String hasImagePageUrl = "http://www1.ala.org.au/gallery2/d/4898-2/ANCYLIS+volutana+Meyrick+1881+Redpa+Tas+F.jpg";
	final String hasFamily = "Tortricidae";
	
	public void test() throws Exception {
		AusmothsDocumentMapper dm = new AusmothsDocumentMapper();
		String uri = "http://www1.ala.org.au/gallery2/v/Tortricidae/olethreutinae/Enarmoniini/ANCYLIS+volutana+Meyrick+1881+Redpa+Tas+F.jpg.html";
		String xml = WebUtils.getHTMLPageAsXML(uri);
		//System.out.println(xml);
		List<ParsedDocument> parsedDocs = dm.map(uri, xml.getBytes());
		
		for(ParsedDocument pd : parsedDocs){
			DebugUtils.debugParsedDoc(pd);
			
			List<Triple<String,String,String>> triples = pd.getTriples();
			for(Triple triple: triples){
				
				String predicate = (String) triple.getPredicate();
				String object = (String) triple.getObject();
				
				if (predicate.endsWith("hasScientificName")) {
					Assert.assertEquals(object, hasScientificName);		    	  
				}

				if (predicate.endsWith("hasFamily")) {
					Assert.assertEquals(object, hasFamily);		    	  
				}
			}
		}
	}
}