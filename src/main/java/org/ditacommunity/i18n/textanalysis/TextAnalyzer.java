package org.ditacommunity.i18n.textanalysis;

import java.util.Locale;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;

import net.sf.saxon.om.SequenceIterator;

/**
 * Provides methods for doing locale-specific text analysis
 * such as word breaking using the ICU4J library.
 */
public class TextAnalyzer {

    /**
     * Given a string of text, split into words and return the words as an array of strings.
     * @param text Text to be split into words.
     * @param langCode Language code, e.g. "en-US" or "zh-CN"
     * @return Array of strings or null if there are no words or text is empty
     * @throws Exception
     */
    public static SequenceIterator<?> splitWords(String text, String langCode) throws Exception {
       return splitWords(text, langCode, false);
    }


    /**
     * Given a string of text, split into words and return the words as an array of strings.
     * @param text Text to be split into words.
     * @param langCode Language code, e.g. "en-US" or "zh-CN"
     * @param debug Set to true to turn on debugging messages.
     * @return Array of strings or null if there are no words or text is empty
     * @throws Exception
     */
    public static SequenceIterator<?> splitWords(String text, String langCode, boolean debug) throws Exception {
        if (null == text || "".equals(text.trim())) {
            return null;
        }

        Locale locale = Locale.forLanguageTag(langCode);
        if (debug) {
          System.out.println("+ [DEBUG] splitWords(): text=\"" + text + "\", debug=" + debug);
        }

        WordSplittingSequenceIterator iterator =
                WordSplittingSequenceIterator.getInstanceForLocale(locale, text, debug);
        return iterator;

    }

    /**
     * Given a string of text, find the line break points. The first value is the start of the text.
     * @param text Text to be analyzed.
     * @param langCode Language code, e.g. "en-US" or "zh-CN"
     * @return Sequence of break point positions as integers.
     * @throws Exception
     */
    public static SequenceIterator<?> splitLine(String text, String langCode) throws Exception {
        return splitLine(text, langCode, false);
    }

    /**
     * Given a string of text, find the line break points. The first value is the start of the text.
     * @param text Text to be analyzed.
     * @param langCode Language code, e.g. "en-US" or "zh-CN"
     * @param debug Set to true to turn on debugging messages.
     * @return Iterator of break point positions as integers.
     * @throws Exception
     */
    public static SequenceIterator<?> splitLine(String text, String langCode, boolean debug) throws Exception {
        if (null == text || "".equals(text.trim())) {
            return null;
        }

        Locale locale = Locale.forLanguageTag(langCode);
        if (debug) {
            System.out.println("+ [DEBUG] splitLine(): text=\"" + text + "\"");
        }

        LineSplittingSequenceIterator iterator =
                LineSplittingSequenceIterator.getInstanceForLocale(locale, text, debug);

        return iterator;

    }

    /**
     * Get the position of the next line break opportunity in the specified text, not counting the start of the
     * text, which is always a line break opportunity.
     * <p>
     * The value is the number of characters from the start
     * of the text to the break point. So if the first break opportunity is between the first and second
     * characters the return value will be "1".
     * @param text The text to analyze
     * @param langCode Language code for the locale to use
     * @param debug Set to true to turn on debug messages
     * @return The zero-indexed position of the first line break opportunity in the text, which may be after the
     * end of the text.
     * @throws Exception
     */
    public static int nextLineBreakPosition(String text, String langCode, boolean debug) throws Exception {
        Locale locale = Locale.forLanguageTag(langCode);
        if (debug) {
            System.out.println("+ [DEBUG] nextLineBreakPosition(): text=\"" + text + "\"");
        }

        BreakIterator iterator = RuleBasedBreakIterator.getLineInstance(locale);
        iterator.setText(text);
        iterator.next(); // Skip the start of the text, which is always the first line break
        return iterator.next();

    }


}
