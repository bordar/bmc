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
package com.borhan.vo
{
	import com.borhan.vo.BorhanConfigurableDistributionProfile;

	[Bindable]
	public dynamic class BorhanYoutubeApiDistributionProfile extends BorhanConfigurableDistributionProfile
	{
		/**
		**/
		public var username : String = null;

		/**
		**/
		public var defaultCategory : int = int.MIN_VALUE;

		/**
		**/
		public var allowComments : String = null;

		/**
		**/
		public var allowEmbedding : String = null;

		/**
		**/
		public var allowRatings : String = null;

		/**
		**/
		public var allowResponses : String = null;

		/**
		**/
		public var apiAuthorizeUrl : String = null;

		/**
		**/
		public var googleClientId : String = null;

		/**
		**/
		public var googleClientSecret : String = null;

		/**
		**/
		public var googleTokenData : String = null;

		/**
		* @see com.borhan.types.borhanBoolean
		**/
		public var assumeSuccess : Boolean;

		/**
		**/
		public var privacyStatus : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('username');
			arr.push('defaultCategory');
			arr.push('allowComments');
			arr.push('allowEmbedding');
			arr.push('allowRatings');
			arr.push('allowResponses');
			arr.push('apiAuthorizeUrl');
			arr.push('googleClientId');
			arr.push('googleClientSecret');
			arr.push('googleTokenData');
			arr.push('assumeSuccess');
			arr.push('privacyStatus');
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			return arr;
		}

		override public function getElementType(arrayName:String):String
		{
			var result:String = '';
			switch (arrayName) {
				default:
					result = super.getElementType(arrayName);
					break;
			}
			return result;
		}
	}
}
