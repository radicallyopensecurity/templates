RELEASE NOTES
=============

April 25, 2016
-------------

### Hidden elements

It is now possible to hide `section`, `appendix` and `annex` elements from the generated report, offerte or generic document. To do so, add the optional attribute `visibility="hidden"` to whatever it is you want to hide in the generated PDF.

Links to 

April 21, 2016
-------------

### Generic Documents

We now have a generic document type, which can be used for (drumroll) generic documents (whitepapers, training notes, presentation notes, whatever).

It is a super-simple template: it contains a a sparse meta section, an optional ToC and then any number of sections and elements. All the general text elements (tables, lists, pre, code, a, etc etc) can be used. It's so simple I'm not even going to document it. Check the example doc in `doc/examples` if you're lost, but if you've ever written an offer or a pentest report using this system it should be a piece of cake. :)

Usage: `genericdocument.xml --> genericdocument.pdf (using generate_doc.xsl + fop)`

April 4, 2016
-------------

### Associating targets with parties

You can now associate certain targets with certain parties. The `<client>` and <`party`> element now have an optional `id` attribute. Each `target` element now has an optional `Ref` attribute.

In waivers, only the targets associated with the party/client that needs to sign the waiver will be shown.

`<generate_targets/>` also has an optional `Ref` attribute for when you only want to generate a list of targets for one client/party.

If a target has no Ref attribute, it will appear in all the lists (both in the waivers and when using `<generate_targets/>`).


March 24, 2016
--------------
### More elaborate invoicing

Instead of generating an invoice straight from the offerte, as described in the release notes of March 10, you can now also take the roundabout route and customize the invoice.

So instead of:

1. offerte.xml --> invoice.pdf (using generate_inv.xsl + fop)

You can do:

1. offerte.xml --> invoice.xml (using off2inv.xsl)
2. edit invoice.xml (add some extra costs, most likely)
3. invoice.xml --> invoice.pdf (using generate_inv.xsl + fop)

More often than not, the simple route will do just fine, though.

### Added client VAT element

When billing EU customers, you do not need to charge VAT (but you do need to have the client's VAT number on the invoice). So the `<client>` element now has an optional `<vat_no>` child.

March 10, 2016
-------------
### Fee denomination

The `<fee>` element in `<pentestinfo>` now has an optional `denomination` attribute, which can be set to `euro` (default) or `dollar`. Yay for globalization! No, wait.

Anyway, the denomination is added automatically whenever you reference the fee using the `<p_fee/>` placeholder.

### Client info now has its own file

The `<client>` element has been extracted from the document and now exists all by itself in the file `client_info.xml`, which is located in the `source` directory. This gives us the possibility to have a 'client library' and to easily reuse client info - just replace the file with the proper one for the current client.

Note that there are some new fields in the client section, `<invoice_rep>` and `<invoice_mail>` for use in the... (see next section)

### Invoices!

w00t. You can now generate a pdf invoice directly from offerte.xml. Use:

`java  -jar saxon9he.jar -s:/path/to/offerte/source/offerte.xml -xsl:/path/to/offerte/xslt/generate_invoice.xsl -o:/path/to/report/target/invoice.fo INVOICE_NO=[invoice number] -xi` 

And then:

`fop -c conf/rosfop.xconf /path/to/offerte/target/invoice.fo path/to/offerte/target/invoice.pdf`

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

### Finally, we have a `<div>` element!

#### What does `<div>` do?

Nothing. `<div>` just *is*.

#### Sigh. Ok, why *is* `<div>`?

You can use `<div>` as a container for other block elements. This is basically only (but very) useful for snippets, as snippets need to be well-formed XML documentlets and can therefore only have one root element. If the snippet is a complete section, this is not a problem. If the snippet is a bunch of paragraphs or something, you're out of luck. Or rather, you used to be out of luck, because there was no `<div>`. But now there is `<div>`. So your snippet can be `<div>` (root element), containing everything you want. Well, everything that's allowed, anyway.

#### So what's allowed in `<div>`?

All block elements: p, ul, ol, table, img, pre, code

#### And what elements can *contain* `<div>`?

Sections, Annexes and Appendices. NOTHING ELSE. DON'T EVEN TRY.


