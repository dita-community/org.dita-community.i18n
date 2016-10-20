package org.ditacommunity.i18n.textanalysis;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;
import net.sf.saxon.om.Item;
import net.sf.saxon.om.SequenceIterator;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.value.BigIntegerValue;
import net.sf.saxon.value.StringValue;

import java.text.CharacterIterator;
import java.util.ArrayList;
import java.util.Locale;

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
public class LineSplittingSequenceIterator implements SequenceIterator {

    private final Locale locale;
    private final BreakIterator breakIterator;
    private final String text;
    private boolean debug = false;
    private String currentWord = null;
    private int position = 0; // For XSLT position(). First item will be position 1;
    private Item currentItem = null;
    ArrayList<Item> items = new ArrayList<Item>();

    public LineSplittingSequenceIterator(Locale locale, String text, boolean debug) {
        this.locale = locale;
        this.breakIterator = RuleBasedBreakIterator.getLineInstance(locale);
        breakIterator.setText(text);
        this.text = text.toString();
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
    public Item next() throws XPathException {
        return getNextItem();
    }

    @Override
    public Item current() {
        if (null == this.currentItem ) {
            this.getNextItem();
        }
        return this.currentItem;
    }

    private Item getNextItem() {
        int pos = breakIterator.next();
        Item value = null;
        if (pos != BreakIterator.DONE) {
            // XSLT positions are 1 indexed:
            value = new BigIntegerValue(pos + 1);
        }
        this.currentItem = value;
        return value;
    }

    @Override
    public int position() {
        return position;
    }

    @Override
    public void close() {
        // Nothing to do.
    }

    @Override
    public SequenceIterator getAnother() throws XPathException {
        return LineSplittingSequenceIterator.
                getInstanceForLocale(locale,
                                     breakIterator.getText().toString());
    }

    @Override
    public int getProperties() {
        return 0; // Not grounded, not lookahead capable, not last position capable.
    }
}
