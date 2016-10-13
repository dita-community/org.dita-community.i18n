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
 * Created on Jul 26, 2004
 *
 */
package org.ditacommunity.i18n.collation.configuration;

import com.ibm.icu.text.Collator;
import com.ibm.icu.text.RuleBasedCollator;
import org.ditacommunity.i18n.util.I18nUtil;
import org.ditacommunity.i18n.util.I18nUtilError;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.io.File;
import java.util.*;

/**
*
* @author  eliot
* @version
*
* Holds the index configuration data for a single national language.
*/
public class GroupingAndSortingRuleSet {

   public static final int SORT_METHOD_BETWEEN_KEYS = 0;
   public static final int SORT_METHOD_BY_MEMBERS = 1;
   public static final int SORT_ENGLISH_BEFORE = 0;
   public static final int SORT_ENGLISH_AFTER = 1;
   public static final int SORT_ENGLISH_MIXED = 2;	// Added for use zh-CN index only. 2009/03/24 t.makita
   public static final int SORT_GROUPS_BY_KEYS = 0;
   public static final int SORT_GROUPS_BY_LABELS = 1;


   String langCode = null;     // The language code for the locale(s) this configuration applies to
   Locale locale = null;
   String collationRuleSpec = null;
   
   TreeMap<String, Group> indexGroups; // Index group definitions by group key. Keys are sorted in ascending collation order
   ArrayList<String> threeCharMembers = new ArrayList<String>(); // List of members that are 3 characters
   ArrayList<String> twoCharMembers = new ArrayList<String>(); // List of members that are 2 characters
   Hashtable<String, String> members2keys = new Hashtable<String, String>(); // Reverse index of group keys by member
   RuleBasedCollator comparator = null;  // Comparator used for this language to sort stuff within the index
   Element configElem = null; // The DOM node that is the index_config element for this configuration.
   public int sortStrategy = SORT_METHOD_BY_MEMBERS; // Default
   public int sortEnglish = SORT_ENGLISH_BEFORE;       // Default
   public int sortGroups = SORT_GROUPS_BY_KEYS;        // Default
   GroupingAndSortingHelper groupingAndSortingHelper = null;

   boolean ignoreEnglish = false; // Ignore English group key. 2013/10/31 t.makita

