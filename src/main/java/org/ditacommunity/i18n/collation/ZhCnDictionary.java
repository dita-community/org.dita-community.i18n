package org.ditacommunity.i18n.collation;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Locale;
import java.util.TreeMap;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;

/**
 * Provides a mapping of Simplified Chinese (zh-CN) words to their pinyin
 * transliterations.
 * <p>The dictionary data is derived from the open-source CC-CEDICT dictionary.
 *
 */
public class ZhCnDictionary {

    private static final TreeMap<String, String> pinyinByWord = new TreeMap<String, String>();
    // Cache of break iterators by string.
    private static HashMap<String, RuleBasedBreakIterator> breakIterators
            = new HashMap<String, RuleBasedBreakIterator>();


    static {
        loadDictionaryFromCSV();
    }

    private static void loadDictionaryFromCSV() {
        String resourceUri = "resources/lookup-zh-cn.csv";
        URL resource = ZhCnDictionary.class.getResource(resourceUri);
        if (resource == null) {
            throw new RuntimeException("Failed to load zh-CN data set \"" + resourceUri + "\"");
        }
        try {
            InputStream inStream = resource.openStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inStream, "UTF-8"));
            String line;
            while((line = reader.readLine()) != null) {
                if (line.startsWith("#")) continue;;
                String[] parts = line.split("\t");
                if (parts.length >= 2) {
                    pinyinByWord.put(parts[0], parts[1]);
                } else {
                    // Only 1 part, nothing we can do.
                }
            }


        } catch (Exception e) {
            throw new RuntimeException(e.getClass().getSimpleName() + " loading zh-CN data set \"" + resourceUri + "\"");
        }
    }

    /**
     * Get the pinyin transliteration for the specified Simplified Chinese string.
     * @param source Word to get transliteration for.
     * @return The transliteration or the input string if no transliteration was found.
     */
    public static String getPinYin(String source) {
        return getPinYin(source, false);
    }

    /**
     * Get the pinyin transliteration for the specified Simplified Chinese string.
     * @param source Word to get transliteration for.
     * @return The transliteration or the input string if no transliteration was found.
     */
    public static String getPinYin(String source, boolean debug) {
        String pinyin = lookupPinYin(source, debug);
        // This should never happen if the input is actually Chinese
        // characters because at least the first character should
        // have a transliteration.
        if (pinyin == null) {
            return source;
        }
        return pinyin;
    }

    /**
     * Look up the pinyin for the source by looking at each word
     * @param source Source consisting of one or more words
     * @param debug Turn debugging messages on or off
     * @return The result pinyin or the original source if no
     * pinyin can be found (which should only happen if the input
     * source is not actually Simplified Chinese characters).
     */
    protected static String lookupPinYin(String source, boolean debug) {
        if (debug) {
            System.err.println("lookupPinYin(): Source=\"" + source + "\"");
        }
        StringBuilder buf = new StringBuilder();
        RuleBasedBreakIterator breakIterator = getBreakIterator(source);
        int curPos = breakIterator.first();
        int breakPos = breakIterator.next();
        while (breakPos != BreakIterator.DONE) {
            if (debug) {
                System.err.println("lookupPinYin(): curPos=" + curPos + ", breakPos=" + breakPos);
            }
            String word = source.substring(curPos, breakPos);
            if (debug) {
                System.err.println("lookupPinYin(): word=\"" + word + "\"");
            }
            if (Character.isLetter(word.charAt(0))) {
                if (debug) {
                    System.err.println("lookupPinYin():   first character of word is a letter, adding it to result.");
                }
                String pinyin = lookupPinYinForWord(word);
                pinyin = pinyin.replace(" ", "");
                if (debug) {
                    System.err.println("lookupPinYin():   pinyin=\"" + pinyin + "\"");
                }
                buf.append(pinyin);
            }
            curPos = breakPos;
            breakPos = breakIterator.next();
        }
        if (debug) {
            System.err.println("lookupPinYin(): Returning \"" + buf.toString() + "\"");
        }
        return buf.toString();
    }

    /**
     * Get a break iterator for the input string.
     * @param source The source text for the iterator
     * @return Break iterator configured with the specified text.
     */
    private static RuleBasedBreakIterator getBreakIterator(String source) {
        if (breakIterators.containsKey(source)) {
            return breakIterators.get(source);
        }
        BreakIterator breakIterator = RuleBasedBreakIterator.getWordInstance(Locale.SIMPLIFIED_CHINESE);
        breakIterator.setText(source);
        breakIterators.put(source, (RuleBasedBreakIterator)breakIterator);
        return (RuleBasedBreakIterator)breakIterator;
    }

    /**
     * Look up the pinyin transliteration for a word. Finds the longest
     * entry that matches the start of the source. The input should be
     * a single word: One, two, or three characters.
     * @param source Source to look up.
     * @return The pinyin transliteration, if found, or null if not found.
     */
    protected static String lookupPinYinForWord(String source) {
        String result = findLongestMatch(source);
        if (result == null) {
            return source;
        } else {
            return result;
        }
    }

    /**
     * Recursive function to find the pinyin value for the
     * longest zh-CN key that matches the start of the source.
     * @param source The text to find the pinyin for
     * @return The pinyin or null if no matching key is found.
     */
    private static String findLongestMatch(String source) {
        String pinyin = pinyinByWord.get(source);
        if (null != pinyin) {
            return pinyin;
        } else {
            if (source.length() <= 1) {
                return null; // No possible match
            } else {
                return findLongestMatch(source.substring(0, source.length() - 1));
            }
        }
    }
}
