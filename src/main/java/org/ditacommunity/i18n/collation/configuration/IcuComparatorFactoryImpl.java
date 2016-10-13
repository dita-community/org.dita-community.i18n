/*
 * Copyright (c) 2016 DITA Community
 *
 * Adapted from ISOGEN I18N utilities project
 * (https://www.antennahouse.com/antenna1/i18n-support-library-2/) originally
 * developed by Eliot Kimber and enhanced by Antenna House.
 *
 * This code has been generalized to any need for grouping, and collation,
 * not just indexes, and removes features not needed in the context of the
 * DITA Open Toolkit. Updated to work with current ICU4J libraries.
 */

/*
 * Created on Sep 29, 2004
 *
 */
package org.ditacommunity.i18n.collation.configuration;

import java.util.Comparator;
import java.util.Locale;

import com.ibm.icu.text.RuleBasedCollator;

/**
 * Constructs ICU rule-based collators.
 */
public class IcuComparatorFactoryImpl  {

	/* Correction comment-2(5)
	 * May 23, 2006 Antenna House, Inc.
	 */
	public static RuleBasedCollator getComparatorForLocale(
		Locale locale, String collationRuleSpec, int replace_rules) throws ComparatorException {
		// TODO: Use comparator/index configuration to get any local collation rules.
		RuleBasedCollator col = null;
		if (collationRuleSpec != null) {
			try {
				if (replace_rules == 0) {
					String baseRules = ((RuleBasedCollator)com.ibm.icu.text.Collator.getInstance(locale)).getRules();
					String addRules = collationRuleSpec;
					collationRuleSpec = baseRules + addRules;
				}
				col = new RuleBasedCollator(collationRuleSpec);
			} catch (Exception e) {
				// e.printStackTrace();
				String msg = IcuComparatorFactoryImpl.class.getSimpleName() + ".getComparatorForLocale(): Exception constructing a RuleBasedCollator";
				throw new ComparatorException(msg, e);
			}
		} else {
			col = (RuleBasedCollator) RuleBasedCollator.getInstance(locale);
		}
		return col;
	}

}
