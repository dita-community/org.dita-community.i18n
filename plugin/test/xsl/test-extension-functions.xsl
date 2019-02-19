<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dci18nfunc="http://org.dita-community/i18n/saxon-extensions"
  exclude-result-prefixes="xs dci18nfunc"
  expand-text="yes"
  version="3.0">    
  
  <xsl:output indent="yes"/>
  
  <xsl:param name="debug" as="xs:boolean" select="false()"/>
  
  <xsl:template match="/" name="start">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>

    <xsl:variable name="doDebug" as="xs:boolean" select="$debug"/>
    
    <xsl:variable name="test-data" as="document-node()"
      select="document('./data/test-data.xml')"
    />
    <test-result>
      <xsl:apply-templates select="$test-data/*/*">
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>
    </test-result>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>

    <xsl:apply-templates>
      <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
    </xsl:apply-templates>    
  </xsl:template>

  <xsl:template match="split-words | split-lines | get-rendered-text-length">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>

    <xsl:copy>
      <xsl:apply-templates>
        <xsl:with-param name="doDebug" as="xs:boolean" tunnel="yes" select="$doDebug"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="split-words/words">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    <xsl:variable name="words" as="xs:string+"
      select="dci18nfunc:splitWords(., string(@xml:lang), $doDebug)"
    />
    <testcase passed="{count($words) eq xs:integer(@word-count)}">
      <lang>{@xml:lang}</lang>
      <input>{.}</input>
      <expected-word-count>{@word-count}</expected-word-count>
      <actual-word-count>{count($words)}</actual-word-count>
      <result>{$words ! ('"' || . || '"') => string-join(', ')}</result>
    </testcase>    
  </xsl:template>

  <xsl:template match="split-lines/text">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:variable name="breakpoints" as="xs:integer+"
      select="dci18nfunc:splitLines(., string(@xml:lang), $doDebug)"
    />
    
    <testcase passed="{count($breakpoints) eq xs:integer(@break-count)}">
      <lang>{@xml:lang}</lang>
      <input>{.}</input>
      <expected-break-count>{@break-count}</expected-break-count>
      <actual-break-count>{count($breakpoints)}</actual-break-count>
      <result>{$breakpoints => string-join(', ')}</result>
    </testcase>    
  </xsl:template>
  
  <xsl:template match="get-rendered-text-length/text">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:variable name="font-name" as="xs:string"
      select="
      if (exists(@font))
      then xs:string(@font)
      else 'Helvetica'
      "
    />
    <xsl:variable name="font-size" as="xs:integer"
      select="
      if (exists(@font-size))
      then xs:integer(@font-size)
      else 10
      "
    />
    <xsl:variable name="font-style" as="xs:string"
      select="
      if (exists(@font-style))
      then xs:string(@font-style)
      else 'plain'
      "
    />
    <testcase pass="true">
      <font>{$font-name}</font>
      <font-size>{$font-size}</font-size>
      <font-style>{$font-style}</font-style>
      <input>{.}</input>
      <result>{dci18nfunc:getRenderedLength(., $font-name, $font-size, $font-style, $doDebug)}</result>
    </testcase>    
  </xsl:template>
  
  
</xsl:stylesheet>