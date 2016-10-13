package org.ditacommunity.i18n.saxon;

import net.sf.saxon.Configuration;
import net.sf.saxon.sort.CollationURIResolver;
import net.sf.saxon.sort.StandardCollationURIResolver;
import net.sf.saxon.sort.StringCollator;
import org.ditacommunity.i18n.collation.ZhCnAwareCollator;

/**
 * Resolves references to the DITA Community zh-CN URI resolver, setting the
 * properties specified on the URI.
 * <p>This version matches the Saxon 9.1 API
 */
public class DCI18nCollationUriResolver91 extends DCI18nCollationUriResolverBase implements CollationURIResolver {

    private final StandardCollationURIResolver defaultResolver;

    public DCI18nCollationUriResolver91() {
        super();
        defaultResolver = StandardCollationURIResolver.getInstance();
    }

    public StringCollator resolve(String uri, String base, Configuration configuration) {
        System.out.println("+ [DEBUG] DCI18nCollationUriResolver91.resolve(): Collation URI=\"" + uri + "\"");
        ZhCnAwareCollator collator = resolveToZhCnAwareCollator(uri);
        if (null == collator) {
            System.out.println("+ [DEBUG] DCI18nCollationUriResolver91.resolve():   Failed to construct a ZhCnAwareCollator, delegating to default resolver.");
            return defaultResolver.resolve(uri, base, configuration);
        }
        System.out.println("+ [DEBUG] DCI18nCollationUriResolver91.resolve():   Returning ZhCnAwareCollator");
        return (StringCollator)collator;
    }

}
