# org.dita-community.i18n

Internationalization Services for the DITA Open Toolkit

This package provides a set of general-purpose internationalization 
services for use with the DITA Open Toolkit XSLT and, if necessary,
Java processing.

It provides the following services:

* A customizable collator for use with XSLT. Includes support for 
dictionary-based Simplified Chinese grouping and sorting.
* A general grouping service useful for grouping index terms, glossary entries, etc.
* Access to the ICU word breaking facility in XSLT, useful for doing word breaking
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

You can customize both the grouping and sorting for a given language using
XML configuration files as for the DITA Open Toolkit PDF2 transform.

You can also extend or customize the Simplified Chinese dictionary to adjust
how Simplified Chinese is sorted. 

## Grouping Feature

Provides XSLT functions for getting locale-specific grouping keys for words.
Depends on the custom collator. Uses the same configuration file format as for the
DITA Open Toolkit PDF2 transform.

Makes it easy to do locale-specific grouping in XSLT as required for index generation,
glossary generation, and so on.

## Word Break Feature

Provides XSLT functions for breaking text strings into words using locale-specific
word breaking rules. Depends on the built-in word break algorithms and dictionaries
provided by the ICU package.

Useful whenever you need to break a string into words, for example to do manual 
line wrapping, to count words, or to insert zero-width spaces or other break-enabling
characters into strings.

## Status

10 Oct 2016

First try at getting something to work.

 