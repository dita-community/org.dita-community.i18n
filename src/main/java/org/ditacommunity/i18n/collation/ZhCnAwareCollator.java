package org.ditacommunity.i18n.collation;

import com.ibm.icu.text.RuleBasedCollator;
import net.sf.saxon.sort.StringCollator;
import org.ditacommunity.i18n.collation.configuration.GroupingAndSortingHelper;
import org.ditacommunity.i18n.collation.configuration.GroupingAndSortingHelperException;

import java.io.File;
import java.text.CollationKey;
import java.text.Collator;
import java.util.HashMap;
import java.util.Locale;

/**
 * Rules-based collator that uses the CC-CEDICT Simplified Chinese
 * dictionary to do collation of Simplified Chinese.
 */
public class ZhCnAwareCollator extends Collator
        implements java.util.Comparator<Object>, StringCollator {

    public static final String CONF_GROUPING_AND_SORTING_GROUPING_AND_SORTING_RULES_XML =
            "conf/grouping-and-sorting/grouping_and_sorting_rules.xml";
    private final RuleBasedCollator delegate;
    private final Locale locale ;
    private final boolean isZhCn;
    private HashMap<String, ZhCnAwareCollationKey> colKeyCache = new HashMap<String, ZhCnAwareCollationKey>();
    private String collationURI;

    public ZhCnAwareCollator(String collationURI)  {
        this.collationURI = collationURI;
        this.locale = Locale.getDefault();
        this.isZhCn = Locale.SIMPLIFIED_CHINESE == locale;
        this.delegate = getConfiguredICUCollator(locale);
    }


    public ZhCnAwareCollator(Locale locale)  {
        this.delegate = getConfiguredICUCollator(locale);

        this.locale = locale;
        this.isZhCn = Locale.SIMPLIFIED_CHINESE == locale;
    }

    private RuleBasedCollator getConfiguredICUCollator(Locale locale) {
        // FIXME: This reflects the original API design implemented by me (Eliot)
        // many years ago. This is obviously not the best design but don't have time
        // to refactor it now.

        // FIXME: This is a hack to avoid having to work out a better configuration mechanism at
        // this time. The better implementation should expect a URI and should use the configured
        // resolution catalog to resolve it.
        final File myJarFile = new File(ZhCnAwareCollator.class.getProtectionDomain().getCodeSource().getLocation().getPath());
        final File configFile =
                new File(myJarFile.getParentFile().getParentFile(),
                         CONF_GROUPING_AND_SORTING_GROUPING_AND_SORTING_RULES_XML);
        RuleBasedCollator collator;
        GroupingAndSortingHelper helper = null;
        try {
            helper = new GroupingAndSortingHelper(configFile.getAbsolutePath());
            collator = helper.getComparator(locale);
        } catch (Exception e) {
            e.printStackTrace();
            collator = (RuleBasedCollator)RuleBasedCollator.getInstance(locale);
        }
        return collator;
    }

    @Override
    public int compareStrings(String source, String target) {

        return this.compare(source, target);
    }

    @Override
    public synchronized CollationKey getCollationKey(String source) {
        if (this.colKeyCache.containsKey(source)) {
            return this.colKeyCache.get(source);
        }
        ZhCnAwareCollationKey colKey = new ZhCnAwareCollationKey(delegate, source);
        this.colKeyCache.put(source, colKey);
        return colKey;
    }

    @Override
    public int hashCode() {
        return delegate.hashCode();
    }

    /**
     * Gets the Collator for the desired locale. Always returns a
     * ZhCnAwareCollator.
     *
     * @param desiredLocale the desired locale.
     * @return the Collator for the desired locale.
     * @see java.util.Locale
     * @see java.util.ResourceBundle
     */
    public static synchronized Collator getInstance(Locale desiredLocale) {
        System.out.print("getInstance(): desiredLocale=" + desiredLocale);
        Collator collator = new ZhCnAwareCollator(desiredLocale);
        return collator;

    }

    @Override
    public int compare(String source, String target) {
        int result;
        if (isZhCn) {
            try {
                result = zhCnCompare(source, target);
            } catch (Exception e) {
                System.out.println(" + [ERROR] ZhCnAwareCollator.compare(): " + e.getClass().getSimpleName());
                e.printStackTrace();
                result = delegate.compare(source, target);
            }
        } else {
//            System.out.println("+ [DEBUG] ZhCnAwareCollator.compare(): Using delegate comparator on \"" + source + "\", \"" + target + "\"");
            result = delegate.compare(source, target);
//            System.out.println("+ [DEBUG] ZhCnAwareCollator.compare(): Returning \"" + result + "\"");
        }
        return result;
    }

    /**
     * Use the Simplified Chinese sort keys to do the comparison. The sort keys
     * are then passed to the base ICU collator so that its normal rule-based
     * configuration rules are then applied. For Simplified Chinese the sort key
     * is the pinyin transliteration of the Chinese word, so the base part of the sort
     * key is always in latin script.
     * @param source Source string
     * @param target Target string
     * @return Comparison value.
     */
    private int zhCnCompare(String source, String target) {

        String sourceSortKey = getZhCnSortKey(source);
        String targetSortKey = getZhCnSortKey(target);

        return delegate.compare(sourceSortKey, targetSortKey);
    }

    /**
     * Given a string that may contain Simplified Chinese ideographs, return
     * the appropiate sort key, which is the pinyin transliteration as the
     * primary key and the original text as the secondary key.
     * @param source Source string.
     * @return Sort key for use by the RuleBasedCollator.compare() method.
     */
    protected String getZhCnSortKey(String source) {

        if (this.colKeyCache.containsKey(source)) {
            return colKeyCache.get(source).getSortKey();
        }


        String pinyin = ZhCnDictionary.getPinYin(source);
        // FIXME: Construct proper primary/secondary ICU sort key.
        return pinyin + source;
    }

    @Override
    public int compare(Object o1, Object o2) {
        return delegate.compare(o1, o2);
    }

    public void setCollationURI(String collationURI) {
        this.collationURI = collationURI;
    }

    /**
     * Get the ICU RuleBasedCollator that backs this collator. Useful mostly for testing
     * and debugging.
     * @return The backing collator.
     */
    public RuleBasedCollator getBackingCollator() {
        return this.delegate;
    }

    /**
     * Get the locale for which the collator was originally constructed.
     * @return
     */
    public Locale getLocale() {
        return this.locale;
    }
}
