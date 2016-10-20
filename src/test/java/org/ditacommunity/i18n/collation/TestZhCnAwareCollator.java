package org.ditacommunity.i18n.collation;

import com.ibm.icu.text.BreakIterator;
import com.ibm.icu.text.RuleBasedBreakIterator;
import org.ditacommunity.i18n.collation.ZhCnAwareCollator;
import org.ditacommunity.i18n.collation.ZhCnDictionary;
import org.junit.Test;

import javax.print.DocFlavor;
import java.text.CollationKey;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Locale;

import static com.ibm.icu.text.BreakIterator.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

/**
 * Test the zh-CN-aware collator in isolation.
 *
 * Can also be tested through Saxon using the test-collator.xsl
 * script.
 */
public class TestZhCnAwareCollator  {


    @org.junit.Test
    public void testGetInstance() throws Exception {
        Collator collator = ZhCnAwareCollator.getInstance(Locale.CHINESE);
        assertNotNull("No comparator", collator != null);
        int result;
        result = collator.compare("a", "b");
        assertTrue("Compared incorrectly", result == -1);
        CollationKey sortKey = collator.getCollationKey("aaa");
        CollationKey sortKeyC = collator.getCollationKey("c");
        assertNotNull(sortKey);
        result = sortKey.compareTo(sortKeyC);
        assertEquals("Wrong compare result", result, -1);

    }

    @org.junit.Test
    public void testZhCnDictionary() throws Exception {
        ZhCnDictionary dictionary = new ZhCnDictionary();
        String expectedPinYin = "a1 lian2 qiu2 zhang3 guo2";
        String sortKey = dictionary.getPinYin("阿联酋长国");
        assertEquals("Wrong pinyin", expectedPinYin, sortKey);

    }

    @Test
    public void testEnWordBoundaries() {
        String wordsEn = "Word1 word2 word3 word4 word-dash-word5, word6 wordlast.";
        // http://chinesereadingpractice.com/2015/03/01/guest-post-story-behind-the-idiom-ke-zhou-qiu-jian/
        // Words are (I think): 从前 有 一 位 楚 国人 他 非常 爱惜 他 的 宝剑
        String wordsZh = "从前有一位楚国人, 他非常爱惜他的宝剑。";

        System.out.println("English word iteration:");
        BreakIterator breakIterator = RuleBasedBreakIterator.getWordInstance(Locale.ENGLISH);

        breakIterator.setText(wordsEn);
        int start = breakIterator.first();
        int end = breakIterator.next();
        ArrayList<String> words = new ArrayList<String>();
        while (end != DONE) {
            String word = wordsEn.substring(start, end);
            if (Character.isLetter(word.charAt(0))) {
                System.out.println("start: " + start + "; end: " + end + "; word=\"" + word + "\"");
                words.add(word);
            }
            start = end;
            end = breakIterator.next();
        }
        // Note that "-" is taken as a word break, so 9 words not 7
        assertEquals("Not enough words", 9, words.size());

    }

    @Test
    public void testZhWordBoundaries() {
        // http://chinesereadingpractice.com/2015/03/01/guest-post-story-behind-the-idiom-ke-zhou-qiu-jian/
        // Words are (according to the break iterator): 从前 有 一位 楚国 人 他 非常 爱惜 他的 宝剑
        String wordsZh = "从前有一位楚国人, 他非常爱惜他的宝剑。";

        System.out.println("\nSimplified Chinese word iteration:");
        ArrayList<String> words = new ArrayList<String>();
        BreakIterator breakIterator = RuleBasedBreakIterator.getWordInstance(Locale.SIMPLIFIED_CHINESE);
        breakIterator.setText(wordsZh);
        int start = breakIterator.first();
        int end = breakIterator.next();
        while (end != DONE) {
            String word = wordsZh.substring(start, end);
            if (Character.isLetter(word.charAt(0))) {
                System.out.println("start: " + start + "; end: " + end + "; word=\"" + word + "\"");
                words.add(word);
            }
            start = end;
            end = breakIterator.next();
        }

        assertEquals("Not enough words", 10, words.size());
    }
}
