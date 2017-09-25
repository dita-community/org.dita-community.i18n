/*
 * Copyright (c) 2016 DITA Community
 *
 * Adapted from ISOGEN I18N utilities project
 * (https://www.antennahouse.com/antenna1/i18n-support-library-2/) originally
 * developed by Eliot Kimber and enhanced by Antenna House.
 *
 */
/*--------------------------------------------------------------------------------
    Copyright (C) 2002, 2004 ISOGEN International

    http://www.isogen.com

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

 --------------------------------------------------------------------------------*/
package org.ditacommunity.i18n.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.net.URL;
import java.util.HashMap;

import org.w3c.dom.Attr;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Text;


/**
 *
 * @version $Revision: 1.1.1.1 $
 *
 * Provides utility functions needed by other i18n support classes.
 * 
 * If your documents to be processed use an attribute other than xml:lang= to
 * indicate their national language, use the System property "com.isogen.i18n.langAttName" to
 * specify the name of the attribute to use. This approach assumes that for a given run all
 * the elements use the same attribute name, which would almost always be the case.
 *
 */
 public class I18nUtil {

    static String langAttName = "language"; // Name of DTD-specific attribute that holds language value.
    // Used by the isTargetLanguage() method. No need to set this
    // to "xml:lang" as that is always used as a fallback.

	static {
	
	}

    private static HashMap<Character, Integer> hexMap;
    private static char[] hexCharsLC = {
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c',
      'd', 'e', 'f'
    };
    private static char[] hexCharsUC = {
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
      'D', 'E', 'F'
    };

	 static {
		if (System.getProperty("com.isogen.i18n.langAttName") != null) {
			langAttName = System.getProperty("com.isogen.i18n.langAttName");
		}    	
		
		hexMap = new HashMap<Character, Integer>();
		for( int index = 0; index < hexCharsLC.length; index++ ) {
			hexMap.put( new Character( hexCharsLC[ index ] ),
			new Integer( index ) );
			if( hexCharsLC[ index ] != hexCharsUC[ index ] )
				hexMap.put( new Character( hexCharsUC[ index ] ),
						new Integer( index ) );
		}
	}


	 /**
	  * Removes leading and trailing angle brackets from a string.
	  * @param toStrip The string to be stripped.
	  * @return The string with the angle brackets removed.
	  */
	 public static String stripAngleBrackets(String toStrip) {
	    return toStrip.substring(1, toStrip.length()-1);
	 }

	 /**
	  * Given a hex string ("A012EBCD"), returns the bytes it represents.
	  * @param hexString A sequence of hex digit pairs.
	  * @return An array of the bytes specified by the hex string.
	  */
	 public static byte[] hexToBytes(String hexString){
		byte[] result = new byte[ hexString.length() / 2 ];
		char[] chars = hexString.toCharArray();
		int byteIndex = 0;
		int firstHalf;
		int secondHalf;
		
		for( int i = 0; i < chars.length; i +=2 )
		{
		   firstHalf = getIntForHexChar( chars[ i ] );
		   secondHalf = getIntForHexChar( chars[ i + 1 ] );
		   result[ byteIndex++ ] = (byte) ( ( firstHalf << 4 ) | secondHalf );
		}
		
		return result;
     }


	/**
	 * Given an element, returns the start tag as a string, including any attributes.
	 * 
	 * Used to generate markup strings from elements.
	 * 
	 * NOTE: This implementation does not account for '"' characters within attribute
	 * values.
	 * @param elem The element node to be echoed.
	 * @return XML start tag.
	 */
    public static String echoStartTag(Element elem) {
        String resultStr = "<" + elem.getTagName();
        String attstr = "";
        NamedNodeMap atts = elem.getAttributes();
        for (int j = 0; j < atts.getLength(); j++) {
            Attr att = (Attr)(atts.item(j));
            // FIXME: doesn't account for '"' within attribute value.
            attstr = attstr + " " + att.getNodeName() + "=\"" + att.getNodeValue() + "\"";
        }
        resultStr = resultStr + attstr + ">";
        return resultStr;
    }

    /**
     * Given an element, returns the end tag as a string.
     * 
     * Used to generate markup strings from elements.
     * 
     * @param elem The element node to be echoed.
     * @return XML end tag.
     */
    public static String echoEndTag(Element elem) {
        return "</" + elem.getTagName() + ">";
    }

    /**
     * Returns element that exhibits the specified attribute, walking up
     * the element hierarchy.
     * 
     * @param startNode The node to check first. It's ancestors will be interogated until 
     * the attribute is found or the root is reached.
     * @param attName The name of the attribute to find.
     * @return Returns the element or null if not found.
     * @throws I18nUtilError
     */
    public static Element getAttHolder(Element startNode, String attName) throws I18nUtilError{
       Node attHolderNode = startNode;
       while ((attHolderNode.getNodeType() != Node.DOCUMENT_NODE) &&
               (!((Element)attHolderNode).hasAttribute(attName))) {
           attHolderNode = attHolderNode.getParentNode();
       }
       if (attHolderNode.getNodeType() == Node.DOCUMENT_NODE) {
           return null;
       } else {
           return (Element)attHolderNode;
       }
    }

    /**
      * Returns the first element node within the children of the specified element.
      *
      * @param elemNode The element whose first element child is to be returned.
      */
     public static Element getFirstElementChild(Element elemNode) {
         NodeList nl = elemNode.getChildNodes();
         for (int i = 0; i < nl.getLength(); i++) {
             Node cand = nl.item(i);
             if (cand.getNodeType() == Node.ELEMENT_NODE) {
                 return (Element)cand;
             }
         }
         return null;
     }

      /**
       * Returns true if the input element has element children.
       * 
       * @param elemNode
       * 
       */
      public static boolean hasElementChildren(Element elemNode) {
          NodeList nl = elemNode.getChildNodes();
          for (int i = 0; i < nl.getLength(); i++) {
              Node cand = nl.item(i);
              if (cand.getNodeType() == Node.ELEMENT_NODE) {
                  return true;
              }
          }
          return false;
      }

     /**
      * Returns the string content of an element (e.g., xsl:value-of()).
      * @param elem Element to get the value of.
      */
    public static String getElementContent(Element elem) {
        String resultStr = "";
        if (elem != null) {
	        NodeList childs = elem.getChildNodes();
	        for (int i = 0; i < childs.getLength(); i++) {
	            Node child = childs.item(i);
	            if (child.getNodeType() == Node.ELEMENT_NODE) {
	                resultStr = resultStr + echoStartTag((Element)child);
	                resultStr = resultStr + getElementContent((Element)child);
	                resultStr = resultStr + echoEndTag((Element)child);
	            } else if (child.getNodeType() == Node.TEXT_NODE) {
	                resultStr = resultStr + ((Text)child).getData();
	            } // Else: ignore other node types
	        }
		}
        return resultStr;
   }
    
    /**
     * Returns the string content of an element with newlines normalized to
     * single space characters.
     * 
     * @param elem Element to get the value of.
     * @return The normalized string value of the element.
     */
    public static String getElementContentNormalized(Element elem) {
    	String contStr = getElementContent(elem);
    	String resultStr = contStr.trim().replace('\n', ' ');
    	resultStr = contStr.trim().replace('\r', ' '); // In case carriage return gets through
    	return resultStr;
    }

    /**
     * Returns the language code associated with the specified element.
     * 
     * @param elemNode The whose language value is to be returned.
     * @param defaultLangCode The default language code to return if
     * there is no explicit language code.
     */
    public static String getElementLanguage(Element elemNode, 
                                            String defaultLangCode) {
       String langCode = defaultLangCode;
       if (elemNode.hasAttribute(langAttName)) {
           langCode = elemNode.getAttribute(langAttName);
       } else if (elemNode.hasAttributeNS("xml", "lang")) {
           langCode = elemNode.getAttributeNS("xml", "lang");
       }
       return langCode;
   }

    /**
     * Returns the element with the specified tag name.
     *
     * Throws an exception if element not found or if more than one found.
     */
    public static Element getElement(Element parentElem, String tagName) throws I18nUtilError {
        NodeList nl = parentElem.getElementsByTagName(tagName);
        if (nl.getLength() == 0) {
            throw new I18nUtilError("No " + tagName + " element found");
        }
        if (nl.getLength() > 1) {
            throw new I18nUtilError("Found more than one " + tagName + " elements");
        }
        Element result = (Element)nl.item(0);
        return result;
    }

    /**
     * Returns the int value of a character that is a hex digit 
     * @param hexChar The character to be processed, one of 0-9, A-F
     * @return The int value. E.g., for "A" return 10.
     */
    public static int getIntForHexChar( char hexChar )
    {
       return ( (Integer) hexMap.get( new Character( hexChar ) ) ).intValue();
    }
   
    /**
     * Given a string containing non-ASCII Unicode characters, returns the
     * same string will all non-ASCII characters replaced with "\\uxxxx" reflecting
     * their Unicode code points.
     * 
     * This method is useful for echoing arbitrary Unicode strings to ASCII-only
     * environments or environments where not all characters may be accounted for
     * by the font(s) in use.
     * 
     * @param inString String to be processed.
     * @return Escaped string.
     */
    public static String escapeUnicodeString(String inString) {
        int l = inString.length();
        byte[] bytes = new byte[l];
        try {
            bytes = inString.getBytes("UTF16");
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        String outString = "";
        byte zeroByte = new Byte("0").byteValue();
        byte lastByte = new Byte("127").byteValue();
        for (int i = 2; i < bytes.length; i = i + 2) {
            if ((bytes[i] == zeroByte) &&
                (bytes[i+1] <= lastByte)) {

                    try {
                        String newString = new String(bytes, i + 1, 1);
                        outString = outString + newString;
                    } catch (Exception e) {
                        System.err.println("escapeUnicodeString(): " + e.getMessage());
                    }
            } else {
                outString = outString + "\\u";
                outString = outString + byteToHex(bytes[i]) + byteToHex(bytes[i+1]);
            }
        }
        return outString;
    }

    /**
     * Converts a byte to the string representation of its hex value. 
     * @param b The byte to process.
     * @return A string consisting of hex digits.
     */
   static public String byteToHex(byte b) {
      // Returns hex String representation of byte b
      char hexDigit[] = {
         '0', '1', '2', '3', '4', '5', '6', '7',
         '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
      };
      char[] array = { hexDigit[(b >> 4) & 0x0f], hexDigit[b & 0x0f] };
      return new String(array);
   }

   /**
    * Returns hex String representation of char c, that is, the hex
    * digits of the Unicode code point for the character.
    * @param c Character to process.
    * @return Hex string of the character's code point.
    */
    static public String charToHex(char c) {
        // Returns hex String representation of char c
        byte hi = (byte) (c >>> 8);
        byte lo = (byte) (c & 0xff);
        return byteToHex(hi) + byteToHex(lo);
    }

    /**
     * Given the URl to a file in the specified encoding, returns a single string
     * with the contents of that file.
     *
     * @param fileUrl The URL of the file
     *
     * @param encoding The encoding name: UTF-8, UTF-16, etc.
     */
	static public String readUnicodeFile(URL fileUrl, String encoding)
			throws I18nUtilError {

		InputStream is = null;				
		try {
			is = fileUrl.openStream();
        } catch (IOException e) {
            e.printStackTrace();
			throw new I18nUtilError("IOException: " +
					e.getMessage() + " for URL '" + fileUrl.toExternalForm() + "'" );
        }
        return readUnicodeStream(is, encoding);
	}
			
	/**
	 * Reads the file at the specified path as a Unicode string in the specified encoding.
	 * @param filePath Path to file to read.
	 * @param encoding Encoding name (e.g. "UTF-16")
	 * @return String containing the file's contents.
	 * @throws I18nUtilError
	 */
	static public String readUnicodeFile(String filePath, String encoding)
			throws I18nUtilError {
		return readUnicodeFile(new File(filePath), encoding);
	}
	
	/**
	 * Reads the specified file as a Unicode string in the specified encoding.
	 * @param file File to be read.
	 * @param encoding Encoding name (e.g., "UTF-16")
	 * @return String containing the file's contents.
	 * @throws I18nUtilError
	 */
	static public String readUnicodeFile(File file, String encoding)
		throws I18nUtilError {
		FileInputStream fis;
        try {
            fis = new FileInputStream(file.getAbsolutePath());
        } catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new I18nUtilError("IOException: " +
					e.getMessage() + " for file '" + file.getAbsolutePath() + "'" );
        }
		return readUnicodeStream(fis, encoding);
	}
			
	/**
	 * Reads an InputStream as a Unicode string in the specified encoding.
	 * @param is InputStream to be read.
	 * @param encoding Encoding name (e.g., "UTF-16")
	 * @return String containing the stream's contents.
	 * @throws I18nUtilError
	 */
    static public String readUnicodeStream(InputStream is, String encoding)
            throws I18nUtilError {
        // This code copied directly from the Java tutorial
        StringBuffer buffer = new StringBuffer();
        try {
            InputStreamReader isr = new InputStreamReader(is, encoding);
            Reader in = new BufferedReader(isr);
            int ch;
            while ((ch = in.read()) > -1) {
                    /* 
                     * 2011/06/24 t.makita
                     */
            		char c=(char)ch;
            		buffer.append(c);
            		//String stChar=String.valueOf(ch);
                    //buffer.append(stChar);
            }
            in.close();
            String result=buffer.toString();
            return result;
        } catch (IOException e) {
            e.printStackTrace();
            throw new I18nUtilError("IOException: " + e.getMessage());
        }
   }

    /**
     * Writes a string to a file in the specified encoding.
     * @param outString String to be written.
     * @param filePath Path of file to write to.
     * @param encoding Encoding name (e.g., "UTF-16")
     * @throws I18nUtilError
     */
    static public void writeUnicodeFile(String outString, String filePath, String encoding)
                                             throws I18nUtilError {
        try {
            FileOutputStream fos = new FileOutputStream(filePath);
            Writer out = new OutputStreamWriter(fos, encoding);
            out.write(outString);
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            throw new I18nUtilError("writeUnicodeFile: " + e.getMessage() +
                                              " for file '" + filePath + "'");
        }
   }

    /**
     * Given a Java Locale object, constructs a RuleBasedCollator for the Locale, gets
     * the collation rules, and writes them to a file.
     * @param locale The Locale to get the rules for.
     * @param outFilePath File to write the rules to.
     * @throws I18nUtilError
     */
   /* 
   static public void writeCollationRulesForLocale(Locale locale,
                                                   String outFilePath)
                                    throws I18nUtilError {
        String sortRules = null;
        myjava.text.RuleBasedCollator col = (java.text.RuleBasedCollator)java.text.Collator.getInstance(locale);
        sortRules = col.getRules();
        I18nUtil.writeUnicodeFile(sortRules, outFilePath, "UTF8");
   }
   */

	/**
	 * Returns the value of the langAttName property.
	 * @return language attribute name.
	 */
	public static String getLangAttName() {
		return langAttName;
	}
}
