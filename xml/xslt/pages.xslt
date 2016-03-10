<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs" version="2.0">


    <xsl:template name="layout-master-set">
        <!-- Main Page layout structure -->
        <fo:layout-master-set>
            <!-- first page -->
            <fo:simple-page-master master-name="Cover" xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="region-body" xsl:use-attribute-sets="region-body"/>
                <fo:region-before region-name="region-before" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="region-after" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <!-- all other pages -->
            <fo:simple-page-master master-name="Content" xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="region-body" xsl:use-attribute-sets="region-body"/>
                <fo:region-before region-name="region-before" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="region-after" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <!-- sequence master -->
            <fo:page-sequence-master master-name="Report">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="Cover"
                        blank-or-not-blank="not-blank" page-position="first"/>
                    <fo:conditional-page-master-reference master-reference="Content"
                        blank-or-not-blank="not-blank"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
        </fo:layout-master-set>
    </xsl:template>
    
    <xsl:template name="layout-master-set-invoice">
        <!-- Main Page layout structure -->
        <fo:layout-master-set>
            <fo:simple-page-master master-name="Content" xsl:use-attribute-sets="PortraitPage">
                <fo:region-body region-name="region-body" xsl:use-attribute-sets="region-body"/>
                <fo:region-before region-name="region-before" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="region-after" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <!-- sequence master -->
            <fo:page-sequence-master master-name="Invoice">
                <fo:repeatable-page-master-alternatives>
                    <fo:conditional-page-master-reference master-reference="Content"
                        blank-or-not-blank="not-blank"/>
                </fo:repeatable-page-master-alternatives>
            </fo:page-sequence-master>
        </fo:layout-master-set>
    </xsl:template>
    
    <xsl:template name="page_header">
        <fo:static-content flow-name="region-before" xsl:use-attribute-sets="HeaderFont">
            <fo:block xsl:use-attribute-sets="header">
                <xsl:value-of select="/pentest_report/meta/classification"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="page_footer">
        <fo:static-content flow-name="region-after" xsl:use-attribute-sets="FooterFont">
            <fo:block xsl:use-attribute-sets="footer">
                <fo:page-number/>/<fo:page-number-citation ref-id="EndOfDoc"/>
                <fo:leader leader-pattern="space"/>
                <fo:inline xsl:use-attribute-sets="TinyFont">Chamber of Commerce
                    <xsl:value-of select="*/meta/company/coc"/></fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="Content">
        <fo:page-sequence master-reference="Report">
            <xsl:call-template name="page_header"/>
            <xsl:call-template name="page_footer"/>
            <fo:flow flow-name="region-body" xsl:use-attribute-sets="DefaultFont">
                <fo:block>
                    <xsl:apply-templates select="pentest_report|offerte|quickscope"/>
                </fo:block>
                <fo:block id="EndOfDoc"/>
            </fo:flow>
        </fo:page-sequence>
        
    </xsl:template>
    
    <xsl:template name="Invoice_Content">
        <fo:page-sequence master-reference="Invoice">
            <xsl:call-template name="page_header_invoice"/>
            <xsl:call-template name="page_footer_invoice"/>
            <fo:flow flow-name="region-body" xsl:use-attribute-sets="DefaultFont">
                <fo:block>
                    <xsl:apply-templates select="offerte" mode="invoice"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
        
    </xsl:template>
    
    <xsl:template name="page_header_invoice">
        <fo:static-content flow-name="region-before" xsl:use-attribute-sets="HeaderFont">
            <fo:block>
            <fo:table width="100%" table-layout="fixed">
                <fo:table-column column-width="proportional-column-width(40)"/>
                <fo:table-column column-width="proportional-column-width(20)"/>
                <fo:table-column column-width="proportional-column-width(40)"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell text-align="right" display-align="after">
                            <fo:block xsl:use-attribute-sets="TinyFont">
                                <fo:block xsl:use-attribute-sets="bold orange-text"><xsl:value-of select="/*/meta/company/full_name"/></fo:block>
                                <fo:block><xsl:value-of select="/*/meta/company/address"/></fo:block>
                                <fo:block><xsl:value-of select="/*/meta/company/postal_code"/>&#160;<xsl:value-of select="/*/meta/company/city"/></fo:block>
                                <fo:block><xsl:value-of select="/*/meta/company/country"/></fo:block>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell text-align="center">
                            <fo:block><fo:external-graphic xsl:use-attribute-sets="logo"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell display-align="after">
                            <fo:block xsl:use-attribute-sets="TinyFont">
                                <fo:block xsl:use-attribute-sets="bold orange-text"><xsl:value-of select="/*/meta/company/website"/></fo:block>
                                <fo:block><xsl:value-of select="/*/meta/company/email"/></fo:block>
                                <fo:block>Chamber of Commerce <xsl:value-of select="/*/meta/company/coc"/></fo:block>
                                <fo:block>VAT number <xsl:value-of select="/*/meta/company/vat_no"/></fo:block>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="page_footer_invoice">
        <fo:static-content flow-name="region-after" xsl:use-attribute-sets="FooterFont">
            <fo:block xsl:use-attribute-sets="footer">
                <fo:inline xsl:use-attribute-sets="TinyFont orange-text">Please keep digital unless absolutely required. Read the (unique) terms and conditions of Radically Open Security at: https://radicallyopensecurity.com/TermsandConditions.pdf</fo:inline>
            </fo:block>
        </fo:static-content>
    </xsl:template>
</xsl:stylesheet>
