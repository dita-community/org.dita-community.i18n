import net.sf.saxon.FeatureKeys;
import org.ditacommunity.i18n.saxon.DCI18nCollationUriResolver;
import org.junit.Test;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertEquals;


import javax.xml.transform.TransformerFactory;

/**
 * Created by ekimber on 10/10/16.
 */
public class TestSaxonFactorySetup {

    @Test
    public void testSaxonSetup() throws Exception {

        System.setProperty("java.xml.transform.TransformerFactory",
                           "DCI18nSaxonTransformerFactoryImpl");

        TransformerFactory factory = TransformerFactory.newInstance();

        assertEquals("Not a DCI18n transformer factory",
                     "DCI18nSaxonTransformerFactoryImpl",
                     factory.getClass().getName());

        String collationUriResolverClass = (String)factory.getAttribute(FeatureKeys.COLLATION_URI_RESOLVER_CLASS);
        assertEquals("Not a DCI18n collation resolver",
                DCI18nCollationUriResolver.class.getName(),
                collationUriResolverClass
                );

    }

}
