package org.ditacommunity.i18n.collation;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.nio.file.FileSystems;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Locale;

import org.apache.commons.io.IOUtils;
import org.ditacommunity.i18n.textanalysis.WordSplittingSequenceIterator;

import com.ibm.icu.text.CharsetDetector;
import com.ibm.icu.text.CharsetMatch;

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
     * æ‘†ä½�
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

        PrintStream utf8Stream = new PrintStream(outStream, true, "UTF8");
        // FIXME: May need UTF-16 stream for Windows output. The UTF-8 stream works on macOS
        
        byte[] inBytes = IOUtils.toByteArray(inStream);
        CharsetDetector detector = new CharsetDetector();
        detector.setText(inBytes);
        CharsetMatch match = detector.detect();
        String encoding = match.getName();
        BufferedReader reader = new BufferedReader(
        		new InputStreamReader(new ByteArrayInputStream(inBytes), encoding));
        String line = getNextDataLine(reader);
        String langCode = line.trim();
        if ("zh-cn".equals(langCode.toLowerCase())) {
            switch (outType) {
                case CSV:
                    reportZhCnCollationAsCSV(langCode, reader, utf8Stream);
                    break;
                case TEXT:
                default:
                    reportZhCnCollation(langCode, reader, utf8Stream);

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
        outStream.print("Collation report for language " + langCode);


        outStream.println("\nInput terms:\n");
        int i = 0;
        for (String term : terms) {
            outStream.format("[%2d] Term: \"%s\"%n", ++i, term);
            WordSplittingSequenceIterator iterator = new WordSplittingSequenceIterator(locale, term, debug);
            Item item = iterator.next();
            outStream.println("       Words and pinyin:");
            while (item != null) {
                String word = item.getStringValue();
                int codePoint = Character.codePointAt(word.toCharArray(), 0);
                if (Character.isLetter(codePoint)) {
                    String pinyin = ZhCnDictionary.getPinYin(word);
                    if (null == pinyin || pinyin.equals("")) {
                    	   pinyin = word;
                    }
                    outStream.format("\t\t \"%s\"\t: %s\"%n", word, pinyin) ;
                }
                item = iterator.next();
            }
            iterator.close();
         }
        outStream.println("\n========================\n");
        outStream.println("\nSorted:\n");
        ArrayList<String> list = new ArrayList<>(terms);
        Collator collator = ZhCnAwareCollator.getInstance(locale);
        Collections.sort(list, collator);
        outStream.println();
        i = 0;
        for (String term : list) {
            outStream.format("[%2d] \"%s\"\t\t\"%s\"\t%n", 
            		            ++i, 
            		            term, 
            		            ((ZhCnAwareCollator)collator).getZhCnSortKey(term));
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
        // System.err.println("Collation Analyzer version " + DCI18nCollationUriResolver91.getVersion());


        outStream.println("\"Input terms\"\t\"words\"\t\"pinyin\"");
        for (String term : terms) {
            WordSplittingSequenceIterator iterator = new WordSplittingSequenceIterator(locale, term, debug);
            Item item = iterator.next();
            StringBuilder words = new StringBuilder();
            StringBuilder pinyin = new StringBuilder();
            String sep = "";
            while (item != null) {
                String word = item.getStringValue();
                if (Character.isLetter(word.charAt(0))) {
                    words.append(sep).append(word);
                    pinyin.append(sep).append(ZhCnDictionary.getPinYin(word));
                } else if (Character.isDigit(word.charAt(0))) {
                		words.append(sep).append(word);
                		pinyin.append(sep).append(ZhCnDictionary.getPinYin(word));
                }
                item = iterator.next();
                sep = "|";
            }
            iterator.close();
            outStream.format("\"%s\"\t\"%s\"\t\"%s\"%n", term, words.toString(), pinyin.toString());
        }

        ArrayList<String> list = new ArrayList<>(terms);
        Collator collator = ZhCnAwareCollator.getInstance(locale);
        Collections.sort(list, collator);
        outStream.println();

        outStream.println("\"Sorted terms\"\t\"sort-key\"");
        for (String term : list) {
            outStream.format("\"%s\"\t\"%s\"%n", 
            		term,
            		((ZhCnAwareCollator)collator).getZhCnSortKey(term));
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
