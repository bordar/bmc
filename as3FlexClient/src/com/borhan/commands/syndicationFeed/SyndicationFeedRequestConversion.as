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
package com.borhan.commands.syndicationFeed
{
	import com.borhan.delegates.syndicationFeed.SyndicationFeedRequestConversionDelegate;
	import com.borhan.net.BorhanCall;

	/**
	* request conversion for all entries that doesnt have the required flavor param
	* returns a comma-separated ids of conversion jobs
	**/
	public class SyndicationFeedRequestConversion extends BorhanCall
	{
		public var filterFields : String;
		
		/**
		* @param feedId String
		**/
		public function SyndicationFeedRequestConversion( feedId : String )
		{
			service= 'syndicationfeed';
			action= 'requestConversion';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('feedId');
			valueArr.push(feedId);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new SyndicationFeedRequestConversionDelegate( this , config );
		}
	}
}
