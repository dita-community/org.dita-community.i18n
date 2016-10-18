package org.ditacommunity.i18n.textanalysis;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;
import net.sf.saxon.om.SequenceIterator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Locale;

import static com.ibm.icu.text.BreakIterator.DONE;

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
    public static SequenceIterator splitWords(String text, String langCode) throws Exception {
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
    public static SequenceIterator splitWords(String text, String langCode, boolean debug) throws Exception {
        if (null == text || "".equals(text.trim())) {
            return null;
        }

        ArrayList<String> words = new ArrayList<String>();
        Locale locale = Locale.forLanguageTag(langCode);

        WordSplittingSequenceIterator iterator =
                WordSplittingSequenceIterator.getInstanceForLocale(locale, text, debug);
        return iterator;

    }
}
