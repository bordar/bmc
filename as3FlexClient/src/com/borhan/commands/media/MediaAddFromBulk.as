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
		import com.borhan.vo.BorhanMediaEntry;
	import com.borhan.delegates.media.MediaAddFromBulkDelegate;
	import com.borhan.net.BorhanCall;

	/**
	* Adds new media entry by importing an HTTP or FTP URL.
	* The entry will be queued for import and then for conversion.
	* This action should be exposed only to the batches
	**/
	public class MediaAddFromBulk extends BorhanCall
	{
		public var filterFields : String;
		
		/**
		* @param mediaEntry BorhanMediaEntry
		* @param url String
		* @param bulkUploadId int
		**/
		public function MediaAddFromBulk( mediaEntry : BorhanMediaEntry,url : String,bulkUploadId : int )
		{
			service= 'media';
			action= 'addFromBulk';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
				keyValArr = borhanObject2Arrays(mediaEntry, 'mediaEntry');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			keyArr.push('url');
			valueArr.push(url);
			keyArr.push('bulkUploadId');
			valueArr.push(bulkUploadId);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new MediaAddFromBulkDelegate( this , config );
		}
	}
}
