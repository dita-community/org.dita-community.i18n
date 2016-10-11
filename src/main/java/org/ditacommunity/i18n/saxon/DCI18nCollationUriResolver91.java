package org.ditacommunity.i18n.saxon;

import net.sf.saxon.Configuration;
import net.sf.saxon.sort.CollationURIResolver;
import net.sf.saxon.sort.StandardCollationURIResolver;
import net.sf.saxon.sort.StringCollator;
import org.ditacommunity.i18n.collation.ZhCnAwareCollator;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;

/**
 * Resolves references to the DITA Community zh-CN URI resolver, setting the
 * properties specified on the URI.
 * <p>This version matches the Saxon 9.1 API
 */
public class DCI18nCollationUriResolver91 extends DCI18nCollationUriResolverBase implements CollationURIResolver {

    public DCI18nCollationUriResolver91() {
        super();
    }

}
