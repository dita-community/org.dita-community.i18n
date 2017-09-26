<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  <!-- ===========================================
       Takes a sorting test doc from source-data/ 
       and orders it based on the values of the
       @sort-position attribute as an aid to 
       creating/validating the data.
       =========================================== -->
  
  <xsl:output indent="yes"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="words">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*">
        <xsl:sort select="format-number(@sort-position, '0000')"/>
      </xsl:apply-templates>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="@*, node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="@* | text() | comment() | processing-instruction()">
    <xsl:sequence select="."/>
  </xsl:template>
</xsl:stylesheet>