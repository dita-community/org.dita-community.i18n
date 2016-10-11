package org.ditacommunity.i18n;

import java.io.*;
import java.net.URI;
import java.net.URL;
import java.text.ParseException;
import java.util.TreeMap;

/**
 * Provides a mapping of Simplified Chinese (zh-CN) words to their pinyin
 * transliterations.
 * <p>The dictionary data is derived from the open-source CC-CEDICT dictionary.
 *
 */
public class ZhCnDictionary {

    private final TreeMap<String, String> pinyinByWord = new TreeMap<String, String>();

    public ZhCnDictionary() {
        // Load the data
        loadDictionaryFromCSV();
    }

    private void loadDictionaryFromCSV() {
        String resourceUri = "resources/lookup-zh-cn.csv";
        URL resource = this.getClass().getResource(resourceUri);
        if (resource == null) {
            throw new RuntimeException("Failed to load zh-CN data set \"" + resourceUri + "\"");
        }
        try {
            InputStream inStream = resource.openStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
            String line;
            while((line = reader.readLine()) != null) {
                if (line.startsWith("#")) continue;;
                String[] parts = line.split("\t");
                if (parts.length >= 2) {
                    this.pinyinByWord.put(parts[0], parts[1]);
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
    public String getPinYin(String source) {
        String pinyin = lookupPinYin(source);
        if (pinyin == null) {
            return source;
        }
        return pinyin;
    }

    /**
     * Look up the pinyin transliteration. Finds the longest
     * entry that matches the start of the source.
     * @param source Source to look up.
     * @return The pinyin transliteration, if found, or null if not found.
     */
    protected String lookupPinYin(String source) {
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
    private String findLongestMatch(String source) {
        String pinyin = this.pinyinByWord.get(source);
        if (null != pinyin) {
            return pinyin;
        } else {
            if (source.length() == 1) {
                return null; // No possible match
            } else {
                return findLongestMatch(source.substring(0, source.length() - 1));
            }
        }
    }
}
