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
	import com.borhan.vo.BorhanAssetFilter;

	import com.borhan.vo.BorhanUrlTokenizer;

	import com.borhan.vo.BorhanUrlRecognizer;

	import com.borhan.vo.BaseFlexVo;

	[Bindable]
	public dynamic class BorhanDeliveryProfile extends BaseFlexVo
	{
		/**
		* The id of the Delivery
		**/
		public var id : int = int.MIN_VALUE;

		/**
		**/
		public var partnerId : int = int.MIN_VALUE;

		/**
		* The name of the Delivery
		**/
		public var name : String = null;

		/**
		* Delivery type
		* @see com.borhan.types.BorhanDeliveryProfileType
		**/
		public var type : String = null;

		/**
		* System name of the delivery
		**/
		public var systemName : String = null;

		/**
		* The description of the Delivery
		**/
		public var description : String = null;

		/**
		* Creation time as Unix timestamp (In seconds)
		**/
		public var createdAt : int = int.MIN_VALUE;

		/**
		* Update time as Unix timestamp (In seconds)
		**/
		public var updatedAt : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanPlaybackProtocol
		**/
		public var streamerType : String = null;

		/**
		**/
		public var url : String = null;

		/**
		* the host part of the url
		**/
		public var hostName : String = null;

		/**
		* @see com.borhan.types.BorhanDeliveryStatus
		**/
		public var status : int = int.MIN_VALUE;

		/**
		**/
		public var recognizer : BorhanUrlRecognizer;

		/**
		**/
		public var tokenizer : BorhanUrlTokenizer;

		/**
		* True if this is the systemwide default for the protocol
		* @see com.borhan.types.BorhanNullableBoolean
		**/
		public var isDefault : int = int.MIN_VALUE;

		/**
		* the object from which this object was cloned (or 0)
		**/
		public var parentId : int = int.MIN_VALUE;

		/**
		* Comma separated list of supported media protocols. f.i. rtmpe
		**/
		public var mediaProtocols : String = null;

		/**
		* priority used for ordering similar delivery profiles
		**/
		public var priority : int = int.MIN_VALUE;

		/**
		* Extra query string parameters that should be added to the url
		**/
		public var extraParams : String = null;

		/**
		* A filter that can be used to include additional assets in the URL (e.g. captions)
		**/
		public var supplementaryAssetsFilter : BorhanAssetFilter;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('name');
			arr.push('type');
			arr.push('systemName');
			arr.push('description');
			arr.push('streamerType');
			arr.push('url');
			arr.push('status');
			arr.push('recognizer');
			arr.push('tokenizer');
			arr.push('mediaProtocols');
			arr.push('priority');
			arr.push('extraParams');
			arr.push('supplementaryAssetsFilter');
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
				case 'recognizer':
					result = '';
					break;
				case 'tokenizer':
					result = '';
					break;
				case 'supplementaryAssetsFilter':
					result = '';
					break;
			}
			return result;
		}
	}
}
