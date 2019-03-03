package org.ditacommunity.i18n.collation;

import java.text.CollationKey;
import java.text.Collator;
import java.util.HashMap;
import java.util.Locale;

import com.ibm.icu.text.RuleBasedCollator;

import net.sf.saxon.expr.sort.AtomicMatchKey;
import net.sf.saxon.lib.StringCollator;

/**
 * Rules-based collator that uses the CC-CEDICT Simplified Chinese
 * dictionary to do collation of Simplified Chinese.
 */
public class ZhCnAwareCollator extends Collator
        implements java.util.Comparator<Object>, StringCollator {

    private final com.ibm.icu.text.Collator delegate;
    private final Locale locale ;
    private final boolean isZhCn;
    private HashMap<String, ZhCnAwareCollationKey> colKeyCache = new HashMap<String, ZhCnAwareCollationKey>();
    private ZhCnDictionary zhCnDictionary;
    private String collationURI;

    public ZhCnAwareCollator(String collationURI)  {
        this.collationURI = collationURI;
        this.locale = Locale.getDefault();
        this.isZhCn = Locale.SIMPLIFIED_CHINESE == locale;
        this.delegate = RuleBasedCollator.getInstance(locale);
    }


    public ZhCnAwareCollator(Locale locale)  {
        this.delegate = RuleBasedCollator.getInstance(locale);
        this.locale = locale;
        this.isZhCn = Locale.SIMPLIFIED_CHINESE == locale;
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
        if (false) {
          System.out.print("getInstance(): desiredLocale=" + desiredLocale);
        }
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
            result = delegate.compare(source, target);
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

        if (zhCnDictionary == null) {
            // Because the dictionary is in the jar this should never fail in normal operation.
            this.zhCnDictionary = new ZhCnDictionary();
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

    @Override
    public String getCollationURI() {
        return this.collationURI;
    }

    @Override
    public int compareStrings(CharSequence charSequence, CharSequence charSequence1) {
        return zhCnCompare(charSequence.toString(), charSequence.toString());
    }

    @Override
    public boolean comparesEqual(CharSequence charSequence, CharSequence charSequence1) {
        throw new UnsupportedOperationException();
    }

    @Override
    public AtomicMatchKey getCollationKey(CharSequence charSequence) {
        throw new UnsupportedOperationException();
    }


    /**
     * Gets the locale associated with the collators
     * @return
     */
    public Locale getLocale() {
      return this.locale;
    }




}