   public GroupingAndSortingRuleSet(GroupingAndSortingHelper inGroupingAndSortingHelper,
                                    Locale locale,
                                    Element indexConfigElement,
                                    File configFile)
                               throws GroupingAndSortingHelperException {
       // NOTE: configFile is intended to allow us to find resources relative to the
       //       the configuration file, but that's not implemented yet.

	   /* Correction comment-2(1)
		* May 23, 2006 Antenna House, Inc.
		*/
		int use_java_collator = 0;
		int replace_rules = 0;
       langCode = locale.toLanguageTag();
       groupingAndSortingHelper = inGroupingAndSortingHelper;
       configElem = indexConfigElement;
       Element colSpecElem = null;
       try {
           colSpecElem = I18nUtil.getElement(configElem, "collation_spec");
           if (I18nUtil.hasElementChildren(colSpecElem)) {
               Element collatorSpecElem = I18nUtil.getElement(colSpecElem, "java_collation_spec");
			   /* Correction comment-2(2)
			    * May 23, 2006 Antenna House, Inc.
			    */
				NodeList node_use_java_collator = colSpecElem.getElementsByTagName("use_java_collator");
				if (node_use_java_collator.getLength() != 0) {
					 use_java_collator = 1;
				}
				NodeList node_replace_rules = colSpecElem.getElementsByTagName("replace_rules");
				if (node_replace_rules.getLength() != 0) {
					replace_rules = 1;
				}
               NodeList nl = colSpecElem.getElementsByTagName("include_collation_spec");
               if (nl.getLength() == 0) {
                   collationRuleSpec = I18nUtil.getElementContent(collatorSpecElem);
               } else {
                   // FIXME: For now we're just processing the first rule spec file we get.
                   Element ecsElem = (Element)nl.item(0);
                   String collationRuleFileName = I18nUtil.getElementContent(ecsElem);
                   File collationRuleFile = new File(configFile.getParentFile(), collationRuleFileName);

                   if (!collationRuleFile.exists()) {
                   	System.err.println("*** Cannot find comparator rule spec file " + collationRuleFile.getAbsolutePath());

                   }
					/* Correction comment-2(3)
					 * May 23, 2006 Antenna House, Inc.
					 */
					collationRuleSpec = I18nUtil.readUnicodeFile(collationRuleFile, "UTF-8");
               }

           }
       } catch (Throwable e) {
           throw new GroupingAndSortingHelperException(e.getMessage());
		}

       // System.err.println("collationRuleSpec=" + collationRuleSpec);
       // See if there are any custom sort rules for this language code:

	   /* Correction comment-2(4)
		* May 23, 2006 Antenna House, Inc.
		*/
		try {
                comparator = IcuComparatorFactoryImpl.getComparatorForLocale(locale, collationRuleSpec, replace_rules);
		} catch (Exception e) {
			throw new GroupingAndSortingHelperException(e);
		}

       try {
           @SuppressWarnings("unused")
           Element sbkElem = I18nUtil.getElement(configElem, "sort_between_keys");
           this.sortStrategy = GroupingAndSortingRuleSet.SORT_METHOD_BETWEEN_KEYS;
       } catch (I18nUtilError e) {
           // Nothing to do
       }

       try {
    	   @SuppressWarnings("unused")
    	   Element sgbkElem = I18nUtil.getElement(configElem, "sort_by_members");
           this.sortGroups = GroupingAndSortingRuleSet.SORT_GROUPS_BY_LABELS;
       } catch (I18nUtilError e) {
           // Nothing to do
       }

       /*
        * Added to support GroupingAndSortingRuleSet.SORT_ENGLISH_MIXED for zh-CN.
        * 2009/03/24 t.makita Antenna House, Inc.
        */
       boolean getEnglishOption=false;

       try {
    	   @SuppressWarnings("unused") Element seElem=I18nUtil.getElement(configElem, "sort_english_before");
    	   this.sortEnglish= GroupingAndSortingRuleSet.SORT_ENGLISH_BEFORE;
    	   getEnglishOption=true;
       } catch (I18nUtilError e) {
           // Nothing to do
       }
       if (!getEnglishOption){
           try {
        	   @SuppressWarnings("unused") Element seElem=I18nUtil.getElement(configElem, "sort_english_after");
        	   this.sortEnglish= GroupingAndSortingRuleSet.SORT_ENGLISH_AFTER;
        	   getEnglishOption=true;
           } catch (I18nUtilError e) {
               // Nothing to do
           }
       }
       if (!getEnglishOption){
           try {
        	   @SuppressWarnings("unused") Element seElem=I18nUtil.getElement(configElem, "sort_english_mixed");
        	   this.sortEnglish= GroupingAndSortingRuleSet.SORT_ENGLISH_MIXED;
        	   getEnglishOption=true;
           } catch (I18nUtilError e) {
               // Nothing to do
           }
       }
       if (!getEnglishOption){
           if (this.langCode.compareToIgnoreCase("zh-cn")==0){
           	   this.sortEnglish= GroupingAndSortingRuleSet.SORT_ENGLISH_MIXED;
           }else{
           	   this.sortEnglish= GroupingAndSortingRuleSet.SORT_ENGLISH_BEFORE;
           }
       }

       // English group key treatment. 2013/10/31 t.makita
       try {
    	   @SuppressWarnings("unused") Element seElem=I18nUtil.getElement(configElem, "ignore_english");
    	   this.ignoreEnglish=true;
       } catch (I18nUtilError e) {
           // Nothing to do
       }

       indexGroups = new TreeMap<String, Group>(comparator);

       Element igsElem = null;
       try {
           igsElem = I18nUtil.getElement(indexConfigElement, "group_definitions");
       } catch (I18nUtilError e) {
           throw new GroupingAndSortingHelperException(e.getMessage());
       }
       if (igsElem == null) {
           throw new GroupingAndSortingHelperException("No group_definitions element within index_config element");
       }
       NodeList nl = igsElem.getElementsByTagName("term_group");
       if (nl.getLength() == 0) {
           throw new GroupingAndSortingHelperException("No term_group elements within group_definitions element");
       }
       // System.err.println("found " + nl.getLength() + " term_group elements");
       for (int i = 0; i < nl.getLength(); i++) {
           Element igElem = (Element)nl.item(i);
           Group ig = new Group(this, igElem);

           //System.err.println("key=" +
           //        I18nUtil.escapeUnicodeString(ig.key));

           /* Correction comment-3
            * May 31, 2005 Antenna House, Inc.
            *
       		String lastKey = "\u0002";
           	if (comparator.compare(ig.key, lastKey) < 0) {
               throw new GroupingAndSortingHelperException("Key '" + I18nUtil.escapeUnicodeString(ig.key) +
                                              "' sorts below previous key '" +
                                              I18nUtil.escapeUnicodeString(lastKey) + "'");
           	}
            * Correction comment-3 */

           //String lastKey = ig.key;
           indexGroups.put(ig.key, ig);
           // System.err.println("indexGroups.size()=" + indexGroups.size());
           for (int j = 0; j < ig.members.size(); j++) {
               String mem = (String)ig.members.get(j);
               if (mem.length() == 3) {
                   threeCharMembers.add(mem);
               } else if (mem.length() == 2) {
                   twoCharMembers.add(mem);
               }
               members2keys.put(mem, ig.key);
           }
       }
   }

