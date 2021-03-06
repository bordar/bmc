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
	import com.borhan.vo.BaseFlexVo;

	[Bindable]
	public dynamic class BorhanConversionProfileAssetParams extends BaseFlexVo
	{
		/**
		* The id of the conversion profile
		**/
		public var conversionProfileId : int = int.MIN_VALUE;

		/**
		* The id of the asset params
		**/
		public var assetParamsId : int = int.MIN_VALUE;

		/**
		* The ingestion origin of the asset params
		* @see com.borhan.types.BorhanFlavorReadyBehaviorType
		**/
		public var readyBehavior : int = int.MIN_VALUE;

		/**
		* The ingestion origin of the asset params
		* @see com.borhan.types.BorhanAssetParamsOrigin
		**/
		public var origin : int = int.MIN_VALUE;

		/**
		* Asset params system name
		**/
		public var systemName : String = null;

		/**
		* Starts conversion even if the decision layer reduced the configuration to comply with the source
		* @see com.borhan.types.BorhanNullableBoolean
		**/
		public var forceNoneComplied : int = int.MIN_VALUE;

		/**
		* Specifies how to treat the flavor after conversion is finished
		* @see com.borhan.types.BorhanAssetParamsDeletePolicy
		**/
		public var deletePolicy : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanNullableBoolean
		**/
		public var isEncrypted : int = int.MIN_VALUE;

		/**
		**/
		public var contentAwareness : Number = Number.NEGATIVE_INFINITY;

		/**
		* @see com.borhan.types.BorhanNullableBoolean
		**/
		public var twoPass : int = int.MIN_VALUE;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('readyBehavior');
			arr.push('origin');
			arr.push('systemName');
			arr.push('forceNoneComplied');
			arr.push('deletePolicy');
			arr.push('isEncrypted');
			arr.push('contentAwareness');
			arr.push('twoPass');
			return arr;
		}

		/** 
		* a list of attributes which may only be inserted when initializing this object 
		**/ 
		public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			return arr;
		}

		/** 
		* get the expected type of array elements 
		* @param arrayName 	 name of an attribute of type array of the current object 
		* @return 	 un-qualified class name 
		**/ 
		public function getElementType(arrayName:String):String
		{
			var result:String = '';
			switch (arrayName) {
			}
			return result;
		}
	}
}
