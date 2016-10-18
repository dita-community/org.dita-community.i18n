package org.ditacommunity.i18n.textanalysis;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;
import net.sf.saxon.om.Item;
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

        Locale locale = Locale.forLanguageTag(langCode);
        System.out.println("+ [DEBUG] splitWords(): text=\"" + text + "\", debug=" + debug);

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
    public static ArrayList<Item> splitLine(String text, String langCode) throws Exception {
        return splitLine(text, langCode, false);
    }

    /**
     * Given a string of text, find the line break points. The first value is the start of the text.
     * @param text Text to be analyzed.
     * @param langCode Language code, e.g. "en-US" or "zh-CN"
     * @param debug Set to true to turn on debugging messages.
     * @return Sequence of break point positions as integers.
     * @throws Exception
     */
    public static ArrayList<Item> splitLine(String text, String langCode, boolean debug) throws Exception {
        if (null == text || "".equals(text.trim())) {
            return null;
        }

        Locale locale = Locale.forLanguageTag(langCode);
        System.out.println("+ [DEBUG] splitLine(): text=\"" + text + "\", debug=" + debug);

        LineSplittingSequenceIterator iterator =
                LineSplittingSequenceIterator.getInstanceForLocale(locale, text, debug);

        ArrayList<Item> items = new ArrayList<Item>();
        Item item = iterator.next();
        while (null != item) {
            items.add(item);
            item = iterator.next();
        }

        return items;

    }
}
