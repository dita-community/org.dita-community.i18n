<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <!-- ==========================================================
       DITA Community i18n 
       
       Takes the XML lookup markup and generates the equivalent
       comma-separated file for use by the Java code.
              
       ========================================================== -->
  
  <xsl:output method="text"
    encoding="UTF-8"
  />
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="title">
    <xsl:text># </xsl:text><xsl:value-of select="."/><xsl:text>&#x0a;</xsl:text>
  </xsl:template>
  
  <xsl:template match="item">
    <xsl:value-of select="concat(@key, '&#x09;', lower-case(@value), '&#x0a;')"/>
  </xsl:template>
  
  <xsl:template match="*">
      <xsl:apply-templates select="*"/>
  </xsl:template>
  
  <xsl:template match="@* | text() | processing-instruction() | comment()"/>
    
  
</xsl:stylesheet>