<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:variable name="a-tones" as="xs:string+"
    select="('a', 'ā','á','ǎ','à')"
  />
  <xsl:variable name="e-tones" as="xs:string+"
    select="('e', 'ē','é','ě','è')"
  />
  <xsl:variable name="i-tones" as="xs:string+"
    select="('i', 'ī','í','ǐ','ì')"
  />
  <xsl:variable name="o-tones" as="xs:string+"
    select="('o', 'ō','ó','ǒ','ò')"
  />
  <xsl:variable name="u-tones" as="xs:string+"
    select="('u', 'ū','ú','ǔ','ù')"
  />
  <xsl:variable name="ü-tones" as="xs:string+"
    select="('ü', 'ǖ','ǘ','ǚ','ǜ')"
  />
  
  <xsl:template match="item">
    <xsl:variable name="word" select="normalize-space(./pinyin)"/>
    <xsl:variable name="toneset" as="xs:string*"
        select="
      if (matches($word, 'a'))
      then $a-tones
      else if (matches($word, 'e'))  
      then $e-tones
      else if (matches($word, 'i'))  
      then $i-tones
      else if (matches($word, 'o'))
      then $o-tones
      else if (matches($word, 'u'))
      then $u-tones
      else if (matches($word, 'ü'))
      then $u-tones
      else ()
        "
    />
    <xsl:message> + [DEBUG] word="<xsl:value-of select="$word"/>"</xsl:message>
    <xsl:message> + [DEBUG] toneset="<xsl:value-of select="$toneset"/>"</xsl:message>
    <xsl:for-each select="1 to 4">
      <xsl:variable name="tone" as="xs:integer" select="."/>
      <xsl:variable name="old" as="xs:string" select="$toneset[1]"/>
      <xsl:variable name="new" as="xs:string" select="$toneset[$tone + 1]"/>
      <item>
        <char>
          <xsl:value-of select="replace($word, $old, $new)"/>
        </char>
        <pinyin><xsl:value-of select="concat($word, .)"/></pinyin>
      </item><xsl:text>&#x0a;      </xsl:text>
    </xsl:for-each>
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