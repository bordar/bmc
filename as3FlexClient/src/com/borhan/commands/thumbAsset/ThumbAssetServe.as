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
package com.borhan.commands.thumbAsset
{
		import com.borhan.vo.BorhanThumbParams;
		import com.borhan.vo.BorhanThumbnailServeOptions;
	import com.borhan.delegates.thumbAsset.ThumbAssetServeDelegate;
	import com.borhan.net.BorhanCall;

	/**
	* Serves thumbnail by its id
	**/
	public class ThumbAssetServe extends BorhanCall
	{
		public var filterFields : String;
		
		/**
		* @param thumbAssetId String
		* @param version int
		* @param thumbParams BorhanThumbParams
		* @param options BorhanThumbnailServeOptions
		**/
		public function ThumbAssetServe( thumbAssetId : String,version : int=int.MIN_VALUE,thumbParams : BorhanThumbParams=null,options : BorhanThumbnailServeOptions=null )
		{
			service= 'thumbasset';
			action= 'serve';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('thumbAssetId');
			valueArr.push(thumbAssetId);
			keyArr.push('version');
			valueArr.push(version);
			if (thumbParams) { 
				keyValArr = borhanObject2Arrays(thumbParams, 'thumbParams');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			} 
			if (options) { 
				keyValArr = borhanObject2Arrays(options, 'options');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			} 
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new ThumbAssetServeDelegate( this , config );
		}
	}
}
