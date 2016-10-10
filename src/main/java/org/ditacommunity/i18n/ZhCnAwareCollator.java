package org.ditacommunity.i18n;

import com.ibm.icu.text.RuleBasedCollator;

import java.text.CollationKey;
import java.text.Collator;
import java.text.ParseException;
import java.util.Comparator;
import java.util.Locale;

/**
 * Rules-based collator that uses the CC-CEDICT Simplified Chinese
 * dictionary to do collation of Simplified Chinese.
 */
public class ZhCnAwareCollator extends Collator implements java.util.Comparator<Object> {

    private final com.ibm.icu.text.Collator delegate;
    private final Locale locale ;

    public ZhCnAwareCollator()  {
        this.locale = Locale.getDefault();
        this.delegate = RuleBasedCollator.getInstance(locale);

    }


    public ZhCnAwareCollator(Locale locale)  {
        this.delegate = RuleBasedCollator.getInstance(locale);

        this.locale = locale;
    }

    @Override
    public synchronized CollationKey getCollationKey(String source) {
        CollationKey colKey = new ZhCnAwareCollationKey(delegate, source);
        return colKey;
    }

    @Override
    public int hashCode() {
        return delegate.hashCode();
    }

    /**
     * Gets the Collator for the desired locale.
     *
     * @param desiredLocale the desired locale.
     * @return the Collator for the desired locale.
     * @see java.util.Locale
     * @see java.util.ResourceBundle
     */
    public static synchronized Collator getInstance(Locale desiredLocale) {
        System.out.print("getInstance(): desiredLocale=" + desiredLocale);
        // FIXME: If locale is zh-CN then construct a zh-CN collator.
        Collator collator = new ZhCnAwareCollator(desiredLocale);
        return collator;

    }

    @Override
    public int compare(String source, String target) {
        return delegate.compare(source, target);
    }

    @Override
    public int compare(Object o1, Object o2) {
        return delegate.compare(o1, o2);
    }
}
