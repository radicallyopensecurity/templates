<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <xsl:template match="generate_index">
        <fo:block xsl:use-attribute-sets="title-toc">Table of Contents</fo:block>
        <fo:block xsl:use-attribute-sets="index">
            <xsl:apply-templates select="/" mode="toc"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="meta" mode="toc"/>
    <!-- meta is not indexed -->
    
    <xsl:template match="section|finding|appendix|non-finding" mode="toc">
        <xsl:call-template name="ToC"/>
    </xsl:template>
    
    <xsl:template name="ToC">
        <fo:block xsl:use-attribute-sets="toc-block">
            <xsl:call-template name="tocContent"/>
            <xsl:text> </xsl:text>
            <fo:leader leader-pattern="dots" leader-alignment="reference-area"
                leader-length.maximum="21cm"/>
            <xsl:text>&#160;</xsl:text>
            <fo:page-number-citation ref-id="{@id}"/>
        </fo:block>
        <xsl:apply-templates select="section|finding|non-finding" mode="toc"/>
    </xsl:template>
    
    <xsl:template name="tocContent">
        <xsl:call-template name="tocContent_Numbering"/>
        <xsl:text>&#xA0;&#xA0;</xsl:text>
        <xsl:call-template name="tocContent_Title"/>
    </xsl:template>
    
    <xsl:template name="tocContent_Title">
        <xsl:apply-templates select="title" mode="toc"/>
    </xsl:template>
    
    <xsl:template match="title" mode="toc">
        <xsl:if test="parent::finding">
            <!-- prepend finding id (XXX-NNN) -->
            <xsl:apply-templates select=".." mode="number"/>
            <xsl:text> &#8212; </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template name="tocContent_Numbering">
        <xsl:choose>
            <xsl:when test="self::appendix">
                <fo:inline> Appendix&#160;<xsl:number count="appendix" level="multiple"
                    format="{$AUTO_NUMBERING_FORMAT}"/>
                </fo:inline>
            </xsl:when>
            <xsl:when test="ancestor::appendix">
                <fo:inline> App&#160;<xsl:number count="appendix" level="multiple"
                    format="{$AUTO_NUMBERING_FORMAT}"/>.<xsl:number count="section[ancestor::appendix]" level="multiple"
                        format="{$AUTO_NUMBERING_FORMAT}"/>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:number count="section|finding|non-finding" level="multiple"
                        format="{$AUTO_NUMBERING_FORMAT}"/>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>