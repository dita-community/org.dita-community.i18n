package org.ditacommunity.i18n.saxon.functions;

import org.ditacommunity.i18n.I18nConstants;
import org.ditacommunity.i18n.textanalysis.TextAnalyzer;

import net.sf.saxon.expr.StaticProperty;
import net.sf.saxon.expr.XPathContext;
import net.sf.saxon.lib.ExtensionFunctionCall;
import net.sf.saxon.lib.ExtensionFunctionDefinition;
import net.sf.saxon.om.Item;
import net.sf.saxon.om.LazySequence;
import net.sf.saxon.om.Sequence;
import net.sf.saxon.om.SequenceIterator;
import net.sf.saxon.om.StructuredQName;
import net.sf.saxon.trans.XPathException;
import net.sf.saxon.type.BuiltInAtomicType;
import net.sf.saxon.value.BooleanValue;
import net.sf.saxon.value.SequenceType;

/**
 * Saxon extension function for locale-aware line splitting.
 *
 */
public class TextAnalysisSplitLines extends ExtensionFunctionDefinition {

  @Override
  public SequenceType[] getArgumentTypes() {
    return
      new SequenceType[] {
          SequenceType.SINGLE_STRING, // Text to split
          SequenceType.SINGLE_STRING, // Language code (locale)
          SequenceType.SINGLE_BOOLEAN // Debug
        };  
  }

  @Override
  public int getMinimumNumberOfArguments() {
    return 2;
  }

  @Override
  public int getMaximumNumberOfArguments() {
    return 3;
  }

  @Override
  public StructuredQName getFunctionQName() {
    return new StructuredQName(
        I18nConstants.NS_PREFIX_DCI18N, 
        I18nConstants.NS_URI_DCI18N_SAXON_EXTENSION, 
        "splitLines");
  }

  @Override
  public SequenceType getResultType(SequenceType[] arg0) {
    return new SequenceType(BuiltInAtomicType.INTEGER, StaticProperty.ALLOWS_ONE_OR_MORE);
  }

  @Override
  public ExtensionFunctionCall makeCallExpression() {
    return new TextAnalysisSplitLinesCall();  
  }
  
  private static class TextAnalysisSplitLinesCall extends ExtensionFunctionCall {

    @SuppressWarnings("rawtypes")
    @Override
    public Sequence<? extends Item> call(XPathContext context, Sequence[] args) throws XPathException {
      String text = args[0].iterate().next().getStringValue();
      String langCode = args[1].iterate().next().getStringValue();
      boolean debug = false;
      if (args.length > 2) {
        debug = ((BooleanValue)args[2].iterate().next()).getBooleanValue();
      }
      try {
        SequenceIterator<?> iterator = TextAnalyzer.splitLine(text, langCode, debug);
        return new LazySequence<>(iterator);
      } catch (Exception e) {
        throw new XPathException(e);
      }
    }

  }
  

}
