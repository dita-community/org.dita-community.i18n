package org.ditacommunity.i18n.textanalysis;

import java.util.ArrayList;
import java.util.Locale;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;

import net.sf.saxon.om.Item;
import net.sf.saxon.om.SequenceIterator;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.value.BigIntegerValue;

/**
 *
 * Saxon sequence iterator that returns a sequence of integers representing the line break
 * points in the input string.
 *
 * FIXME: Would be good to be able to cache iterators that are used from the
 * same thread as instantiating break iterators can be expensive. However,
 * because you set the text on the breakiterator can't share the same instance
 * across different threads. Not sure how that works in a Saxon context.
 */
public class LineSplittingSequenceIterator implements SequenceIterator<Item<?>> {

    private final Locale locale;
    private final BreakIterator breakIterator;
    private boolean debug = false;
    ArrayList<Item<?>> items = new ArrayList<Item<?>>();

    public LineSplittingSequenceIterator(Locale locale, String text, boolean debug) {
        this.locale = locale;
        this.breakIterator = RuleBasedBreakIterator.getLineInstance(locale);
        breakIterator.setText(text);
        this.debug = debug;
    }

    public static LineSplittingSequenceIterator getInstanceForLocale(Locale locale, String text) {
        LineSplittingSequenceIterator iterator = new LineSplittingSequenceIterator(locale, text, false);
        return iterator;
    }

    public static LineSplittingSequenceIterator getInstanceForLocale(Locale locale, String text, boolean debug) {
        LineSplittingSequenceIterator iterator = new LineSplittingSequenceIterator(locale, text, debug);
        return iterator;
    }

    @Override
    public Item<?> next() throws XPathException {
        return getNextItem();
    }

    private Item<?> getNextItem() {
        int pos = breakIterator.next();
        Item<?> value = null;
        if (pos != BreakIterator.DONE) {
            // XSLT positions are 1 indexed:
            value = new BigIntegerValue(pos + 1);
        }
        return value;
    }
    
    /*
     * Returns the current debug state.
     * @return True if debugging has been turned on.
     */
    public boolean isDebug() {
    		return this.debug;
    }

    @Override
    public void close() {
        // Nothing to do.
    }

    //@Override
    public SequenceIterator<?> getAnother() throws XPathException {
        return LineSplittingSequenceIterator.
                getInstanceForLocale(locale,
                                     breakIterator.getText().toString());
    }

    @Override
    public int getProperties() {
        return 0; // Not grounded, not lookahead capable, not last position capable.
    }
}
