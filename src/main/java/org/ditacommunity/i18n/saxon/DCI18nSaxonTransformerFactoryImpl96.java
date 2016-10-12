package org.ditacommunity.i18n.saxon;

import net.sf.saxon.Configuration;
import net.sf.saxon.TransformerFactoryImpl;
import net.sf.saxon.lib.FeatureKeys;
import net.sf.saxon.lib.StringCollator;

/**
 * Replacement for the base Saxon transformer factory so we can set
 * our own features, in particular, the collation URI resolver.
 * <p>Provides a Saxon 9.6+ collation URI resolver.</p>
 */
public class DCI18nSaxonTransformerFactoryImpl96 extends TransformerFactoryImpl {

    public DCI18nSaxonTransformerFactoryImpl96() {
        super();
        System.out.println("DCI18nSaxonTransformerFactoryImpl: Setting collation URI resolver to DCI18nCollationUriResolver96");
        this.setAttribute(FeatureKeys.COLLATION_URI_RESOLVER, new DCI18nCollationUriResolver96());
    }

}
