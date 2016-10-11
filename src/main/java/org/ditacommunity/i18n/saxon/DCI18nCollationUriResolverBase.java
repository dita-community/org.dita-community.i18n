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
 * Created by ekimber on 10/11/16.
 */
public class DCI18nCollationUriResolverBase {

    protected final CollationURIResolver defaultResolver;

    public static final String DITA_COMMUNITY_I18N_ZH_CNAWARE_COLLATOR =
            "http://org.dita-community.i18n.zhCNawareCollator";
    public static final String LANG_URI_PARAM = "lang";

    protected DCI18nCollationUriResolverBase() {
        this.defaultResolver = StandardCollationURIResolver.getInstance();
    }

    // From http://stackoverflow.com/questions/13592236/parse-a-uri-string-into-name-value-collection
    public static Map<String, List<String>> splitQuery(URL url) throws UnsupportedEncodingException {
        final Map<String, List<String>> query_pairs = new LinkedHashMap<String, List<String>>();
        final String[] pairs = url.getQuery().split("&");
        for (String pair : pairs) {
            final int idx = pair.indexOf("=");
            final String key = idx > 0 ? URLDecoder.decode(pair.substring(0, idx), "UTF-8") : pair;
            if (!query_pairs.containsKey(key)) {
                query_pairs.put(key, new LinkedList<String>());
            }
            final String value = idx > 0 && pair.length() > idx + 1 ? URLDecoder.decode(pair.substring(idx + 1), "UTF-8") : null;
            query_pairs.get(key).add(value);
        }
        return query_pairs;
    }

    public StringCollator resolve(String uri, String base, Configuration configuration) {

        if (uri.startsWith(DITA_COMMUNITY_I18N_ZH_CNAWARE_COLLATOR)) {
            URL url = null;
            Map<String, List<String>> params;
            try {
                url = new URL(uri);
                params = splitQuery(url);
            } catch (Exception e) {
                // Should never happen.
                return defaultResolver.resolve(uri, base, configuration);
            }
            String locale = Locale.getDefault().toString();
            // "lang" is the parameter defined by Saxon for Saxon collation URIs, so using
            // that convention.
            if (params.containsKey(LANG_URI_PARAM)) {
                locale = params.get(LANG_URI_PARAM).get(0);
            }
            StringCollator collator = null;
            collator = (StringCollator) ZhCnAwareCollator.getInstance(Locale.forLanguageTag(locale));
            System.out.println("DCI18nCollationUriResolver.resolve(): " +
                    "Constructing ZhCnAwareCollator for language \"" + locale + "\"");
            ((ZhCnAwareCollator)collator).setCollationURI(uri);
            return collator;
        } else {
            return defaultResolver.resolve(uri, base, configuration);
        }
    }
}
