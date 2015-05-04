<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <xsl:template name="checkIfLast">
        <!-- Checks if an element is last in the section / appendix and adds some space after it if it is -->
        <xsl:if
            test="(parent::section and not(following-sibling::*)) or 
            (parent::appendix and not(following-sibling::*)) or 
            (ancestor::section and not(following-sibling::*) and not(parent::*/following-sibling::*)) or 
            (ancestor::appendix and not(following-sibling::*) and not(parent::*/following-sibling::*)) or 
            (not(self::title) and following-sibling::*[1][self::section]) or
            (not(self::title) and following-sibling::*[1][self::finding]) or
            (not(self::title) and following-sibling::*[1][self::non-finding])">
            <xsl:attribute name="margin-bottom" select="$very-large-space"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="contact/address">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="br">
        <fo:block/>
    </xsl:template>
    
    <xsl:template match="p">
        <fo:block xsl:use-attribute-sets="p">
            <xsl:call-template name="checkIfLast"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="pre">
        <fo:block xsl:use-attribute-sets="pre">
            <xsl:call-template name="checkIfLast"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="finding" mode="number">
        <!-- Output finding display number (context is finding) -->
        <xsl:variable name="sectionNumber">
            <xsl:choose>
                <xsl:when test="/pentest_report/@findingNumberingBase = 'Section'">
                    <xsl:value-of select="count(ancestor::section[last()]/preceding-sibling::section) + 1"/>
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="findingNumber" select="count(preceding-sibling::finding)+1"/>
        <xsl:variable name="numFormat" select="'00'"/>
        <xsl:value-of
            select="concat(ancestor::*[@findingCode][1]/@findingCode,'-',$sectionNumber, string(format-number($findingNumber, $numFormat)))"
        />
    </xsl:template>
    
</xsl:stylesheet>