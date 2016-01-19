<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:template match="generate_targets">
        <xsl:call-template name="generate_targets_xslt"/>
    </xsl:template>

    <xsl:template name="generate_targets_xslt">
        <fo:list-block xsl:use-attribute-sets="list"  provisional-distance-between-starts="0.75cm"
            provisional-label-separation="2.5mm" space-after="12pt" start-indent="1cm">
            <xsl:for-each select="/*/meta/targets/target">
                <fo:list-item>
                    <!-- insert a bullet -->
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>
                            <fo:inline>&#8226;</fo:inline>
                        </fo:block>
                    </fo:list-item-label>
                    <!-- list text -->
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:value-of select="."/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:for-each>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="generate_findings">
        <xsl:variable name="Ref" select="@Ref"/>
        <fo:block>
            <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="table borders">
                <xsl:call-template name="checkIfLast"/>
                <fo:table-column column-width="proportional-column-width(12)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(22)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(50)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(16)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-body>
                    <fo:table-row xsl:use-attribute-sets="bg-orange borders">
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>ID</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>Type</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>Description</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>Threat level</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:choose>
                        <xsl:when test="@Ref">
                            <!-- Only generate a table for findings in the section with this Ref -->
                            <xsl:for-each
                                select="/pentest_report/descendant::finding[ancestor::*[@id = $Ref]]">
                                <xsl:call-template name="findingsSummaryContent"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="/pentest_report/descendant::finding">
                                <xsl:call-template name="findingsSummaryContent"/>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="findingsSummaryContent">
        <fo:table-row xsl:use-attribute-sets="borders TableFont">
            <fo:table-cell xsl:use-attribute-sets="td">
                <fo:block>
                    <xsl:apply-templates select="." mode="number"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="td">
                <fo:block>
                    <xsl:value-of select="@type"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="td">
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="description_summary">
                            <xsl:value-of select="description_summary"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="description" mode="summarytable"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="td">
                <fo:block>
                    <xsl:value-of select="@threatLevel"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template match="generate_recommendations">
        <xsl:variable name="Ref" select="@Ref"/>
        <fo:block>
            <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="table borders">
                <xsl:call-template name="checkIfLast"/>
                <fo:table-column column-width="proportional-column-width(12)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(22)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(66)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-body>
                    <fo:table-row xsl:use-attribute-sets="bg-orange borders">
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>ID</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>Type</fo:block>
                        </fo:table-cell>
                        <fo:table-cell xsl:use-attribute-sets="td">
                            <fo:block>Recommendation</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:choose>
                        <xsl:when test="@Ref">
                            <!-- Only generate a table for findings in the section with this Ref -->
                            <xsl:for-each
                                select="/pentest_report/descendant::finding[ancestor::*[@id = $Ref]]">
                                <xsl:call-template name="recommendationsSummaryContent"/>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="/pentest_report/descendant::finding">
                                <xsl:call-template name="recommendationsSummaryContent"/>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="recommendationsSummaryContent">
        <fo:table-row xsl:use-attribute-sets="TableFont borders">
            <fo:table-cell xsl:use-attribute-sets="td">
                <fo:block>
                    <xsl:apply-templates select="." mode="number"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="td">
                <fo:block>
                    <xsl:value-of select="@type"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell xsl:use-attribute-sets="td">
                <fo:block>
                    <xsl:choose>
                        <xsl:when test="recommendation_summary">
                            <xsl:value-of select="recommendation_summary"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="recommendation" mode="summarytable"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>


    <xsl:template match="generate_testteam">
        <fo:block>
            <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="borders">
                <fo:table-column column-width="proportional-column-width(25)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-column column-width="proportional-column-width(75)"
                    xsl:use-attribute-sets="borders"/>
                <fo:table-body>
                    <xsl:for-each select="/pentest_report/meta/collaborators/approver">
                        <fo:table-row xsl:use-attribute-sets="borders">
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:apply-templates select="name"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:apply-templates select="bio"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <xsl:for-each select="/pentest_report/meta/collaborators/pentesters/pentester">
                        <fo:table-row xsl:use-attribute-sets="borders">
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:apply-templates select="name"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:apply-templates select="bio"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template match="generate_offer_signature_box">

        <xsl:call-template name="generateSignatureBox">
            <xsl:with-param name="latestVersionDate" select="$latestVersionDate"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="generateSignatureBox">
        <xsl:param name="latestVersionDate"/>
        <fo:block keep-together.within-page="always" xsl:use-attribute-sets="signaturebox">
            <fo:block xsl:use-attribute-sets="title-client">SIGNED IN DUPLICATE</fo:block>
            <fo:block>
                <fo:table width="100%" table-layout="fixed" xsl:use-attribute-sets="borders">
                    <fo:table-column column-width="proportional-column-width(50)"
                        xsl:use-attribute-sets="borders"/>
                    <fo:table-column column-width="proportional-column-width(50)"
                        xsl:use-attribute-sets="borders"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:value-of select="$latestVersionDate"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:value-of select="$latestVersionDate"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:choose>
                                        <xsl:when test="/offerte">

                                            <xsl:value-of
                                                select="/*/meta/permission_parties/client/city"/>

                                        </xsl:when>
                                        <xsl:when test="/quickscope">

                                            <xsl:value-of select="/*/customer/city"/>

                                        </xsl:when>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:text>Amsterdam</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>&#160;</fo:block>
                                <fo:block>&#160;</fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>&#160;</fo:block>
                                <fo:block>&#160;</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:choose>
                                        <xsl:when test="/offerte">

                                            <xsl:value-of
                                                select="/*/meta/permission_parties/client/legal_rep"/>

                                        </xsl:when>
                                        <xsl:when test="/quickscope">

                                            <xsl:value-of select="/*/customer/legal_rep"/>

                                        </xsl:when>
                                    </xsl:choose>

                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block>
                                    <xsl:choose>
                                        <xsl:when test="/offerte">

                                            <xsl:value-of select="/*/meta/ros/legal_rep"/>

                                        </xsl:when>
                                        <xsl:when test="/quickscope">

                                            <xsl:value-of select="/*/ros/legal_rep"/>

                                        </xsl:when>
                                    </xsl:choose>

                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block xsl:use-attribute-sets="bold">
                                    <xsl:choose>
                                        <xsl:when test="/offerte">

                                            <xsl:value-of
                                                select="/*/meta/permission_parties/client/full_name"/>

                                        </xsl:when>
                                        <xsl:when test="/quickscope">

                                            <xsl:value-of select="/*/customer/full_name"/>

                                        </xsl:when>
                                    </xsl:choose>

                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="td">
                                <fo:block xsl:use-attribute-sets="bold">
                                    <xsl:choose>
                                        <xsl:when test="/offerte">

                                            <xsl:value-of select="/*/meta/ros/full_name"/>

                                        </xsl:when>
                                        <xsl:when test="/quickscope">

                                            <xsl:value-of select="/*/ros/full_name"/>

                                        </xsl:when>
                                    </xsl:choose>

                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template match="generate_permission_parties">
        <xsl:for-each select="/*/meta/permission_parties/client | /*/meta/permission_parties/party">
            <xsl:if test="self::party and not(following-sibling::party)"> and </xsl:if>
            <xsl:value-of select="full_name"/>
            <xsl:if test="../party[2]">, </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!-- PLACEHOLDERS -->
    <xsl:template match="c_long">
        <xsl:value-of select="/*/meta/permission_parties/client/full_name"/>
    </xsl:template>
    <xsl:template match="c_short">
        <xsl:value-of select="/*/meta/permission_parties/client/short_name"/>
    </xsl:template>
    <xsl:template match="c_street">
        <xsl:value-of select="/*/meta/permission_parties/client/address"/>
    </xsl:template>
    <xsl:template match="c_city">
        <xsl:value-of select="/*/meta/permission_parties/client/city"/>
    </xsl:template>
    <xsl:template match="c_country">
        <xsl:value-of select="/*/meta/permission_parties/client/country"/>
    </xsl:template>
    <xsl:template match="c_legal_rep">
        <xsl:value-of select="/*/meta/permission_parties/client/legal_rep"/>
    </xsl:template>
    <xsl:template match="c_waiver_rep">
        <xsl:value-of select="/*/meta/permission_parties/client/waiver_rep"/>
    </xsl:template>
    <xsl:template match="c_poc1">
        <xsl:value-of select="/*/meta/permission_parties/client/poc1"/>
    </xsl:template>
    <xsl:template match="c_coc">
        <xsl:value-of select="/*/meta/permission_parties/client/coc"/>
    </xsl:template>
    <xsl:template match="ros_long">
        <xsl:value-of select="/*/meta/ros/full_name"/>
    </xsl:template>
    <xsl:template match="ros_short">
        <xsl:value-of select="/*/meta/ros/short_name"/>
    </xsl:template>
    <xsl:template match="ros_svc_long">
        <xsl:value-of select="/*/meta/offered_service_long"/>
    </xsl:template>
    <xsl:template match="ros_svc_short">
        <xsl:value-of select="/*/meta/offered_service_short"/>
    </xsl:template>
    <xsl:template match="ros_legal_rep">
        <xsl:value-of select="/*/meta/ros/legal_rep"/>
    </xsl:template>
    <xsl:template match="ros_poc1">
        <xsl:value-of select="/*/meta/ros/poc1"/>
    </xsl:template>
    <xsl:template match="t_app">
        <xsl:value-of select="/*/meta/pentestinfo/target_application"/>
    </xsl:template>
    <xsl:template match="t_app_producer">
        <xsl:value-of select="/*/meta/pentestinfo/target_application_producer"/>
    </xsl:template>
    <xsl:template match="p_duration">
        <xsl:value-of select="/*/meta/pentestinfo/duration"/>
    </xsl:template>
    <xsl:template match="p_boxtype">
        <xsl:value-of select="/*/meta/pentestinfo/type"/>
    </xsl:template>
    <xsl:template match="p_fee">
        <xsl:value-of select="/*/meta/pentestinfo/fee"/>
    </xsl:template>
    <xsl:template match="p_testingduration">
        <xsl:value-of select="/*/meta/pentestinfo/test_planning"/>
    </xsl:template>
    <xsl:template match="p_reportwritingduration">
        <xsl:value-of select="/*/meta/pentestinfo/report_writing"/>
    </xsl:template>
    <xsl:template match="p_reportdue">
        <xsl:value-of select="/*/meta/pentestinfo/report_due"/>
    </xsl:template>
</xsl:stylesheet>
