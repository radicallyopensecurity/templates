<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="generate_waivers">
        <xsl:for-each select="/offerte/meta/permission_parties/client | /offerte/meta/permission_parties/party">
            <xsl:choose>
                <xsl:when test="local-name() = 'client'">
                    <xsl:call-template name="waiver"/>
                </xsl:when>
                <xsl:when test="local-name() = 'party'">
                    <!-- create an additional .fo file for every party that needs to sign -->
                    <xsl:variable name="cname_file">
                        <xsl:value-of select="translate(short_name,' ', '')"/>
                    </xsl:variable>
                    <xsl:variable name="filename">
                        <xsl:value-of select="concat('waiver_',$cname_file,'.fo')"/>
                    </xsl:variable>
                    <xsl:result-document href="{$filename}">
                        <fo:root>
            <xsl:call-template name="layout-master-set"/>
            <fo:page-sequence master-reference="Report">
            <xsl:call-template name="page_header"/>
            <xsl:call-template name="page_footer"/>
            <fo:flow flow-name="region-body" xsl:use-attribute-sets="DefaultFont">
                <fo:block>
                    <xsl:call-template name="waiver"/>
                </fo:block>
                <fo:block id="EndOfDoc"/>
            </fo:flow>
        </fo:page-sequence>
            
        </fo:root>
                    </xsl:result-document>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="waiver">
        <fo:block margin-bottom="1.5cm">
            <!--only if it's the first (2nd and more go each in their own file) -->
            <xsl:if test="local-name() = 'client'">
                <xsl:attribute name="break-before">page</xsl:attribute>
            </xsl:if>
        <fo:block xsl:use-attribute-sets="title-1"><xsl:if test="local-name() = 'client'"><xsl:text>ANNEX 2</xsl:text><fo:block/></xsl:if>PENETRATION TESTING WAIVER</fo:block>
        <fo:block xsl:use-attribute-sets="p"><fo:inline xsl:use-attribute-sets="bold"><fo:inline xsl:use-attribute-sets="underline"><xsl:value-of select="full_name"/></fo:inline> (“<xsl:value-of select="short_name"/>”)</fo:inline>, with its registered office at <xsl:value-of select="address"/>, <xsl:value-of select="city"/>, <xsl:value-of select="country"/>
            <xsl:if test="coc">, registered at the <xsl:value-of select="coc/@nationality"/> Chamber of Commerce under no. <xsl:value-of select="coc"/></xsl:if>
         and duly represented by <xsl:choose>
            <xsl:when test="waiver_rep">
                                    <xsl:value-of select="waiver_rep"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>__________________________________</xsl:text>
                                </xsl:otherwise>
         </xsl:choose>
                            </fo:block>
        <fo:block xsl:use-attribute-sets="p"><fo:inline xsl:use-attribute-sets="bold">WHEREAS:</fo:inline></fo:block>
