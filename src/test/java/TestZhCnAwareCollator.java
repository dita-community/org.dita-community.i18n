import org.ditacommunity.i18n.ZhCnAwareCollator;

import java.text.CollationKey;
import java.text.Collator;
import java.text.RuleBasedCollator;
import java.util.Comparator;
import java.util.Locale;

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
}
