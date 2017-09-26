package org.ditacommunity.i18n.saxon;

import java.io.InputStream;
import java.util.Properties;

import org.ditacommunity.i18n.collation.ZhCnAwareCollator;

import net.sf.saxon.Configuration;
import net.sf.saxon.sort.CollationURIResolver;
import net.sf.saxon.sort.StandardCollationURIResolver;
import net.sf.saxon.sort.StringCollator;

/**
 * Resolves references to the DITA Community zh-CN URI resolver, setting the
 * properties specified on the URI.
 * <p>This version matches the Saxon 9.1 API
 */
public class DCI18nCollationUriResolver91 extends DCI18nCollationUriResolverBase implements CollationURIResolver {

	private static final long serialVersionUID = 1L;

	private final StandardCollationURIResolver defaultResolver;

    private static final Properties versionProps = new Properties();

    static {
        try {
            InputStream inStream = DCI18nCollationUriResolver91.class.getResourceAsStream("version.properties");
            if (null != inStream) {
                versionProps.load(inStream);
            }
        } catch (Exception e) {
            System.err.println("Failed to load version.properties resource from jar file. This should not happen.");
        }

    }

    public DCI18nCollationUriResolver91() {
        super();
        defaultResolver = StandardCollationURIResolver.getInstance();
    }

    public StringCollator resolve(String uri, String base, Configuration configuration) {
        System.out.println("DCI18nCollationUriResolver91 version " + DCI18nCollationUriResolver91.getVersion());
        System.out.println("+ [DEBUG] DCI18nCollationUriResolver91.resolve(): Collation URI=\"" + uri + "\"");
        ZhCnAwareCollator collator = resolveToZhCnAwareCollator(uri);
        if (null == collator) {
            System.out.println("+ [DEBUG] DCI18nCollationUriResolver91.resolve():   Failed to construct a ZhCnAwareCollator, delegating to default resolver.");
            return defaultResolver.resolve(uri, base, configuration);
        }
        System.out.println("+ [DEBUG] DCI18nCollationUriResolver91.resolve():   Returning ZhCnAwareCollator");
        return (StringCollator)collator;
    }

    public static String getVersion() {
        return versionProps.getProperty("version", "Version not set");
    }

}
