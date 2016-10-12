package org.ditacommunity.i18n.saxon;

import net.sf.saxon.FeatureKeys;
import org.junit.Test;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;


import javax.xml.transform.TransformerFactory;

public class TestSaxonFactorySetup {

    @Test
    /**
     * Test use of the Saxon 9.1 API for collators and collation URI resolvers.
     */
    public void testSaxonSetup91() throws Exception {

        System.setProperty("javax.xml.transform.TransformerFactory",
                           "org.ditacommunity.i18n.saxon.DCI18nSaxonTransformerFactoryImpl91");

        TransformerFactory factory = TransformerFactory.newInstance();

        assertEquals("Not a DCI18n transformer factory",
                     "org.ditacommunity.i18n.saxon.DCI18nSaxonTransformerFactoryImpl91",
                     factory.getClass().getName());

        String collationUriResolverClass = (String)factory.getAttribute(FeatureKeys.COLLATION_URI_RESOLVER_CLASS);
        assertEquals("Not a DCI18n collation resolver",
                DCI18nCollationUriResolver91.class.getName(),
                collationUriResolverClass
                );

    }


}
