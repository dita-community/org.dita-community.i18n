package org.ditacommunity.i18n.saxon;

import net.sf.saxon.Configuration;
import net.sf.saxon.sort.CollationURIResolver;
import net.sf.saxon.sort.StandardCollationURIResolver;
import net.sf.saxon.sort.StringCollator;
import net.sf.saxon.trans.XPathException;
import org.ditacommunity.i18n.collation.ZhCnAwareCollator;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;

/**
 * Resolves references to the DITA Community zh-CN URI resolver, setting the
 * properties specified on the URI.
 * <p>The interface net.sf.saxon.lib.CollationURIResolver is in Saxon 9.6+ but not 9.1.</p>
 */
public class DCI18nCollationUriResolver96 implements net.sf.saxon.lib.CollationURIResolver {

    DCI18nCollationUriResolverBase delegate;

    public DCI18nCollationUriResolver96() {
        delegate = new DCI18nCollationUriResolverBase();
    }


    @Override
    public net.sf.saxon.lib.StringCollator resolve(String uri, Configuration configuration) throws XPathException {
        return (net.sf.saxon.lib.StringCollator)(delegate.resolve(uri, null, configuration));
    }
}
