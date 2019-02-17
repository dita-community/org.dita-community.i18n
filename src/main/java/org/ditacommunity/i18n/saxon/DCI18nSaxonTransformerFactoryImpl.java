package org.ditacommunity.i18n.saxon;

import net.sf.saxon.TransformerFactoryImpl;
import net.sf.saxon.lib.FeatureKeys;

/**
 * Replacement for the base Saxon transformer factory so we can set
 * our own features, in particular, the collation URI resolver.
 * <p>Provides a Saxon 9.6+ collation URI resolver.</p>
 */
public class DCI18nSaxonTransformerFactoryImpl extends TransformerFactoryImpl {

    public DCI18nSaxonTransformerFactoryImpl() {
        super();
        System.out.println("DCI18nSaxonTransformerFactoryImpl: Setting collation URI resolver to DCI18nCollationUriResolver");
        this.setAttribute(FeatureKeys.COLLATION_URI_RESOLVER, new DCI18nCollationUriResolver());
    }

}
