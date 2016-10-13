package org.ditacommunity.i18n.saxon;

import net.sf.saxon.FeatureKeys;
import net.sf.saxon.TransformerFactoryImpl;

/**
 * Replacement for the base Saxon transformer factory so we can set
 * our own features, in particular, the collation URI resolver.
 * <p>Provides a Saxon 9.1 collation resolver.</p>
 */
public class DCI18nSaxonTransformerFactoryImpl91 extends TransformerFactoryImpl {

    public DCI18nSaxonTransformerFactoryImpl91() {
        super();
        System.out.println("DCI18nSaxonTransformerFactoryImpl: Setting collation URI resolver to DCI18nCollationUriResolver91");
        this.setAttribute(FeatureKeys.COLLATION_URI_RESOLVER, new DCI18nCollationUriResolver91());
    }


}