   // Added GroupingAndSortingRuleSet.SORT_ENGLISH_MIXED for zh-CN.
   // 2009/03/24 t.makita AntennaHouse, Inc.
   public int getEnglishIndexPosition(){
	   return this.sortEnglish;
   }

   public String getLanguage() {
       return langCode;
   }

   public Locale getLocale() {
       return locale;
   }

   public Iterator<String> getGroupKeysIterator() throws GroupingAndSortingHelperException {
       // Need to get English keySet iterator and append or prepend it to
       // the main language iterator.
       ArrayList<String> al = new ArrayList<String>(indexGroups.keySet());
       // Get the second key list
       GroupingAndSortingRuleSet engConfig = this.groupingAndSortingHelper.getRuleSet(Locale.ENGLISH);
       if (this.sortEnglish == GroupingAndSortingRuleSet.SORT_ENGLISH_AFTER) {
           al.addAll(al.size(),engConfig.indexGroups.keySet());
       } else {
           al.addAll(0,engConfig.indexGroups.keySet());
       }
       return al.iterator();
   }

   public String getGroupKey(String indexEntry)  throws GroupingAndSortingHelperException {
       if (indexEntry.equals("")) {
           return null;
       }
       if (this.sortStrategy == GroupingAndSortingRuleSet.SORT_METHOD_BETWEEN_KEYS) {
           return this.getSortKeyByKeys(indexEntry);
       }
       if (this.sortStrategy == GroupingAndSortingRuleSet.SORT_METHOD_BY_MEMBERS) {
           return this.getSortKeyByMembers(indexEntry);
       }
       throw new GroupingAndSortingHelperException("Unrecognized sort method value '" +
                                       String.valueOf(this.sortStrategy) + "'");
   }


