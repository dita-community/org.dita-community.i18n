package org.ditacommunity.i18n.saxon;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.dita.dost.module.saxon.DelegatingCollationUriResolver;
import org.ditacommunity.i18n.collation.ZhCnAwareCollator;

import net.sf.saxon.Configuration;
import net.sf.saxon.lib.CollationURIResolver;
import net.sf.saxon.lib.StandardCollationURIResolver;
import net.sf.saxon.lib.StringCollator;
import net.sf.saxon.trans.XPathException;

/**
 * Resolves references to the DITA Community zh-CN URI resolver, setting the
 * properties specified on the URI.
 * <p>The interface net.sf.saxon.lib.CollationURIResolver is in Saxon 9.6+ but not 9.1.</p>
 */
public class DCI18nCollationUriResolver implements DelegatingCollationUriResolver {

  public static final String DITA_COMMUNITY_I18N_ZH_CNAWARE_COLLATOR =
      "http://org.dita-community.i18n.zhCNawareCollator";
  public static final String LANG_URI_PARAM = "lang";

  private CollationURIResolver baseResolver;

  public DCI18nCollationUriResolver() {
      super();
      this.baseResolver = StandardCollationURIResolver.getInstance();

  }


  public net.sf.saxon.lib.StringCollator resolve(String uri, Configuration configuration) throws XPathException {
      ZhCnAwareCollator collator = resolveToZhCnAwareCollator(uri, null, configuration);
      if (null == collator) {
          return baseResolver.resolve(uri, configuration);
      }
      return (StringCollator) collator;
  }


  @Override
  public void setBaseResolver(CollationURIResolver baseResolver) {
    this.baseResolver = baseResolver;
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
  
  /**
   * Get a ZhCnAwareCollator or, if this fails for some very unlikely reason, return null.
   * It's up to the caller to provide a default resolver if this method returns null;
   * @param uri The URI of the collator
   * @param base Base for the URI
   * @param configuration The Saxon configuration object.
   * @return A ZhCnAwareCollator instance or null (should never happen).
   */
  protected ZhCnAwareCollator resolveToZhCnAwareCollator(String uri, String base, Configuration configuration) {
  
      if (uri.startsWith(DITA_COMMUNITY_I18N_ZH_CNAWARE_COLLATOR)) {
          URL url = null;
          Map<String, List<String>> params;
          try {
              url = new URL(uri);
              params = splitQuery(url);
          } catch (Exception e) {
              // Should never happen.
              return null;
          }
          String locale = Locale.getDefault().toString();
          // "lang" is the parameter defined by Saxon for Saxon collation URIs, so using
          // that convention.
          if (params.containsKey(LANG_URI_PARAM)) {
              locale = params.get(LANG_URI_PARAM).get(0);
          }
          ZhCnAwareCollator collator = (ZhCnAwareCollator)ZhCnAwareCollator.getInstance(Locale.forLanguageTag(locale));
          // System.out.println("DCI18nCollationUriResolver.resolveToZhCnAwareCollator(): " +
          //        "Constructing ZhCnAwareCollator for language \"" + locale + "\"");
          collator.setCollationURI(uri);
          return collator;
      }
      return null;
  }
}
