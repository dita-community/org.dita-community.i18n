import org.ditacommunity.i18n.textanalysis.TextMetrics;
import org.junit.Test;

import java.awt.*;
import java.awt.image.BufferedImage;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

/**
 * Created by ekimber on 10/24/16.
 */
public class TestFontMetrics {

    FontMetrics metrics;

    @Test
    public void testGetAllFonts() throws Exception {
        GraphicsEnvironment e = GraphicsEnvironment.getLocalGraphicsEnvironment();
        Font[] fonts = e.getAllFonts(); // Get the fonts
        for (Font f : fonts) {
            System.out.println(f.getFontName());
        }
    }

    @Test
    public void testGetFontMetrics() throws Exception {
//        String fontName = "arglebargle";
        String fontName = "Avenir";
        Font font = new Font(fontName, Font.PLAIN, 24);
        assertNotNull("No font \"" + fontName + "\"", font);
        System.out.println("Got font \"" + font.getFontName() + "\"");
        GraphicsEnvironment e = GraphicsEnvironment.getLocalGraphicsEnvironment();
        BufferedImage img = new BufferedImage(400, 600, BufferedImage.TYPE_INT_ARGB);
        Graphics graphics = img.createGraphics();
        graphics.setFont(font);
        FontMetrics metrics = graphics.getFontMetrics();
        for (int charNum = 20; charNum < 128; charNum++) {
            char c = Character.toChars(charNum)[0];
            System.out.println("[" + (charNum) + "] \"" + c + "\": " + metrics.charWidth(c));
        }
    }

    @Test
    public void testGetRenderedLength() throws Exception {
        String text1 = "“For ring gantry devices, the virtual isocenter is allocated outside of the gantry bore, so";
        int length = TextMetrics.getRenderedLength(text1, "Avenir", 24, "plain");
        assertTrue(length + " not greater than 20", length > 20);
        System.out.println("Length: " + length);
    }
}
