PROJECT INFO:

Please edit this information as it becomes available.

scope:

planning:

duration:

contact persons:

focus:

accounts:

Brief notes from email: 

Directory overview:


This is an XML framework for generating Pentest Reports and Offers for clients. You download the whole framework whenever you need to write a new document (so every document exists in its own framework).

Directory overview:

doc
---

All available documentation in several formats (pick the one you like best). The 'tools' documentation is general. Writing documentation is specific to offertes and reports and is split up in subdirectories for each.

There is also an 'examples' directory which contains an example report, finding and offerte to have a look at. To generate an example report or offerte, copy it to the 'source' directory and generate it according to the instructions in the tools doc.

dtd
---

Contains schemas, i.e. the grammar of the report and offerte language. Not for users.

graphics
--------

If you use graphics in your report or offerte, place them here. You can then reference the graphics from your report or offerte by setting the img href attribute to "../graphics/yourgraphic.jpg".

source
------

Whenever you are creating a new report or offerte, copy the template (see 'template' directory) for it to this directory, edit the template and then generate it according to the instructions in the tools doc.

In 'source' there is a subdirectory 'snippets' containing boilerplate text for reports and offertes.

target
------

This is where your intermediate XSL-FO and generated PDF document end up if you have generated your XML according to the instructions in the tools doc.

templates
---------

Holds templates for offertes, reports, findings (general and specific) and non-findings. Grab whatever you need and copy it to the 'source' directory (in case of offerte or report) or the pentest repo's 'finding' directory (in case of findings). Then edit to your liking.

xslt
----

Contains stylesheets to transform the XML into XSL-FO, which can then be used to generate a PDF through FOP. Not for users.