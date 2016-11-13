DITA OT With i18n Plugin Integrated 
===================================

This container provides an image
of the DITA Open Toolkit with the DITA Community
Internationalization plugin integrated.

It is identical to the base OT container except for
two changes:

1. Integrates the org.dita-community.i18n plugin
1. Sets the javax.xml.transform.TransformerFactory system property to use the i18n transformer factory. 

It defines one volume in addition to the
two volumes defined by the dita-ot-base
container:

- /opt/dita-ot/DITA-OT is the full DITA-OT itself

NOTE: Use the image ditaot/dita-ot-base as the extension base for new DITA-OT images.
This image will not work because the volume definitions in this image prevent other images
based on it from persisting anything to the OT. 