   String getSortKeyByMembers(String textToBeGrouped) throws GroupingAndSortingHelperException {
	   // Check for 3- and 2-character sequences then lookup the sort key
	   String candMember = null;
	   if (textToBeGrouped.length() > 2) {
		   if (threeCharMembers.contains(textToBeGrouped.substring(0,3))) {
			   candMember = textToBeGrouped.substring(0,3);
		   }
	   }
	   if (candMember == null & (textToBeGrouped.length() > 1)) {
		   if (twoCharMembers.contains(textToBeGrouped.substring(0,2))) {
			   candMember = textToBeGrouped.substring(0,2);
		   }
	   }
	   if (candMember == null) {
		   candMember = textToBeGrouped.substring(0,1);
	   }
	   if (members2keys.containsKey(candMember)) {
		   return (String)members2keys.get(candMember);
	   }
	   // Try to get English group key if this configuration is not English and <ignore_english/> is not specified. 2013/11/01 t.makita
	   if (!this.ignoreEnglish && !this.langCode.equals("en")){
	       GroupingAndSortingRuleSet engConfig = this.groupingAndSortingHelper.getRuleSet(Locale.ENGLISH);
	       return engConfig.getGroupKey(textToBeGrouped);
	   }else{
		   return "#NUMERIC";
	   }
   }

   /**
    * Returns the index group sort key for the specified index entry string,
    * using the group keys as the sort boundaries.
    *
    * Return "#NUMERIC" if the entry does not map to an index key in the configuration
    * (i.e., the string is a numeric or other special character).
    *
    * @param indexEntry the index entry string for which a sort key is requested.
    */
   String getSortKeyByKeys(String indexEntry) throws GroupingAndSortingHelperException {
       // Iterate over the indexGroups key list and compare
	   Object[] keys = this.indexGroups.keySet().toArray();
	   // If indexEntry is less than the first key entry, get group key form English rule set.
	   // Added condition for <ignore_english/> 2013/11/01 t.makita
	   if ((this.comparator.compare(indexEntry,(String)keys[0]) < 0) && (!this.ignoreEnglish)) {
	       GroupingAndSortingRuleSet engConfig = this.groupingAndSortingHelper.getRuleSet(Locale.ENGLISH);
	       return engConfig.getGroupKey(indexEntry);
	   }
	   //String c = indexEntry.substring(0,1);
	   //System.err.println("Index entry=" + I18nUtil.escapeUnicodeString(indexEntry));
	   for (int i = 0; i < (keys.length); i++) {
	       String secondKey = null;
	       if (i == (keys.length - 1)) {
	           secondKey = ((Group)this.indexGroups.get(this.indexGroups.lastKey())).lastMember;
		       // Added 2006-12-22 t.makita
		       if ((this.comparator.compare(indexEntry,(String)keys[i]) >= 0) &&
			           (this.comparator.compare(indexEntry, secondKey) <= 0)) {
			           return (String)keys[i];
			       }

	       } else {
	           secondKey = (String)keys[i+1];
		       // Added 2006-12-22 t.makita
	           if ((this.comparator.compare(indexEntry,(String)keys[i]) >= 0) &&
			           (this.comparator.compare(indexEntry, secondKey) < 0)) {
			           return (String)keys[i];
			       }
	       }
	       // Deleted 2006-12-22 t.makita
	       //if ((this.comparator.compare(indexEntry,(String)keys[i]) >= 0) &&
	       //    (this.comparator.compare(indexEntry, secondKey) < 0)) {
	       //    return (String)keys[i];
	       //}
	   }
	   return "#NUMERIC";
   }

   public Group getIndexGroup(String groupKey) throws GroupingAndSortingHelperException {
       if (indexGroups.containsKey(groupKey)) {
           return (Group)indexGroups.get(groupKey);
       }
       if (!this.langCode.equals("en")) {
           GroupingAndSortingRuleSet engConfig = this.groupingAndSortingHelper.getRuleSet(Locale.ENGLISH);
           return engConfig.getIndexGroup(groupKey);
       }
       throw new GroupingAndSortingHelperException("GroupingAndSortingHelper.getIndexGroup(): No group with key '" +
                                      I18nUtil.escapeUnicodeString(groupKey) +
                                      "' for language '" + langCode + "'");
   }

