<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dci18n="http://org.dita-community/i18n"
  xmlns:dci18nfunc="http://org.dita-community/i18n/saxon-extensions"
  exclude-result-prefixes="#all"
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

  <!-- Construct the base sort key for a topic using the topic's title.
       
       The base sort key is the sort key without regard to any sort-as
       specifications. It is typically used as the secondary sort key.
       
       @param topic The topic to get the sort key for.
       @return The sort key string. Will be empty if, for some reason,
       all the topic's possible titles are empty and there is no sort-as
       in the prolog.
    -->
  <xsl:function name="dci18n:getBaseSortKeyForTopic" as="xs:string">
    <xsl:param name="topic" as="element()"/>
    <xsl:sequence select="dci18n:getBaseSortKeyForTopic($topic, false())"/>
  </xsl:function>
  
  <!-- Construct the base sort key for a topic using the topic's title.
       
       The base sort key is the sort key without regard to any sort-as
       specifications. It is typically used as the secondary sort key.
       
       @param topic The topic to get the sort key for.
       @param doDebug Set to true() to turn on debug messgaes.
       @return The sort key string. Will be empty if, for some reason,
       all the topic's possible titles are empty and there is no sort-as
       in the prolog.
    -->
  <xsl:function name="dci18n:getBaseSortKeyForTopic" as="xs:string">
    <xsl:param name="topic" as="element()"/>
    <xsl:param name="doDebug" as="xs:boolean"/>
    
    <xsl:variable name="title">
      <xsl:apply-templates select="$topic" mode="dci18n:getTitleText">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>
    </xsl:variable>
    
    <xsl:variable name="result" as="xs:string"
      select="lower-case($title)"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortKeyForTopic: Returning "<xsl:value-of select="$result"/>"</xsl:message>
    </xsl:if>
    
    <xsl:sequence select="normalize-space($result)"/>
  </xsl:function>
  
  
  
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
    
    <xsl:variable name="result" as="xs:string"
      select="dci18n:getSortAsForTopic($topic, $doDebug)"
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getSortKeyForTopicref: Returning "<xsl:value-of select="$result"/>"</xsl:message>
    </xsl:if>
    
    <xsl:sequence select="normalize-space($result)"/>
  </xsl:function>

  <!-- Get the primary sort key for the specified topic. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.
       
       @param topic The topic that provides the sort key data.
       @return The primary sort key string.
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopic">
    <xsl:param name="topic" as="element()"/>
    <xsl:sequence select="dci18n:getPrimarySortKeyForTopic($topic, 'first', false())"/>
  </xsl:function>
  
  <!-- Get the primary sort key for the specified topic. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.
       
       @param topic The topic that provides the sort key data.
       @param sortEnglish Indicate where to sort English: before, with, or after other languages.
       @return The primary sort key string.
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopic">
    <xsl:param name="topic" as="element()"/>
    <xsl:param name="sortEnglish" as="xs:string"/>
    <xsl:sequence select="dci18n:getPrimarySortKeyForTopic($topic, 'first', false())"/>
  </xsl:function>
  
  <!-- Get the primary sort key for the specified topic. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.
       
       @param topic The topic that provides the sort key data.
       @param sortEnglish Indicate where to sort English: before, with, or after other languages.
       @param doDebug Turn debug messages on or off.
       @return The primary sort key string.
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopic">
    <xsl:param name="topic" as="element()"/>
    <xsl:param name="sortEnglish" as="xs:string"/>
    <xsl:param name="doDebug" as="xs:boolean"/>
    
    <xsl:variable name="sortAs" as="xs:string?" 
      select="dci18n:getSortAsForTopic($topic, $doDebug)"
    />
    <xsl:variable name="baseSortKey" as="xs:string?" 
      select="dci18n:getBaseSortKeyForTopic($topic, $doDebug)"
    />
    <!-- This is kind of crude but will work for CJK languages.
      
         For zh-CN, where the sort is done using the pinyin
         transliteration and therefore would otherwise sort
         with English, we have to use a character that would
         not be in any pinyin as the prefix to force English
         to sort before it or after it.
         
         For other languages the normal collation order will
         do the right thing.
      -->
    
    <xsl:variable name="sortKeyPrefix" as="xs:string?"
      select="if (dci18n:startsWithEnglishText($baseSortKey, $doDebug)) 
      then if (matches($sortEnglish, 'before', 'i'))
      then '&#x09;'
      else if (matches($sortEnglish, 'after', 'i'))
      then '&#xFFFC;'
      else ''
      else if (matches($sortEnglish, 'before', 'i'))
      then '&#x4E00;'
      else if (matches($sortEnglish, 'after', 'i')) 
      then '&#x09;'
      else ''
      "
    />
    
    <xsl:if test="$doDebug">
      <xsl:message> + [DEBUG] dci18n:getPrimarySortKeyForTopic(): exists($sortAs)=<xsl:value-of select="exists($sortAs)"/>; $sortAs="<xsl:value-of select="$sortAs"/>"</xsl:message>
      <xsl:message> + [DEBUG] dci18n:getPrimarySortKeyForTopic(): exists($baseSortKey)=<xsl:value-of select="exists($sortAs)"/>; $baseSortKey="<xsl:value-of select="$baseSortKey"/>"</xsl:message>
    </xsl:if>
    <xsl:variable name="sortKey" as="xs:string?"
      select="if (normalize-space($sortAs) != '') 
      then normalize-space($sortAs)
      else $baseSortKey"
    />
    <xsl:variable name="result" as="xs:string" 
      select="concat($sortKeyPrefix, $sortKey)"
    />
    <xsl:sequence select="$result"/>
    
  </xsl:function>
  
  <!-- Get the primary sort key for the specified topicref. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.
       
       @param topicref The topicref whose referenced topic provides the sort key data.
       @return The primary sort key string.
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopicref">
    <xsl:param name="topicref" as="element()"/>
    <xsl:sequence select="dci18n:getPrimarySortKeyForTopicref($topicref, 'first', false())"/>
  </xsl:function>
  
  <!-- Get the primary sort key for the specified topicref. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.
       
       @param topicref The topicref whose referenced topic provides the sort key data.
       @param sortEnglish One of 'first', 'last', 'together'. Determines how English
       text is sorted relative to non-English (non-latin alphabet) text.
       @return The primary sort key string.
       
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopicref">
    <xsl:param name="topicref" as="element()"/>
    <xsl:param name="sortEnglish" as="xs:string"/>
    <xsl:sequence select="dci18n:getPrimarySortKeyForTopicref($topicref, $sortEnglish, false())"/>
  </xsl:function>
  
  <!-- Get the primary sort key for the specified topicref. 
    
       The primary sort key is either the first sort-as value,
       if present, or the base sort key for the referenced
       topic.

       @param topicref The topicref whose referenced topic provides the sort key data.
       @param sortEnglish One of 'first', 'last', 'together'. Determines how English
       text is sorted relative to non-English (non-latin alphabet) text.
       @debug Turns debug messages on or off
       @return The primary sort key string.
    -->
  <xsl:function name="dci18n:getPrimarySortKeyForTopicref">
    <xsl:param name="topicref" as="element()"/>
    <xsl:param name="sortEnglish" as="xs:string"/>
    <xsl:param name="doDebug" as="xs:boolean"/>
    
    <xsl:variable name="topic" as="element()?"
      select="document(string($topicref/@href), $topicref)/*"
    />
    <xsl:variable name="result" as="xs:string?"
      select="dci18n:getPrimarySortKeyForTopic($topic, $sortEnglish, $doDebug)"
    />
    <xsl:sequence select="$result"/>
  </xsl:function>
  
  <!-- Gets the sort-as value, if any, for the specified topic.
       
    -->
  <xsl:function name="dci18n:getSortAsForTopic" as="xs:string?">
    <xsl:param name="topic" as="element()"/>
    <xsl:param name="doDebug" as="xs:boolean"/>

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
      <xsl:message> + [DEBUG] dci18n:getSortAsForTopic: Returning "<xsl:value-of select="$result"/>"</xsl:message>
    </xsl:if>
    
    <xsl:sequence select="normalize-space($result)"/>
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
    
    <xsl:variable name="result" as="xs:string?"
      select="dci18n:getSortAsForTopic($topic, $doDebug)"
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
  <xsl:function name="dci18n:splitWords" as="xs:string*" >
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="lang" as="xs:string"/><!-- Language code -->
    <xsl:param name="debug" as="xs:boolean"/>
    
    <xsl:variable name="result" as="xs:string*">
      <xsl:choose>
        <xsl:when test="function-available('dci18nfunc:splitWords')" use-when="function-available('dci18nfunc:splitWords')">
          <xsl:sequence select="dci18nfunc:splitWords($text, $lang, $debug)"/>
        </xsl:when>
        <xsl:when test="true()">
          <xsl:sequence select="tokenize($text, '\s+')"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:sequence select="$result"/>
  </xsl:function>
  
  <!-- Return the allowed line break points for the text using 
       a locale-aware line breaker.
    
    @param text The text to be split
    @param lang Language code specifying the locale to use for identifying words.
    @param debug Turn debuging on or off.
    @return Sequence of integers, one for each break point. The last value is after
    the last character in the string.
    -->
  <xsl:function name="dci18n:splitLine" as="xs:integer*">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="lang" as="xs:string"/><!-- Language code -->
    <xsl:param name="debug" as="xs:boolean"/>
    
    <xsl:variable name="result" as="xs:integer*" >
      <xsl:choose>
        <xsl:when test="function-available('dci18nfunc:splitLines')" use-when="function-available('dci18nfunc:splitLines')">
          <xsl:sequence select="dci18nfunc:splitLines($text, $lang, $debug)"/>
        </xsl:when>
        <xsl:when test="true()">
          <xsl:message>+ [WARN] dci18n:splitLine(): Java extension function dci18nfunc:splitLines() is not available, returning first break point.</xsl:message>
          <xsl:sequence select="string-length(tokenize($text, '\s+')[1])"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:sequence select="$result"/>
  </xsl:function>
  
  <!-- Get the next line break position in the line. If the line break
       position is the end of the line then returns the length of the
       line. 
    -->
  <xsl:function name="dci18n:nextLineBreakPosition" as="xs:integer">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="lang" as="xs:string"/>
    <xsl:param name="debug" as="xs:boolean"/>
    
    <xsl:variable name="breakPos" as="xs:integer">
      <xsl:choose>
        <xsl:when test="function-available('dci18nfunc:splitLines')" use-when="function-available('dci18nfunc:splitLines')">
          <xsl:sequence select="dci18nfunc:splitLines($text, $lang, $debug)[1]"/>
        </xsl:when>
        <xsl:when test="true()">
          <xsl:message>+ [WARN] dci18n:nextLineBreakPosition(): Java extension function dci18nfunc:splitLines() is not available, returning first break point.</xsl:message>
          <xsl:sequence select="string-length(tokenize($text, '\s+')[1])"/>          
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="result" as="xs:integer"
      select="if ($breakPos = -1) then string-length($text) else $breakPos"
    />
    <xsl:sequence select="$result"/>
  </xsl:function>
  
  <!-- Determine if the text starts with  only charcters used in English
       text (essentially, the ASCII range in Unicode).
    -->
  <xsl:function name="dci18n:startsWithEnglishText" as="xs:boolean">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="debug" as="xs:boolean"/>
    
    <!-- 
      x00A0 - non-breaking space
      x00A9 - ©
      x2010-x2015 - Hyphen, dash, etc.
      x2018-x201F - Typographic quotes
      
      -->
    <xsl:variable name="specialCharacters" as="xs:string"
      select="'&#xA0;&#xA9;&#x2010;-&#x2015;&#x2018;-&#x201F;'"
    />
    
    <xsl:variable name="result" as="xs:boolean"
      select="matches($text, concat('^[&#x20;-&#x7E;', $specialCharacters, ']+'))"
    />
    <xsl:sequence select="$result"/>
  </xsl:function>

  <!-- Estimate the rendered length of the specified text string using
       the specified font (if available). The accuracy of the resulting
       estimate depends on the accuracy of the font specification.
      
       @param text The text to get the length of
       @param fontName The name of the font as known to the Java2D font
       access functions. Normally this is the font name as you see it
       in your operating system font library. See the Java2D documentation
       for details.
       @param fontSize The font size in points with no units, e.g. "24" for 
       a 24-point font.
       @param fontStyle The font style, e.g. "bold", "italic", "oblique", etc.
       Corresponds to the font variant of the installed font.
       @debug Turns debug messages on or off. Set to true() to turn debug
       messages on.
    -->
  <xsl:function name="dci18n:getRenderedTextLength" as="xs:integer">
    <xsl:param name="text" as="xs:string"/>
    <xsl:param name="fontName" as="xs:string"/>
    <xsl:param name="fontSize" as="xs:integer"/>
    <xsl:param name="fontStyle" as="xs:string"/>
    <xsl:param name="debug" as="xs:boolean"/>
    <xsl:variable name="result" as="xs:integer"      
    >
     <xsl:choose>
       <xsl:when test="function-available('dci18nfunc:getRenderedLength')" use-when="function-available('dci18nfunc:getRenderedLength')">
         <xsl:sequence select="dci18nfunc:getRenderedLength($text, $fontName, $fontSize, $fontStyle, $debug)"/>
       </xsl:when>
       <xsl:when test="true()">
         <xsl:message>+ [WARN] dci18n:getRenderedTextLength(): Java extension function dci18nfunc:getRenderedLength() is not available, returning very rough estimate.</xsl:message>
         <!-- Treat fontSize as EM width in pixels -->
         <xsl:sequence select="string-length($text) * $fontSize"/>
       </xsl:when>
     </xsl:choose>
    </xsl:variable>
    <xsl:sequence select="$result"/>
  </xsl:function>
  
</xsl:stylesheet>