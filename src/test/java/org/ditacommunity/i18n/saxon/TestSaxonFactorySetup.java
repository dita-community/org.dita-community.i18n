package org.ditacommunity.i18n.saxon;

import com.ibm.icu.text.RuleBasedBreakIterator;
import com.ibm.icu.text.RuleBasedCollator;
import net.sf.saxon.FeatureKeys;
import net.sf.saxon.sort.CollationURIResolver;
import org.ditacommunity.i18n.collation.ZhCnAwareCollator;
import org.junit.Test;

import static org.junit.Assert.assertNotNull;
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

        CollationURIResolver resolver = new DCI18nCollationUriResolver91();
        Object collator = resolver.resolve(DCI18nCollationUriResolver91.DITA_COMMUNITY_I18N_ZH_CNAWARE_COLLATOR + "?lang=zh-CN", "", null);
        assertNotNull(collator);
        assertTrue("Not an ICU collator", collator instanceof ZhCnAwareCollator);
        RuleBasedCollator delegate = ((ZhCnAwareCollator)collator).getBackingCollator();
        assertNotNull(delegate);

    }


}
