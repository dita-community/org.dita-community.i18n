package org.ditacommunity.i18n.saxon;

import org.ditacommunity.i18n.saxon.functions.TextAnalysisSplitLines;
import org.ditacommunity.i18n.saxon.functions.TextAnalysisSplitWords;
import org.ditacommunity.i18n.saxon.functions.TextMetricsGetRenderedLength;

import net.sf.saxon.Configuration;
import net.sf.saxon.Transform;
import net.sf.saxon.trans.CommandLineOptions;

public class ExtensionRegisteringTransform extends Transform {
  
  @Override
  public void applyLocalOptions (CommandLineOptions options, Configuration config) {   
    // System.out.println("ExtensionRegisteringTransform.applyLocalOptions(): registering extension functions...");
    config.registerExtensionFunction (new TextAnalysisSplitWords());
    config.registerExtensionFunction (new TextAnalysisSplitLines());
    config.registerExtensionFunction (new TextMetricsGetRenderedLength());
    // System.out.println("ExtensionRegisteringTransform.applyLocalOptions(): Extension functions registered.");
  }
  
  public static void main (String[] args) {
    Transform transform = new ExtensionRegisteringTransform();
    transform.doTransform(args, "Transform");
  }
}
