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
package org.ditacommunity.i18n.collation.configuration;

import org.ditacommunity.i18n.util.I18nUtil;
import org.ditacommunity.i18n.util.I18nUtilError;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.util.Vector;

/**
 * Represents a single index group within a language-specific index configuration.
 *
 */
class Group {
    // Sort strategy defines how membership in a group is determined, either by
    // sorting between the group keys (e.g., for Traditional Chinese) or by
    // explicit group membership. The default is by membership.
    public String key; // The string key for this index group
    public String label; // The display label for this index group
    public String groupSortKey; // The key by which the group is sorted in the presented index
    public Vector<String> members = new Vector<String>(); // The character set members of the group
    public GroupingAndSortingRuleSet indexConfiguration; // The index configuration we're a part of
    public String lastMember = null; // Used for last group when doing between-key sorting.


    public Group(GroupingAndSortingRuleSet parent, Element igElem) throws GroupingAndSortingHelperException {
        indexConfiguration = parent;
        try {
            Element gkElem = I18nUtil.getElement(igElem, "group_key");
            key = I18nUtil.getElementContent(gkElem);
            if (key.equals("")) {
                throw new GroupingAndSortingHelperException("Null value for <group_key> element in <term_group) for language '" + parent.getLanguage() + "'");
            }
            label = key;
            groupSortKey = key;
            //System.err.println("label=" + I18nUtil.escapeUnicodeString(label));
            try {
                Element glElem = I18nUtil.getElement(igElem, "group_label");
                label = I18nUtil.getElementContent(glElem);
                if (key.equals("")) {
                    throw new GroupingAndSortingHelperException("Null value for <group_label> element in <term_group) for language '" + parent.getLanguage() + "'");
                }
            } catch (I18nUtilError e) {
                // Use key as label
                // System.err.println(e.getMessage());
            }
            if (indexConfiguration.sortGroups == GroupingAndSortingRuleSet.SORT_GROUPS_BY_LABELS) {
                groupSortKey = label;
            }

            Element groupMembersElem = I18nUtil.getElement(igElem, "group_members");
            if (parent.sortStrategy == GroupingAndSortingRuleSet.SORT_METHOD_BY_MEMBERS) {
                NodeList memberElems = groupMembersElem.getElementsByTagName("char_or_seq");
                if ((memberElems.getLength() == 0) &&
                    (this.indexConfiguration.sortStrategy == GroupingAndSortingRuleSet.SORT_METHOD_BY_MEMBERS)) {
                    throw new GroupingAndSortingHelperException(
                      "No char_or_seq elements in group_members element when grouping strategy is 'by members'");
                }
                for (int i = 0; i < memberElems.getLength(); i++) {
                    String memStr = I18nUtil.getElementContent((Element)memberElems.item(i));
                    if (!memStr.equals("")) {
                        members.add(memStr);
                    } else {
                        System.err.println("WARNING: GroupingAndSortingRuleSet - Empty <char_or_seq> element in <group_members> with key '" + key + "', language '" + parent.getLanguage() + "'");
                    }
                }
            } else {
                // Sort by keys
                try {
                    Element charSetElem = I18nUtil.getElement(igElem, "char_or_seq");
                    lastMember = I18nUtil.getElementContent(charSetElem);
                    if (lastMember.equals("")) {
                        throw new GroupingAndSortingHelperException("Null value for <char_or_seq> element in <last.member> for language '" + parent.getLanguage() + "'");
                    }
                } catch (I18nUtilError e) {
                    // Nothing to do.
                }
            }
        } catch (I18nUtilError e) {
            throw new GroupingAndSortingHelperException(e.getMessage());
        }

    }

    public String toString() {
        String outStr = "";
        outStr = outStr + "\n\t\tKey: '" + I18nUtil.escapeUnicodeString(key) + "'";
        outStr = outStr + "\n\t\tLabel: '" + I18nUtil.escapeUnicodeString(label) + "'";
        outStr = outStr + "\n\t\tMembers:";
        if (this.lastMember != null) {
            outStr = outStr + "\n\t\t\t LastMember='" +
               I18nUtil.escapeUnicodeString(this.lastMember) +
               "'";
        } else {
            for (int i = 0; i < members.size(); i++) {
                outStr = outStr + "\n\t\t\t'" +
                   I18nUtil.escapeUnicodeString((String)members.elementAt(i)) +
                   "'";
            }
        }
        return outStr;
    }
}
