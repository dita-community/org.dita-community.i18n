<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  <!-- For each word in the lookup doc, try to find it in the word frequency doc and
       capture its frequency if found.
       
       Input is the lookup-zh-cn.xml file. Output is an updated copy of the input.
    -->
  
  <xsl:key name="words-by-trad" match="word[trad]" use="normalize-space(trad)"/>
  <xsl:key name="words-by-simplified" match="word[simplified]" use="normalize-space(simplified)"/>
  
  <xsl:variable name="word-frequency-data" as="document-node()"
    select="document('../resources/mandarin-word-frequency.xml')"
  />
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="item">
    <!-- <item key="AA制" value="A A zhi4"/> -->
    <xsl:variable name="chars" as="xs:string" select="@key"/>
<!--    <xsl:variable name="word-frequency-word" as="element()?" 
      select="(key('words-by-simplified', $chars, $word-frequency-data), key('words-by-trad', $chars, $word-frequency-data))[1]"
    />
-->
    <xsl:variable name="word-frequency-word" as="element()?" 
      select="($word-frequency-data/*/word[normalize-space(simplified) eq $chars])[1]"
    />
    <xsl:variable name="frequency"
      select="if (exists($word-frequency-word)) then count($word-frequency-word/preceding-sibling::word) + 1 else -1"
    />
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="frequency" select="$frequency"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*, node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@* | comment() | processing-instruction()">
    <xsl:sequence select="."/>
  </xsl:template>
  
</xsl:stylesheet>