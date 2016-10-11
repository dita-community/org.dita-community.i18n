package org.ditacommunity.i18n.saxon;

import net.sf.saxon.FeatureKeys;
import net.sf.saxon.TransformerFactoryImpl;

/**
 * Replacement for the base Saxon transformer factory so we can set
 * our own features, in particular, the collation URI resolver.
 *
 */
public class DCI18nSaxonTransformerFactoryImpl extends TransformerFactoryImpl {

    public DCI18nSaxonTransformerFactoryImpl() {
        super();
        System.out.println("DCI18nSaxonTransformerFactoryImpl: Setting collation URI resolver to DCI18nCollationUriResolver");
        this.setAttribute(FeatureKeys.COLLATION_URI_RESOLVER, new DCI18nCollationUriResolver());
    }


}
