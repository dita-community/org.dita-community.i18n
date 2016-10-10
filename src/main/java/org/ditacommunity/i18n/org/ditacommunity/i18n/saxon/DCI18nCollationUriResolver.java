package org.ditacommunity.i18n.org.ditacommunity.i18n.saxon;

import net.sf.saxon.Configuration;
import net.sf.saxon.sort.CollationURIResolver;
import net.sf.saxon.sort.StandardCollationURIResolver;
import net.sf.saxon.sort.StringCollator;
import org.ditacommunity.i18n.ZhCnAwareCollator;

import java.text.Collator;
import java.text.RuleBasedCollator;
import java.util.Locale;

/**
 * Resolves references to the DITA Community zh-CN URI resolver, setting the
 * properties specified on the URI.
 */
public class DCI18nCollationUriResolver implements CollationURIResolver {
    private final StandardCollationURIResolver defaultResolver;

    public DCI18nCollationUriResolver() {
        this.defaultResolver = StandardCollationURIResolver.getInstance();
    }

    public StringCollator resolve(String uri, String base, Configuration configuration) {
        if (uri.startsWith("http://org.dita-community.i18n.zhCNawareCollator")) {
            StringCollator collator =
                    (StringCollator)(ZhCnAwareCollator.getInstance(Locale.forLanguageTag("zh-CN")));
            return collator;
        } else {
            return defaultResolver.resolve(uri, base, configuration);
        }
    }

}
