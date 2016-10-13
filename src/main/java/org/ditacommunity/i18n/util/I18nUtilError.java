/*
 * Copyright (c) 2016 DITA Community
 *
 * Adapted from ISOGEN I18N utilities project
 * (https://www.antennahouse.com/antenna1/i18n-support-library-2/) originally
 * developed by Eliot Kimber and enhanced by Antenna House.
 *
 * This code has been generalized to any need for grouping, and collation,
 * not just indexes, and removes features not needed in the context of the
 * DITA Open Toolkit. Updated to work with current ICU4J libraries.
 */

/*--------------------------------------------------------------------------------
    Copyright (C) 2002 ISOGEN International

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

/**
 *
 * @version $Revision: 1.1.1.1 $
 */
public class I18nUtilError extends java.lang.Exception {

	private static final long serialVersionUID = 4994931351803946209L;


	public I18nUtilError() {
    }


    public I18nUtilError(String msg) {
        super(msg);
    }
}


