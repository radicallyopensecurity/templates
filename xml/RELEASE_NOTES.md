RELEASE NOTES
=============

March 9, 2016
-------------

### An essay on placeholders

#### Universality
Placeholders can now be used in both offertes and pentest reports. Within reason, though! Pentest reports only have access to a limited set as the other placeholders are not relevant:

- c_long, c_short, c_street, c_city, c_country (i.e. client data)
- company_long, company_short (i.e. company data)
- p_duration, p_boxtype, p_testingduration, p_reportwritingduration, p_reportdue (i.e. pentest info)
- t_app, t_app_producer (i.e. tested app name & producer)

To accommodate for especially those last two bullets, we now have room for an optional `pentestinfo` tag in the report meta section, following the `<targets>` element. It's the same as the `pentestinfo` for offertes, except it doesn't hold financial info.

#### Robustness
When you insert a placeholder, there is now a check to see if
a. The element you're referring to exists
b. The element you're referring to contains text

If either a or b are not the case, you'll end up with a red XXXXX. Which should hopefully get your, or somebody else's, attention during review time.

#### Title Case

Uppercase is now forced on titles that should be in uppercase (i.e. report and offerte title pages, plus offerte titles in general).

Forcing title case for pentest report titles is unfortunately not possible from a style point of view as xsl-fo can only capitalize every word, which is not really what we want. But Peter Mosmans's validation script has your back on this.

Todo
X schema
X xslt
- docs