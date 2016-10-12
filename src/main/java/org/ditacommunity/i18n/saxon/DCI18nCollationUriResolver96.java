package org.ditacommunity.i18n.saxon;

import net.sf.saxon.Configuration;
import net.sf.saxon.lib.StandardCollationURIResolver;
import net.sf.saxon.lib.StringCollator;
import net.sf.saxon.trans.XPathException;
import org.ditacommunity.i18n.collation.ZhCnAwareCollator;

/**
 * Resolves references to the DITA Community zh-CN URI resolver, setting the
 * properties specified on the URI.
 * <p>The interface net.sf.saxon.lib.CollationURIResolver is in Saxon 9.6+ but not 9.1.</p>
 */
public class DCI18nCollationUriResolver96 extends DCI18nCollationUriResolverBase
        implements net.sf.saxon.lib.CollationURIResolver {


    private final StandardCollationURIResolver defaultResolver;

    public DCI18nCollationUriResolver96() {
        super();
        this.defaultResolver = StandardCollationURIResolver.getInstance();

    }


    public net.sf.saxon.lib.StringCollator resolve(String uri, Configuration configuration) throws XPathException {
        ZhCnAwareCollator collator = resolveToZhCnAwareCollator(uri, null, configuration);
        if (null == collator) {
            return defaultResolver.resolve(uri, configuration);
        }
        return (StringCollator) collator;
    }
}
