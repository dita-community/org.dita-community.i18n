package org.ditacommunity.i18n.textanalysis;

import java.awt.*;
import java.awt.image.BufferedImage;

/**
 * Utility class to provide rendered text width for
 * text given a font and pixels density value.
 * <p>Useful for estimating the rendered geometry of text when
 * doing layout-aware output, such as determining how wide
 * a definition term or table cell will be.
 * </p>
 * <p>The values produced are only estimates relative to what
 * you will get from a browser or PDF renderer because of details
 * like kerning and interword space, layout sophistication that is
 * beyond this simple utility.</p>
 * <p>This class uses the Java2D API which requires a graphics context.
 * This may be a problem in "headless" environments.</p>
 */
public class TextMetrics {


    /**
     *
     * @param text
     * @param fontName
     * @param fontSize
     * @param fontStyle
     * @return Rendered length in pixels
     */
    public static int getRenderedLength(String text,
                                        String fontName,
                                        int fontSize,
                                        String fontStyle,
                                        boolean debug) {


        int fontStyleValue = getFontStyle(fontStyle);
        Font font = new Font(fontName, fontStyleValue, fontSize);
        if (debug) {
            System.out.println("Input font name \"" + fontName + "\" resulted in font \"" + font.getFontName() + "\"");
        }

        GraphicsEnvironment e = GraphicsEnvironment.getLocalGraphicsEnvironment();
        // NOTE: The image is just so we can create a Graphics instance, we're not
        // actually doing anything with the image.
        BufferedImage img = new BufferedImage(400, 600, BufferedImage.TYPE_INT_ARGB);
        Graphics graphics = img.createGraphics();
        graphics.setFont(font);
        FontMetrics metrics = graphics.getFontMetrics();
        int result = metrics.stringWidth(text);
        return result;

    }

    /**
     * Convert a font style string into a Font font-style constant.
     * @param fontStyle Font style string, e.g., "bold", "regular", "italic".
     * @return Font style constant. Uses Font.PLAIN if the string can't be otherwise mapped.
     */
    public static int getFontStyle(String fontStyle) {
        int result = Font.PLAIN;
        String normalized = fontStyle.trim().toLowerCase();
        if (normalized.matches("bold")) {
            return Font.BOLD;
        }
        if (normalized.matches("italic|slanted")) {
            return Font.ITALIC;
        }
        return result;
    }

    /**
     *
     * @param text
     * @param fontName
     * @return Rendered length in pixels
     */
    public static int getRenderedLength(String text,
                                        String fontName) {
        return getRenderedLength(text, fontName, 12, "plain", false);
    }

    /**
     *
     * @param text
     * @param fontName
     * @param fontSize
     * @return Rendered length in pixels
     */
    public static int getRenderedLength(String text,
                                 String fontName,
                                 int fontSize) {
        return getRenderedLength(text, fontName, fontSize, "plain", false);
    }


}
