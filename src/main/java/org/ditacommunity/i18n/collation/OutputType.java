package org.ditacommunity.i18n.collation;

/**
 * Output types for reports.
 */
public enum OutputType {
    CSV("csv"), // Comma-separated values
    TEXT("text"); // Text report
    // HTML("html") // HTML page.

    private String text;

    OutputType(String text) {
        this.text = text;
    }

    public String getText() {
        return this.text;
    }

    public static OutputType fromString(String text) {
        if (text != null) {
            for (OutputType b : OutputType.values()) {
                if (text.equalsIgnoreCase(b.text)) {
                    return b;
                }
            }
        }
        return null;
    }
}
