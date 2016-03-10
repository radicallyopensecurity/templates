<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xs" version="2.0">


    <xsl:import href="pages.xslt"/>
    <!--<xsl:import href="meta.xslt"/>
    <xsl:import href="toc.xslt"/>
    <xsl:import href="structure.xslt"/>
    <xsl:import href="att-set.xslt"/>
    <xsl:import href="block.xslt"/>
    <xsl:import href="findings.xslt"/>
    <xsl:import href="auto.xsl"/>
    <xsl:import href="table.xslt"/>
    <xsl:import href="lists.xslt"/>
    <xsl:import href="inline.xslt"/>
    <xsl:import href="graphics.xslt"/>
    <xsl:import href="generic.xslt"/>
    <xsl:import href="numbering.xslt"/>
    <xsl:import href="waiver.xslt"/>-->
    
    <xsl:include href="styles_inv.xslt"/>
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>


    <!-- ****** AUTO_NUMBERING_FORMAT:	value of the <xsl:number> element used for auto numbering -->
    <!--<xsl:param name="AUTO_NUMBERING_FORMAT" select="'1.1.1'"/>-->
    <xsl:param name="INVOICE_NO">00/000</xsl:param>
    
    <xsl:variable name="fee" select="/offerte/meta/pentestinfo/fee * 1"/>
    <xsl:variable name="vat" select="$fee div 100 * 21"/>
    <xsl:variable name="denomination">
        <xsl:choose>
            <xsl:when test="/offerte/meta/pentestinfo/fee/@denomination = 'euro'">€</xsl:when>
            <xsl:when test="/offerte/meta/pentestinfo/fee/@denomination = 'dollar'">$</xsl:when>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="currentDate"><xsl:value-of select="format-date(current-date(), '[MNn] [D1], [Y]', 'en', (), ())"/></xsl:variable>

    <!--<xsl:key name="rosid" match="section|finding|appendix|non-finding" use="@id"/>-->
    
    
    <xsl:variable name="CLASSES" select="document('../xslt/styles_inv.xslt')/*/xsl:attribute-set"/>
    
    
    
<!-- ROOT -->
    <xsl:template match="/">

        <fo:root>

            <xsl:call-template name="layout-master-set-invoice"/>
            <xsl:call-template name="Invoice_Content"/>

        </fo:root>
    </xsl:template>
    
    <xsl:template match="offerte" mode="invoice">
        <fo:block xsl:use-attribute-sets="title-0">Invoice nr. <xsl:value-of select="$INVOICE_NO"/></fo:block>
        <fo:block>
            <fo:block><xsl:value-of select="/offerte/meta/permission_parties/client/full_name"/></fo:block>
            <fo:block><xsl:if test="/offerte/meta/permission_parties/client/invoice_rep">T.a.v. <xsl:value-of select="/offerte/meta/permission_parties/client/invoice_rep"/></xsl:if></fo:block>
            <fo:block><xsl:value-of select="/offerte/meta/permission_parties/client/address"/></fo:block>
            <fo:block><xsl:value-of select="/offerte/meta/permission_parties/client/postal_code"/>&#160;<xsl:value-of select="/offerte/meta/permission_parties/client/city"/></fo:block>
            <fo:block><xsl:value-of select="/offerte/meta/permission_parties/client/country"/></fo:block>
            <fo:block><xsl:if test="/offerte/meta/permission_parties/client/invoice_mail"><xsl:value-of select="/offerte/meta/permission_parties/client/invoice_mail"/></xsl:if></fo:block>
        </fo:block>
        <fo:block xsl:use-attribute-sets="p big-space-below" text-align="right"><xsl:value-of select="$currentDate"/></fo:block>
        <fo:block xsl:use-attribute-sets="title-2">Services Delivered</fo:block>
        <fo:block>
            <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="big-space-below table-shading">
                <fo:table-column column-width="proportional-column-width(90)"/>
                <fo:table-column column-width="proportional-column-width(10)"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block><xsl:value-of select="/offerte/meta/pentestinfo/duration"/>-day&#160;<xsl:value-of select="/offerte/meta/offered_service_short"/>&#160;<xsl:value-of select="/offerte/meta/permission_parties/client/short_name"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td align-right">
                            <fo:block xsl:use-attribute-sets="p"><xsl:value-of select="$denomination"/>&#160;<xsl:number value="$fee" grouping-separator="," grouping-size="3"/>.--</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>VAT 21%</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td align-right">
                            <fo:block xsl:use-attribute-sets="p"><xsl:value-of select="$denomination"/>&#160;<xsl:number value="$vat" grouping-separator="," grouping-size="3"/>.--</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row xsl:use-attribute-sets="border-top bold">
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>Total amount to be paid</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td align-right">
                            <fo:block xsl:use-attribute-sets="p"><xsl:value-of select="$denomination"/>&#160;<xsl:number value="$vat + $fee" grouping-separator="," grouping-size="3"/>.--</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block xsl:use-attribute-sets="big-space-below"><xsl:value-of select="/*/meta/company/full_name"/> donates > 90% of its entire profits to charity.</fo:block>
        <fo:block xsl:use-attribute-sets="big-space-below">Please be so kind to pay within 30 days by money transfer, to the following account:</fo:block>
        
        <fo:block xsl:use-attribute-sets="big-space-below" margin-left="1.3cm"><fo:block><xsl:value-of select="/*/meta/company/full_name"/></fo:block>
        <fo:block>IBAN: <xsl:value-of select="/*/meta/company/iban"/></fo:block>
        <fo:block>Reference: <xsl:value-of select="$INVOICE_NO"/></fo:block></fo:block>
        
        <fo:block>Kind regards,</fo:block>
        <fo:block>your dedicated team at</fo:block>
        <fo:block><xsl:value-of select="/*/meta/company/full_name"/></fo:block>
    </xsl:template>


</xsl:stylesheet>
