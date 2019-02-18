package org.ditacommunity.i18n.saxon.functions;

import org.ditacommunity.i18n.I18nConstants;
import org.ditacommunity.i18n.textanalysis.TextMetrics;

import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.lib.ExtensionFunctionCall;
import net.sf.saxon.lib.ExtensionFunctionDefinition;
import net.sf.saxon.om.Item;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.value.BooleanValue;
import net.sf.saxon.value.Int64Value;
import net.sf.saxon.value.SequenceType;

/**
 * Saxon extension function for string length estimation.
 *
 */
public class TextMetricsGetRenderedLength extends ExtensionFunctionDefinition {

  @Override
  public StructuredQName getFunctionQName() {
    return new StructuredQName(
        I18nConstants.NS_PREFIX_DCI18N, 
        I18nConstants.NS_URI_DCI18N_SAXON_EXTENSION, 
        "getRenderedLength");
  }

  @Override
  public SequenceType[] getArgumentTypes() {
    return 
        new SequenceType[] {
          SequenceType.SINGLE_STRING, // String to get the length of
          SequenceType.SINGLE_STRING, // Font name
          SequenceType.SINGLE_INTEGER, // Font size (in points)
          SequenceType.SINGLE_STRING, // Font style ("plain", "bold", "italic")
          SequenceType.SINGLE_BOOLEAN // Debug
        };  
  }
  
  @Override
  public int getMinimumNumberOfArguments() {
    return 2;
  }  

  @Override
  public int getMaximumNumberOfArguments() {
    return 5;
  }  

  @Override
  public SequenceType getResultType(SequenceType[] arg0) {
    return SequenceType.SINGLE_INTEGER; // Length in pixels
  }

  @Override
  public ExtensionFunctionCall makeCallExpression() {
    return new TextAnalysisGetRenderedTextLengthCall();
  }
  
  private static class TextAnalysisGetRenderedTextLengthCall extends ExtensionFunctionCall {

    @SuppressWarnings("rawtypes")
    @Override
    public Sequence<? extends Item> call(XPathContext context, Sequence[] args) throws XPathException {
      String text = args[0].iterate().next().getStringValue();
      String fontName = args[1].iterate().next().getStringValue();
      long fontSize = 10;
      String fontStyle = "plain";
      boolean debug = false;
      try {
        if (args.length > 2) {
          fontSize = ((Int64Value)args[2].iterate().next()).longValue();
        }
        if (args.length > 3) {
          fontStyle = args[3].iterate().next().getStringValue();
        }
        if (args.length > 4) {
          debug = ((BooleanValue)args[4].iterate().next()).getBooleanValue();
        }
        int length = TextMetrics.getRenderedLength(text, fontName, fontSize, fontStyle, debug);
        return Int64Value.makeIntegerValue(length);
      } catch (Exception e) {
        throw new XPathException(e);
      }
    }

  }

}
