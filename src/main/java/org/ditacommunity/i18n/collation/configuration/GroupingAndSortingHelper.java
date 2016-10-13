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

/*--------------------------------------------------------------------------------
    Copyright (C) 2003 ISOGEN International
 
    http://www.isogen.com
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 --------------------------------------------------------------------------------*/
package org.ditacommunity.i18n.collation.configuration;

import com.ibm.icu.text.RuleBasedCollator;
import org.ditacommunity.i18n.util.I18nUtil;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Locale;

/* Correction comment-1(a)
 * May 31, 2005 Antenna House, Inc.
 */
// Correction comment-1(a)

/**
 *
 * Provides services that support the generation of back-of-the-book
 * indexes.
 *
 * FIXME: Make the methods static.
 */
public class GroupingAndSortingHelper {
	// SORT_ENGLISH_MIXED is used for zh-CN index only.
	// SORT_ENGLISH_BEFORE is default. 
	// SORT_ENGLISH_AFTER is not implemented from beginning.
	// Added 2009/03/24 Antenna House, Inc. t.makita
	public static final int SORT_ENGLISH_BEFORE = GroupingAndSortingRuleSet.SORT_ENGLISH_BEFORE;
	public static final int SORT_ENGLISH_AFTER  = GroupingAndSortingRuleSet.SORT_ENGLISH_AFTER;
    public static final int SORT_ENGLISH_MIXED  = GroupingAndSortingRuleSet.SORT_ENGLISH_MIXED;

    public static final String ELEMENT_INDEX_CONFIG = "index_config";
    public static final String ELEMENT_NATIONAL_LANGUAGE = "national_language";
    public static final String LANGUAGE_EN = "en";
    public static final String GROUP_KEY_NUMERIC = "#NUMERIC";
    
    private Document configDom;
    private Element  rootElem=null;
    private NodeList nlIndexConfig=null;
    
    java.io.File configFile;
    java.util.Hashtable<String,GroupingAndSortingRuleSet> configs = new java.util.Hashtable<String,GroupingAndSortingRuleSet>();
    
    java.util.Vector<String> missingLangCode = new java.util.Vector<String>(); 

    /**
     *
     * Construct new groupingAndSortingHelper with configuration.
     *
     * @parm configFilename Filename of index configuration XML document.
     */
    public GroupingAndSortingHelper(String configFilename) throws GroupingAndSortingHelperException {
        configFile = new java.io.File(configFilename);
        loadRuleSetDom(configFilename);
    }

    public GroupingAndSortingHelper() {
        configFile = null;
    }

    /**
     * Loads the specified index configuration file.
     * 
     * @param configFilename Filename of the index configuration file.
     * @throws GroupingAndSortingHelperException
     */
    public void loadRuleSetDoc(String configFilename)
                                throws GroupingAndSortingHelperException {
	    configFile = new java.io.File(configFilename);
	    if (!configFile.exists()) {
	    	throw new GroupingAndSortingHelperException("loadRuleSetDoc(): Cannot find index configuration file '" + configFile.getAbsolutePath() + "'");
	    }
        loadRuleSetDom(configFile.getAbsolutePath());
    }
    
    /**
     * Loads the DOM for the index configuration doc. Doesn't do anything with
     * the doc at this point--that is done when a request is actually made.
     */
    void loadRuleSetDom(String configFilename) throws GroupingAndSortingHelperException {
        try {
        	DocumentBuilderFactory factory 
            	= DocumentBuilderFactory.newInstance();
        	DocumentBuilder parser = factory.newDocumentBuilder();
            configDom = parser.parse(configFilename);
        } catch (Throwable e) {
            throw new GroupingAndSortingHelperException("Error constructing DOM from docid '" +
                                            configFilename + ": " +
                                            e.getMessage());
        }
        
        this.rootElem = configDom.getDocumentElement();
        if (this.rootElem == null) {
           throw new GroupingAndSortingHelperException("Failed to find root element of index configuration document " +
                                          configFilename);
        }
        this.nlIndexConfig = this.rootElem.getElementsByTagName(ELEMENT_INDEX_CONFIG);
        if (this.nlIndexConfig.getLength() == 0) {
            throw new GroupingAndSortingHelperException("Failed to find any '" + ELEMENT_INDEX_CONFIG + "' elements");
        }
    }

    /**
     * Loads the index configuration information for the parent language of the specified language. 
     * Raises an exception if the language's configuration information can't be found.
     *
     * @param locale The locale to get the rule set for.
     */

    GroupingAndSortingRuleSet getRuleSet(Locale locale) throws GroupingAndSortingHelperException {
        String langCode = locale.toLanguageTag();
    	String parentLangCode=getParentLangCode(langCode);
    	if (configs.containsKey(parentLangCode)) {
            return configs.get(parentLangCode);
        }

    	// System.err.println("*** getRuleSet(): loading index config for language " + langCode);
        GroupingAndSortingRuleSet ic = loadRuleSet(locale);
        configs.put(langCode, ic);
    	// System.err.println("*** getRuleSet(): returning config for language " + langCode);
        return ic;
    }

