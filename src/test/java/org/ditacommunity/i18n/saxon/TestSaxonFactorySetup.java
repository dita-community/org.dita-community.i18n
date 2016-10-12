package org.ditacommunity.i18n.saxon;

import net.sf.saxon.FeatureKeys;
import org.junit.Test;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;


import javax.xml.transform.TransformerFactory;

public class TestSaxonFactorySetup {

    /**
     * Test use of the Saxon 9.6+ API for collators and collation URI resolvers.
     * @throws Exception
     */
    @Test
    public void testSaxonSetup96() throws Exception {

        System.setProperty("javax.xml.transform.TransformerFactory",
                "org.ditacommunity.i18n.saxon.DCI18nSaxonTransformerFactoryImpl96");

        TransformerFactory factory = TransformerFactory.newInstance();

        assertEquals("Not a DCI18n transformer factory",
                "org.ditacommunity.i18n.saxon.DCI18nSaxonTransformerFactoryImpl96",
                factory.getClass().getName());

        String collationUriResolverClass = (String)factory.getAttribute(FeatureKeys.COLLATION_URI_RESOLVER_CLASS);
        assertEquals("Not a DCI18n collation resolver",
                DCI18nCollationUriResolver96.class.getName(),
                collationUriResolverClass
        );
        Object resolver = Class.forName(collationUriResolverClass);
        assertTrue("Not a saxon resolver", resolver instanceof net.sf.saxon.lib.CollationURIResolver);

    }

}
