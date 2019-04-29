# org.dita-community.i18n

Internationalization Services for the DITA Open Toolkit

This package provides a set of general-purpose internationalization 
services for use with the DITA Open Toolkit XSLT and, if necessary,
Java processing.

It provides the following services:

* A customizable collator for use with XSLT. Includes support for 
dictionary-based Simplified Chinese grouping and sorting.
* A general grouping service useful for grouping index terms, glossary entries, etc.
* Access to the ICU line and word breaking facility in XSLT, useful for doing word breaking
in languages like Thai and Chinese that require a dictionary or writing-system-specific
rules.

The code is packaged as a DITA Open Toolkit plugin but the features may be used 
with any XSLT transform or in any Java program. The Open Toolkit plugin uses the
OT's plugin features to manage the Java class path and other integration details.

## Simplified Chinese support

Correct sorting of Simplified Chinese requires a dictionary because Simplified
Chinese is sorted according to the pinyin transliteration of each word. This means
that you cannot simply map individual characters to pinyin and then sort because
the same character may have a different transliteration when used in different words.

This package uses the open-source CC-CEDICT dictionary, which currently has about
140 thousand entries, more than sufficient to sort most Simplified Chinese content.

The CC-CEDICT package is available here:

http://www.mdbg.net/chindict/chindict.php?page=cedict

See that page for licensing details, but per that Web site, the data may used for
commercial and non-commercial purposes as long as attribution is provided, making
the license compatible with the Open Toolkit's Apache 2 license.

## Custom Collator Feature

Provides a Java implementation of RuleBasedCollator that can then be used
with Saxon 9.1+ or with other XSLT engines or Java code that needs to do
collation. The core collation functionality is provided by the ICU4J 
library.

*NOTE:* Support for Saxon 9.6+ is under development but the 9.1 and 9.6 collation
APIs are not compatible so it requires two different code sets.

You can customize both the grouping and sorting for a given language using
project-specific grouping configuration files or normal ICU collation rule
files.

You can also extend or customize the Simplified Chinese dictionary to adjust
how Simplified Chinese is sorted. 

## Grouping Feature

*NOTE*: Grouping feature TBD

Provides XSLT functions for getting locale-specific grouping keys for words.
Depends on the custom collator. Uses the same configuration file format as for the
DITA Open Toolkit PDF2 transform.

Makes it easy to do locale-specific grouping in XSLT as required for index generation,
glossary generation, and so on.

## Line and Word Break Feature

Provides XSLT extension functions that use the ICU4J line break and work break
features to enable doing locale-specific line and word breaking, including in
CJK languages that do not use spaces or that require a dictionary to determine
word boundaries.

## Installation and Removal

You can use the OT 3.x `--install` command to install this plugin from the DITA OT plugin registry ([https://www.dita-ot.org/plugins]):

```
bin/dita --install org.dita-community.i18n
```

Likewise, you can uninstall the plugin using the `--uninstall` command:

```
bin/dita --uninstall org.dita-community.i18n
```

However, there's an issue with the OT as of 3.3.1 where the uninstall fails with an error like this:

```
Error: The following error occurred while executing this line:
/Users/ekimber/dita-ot/dita-ot-3.3-dc/integrator.xml:45: javax.xml.transform.TransformerFactoryConfigurationError: Provider for class javax.xml.transform.TransformerFactory cannot be created
```

This is a side effect of the fact that the plugin provides a custom Saxon transformer that Saxon tries to find after the jar file with it has already been removed by the uninstall process. This is a pretty serious edge case for the uninstaller and is unlikely to be fixed.

The workaround is simply to run the `--install` command with no arguments a second time:

```
bin/dita --install
Removed org.dita-community.i18n 
```

Which will remove the plugin completely.


## Status

29 May 2019

Added installation and removal instructions

02 Mar 2019 Version 2.0.1

Corrected plugin.xml file, automated putting version in plugin.xml file.

24 Feb 2019 Version 2.0.0

* Updated to work with Saxon 9.8 and OT 3.3. Saxon configuration is now 100% automatic for OT 3.3. 
* Support for Saxon 9.1 removed. 

20 Oct 2016

* Collator fully tested with Saxon 9.1.
* Initial support for line and word breaking extension functions
* Refined XSLT functions in i18n-utils.xsl to enable getting primary and secondary 
sort keys

10 Oct 2016

First try at getting something to work.

 