    GroupingAndSortingRuleSet loadRuleSet(Locale locale) throws GroupingAndSortingHelperException {
    	final String methodName="[loadRuleSet] ";

        String langCode = locale.toLanguageTag();

        Element indexConfigElement = null;
        String parentLangCode="";
        for (int i = 0; i < nlIndexConfig.getLength(); i++) {
            Element candIndexConfigElem = (Element)(nlIndexConfig.item(i));
            NodeList nl = candIndexConfigElem.getElementsByTagName(ELEMENT_NATIONAL_LANGUAGE);
            if (nl.getLength() == 0) {
                throw new GroupingAndSortingHelperException(methodName + "Missing required " + ELEMENT_NATIONAL_LANGUAGE + " element within " + ELEMENT_INDEX_CONFIG + " element");
            }
            parentLangCode="";
            for (int j=0;j < nl.getLength(); j++){
                String candLangCode = I18nUtil.getElementContent((Element)nl.item(j));
                if (candLangCode.equals("")) {
                    System.err.println(methodName + "WARNING: GroupingAndSortingRuleSet - Null value for <" + ELEMENT_NATIONAL_LANGUAGE + "> element in <" + ELEMENT_INDEX_CONFIG + ">");
                    continue;
                }
            	Boolean isParentLangCode=(j==0)?true:false;
                if (isParentLangCode){
                	parentLangCode = candLangCode;
                }
                if (candLangCode.equalsIgnoreCase(langCode)){
                    indexConfigElement = candIndexConfigElem;
                    break;
                }
            }
            if (indexConfigElement != null){
            	break;
            }
        }
        if (indexConfigElement == null & langCode.equals(LANGUAGE_EN)) {
            throw new GroupingAndSortingHelperException(methodName + "Failed to find index configuration for language '" + langCode + "'");
        }
        if (indexConfigElement == null & !langCode.equals(LANGUAGE_EN)) {
            System.err.println(methodName + "Failed to find index configuration for language '" + langCode + "', trying " + locale.getDefault().toLanguageTag());
            return this.getRuleSet(Locale.getDefault());
        }
        /**
         * Generate GroupingAndSortingRuleSet using parent language code.
         * 2011-11-22 Antenna House, Inc. t.makita
         */
        //System.err.println("*** loadRuleSet: loading index rule set for " + langCode);
        //GroupingAndSortingRuleSet ic = new GroupingAndSortingRuleSet(this, langCode, indexConfigElement, configFile);
        GroupingAndSortingRuleSet ic =
                new GroupingAndSortingRuleSet(this, locale, indexConfigElement, configFile);

        return ic;
    }

    public Iterator<String> getIndexGroupKeysIterator(Locale locale) throws GroupingAndSortingHelperException {
        String langCode = locale.toLanguageTag();
    	String parentLangCode = getParentLangCode(langCode);
        GroupingAndSortingRuleSet ic = getRuleSet(locale);
        return ic.getGroupKeysIterator();
    }

	/* Correction comment-1(b)
	 * May 31, 2005 Antenna House, Inc.
	 */
	public RuleBasedCollator getComparator(Locale locale) throws GroupingAndSortingHelperException {
        String langCode = locale.toLanguageTag();
    	String parentLangCode=getParentLangCode(langCode);
		GroupingAndSortingRuleSet ic = getRuleSet(locale);
		RuleBasedCollator co = ic.getComparator();
		return co;
	}
	// Correction comment-1(b)
	
	/**
	 * Given a dialect language code, returns the parent language code.
	 * The parent language code must be placed as the first child <national_language>
	 * of <index_config> element.
	 * @param langCode The input language code.
	 * @return Parent language code. (LANGUAGE_EN if not found.)
	 * @author 2012-01-11 Antenna House, Inc. t.makita
	 */
	private String getParentLangCode(String langCode){
    	final String methodName="[getParentLangCode] ";
		for (int i = 0; i < nlIndexConfig.getLength(); i++) {
            Element indexConfigElem = (Element)(nlIndexConfig.item(i));
            NodeList nl = indexConfigElem.getElementsByTagName(ELEMENT_NATIONAL_LANGUAGE);
            String parentLangCode = "";
            for (int j=0;j < nl.getLength(); j++){
            	Element elmNationalLanguage=(Element)nl.item(j);
            	String candLangCode = I18nUtil.getElementContent(elmNationalLanguage);
            	Boolean isParentLangCode=(j==0)?true:false;
                if (isParentLangCode){
                	parentLangCode = candLangCode;
                }
                if (candLangCode.equalsIgnoreCase(langCode)){
                    return parentLangCode;
                }
            }
        }
		if (!missingLangCode.contains(langCode)){
			System.err.println(methodName + "WARNING! Failed to find language code entry for '" + langCode + "'. Using English instead.");
			missingLangCode.add(langCode);
		}
		return LANGUAGE_EN;
	}
	
    public String printRuleSet(Locale locale,
                               boolean includeCollationRules)
                            throws GroupingAndSortingHelperException {
        String langCode = locale.toLanguageTag();
    	String parentLangCode=getParentLangCode(langCode);
        GroupingAndSortingRuleSet ic = getRuleSet(locale);
        return ic.toString(includeCollationRules);
    }
    
    public String printRuleSet(Locale locale)
                            throws GroupingAndSortingHelperException {
        String langCode = locale.toLanguageTag();
    	String parentLangCode=getParentLangCode(langCode);
        return printRuleSet(locale, false);
    }
    
    public String toString() {
         return toString(true);
    }

    public String toString(boolean includeCollationRules) {
         String outStr = "";
         Enumeration<GroupingAndSortingRuleSet>  configs = this.configs.elements();
         while (configs.hasMoreElements()) {
             GroupingAndSortingRuleSet ic = configs.nextElement();
             outStr = outStr + ic.toString(includeCollationRules);
         }
         return outStr;
    }
}
