// ===================================================================================================
//                           _  __     _ _
//                          | |/ /__ _| | |_ _  _ _ _ __ _
//                          | ' </ _` | |  _| || | '_/ _` |
//                          |_|\_\__,_|_|\__|\_,_|_| \__,_|
//
// This file is part of the Borhan Collaborative Media Suite which allows users
// to do with audio, video, and animation what Wiki platfroms allow them to do with
// text.
//
// Copyright (C) 2006-2016  Borhan Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
// @ignore
// ===================================================================================================
package com.borhan.commands.media
{
	import com.borhan.delegates.media.MediaGetMrssDelegate;
	import com.borhan.net.BorhanCall;

	/**
	* Get MRSS by entry id
	* XML will return as an escaped string
	**/
	public class MediaGetMrss extends BorhanCall
	{
		public var filterFields : String;
		
		/**
		* @param entryId String
		* @param extendingItemsArray Array
		* @param features String
		**/
		public function MediaGetMrss( entryId : String,extendingItemsArray : Array=null,features : String = null )
		{
			service= 'media';
			action= 'getMrss';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('entryId');
			valueArr.push(entryId);
			if (extendingItemsArray) { 
				keyValArr = extractArray(extendingItemsArray,'extendingItemsArray');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			} 
			keyArr.push('features');
			valueArr.push(features);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new MediaGetMrssDelegate( this , config );
		}
	}
}
