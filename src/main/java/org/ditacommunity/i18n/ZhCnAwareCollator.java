package org.ditacommunity.i18n;

import java.text.CollationKey;
import java.text.Collator;
import java.text.ParseException;
import java.text.RuleBasedCollator;
import java.util.Comparator;
import java.util.Locale;

/**
 * Rules-based collator that uses the CC-CEDICT Simplified Chinese
 * dictionary to do collation of Simplified Chinese.
 */
public class ZhCnAwareCollator extends RuleBasedCollator implements java.util.Comparator<Object> {

    /**
     * RuleBasedCollator constructor.  This takes the table rules and builds
     * a collation table out of them.  Please see RuleBasedCollator class
     * description for more details on the collation rule syntax.
     *
     * @param rules the collation rules to build the collation table from.
     * @throws ParseException A format exception
     *                        will be thrown if the build process of the rules fails. For
     *                        example, build rule "a &lt; ? &lt; d" will cause the constructor to
     *                        throw the ParseException because the '?' is not quoted.
     * @see Locale
     */
    public ZhCnAwareCollator(String rules) throws ParseException {
        // FIXME: Load zh-CN rules using dictionary
        super(rules);
    }

    @Override
    public synchronized CollationKey getCollationKey(String source) {
        // If locale is zh-CN, use the dictionary, otherwise delegate
        // to superclass.
        return super.getCollationKey(source);

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
        return RuleBasedCollator.getInstance(desiredLocale);

    }
}
