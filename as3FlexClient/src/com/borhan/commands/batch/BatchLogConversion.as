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
package com.borhan.commands.batch
{
	import com.borhan.delegates.batch.BatchLogConversionDelegate;
	import com.borhan.net.BorhanCall;

	/**
	* Add the data to the flavor asset conversion log, creates it if doesn't exists
	**/
	public class BatchLogConversion extends BorhanCall
	{
		public var filterFields : String;
		
		/**
		* @param flavorAssetId String
		* @param data String
		**/
		public function BatchLogConversion( flavorAssetId : String,data : String )
		{
			service= 'batch';
			action= 'logConversion';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('flavorAssetId');
			valueArr.push(flavorAssetId);
			keyArr.push('data');
			valueArr.push(data);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new BatchLogConversionDelegate( this , config );
		}
	}
}
