<xsl:stylesheet version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="#all"
  >
  <!-- =================================================================================
       Test the DITA Community i18n functions.
       
       Input is a test document containing entries like:
       
       <word sort-position="1" expected-sort-key="foo" expected-group="D">请参阅</word>
       
       Output is an HTML document that reflects the grouping and sorting of the input
       document.
       
       ================================================================================== -->

    <xsl:output method="html"
      indent="yes"
    />
  
  <xsl:variable name="customCollatorUri" as="xs:string"
    select="'http://saxon.sf.net/collation?class=org.ditacommunity.i18n.ZhCnAwareCollator'"
  />
  <xsl:variable name="collatorUri" as="xs:string"
    select="if (false()) then 'http://www.w3.org/2005/xpath-functions/collation/codepoint' else $customCollatorUri"
  />

    <xsl:template match="/">
      
      <xsl:message> + [INFO] Processing source document <xsl:value-of select="document-uri(.)"/>...</xsl:message>
      
      <html>
        <head>
          <xsl:apply-templates mode="head" select="*/title"/>
          <style>
            
          </style>
        </head>
        <body>
          <xsl:apply-templates/>
        </body>
      </html>
      
      <xsl:message> + [INFO] Document processed.</xsl:message>
      
    </xsl:template>

  <!-- ==================================
       Mode #default
       ================================== -->
  
  <xsl:template match="/*">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>

    <div class="root">
      <xsl:apply-templates select="title"/>
      <div class="results">
        <xsl:apply-templates select="words"/>
      </div>      
    </div>    
  </xsl:template>
  
  <xsl:template match="words">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>

    <div class="wordset">
      <table border="1">
        <thead>
          <tr>
            <td>&#xa0;</td>
            <td>Word</td>
            <td>Expected Position</td>
            <td>Expected Sort Key</td>
          </tr>
        </thead>
        <tbody>
          <xsl:apply-templates select="word">
            <xsl:sort collation="{$collatorUri}"/>
          </xsl:apply-templates>
        </tbody>
      </table>
    </div>
  </xsl:template>
  
  <xsl:template match="word">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <tr class="sorted-word">
      <td><xsl:value-of select="concat('[', position(), ']')"/></td>
      <td><xsl:value-of select="."/></td> 
      <td><xsl:value-of select="@sort-position"/></td>
      <td><xsl:value-of select="@expected-sort-key"/></td>
    </tr>
  </xsl:template>
  
  <xsl:template match="title">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <h1>[<xsl:value-of select="../@xml:lang"/>] <xsl:apply-templates/></h1>
  </xsl:template>
  
  <xsl:template match="*" priority="-1">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <xsl:message> - [WARN] #default: Fallback handling <xsl:value-of select="concat(name(..), '/', name(.))"/></xsl:message>
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- ==================================
       Mode head
       ================================== -->
  
  <xsl:template mode="head" match="title">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <title><xsl:apply-templates/></title>
  </xsl:template>
  
  <xsl:template mode="head" match="*" priority="-1">
    <xsl:param name="doDebug" as="xs:boolean" tunnel="yes" select="false()"/>
    
    <!-- Suppress -->
  </xsl:template>

</xsl:stylesheet>