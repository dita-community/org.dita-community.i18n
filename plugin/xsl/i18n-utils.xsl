<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dci18n="http://org.dita-community/i18n"
  xmlns:textAnalyzer="java:org.ditacommunity.i18n.textanalysis.TextAnalyzer"
  exclude-result-prefixes="xs dci18n"
  version="2.0">
  <!-- ==================================================================
       DITA Community Internationalization Utilities
       
       These XSLT templates and functions support doing locale-specific
       sorting and grouping.
       
       Include this module in any extension code that needs it.
       
       Depends on the org.dita-community.i18n Java library, which
       provides support for Simplified Chinese dictionary-based
       sorting and grouping and provides a general integration with
       the ICU4J libraries, as also used by the Open Toolkit's PDF2 plugin.
       
       Specific facilities provided by this module:
       
       - Get sort key for topic, taking into account presence of DITA 1.3
         <sort-as> elements or the equivalent unspecialized <data> elements.
         
       - Get grouping key for string. Uses the ICU Alphabetic Index facility
         to determine the locale-specific grouping key for a given string.
         
       - Get group lable. Uses the ICU Alphabetic Index facility to get the
         display label for a given grouping key.
         
       - Get pinyin for Simplified Chinese. Returns the pinyin transliteration
         for Chinese words, using the CC-CEDICT dictionary. Useful for debugging
         Simplified Chinese collation.
       
       ===================================================================== -->
  
  
  <!-- Given a topicref to a topic, construct the base sort key for the 
       topic using the topic's title.
       
       The base sort key is the sort key without regard to any sort-as
       specifications. It is typically used as the secondary sort key.
       
       @param topicref The topicref to be resolved.
       @return The sort key string. Will be empty if, for some reason,
       all the topic's possible titles are empty and there is no sort-as
       in the prolog.
    -->
  <xsl:function name="dci18n:getBaseSortKeyForTopicref" as="xs:string">
    <xsl:param name="topicref" as="element()"/>
    <xsl:sequence select="dci18n:getBaseSortKeyForTopicref($topicref, false())"/>
  </xsl:function>
  
  <!-- Given a topicref to a topic, construct the sort key for the 
       topic using the topic's title. The sort key is folded
       to lowercase.       
       
       @param topicref The topicref to be resolved.
       @param debug Set to true to turn debug messages on.
       @return The sort key string. Will be empty if, for some reason,
       all the topic's possible titles are empty and there is no sort-as
       in the prolog.
