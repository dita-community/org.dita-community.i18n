package org.ditacommunity.i18n;

import com.ibm.icu.text.Collator;

import java.text.CollationKey;

/**
 * Use an ICU collation key to do the comparison.
 *
 * FIXME: Use zh-CN collation if delegate locale is zh-CN
 */
public class ZhCnAwareCollationKey extends CollationKey {
    private final Collator delegate;
    private final com.ibm.icu.text.CollationKey icuColKey;

    public ZhCnAwareCollationKey(Collator delegate, String source) {
        super(source);
        this.delegate = delegate;
        this.icuColKey = delegate.getCollationKey(source);

    }

    @Override
    public int compareTo(CollationKey target) {
        com.ibm.icu.text.CollationKey targetIcuColKey = delegate.getCollationKey(target.getSourceString());
        return icuColKey.compareTo(targetIcuColKey);
    }

    @Override
    public byte[] toByteArray() {
        return icuColKey.toByteArray();
    }
}
