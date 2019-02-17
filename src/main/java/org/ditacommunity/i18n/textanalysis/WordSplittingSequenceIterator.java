package org.ditacommunity.i18n.textanalysis;

import java.util.Locale;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;

import net.sf.saxon.om.Item;
import net.sf.saxon.om.SequenceIterator;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.value.StringValue;

/**
 * Wrapper for ICU4J RuleBasedBreakIterator for getting words
 * from a text string.
 *
 * FIXME: Would be good to be able to cache iterators that are used from the
 * same thread as instantiating break iterators can be expensive. However,
 * because you set the text on the breakiterator can't share the same instance
 * across different threads. Not sure how that works in a Saxon context.
 */
public class WordSplittingSequenceIterator implements SequenceIterator<Item<?>> {

    private final Locale locale;
    private final BreakIterator breakIterator;
    private final String text;
    private boolean debug = false;

    public WordSplittingSequenceIterator(Locale locale, String text, boolean debug) {
        this.locale = locale;
        this.breakIterator = RuleBasedBreakIterator.getWordInstance(locale);
        breakIterator.setText(text);
        this.text = text;
        this.debug = debug;
    }

    public static WordSplittingSequenceIterator getInstanceForLocale(Locale locale, String text) {
        WordSplittingSequenceIterator iterator = new WordSplittingSequenceIterator(locale, text, false);
        return iterator;
    }

    public static WordSplittingSequenceIterator getInstanceForLocale(Locale locale, String text, boolean debug) {
        WordSplittingSequenceIterator iterator = new WordSplittingSequenceIterator(locale, text, debug);
        return iterator;
    }

    @Override
    public Item<?> next() throws XPathException {
        String word = getNextWord();
        Item<?> value = null;
        if (null != word) {
            value = new StringValue(word);
        }
        return value;
    }

    /**
     * Get the next word. Note that this returns everything, not just words containing
     * letter characters. This allows processing of all the text in a string. It's up to
     * the consumer to decide how to handle non-letter words.
     * @return The next word or null if we are at the end of the text.
     */
    private String getNextWord() {
        String word = null;
        int start = breakIterator.current();
        int end = breakIterator.next();
        if (BreakIterator.DONE != end) {
            word = this.text.substring(start, end);
        }
        if (debug) {
            System.out.println("getNextWord(): start: " + start + "; end: " + end + "; word=\"" + word + "\"");
        }
        if (debug) {
            System.out.println("getNextWord(): Returning " + word);
        }
        return word;
    }

    @Override
    public void close() {
        // Nothing to do.
    }

    // @Override
    // This is not in the 9.6+ API
    public SequenceIterator<?> getAnother() throws XPathException {
        return WordSplittingSequenceIterator.getInstanceForLocale(locale, breakIterator.getText().toString());
    }

    @Override
    public int getProperties() {
        return 0; // Not grounded, not lookahead capable, not last position capable.
    }
}
