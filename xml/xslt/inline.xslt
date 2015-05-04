<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <xsl:template match="a">
        <xsl:variable name="destination">
            <xsl:choose>
                <xsl:when test="starts-with(@href, '#')">
                        <xsl:value-of select="substring(@href, 2)"/>
                </xsl:when>
                <xsl:otherwise>
                        <xsl:value-of select="@href"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:basic-link color="blue">
            <xsl:choose>
                <xsl:when test="starts-with(@href, '#')">
                    <xsl:attribute name="internal-destination">
                        <xsl:value-of select="$destination"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="external-destination">
                        <xsl:value-of select="$destination"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="starts-with(@href, '#') and not(text())">
                    <xsl:for-each select="key('rosid',$destination)">
                        <xsl:value-of select="local-name()"/>
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates select="." mode="number"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="*|text()"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
        <xsl:if test="starts-with(@href, '#')">
            <xsl:text> (page </xsl:text>
            <fo:page-number-citation ref-id="{substring(@href, 2)}"/>
            <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="b">
        <fo:inline xsl:use-attribute-sets="bold"><xsl:apply-templates/></fo:inline>
    </xsl:template>
    
    <xsl:template match="i">
        <fo:inline xsl:use-attribute-sets="italic"><xsl:apply-templates/></fo:inline>
    </xsl:template>
    
    <xsl:template match="u">
        <fo:inline xsl:use-attribute-sets="underline"><xsl:apply-templates/></fo:inline>
    </xsl:template>
    
</xsl:stylesheet>