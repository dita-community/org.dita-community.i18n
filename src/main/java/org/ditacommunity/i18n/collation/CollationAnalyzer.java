package org.ditacommunity.i18n.collation;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.nio.file.FileSystems;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Locale;

import org.ditacommunity.i18n.textanalysis.WordSplittingSequenceIterator;

import net.sf.saxon.om.Item;

/**
 * Utility to do analysis and reporting on the collation details
 * of text in order to debug and evaluate the collation results.
 */
public class CollationAnalyzer {

    /**
     * arg[1] filename of text to process. A file where each line is a separate string
     * to be collated and the first line is the language code for the language of the text, e.g.:
     * <pre>
     * zh-CN
     * 摆位
     * ...
     * </pre>
     * @param args
     */
    public static void main(String[] args) {
        if (args.length < 1) {
            System.err.println("You must specify the input filename.");
            System.exit(1);
        }
        String inFilename = args[0];
        File inFile = FileSystems.getDefault().getPath(inFilename).toFile();
        if (!inFile.exists()) {
            System.err.println("Cannot find input file \"" + inFile.getAbsolutePath() + "\"");
            System.exit(1);
        }
        if (!inFile.canRead()) {
            System.err.println("Cannot read input file \"" + inFile.getAbsolutePath() + "\"");
            System.exit(1);
        }
        OutputType outType = null;
        if (args.length > 1) {
            outType = OutputType.fromString(args[1]);
        }
        if (outType == null) outType = OutputType.TEXT;
        try {
            reportCollationDetails(inFile, System.out, outType);
        } catch (Exception e) {
            System.err.println("Unexpected " + e.getClass().getSimpleName() + ":");
            e.printStackTrace();
            System.exit(1);
        }
    }

    /**
     * Report the collation details for the input file.
     * @param inFile Input file (see @main for details).
     */
    public static void reportCollationDetails(File inFile,
                                              PrintStream outStream,
                                              OutputType outType) throws Exception {
        InputStream inStream = new FileInputStream(inFile);

        reportCollationDetails(inStream, outStream, outType);
    }

    /**
     * Report the collation details for the input stream.
     * @param inStream Input stream (see @main for details).
     * @param outStream
     * @param outType
     */
    public static void reportCollationDetails(InputStream inStream,
                                              PrintStream outStream,
                                              OutputType outType) throws Exception {

        PrintStream utf16Stream = new PrintStream(outStream, true, "UTF-16LE");
        BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
        String line = getNextDataLine(reader);
        String langCode = line.trim();
        if ("zh-cn".equals(langCode.toLowerCase())) {
            switch (outType) {
                case CSV:
                    reportZhCnCollationAsCSV(langCode, reader, utf16Stream);
                    break;
                case TEXT:
                default:
                    reportZhCnCollation(langCode, reader, outStream);

            }
        } else {
            System.err.println("Language codes other than zh-CN not yet implemented.");
        }

    }

    /**
     * @param langCode
     * @param reader
     * @param outStream
     */
    public static void reportZhCnCollation(String langCode, BufferedReader reader, PrintStream outStream) throws Exception {
        // Two parts: first do word and pinyin analysis in the order provided then
        // do the sort.
        ArrayList<String> terms = loadTerms(reader);
        Locale locale = Locale.forLanguageTag(langCode);

        boolean debug = false;
        outStream.print("Collation report for language ");


        outStream.println("\nInput terms:\n");
        int i = 0;
        for (String term : terms) {
            outStream.format("[%2d] Term: \"%s\"%n", ++i, term);
            WordSplittingSequenceIterator iterator = new WordSplittingSequenceIterator(locale, term, debug);
            Item item = iterator.next();
            outStream.println("       Words and pinyin:");
            while (item != null) {
                String word = item.getStringValue();
                if (Character.isLetter(word.charAt(0))) {
                    String pinyin = ZhCnDictionary.getPinYin(word);
                    outStream.format("\t\t \"%s\"\t: %s\"%n", word, pinyin);
                }
                item = iterator.next();
            }
         }
        outStream.println("\n========================\n");
        outStream.println("\nSorted:\n");
        ArrayList<String> list = new ArrayList<>(terms);
        Collections.sort(list, ZhCnAwareCollator.getInstance(locale));
        outStream.println();
        i = 0;
        for (String term : terms) {
            outStream.format("[%2d] \"%s\"%n", ++i, term);
        }


    }

    /**
     * @param langCode
     * @param reader
     * @param outStream
     */
    public static void reportZhCnCollationAsCSV(String langCode, BufferedReader reader, PrintStream outStream) throws Exception {
        // Two parts: first do word and pinyin analysis in the order provided then
        // do the sort.
        ArrayList<String> terms = loadTerms(reader);
        Locale locale = Locale.forLanguageTag(langCode);

        boolean debug = false;

        outStream.write(0xFF);
        outStream.write(0xFE);

        outStream.println("\"Input terms\t\"words\t\"pinyin");
        for (String term : terms) {
            WordSplittingSequenceIterator iterator = new WordSplittingSequenceIterator(locale, term, debug);
            Item item = iterator.next();
            while (item != null) {
                String word = item.getStringValue();
                if (Character.isLetter(word.charAt(0))) {
                    String pinyin = ZhCnDictionary.getPinYin(word);
                    outStream.format("\"%s\t\"%s\t\"%s%n", term, word, pinyin);
                }
                item = iterator.next();
            }
        }

        ArrayList<String> list = new ArrayList<>(terms);
        Collections.sort(list, ZhCnAwareCollator.getInstance(locale));
        outStream.println();

        outStream.println("\"Sorted terms\t\"pinyin");
        for (String term : terms) {
            outStream.format("\"%s\t\"%s%n", term, ZhCnDictionary.getPinYin(term));
        }


    }

    private static ArrayList<String> loadTerms(BufferedReader reader) throws IOException {
        // System.out.println("\nLoading terms:\n");
        ArrayList<String> terms = new ArrayList<String>();
        String term = getNextDataLine(reader);
        while (null != term) {
            terms.add(term.trim());
            term = getNextDataLine(reader);
        }
        return terms;
    }

    private static String getNextDataLine(BufferedReader reader) throws IOException {
        String line = reader.readLine();
        while ((null != line) && (line.startsWith("#") || line.trim().equals(""))) {
            line = reader.readLine();

        }
        return line;
    }


}