   public String getGroupSortKey(String groupKey)  throws GroupingAndSortingHelperException {
       if (indexGroups.containsKey(groupKey)) {
           return ((Group)indexGroups.get(groupKey)).groupSortKey;
       }
       throw new GroupingAndSortingHelperException("GroupingAndSortingHelper.getGroupSortKey(): No group with key '" +
                                      I18nUtil.escapeUnicodeString(groupKey) +
                                      "' for language '" + langCode + "'");
   }

   /**
    * Returns the Collator object for this index configuration.
    *
    */
   public RuleBasedCollator getComparator() {
       return comparator;
   }

   /**
    * Produces a string representation of the index configuration rules.
    * @param includeCollationRules
    * @return
    */
   public String toString(boolean includeCollationRules) {
       String outStr = "\nIndex Configuration\n";
       outStr = outStr + "\n\tLanguage: " + this.langCode;
       // FIXME: Get the description
       if (includeCollationRules) {
           if (collationRuleSpec != null) {
               outStr = outStr + "\n\tCollation spec: " + this.collationRuleSpec;
           } else {
               outStr = outStr + "\n\tCollation spec: Use Java rules";
           }
       } else {
           outStr = outStr + "\n\tCollation spec: {not shown}";
       }
       outStr = outStr + "\n\tIndex Groups:";
       Iterator<Group> gi = this.indexGroups.values().iterator();
       while (gi.hasNext()) {
           outStr = outStr + ((Group)gi.next()).toString();
       }
       return outStr + "\n";
   }

   public String toString() {
       return toString(true);
   }

   void findAlphaStarts(Collator col) {
       // This is a one-time-use thing but it seemed useful to keep the code around in
       // case we need it again at some point.
       // Given the Unicode-to-pinyin mapping from the Unihan database, figures out
       // which character actually starts each letter group.

       String[] letters = { "A", "B", "C", "D", "E", "F", "G", "H", "I",
                            "J", "K", "L", "M", "N", "O", "P", "Q", "R",
                            "S", "T", "U", "V", "W", "X", "Y", "Z" };

       try {
           String uhPY = I18nUtil.readUnicodeFile("mandarin.txt", "UTF8");
           java.io.Reader sr = new java.io.StringReader(uhPY);
           java.io.LineNumberReader lnr = new java.io.LineNumberReader(sr);
           String inline = null;
           inline = "";
           int i = 0; // Index into letters[]
           String candChar = "\uFFF0";  // Candidate for start of a letter group
           String alphaCode = "";
           alphaCode = letters[0];
           while (inline != null) {
               try {
                   inline = lnr.readLine();
               } catch (java.io.IOException e) {
                   System.err.println(alphaCode + "=" +
                                   I18nUtil.escapeUnicodeString(candChar));
                   break;
               }
               if (inline == null) {
                   System.err.println(alphaCode + "=" +
                                   I18nUtil.escapeUnicodeString(candChar));
                   break;
               }
               int p = inline.indexOf("  ");
               if (p <= 0) {
                   continue;
               }
               //System.err.println("inline='" + inline + "'");
               String charCode = inline.substring(0,p);
               String pinyin = inline.substring(p+2);
               String firstChar = pinyin.substring(0,1);
               if (firstChar.compareTo(alphaCode) > 0) {
                   // We've scanned to the next letter group, go to the
                   // next entry in letters[]
                   i++;
                   System.err.println(alphaCode + "=" +
                                   I18nUtil.escapeUnicodeString(candChar));
                   alphaCode = letters[i];
                   candChar = "\uFFF0";
               }
               //
               if (col.compare(candChar, charCode) > 0) {
                   candChar = charCode;
               }
           }
       } catch (Exception e) {
           e.printStackTrace();
       }
   }
}
