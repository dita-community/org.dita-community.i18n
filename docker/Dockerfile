FROM ditaot/dita-ot-base
MAINTAINER Eliot Kimber "ekimber@contrext.com"
USER root
RUN $DITA_HOME/bin/dita -install https://github.com/dita-community/org.dita-community.i18n/releases/download/version-0.2.4/org_dita-community_i18n_plugin.zip
VOLUME /opt/dita-ot/DITA-OT
ENV ANT_OPTS -Djavax.xml.transform.TransformerFactory=org.ditacommunity.i18n.saxon.DCI18nSaxonTransformerFactoryImpl91
CMD /bin/bash
#
# End of Dockerfile
#