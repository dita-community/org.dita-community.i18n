package org.ditacommunity.i18n.collation;

import java.io.*;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

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
        try {
            reportCollationDetails(inFile);
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
    public static void reportCollationDetails(File inFile) throws Exception {
        InputStream inStream = new FileInputStream(inFile);
        reportCollationDetails(inStream);
    }

    /**
     * Report the collation details for the input stream.
     * @param inStream Input stream (see @main for details).
     */
    public static void reportCollationDetails(InputStream inStream) throws Exception {

        System.out.print("Collation report for language ");
        BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
        String line = getNextDataLine(reader);
        String langCode = line.trim();
        System.out.print(langCode + "\n\n");
        if ("zh-cn".equals(langCode.toLowerCase())) {
            reportZhCnCollation(langCode, reader);
        } else {
            System.out.println("Language codes other than zh-CN not yet implemented.");
        }

    }

    /**
     *
     * @param langCode
     * @param reader
     */
    public static void reportZhCnCollation(String langCode, BufferedReader reader) throws IOException {
        // Two parts: first do word and pinyin analysis in the order provided then
        // do the sort.
        ArrayList<String> terms = loadTerms(reader);
        System.out.println("\nInput terms:\n");
        for (String term : terms) {
            System.out.println(term);
        }
        System.out.println("\n========================\n");

    }

    private static ArrayList<String> loadTerms(BufferedReader reader) throws IOException {
        System.out.println("\nLoading terms:\n");
        ArrayList<String> terms = new ArrayList<String>();
        String term = getNextDataLine(reader);
        System.out.println("term=\"" + term + "\"");
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
