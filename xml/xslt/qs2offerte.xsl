<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="xs" version="2.0">

    <!-- ROOT -->
    <xsl:template match="/">

        <offerte xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:noNamespaceSchemaLocation="../dtd/offerte.xsd"
            xmlns:xi="http://www.w3.org/2001/XInclude">
            <xsl:comment>document meta information; to be filled in by the offerte writer</xsl:comment>
            <meta>
                <offered_service_long><xsl:value-of select="/*/meta/requested_service"
                    /></offered_service_long>
                <xsl:comment>if there is a shorter way of saying the same thing, you can type it here (it makes for more dynamic offerte text). If not, just repeat the long name.</xsl:comment>
                <offered_service_short>penetration test</offered_service_short>
                <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/ros_info.xml</xsl:attribute>
                </xsl:element>
                <targets>
                    <xsl:comment>one target element per target</xsl:comment>
                    <xsl:for-each select="/*/meta/targets/target">
                        <xsl:copy><xsl:copy-of select="node()"/></xsl:copy>
                    </xsl:for-each>
                </targets>
                <permission_parties>
                    <client><xsl:comment>mandatory; please add client information</xsl:comment>
                        <full_name><xsl:value-of select="/*/customer/full_name"/></full_name><xsl:comment>long client name, e.g. Sitting Duck B.V.</xsl:comment>
                        <short_name><xsl:value-of select="/*/customer/short_name"/></short_name>
                        <xsl:comment>short client name, e.g. Sitting Duck; if no short name: same as long name</xsl:comment>
                        <legal_rep><xsl:value-of select="/*/customer/legal_rep"/></legal_rep><xsl:comment>customer legal representative (to sign offer)</xsl:comment>
                        <waiver_rep><xsl:value-of select="/*/customer/waiver_rep"/></waiver_rep><xsl:comment>customer legal representative (to sign waiver; can be same person as legal_rep)</xsl:comment>
                        <poc1><xsl:value-of select="/*/customer/poc1"/></poc1><xsl:comment>first point of contact for customer (during pentest); can be same person as above</xsl:comment>
                        <address><xsl:value-of select="/*/customer/address"/></address>
                        <city><xsl:value-of select="/*/customer/city"/></city>
                        <country><xsl:value-of select="/*/customer/country"/></country>
                        <coc>
                            <xsl:attribute name="nationality"><xsl:value-of
                                    select="/*/customer/coc_nat"/></xsl:attribute>
                            <xsl:value-of select="/*/customer/coc_no"/>
                        </coc><xsl:comment>chamber of commerce number; if no chamber of commerce number, please delete the whole element</xsl:comment>
                    </client>
                    <xsl:if test="/*/third_party">
                        <party>
                            <full_name><xsl:value-of select="/*/third_party/full_name"/></full_name>
                            <short_name><xsl:value-of select="/*/third_party/short_name"
                                /></short_name>
                            <xsl:comment>short party name; if no short name: same as long name</xsl:comment>
                            <waiver_rep><xsl:value-of select="/*/third_party/waiver_rep"
                                /></waiver_rep>
                            <address><xsl:value-of select="/*/third_party/address"/></address>
                            <city><xsl:value-of select="/*/third_party/city"/></city>
                            <country><xsl:value-of select="/*/third_party/country"/></country>
                        </party>
                    </xsl:if>
                </permission_parties>
                <pentestinfo>
                    <duration><xsl:value-of select="/*/pentest_info/days"/></duration><xsl:comment>duration of pentest, in working days</xsl:comment>
                    <test_planning><xsl:value-of select="/*/pentest_info/planning"/></test_planning>
                    <xsl:comment>date or date range in text, e.g. May 18th until May 25th, 2015</xsl:comment>
                    <report_writing>???</report_writing>
                    <xsl:comment>date or date range in text, e.g. May 18th until May 25th, 2015</xsl:comment>
                    <report_due><xsl:value-of select="/*/pentest_info/delivery"/></report_due>
                    <xsl:comment>date or date range in text, e.g. May 18th until May 25th, 2015</xsl:comment>
                    <nature><xsl:value-of select="/*/pentest_info/nature"/></nature>
                    <type><xsl:value-of select="/*/pentest_info/type"/></type><xsl:comment>please choose one of the following: black-box, grey-box, crystal-box</xsl:comment>
                    <fee><xsl:value-of select="/*/pentest_info/rate"/></fee><xsl:comment>euro is added automatically in the document</xsl:comment>
                    <target_application>FishInABarrel</target_application><xsl:comment>name of application/serice to be tested (if any; if none, delete target_application element)</xsl:comment>
                </pentestinfo>
                <version_history><xsl:comment>needed for date on frontpage and in signature boxes; it is possible to add a new &lt;version> after each review; in that case, make sure to update the date/time</xsl:comment>
                    <version number="auto">
                        <xsl:attribute name="date"><xsl:value-of select="/*/version/@date"
                            />T10:00:00</xsl:attribute>
                        <xsl:comment>actual date-time here; you can leave the number attribute alone</xsl:comment>
                        <v_author>ROS Writer</v_author>
                        <xsl:comment>name of the author here; for internal use only</xsl:comment>
                        <v_description>Initial
                        draft</v_description><xsl:comment>for internal use only</xsl:comment>
                    </version>
                </version_history>
            </meta>
            <!-- INTRODUCTION -->
            <section>
                <title>Introduction</title>
                <p><c_long/> (hereafter “<b><c_short/></b>”), with its registered office at
                    <c_street/>, <c_city/>, <c_country/>, has requested <ros_long/> (hereafter
                        “<b><ros_short/></b>”) to perform <ros_svc_long/>.</p>
                <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/setoutscope.xml</xsl:attribute>
                </xsl:element>
            </section>
            <xsl:comment>Project overview section (complete section is in a snippet)</xsl:comment>
            <xsl:element name="xi:include">
                <xsl:attribute name="href">snippets/offerte/projectoverview.xml</xsl:attribute>
            </xsl:element>
            <xsl:comment>Prerequisites section (complete section is in a snippet)</xsl:comment>
            <xsl:element name="xi:include">
                <xsl:attribute name="href">snippets/offerte/prerequisites.xml</xsl:attribute>
            </xsl:element>
            <xsl:comment>Disclaimer section (complete section is in a snippet)</xsl:comment>
            <xsl:element name="xi:include">
                <xsl:attribute name="href">snippets/offerte/disclaimer.xml</xsl:attribute>
            </xsl:element>
            <xsl:comment>Pentest Methodology section</xsl:comment>
            <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/pentestmethodology.xml</xsl:attribute>
                </xsl:element>
                <xsl:if test="/*/pentest_info/codeaudit/@perform = 'yes'">
                    <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/codeauditmethodology.xml</xsl:attribute>
                    </xsl:element>
                </xsl:if>
            <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/teamandreporting.xml</xsl:attribute>
                </xsl:element>
            <xsl:comment>Planning and payment section (complete section is in a snippet)</xsl:comment>
            <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/planningandpayment.xml</xsl:attribute>
                </xsl:element>
            <xsl:comment>About ROS section (complete section is in a snippet)</xsl:comment>
            <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/aboutros.xml</xsl:attribute>
                </xsl:element>
            <xsl:comment>Work condition section (complete section is in a snippet)</xsl:comment>
            <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/conditions.xml</xsl:attribute>
                </xsl:element>
            <xsl:comment>General terms and conditions section (complete section is in a snippet)</xsl:comment>
            <xsl:element name="xi:include">
                    <xsl:attribute name="href">snippets/offerte/generaltermsandconditions.xml</xsl:attribute>
                </xsl:element>
            <xsl:comment>Waivers</xsl:comment>
            <generate_waivers/>
        </offerte>


    </xsl:template>



</xsl:stylesheet>