<fo:block xsl:use-attribute-sets="p">A. <xsl:value-of select="../client/short_name"/> wants some of its systems to be tested, <xsl:value-of select="/offerte/meta/ros/full_name"/> (“<xsl:value-of select="/offerte/meta/ros/short_name"/>”) has offered to perform such testing for <xsl:value-of select="./client/short_name"/> and <xsl:value-of select="./client/short_name"/> has accepted this offer. The assignment will be performed by <xsl:value-of select="/offerte/meta/ros/short_name"/>' core-team members, external freelancers, and/or volunteers (the “Consultants”).</fo:block>
<fo:block xsl:use-attribute-sets="p">B. Some of the activities performed by <xsl:value-of select="/offerte/meta/ros/short_name"/> and the Consultants during the course of this assignment could be considered illegal, unless <xsl:value-of select="short_name"/> has given permission for these activities. <xsl:value-of select="/offerte/meta/ros/short_name"/> and the Consultant will only perform such activities if they have received the required permission.</fo:block>
<fo:block xsl:use-attribute-sets="p">C. <xsl:value-of select="short_name"/> is willing to give such permission to <xsl:value-of select="/offerte/meta/ros/short_name"/>, the Consultants and any other person <xsl:value-of select="/offerte/meta/ros/short_name"/> might employ or engage for the assignment.</fo:block>
<fo:block xsl:use-attribute-sets="p"><fo:inline xsl:use-attribute-sets="bold">DECLARES AS FOLLOWS:</fo:inline></fo:block>
<fo:block xsl:use-attribute-sets="p">1. <xsl:value-of select="short_name"/> is aware that <xsl:value-of select="/offerte/meta/ros/short_name"/> will perform penetration testing services of the following systems of <xsl:value-of select="short_name"/>, as described below. The services are intended to gain insight in the security of these systems. To do so, <xsl:value-of select="/offerte/meta/ros/short_name"/> will access these systems, attempt to find vulnerabilities and gain further access and elevated privileges by exploiting any vulnerabilities found. <xsl:value-of select="/offerte/meta/ros/short_name"/> will test the following targets (the “<fo:inline xsl:use-attribute-sets="bold">Targets</fo:inline>”):</fo:block>
<xsl:call-template name="generate_targets_xslt"></xsl:call-template>
<fo:block xsl:use-attribute-sets="p">2. <xsl:value-of select="short_name"/> hereby grants <xsl:value-of select="/offerte/meta/ros/short_name"/> and the Consultants on a date to be confirmed by email the broadest permission
possible to perform the assignment, including the permission to:</fo:block>
<fo:block xsl:use-attribute-sets="p">a. enter and use the Targets;</fo:block>
<fo:block xsl:use-attribute-sets="p">b. circumvent, breach, remove and turn off any security measures protecting the Targets;</fo:block>
<fo:block xsl:use-attribute-sets="p">c. copy, intercept, record, amend, delete, render unusable or inaccessible any data stored on, processed by or transferred via the Targets; and</fo:block>
<fo:block xsl:use-attribute-sets="p">d. hinder the access or use of the Targets,</fo:block>
<fo:block xsl:use-attribute-sets="p">but <xsl:value-of select="short_name"/> only grants the permission for these activities to the extent that (i) such activities are necessary to perform the assignment and (ii) such activities do not disrupt the normal business operations of <xsl:value-of select="short_name"/>.</fo:block>
<fo:block xsl:use-attribute-sets="p">3. The permission under Article 1 extends to all systems on which the Targets run, or which <xsl:value-of select="/offerte/meta/ros/short_name"/> or the Consultant might encounter while performing the assignment, regardless of whether these systems are owned by third parties.</fo:block>
<fo:block xsl:use-attribute-sets="p">4. <xsl:value-of select="short_name"/> warrants that it has the legal authority to give the permission set out under Articles 1 and 2. It also warrants it has obtained the necessary permissions from any third parties referred to under Article 3.</fo:block>
<fo:block xsl:use-attribute-sets="p">5. Should the public prosecutor initiate an investigation or criminal proceedings against <xsl:value-of select="/offerte/meta/ros/short_name"/> or any of the consultants it engaged or employed as a result of the performance of the assignment for the customer, then <xsl:value-of select="short_name"/> will co-operate fully with <xsl:value-of select="/offerte/meta/ros/short_name"/> in defending against this investigation or proceedings, including by providing any evidence it has which relates to this investigation or these proceedings.</fo:block>
        <xsl:call-template name="generate_waiver_signature_box"/>
    </fo:block>
    </xsl:template>
    
    
    <xsl:template name="generate_waiver_signature_box">
        <fo:block keep-together.within-page="always" xsl:use-attribute-sets="signaturebox">
            <fo:table width="100%" table-layout="fixed">
                <fo:table-column column-width="proportional-column-width(10)"/>
                <fo:table-column column-width="proportional-column-width(90)"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="td" number-rows-spanned="4">
                            <fo:block>Signed</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block xsl:use-attribute-sets="p">on &#160;&#160;&#160;<xsl:value-of select="$latestVersionDate"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block xsl:use-attribute-sets="p">in &#160;&#160;&#160; <xsl:value-of select="city"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <xsl:choose>
                                <xsl:when test="waiver_rep">
                                    <fo:block xsl:use-attribute-sets="p">by &#160;&#160;&#160;<xsl:value-of select="waiver_rep"/></fo:block>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:block xsl:use-attribute-sets="p">by &#160;&#160;&#160;__________________________________</fo:block>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block xsl:use-attribute-sets="p">for &#160;&#160;&#160;<xsl:value-of select="full_name"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>