-->
  <xsl:function name="dci18n:getBaseSortKeyForTopicref" as="xs:string">
    <xsl:param name="topicref" as="element()"/>
    <xsl:param name="doDebug" as="xs:boolean"/>
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortKeyForTopicref: href="<xsl:value-of select="$topicref/@href"/>"</xsl:message>
    </xsl:if>
    
    <xsl:variable name="topic" as="element()?"
      select="document(string($topicref/@href), $topicref)/*"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortKeyForTopicref: Resolved ref? <xsl:value-of select="exists($topic)"/></xsl:message>
    </xsl:if>
    
    <xsl:variable name="title">
      <xsl:apply-templates select="$topic" mode="dci18n:getTitleText">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>
    </xsl:variable>
    
    <xsl:variable name="result" as="xs:string"
      select="lower-case($title)"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortKeyForTopicref: Returning "<xsl:value-of select="$result"/>"</xsl:message>
    </xsl:if>
    
    <xsl:sequence select="normalize-space($result)"/>
  </xsl:function>
  
  <!-- Get the primary sort key for the specified topicref. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.
       
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopicref">
    <xsl:param name="topicref" as="element()"/>
    <xsl:sequence select="dci18n:getPrimarySortKeyForTopicref($topicref, false())"/>
  </xsl:function>
  
  <!-- Get the primary sort key for the specified topicref. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.
       
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopicref">
    <xsl:param name="topicref" as="element()"/>
    <xsl:param name="doDebug" as="xs:boolean"/>
    
    <xsl:variable name="sortAs" as="xs:string?" 
      select="dci18n:getSortAsForTopicref($topicref, $doDebug)"
    />
    <xsl:variable name="baseSortKey" as="xs:string?" 
      select="dci18n:getBaseSortKeyForTopicref($topicref, $doDebug)"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getPrimarySortKeyForTopicref(): exists($sortAs)=<xsl:value-of select="exists($sortAs)"/>; $sortAs="<xsl:value-of select="$sortAs"/>"</xsl:message>
      <xsl:message> + [DEBUG] dci18n:getPrimarySortKeyForTopicref(): exists($baseSortKey)=<xsl:value-of select="exists($sortAs)"/>; $baseSortKey="<xsl:value-of select="$baseSortKey"/>"</xsl:message>
    </xsl:if>
    <xsl:variable name="result" as="xs:string?"
      select="if (normalize-space($sortAs) != '') 
                 then normalize-space($sortAs)
                 else $baseSortKey"
    />
    <xsl:sequence select="$result"/>
  </xsl:function>
  
  <!-- Gets the sort-as value, if any, for the topic referenced by the specified
       topicref.
       
    -->
  <xsl:function name="dci18n:getSortAsForTopicref" as="xs:string?">
    <xsl:param name="topicref" as="element()"/>
    <xsl:param name="doDebug" as="xs:boolean"/>
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortAsForTopicref: href="<xsl:value-of select="$topicref/@href"/>"</xsl:message>
    </xsl:if>
    
    <xsl:variable name="topic" as="element()?"
      select="document(string($topicref/@href), $topicref)/*"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortAsForTopicref: Resolved ref? <xsl:value-of select="exists($topic)"/></xsl:message>
    </xsl:if>
    
    <xsl:variable name="sort-as">
      <xsl:apply-templates select="$topic" mode="dci18n:getTopicSortAs">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>
    </xsl:variable>
    
    <xsl:variable name="result" as="xs:string?"
      select="if (normalize-space($sort-as) != '') 
                 then normalize-space($sort-as) 
                 else ()"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortAsForTopicref: Returning "<xsl:value-of select="$result"/>"</xsl:message>
    </xsl:if>
    
    <xsl:sequence select="normalize-space($result)"/>
  </xsl:function>
  
  <!-- Get the text of the topic's title. -->
  <xsl:template mode="dci18n:getTitleText" match="*[contains(@class, ' topic/topic ')]" as="xs:string">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:variable name="titleText">
      <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="text-only"/>
    </xsl:variable>
    <xsl:variable name="searchTitleText">
      <xsl:apply-templates select="*[contains(@class, ' topic/titlealts ')]/*[contains(@class, ' topic/searchtitle ')]" mode="text-only"/>
    </xsl:variable>
    <xsl:variable name="navTitleText">
      <xsl:apply-templates select="*[contains(@class, ' topic/titlealts ')]/*[contains(@class, ' topic/navtitle ')]" mode="text-only"/>
    </xsl:variable>
    <xsl:sequence 
      select="(for $t in ($titleText, $navTitleText, $searchTitleText) 
                   return if (not(normalize-space($t) = '')) 
                             then $t 
                             else ())[1]"
    />
  </xsl:template>
  
  <!-- Get the first sort-as element (or data name="sort-as") in the topic's title or
       prolog.
       
    -->
  <xsl:template mode="dci18n:getTopicSortAs" match="*[contains(@class, ' topic/topic ')]" as="xs:string?">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <!-- Prefer sort-as in the title over sort-as in the prolog -->
    <xsl:value-of 
      select="(*[contains(@class, ' topic/title ')]//*[contains(@class, ' ut-d/sort-as ')], 
      *[contains(@class, ' topic/title ')]//*[(@name = ('sort-as'))][not(@value)], 
      *[contains(@class, ' topic/title ')]//*[(@name = ('sort-as'))]/@value,
      *[contains(@class, ' topic/prolog ')]//*[contains(@class, ' ut-d/sort-as ')], 
      *[contains(@class, ' topic/prolog ')]//*[(@name = ('sort-as'))][not(@value)], 
      *[contains(@class, ' topic/prolog ')]//*[(@name = ('sort-as'))]/@value)[1]"/>
  </xsl:template>
  
  <xsl:function name="dci18n:splitWords" as="xs:string*">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="lang" as="xs:string"/><!-- Language code -->
    <xsl:sequence select="dci18n:splitWords($text, $lang, false())"/>
  </xsl:function>
  
  <!-- Split a text into words using a locale-specific ICU word iterator.
    
    @param text The text to be split
    @param lang Language code specifying the locale to use for identifying words.
    @param debug Turn debuging on or off.
    @return Sequence of words. Will contain at least one word unless the input 
    text is empty or only consists of non-letter text.
    -->
  <xsl:function name="dci18n:splitWords" as="xs:string*">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="lang" as="xs:string"/><!-- Language code -->
    <xsl:param name="debug" as="xs:boolean"/>
    
    <xsl:variable name="result" as="xs:string*" select="textAnalyzer:splitWords($text, $lang, $debug)"/>
    <xsl:sequence select="$result"/>
  </xsl:function>
  
  <!-- Split a text into words using a locale-specific ICU word iterator.
    
    @param text The text to be split
    @param lang Language code specifying the locale to use for identifying words.
    @param debug Turn debuging on or off.
    @return Sequence of words. Will contain at least one word unless the input 
    text is empty or only consists of non-letter text.
    -->
  <xsl:function name="dci18n:splitLine" as="xs:integer*">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="lang" as="xs:string"/><!-- Language code -->
    <xsl:param name="debug" as="xs:boolean"/>
    
    <xsl:variable name="result" as="xs:integer*" select="textAnalyzer:splitLine($text, $lang, $debug)"/>
    <xsl:sequence select="$result"/>
  </xsl:function>
  
</xsl:stylesheet>