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
	public dynamic class BorhanFileSync extends BaseFlexVo
	{
		/**
		**/
		public var id : Number = Number.NEGATIVE_INFINITY;

		/**
		**/
		public var partnerId : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanFileSyncObjectType
		**/
		public var fileObjectType : String = null;

		/**
		**/
		public var objectId : String = null;

		/**
		**/
		public var version : String = null;

		/**
		**/
		public var objectSubType : int = int.MIN_VALUE;

		/**
		**/
		public var dc : String = null;

		/**
		**/
		public var original : int = int.MIN_VALUE;

		/**
		**/
		public var createdAt : int = int.MIN_VALUE;

		/**
		**/
		public var updatedAt : int = int.MIN_VALUE;

		/**
		**/
		public var readyAt : int = int.MIN_VALUE;

		/**
		**/
		public var syncTime : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanFileSyncStatus
		**/
		public var status : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanFileSyncType
		**/
		public var fileType : int = int.MIN_VALUE;

		/**
		**/
		public var linkedId : int = int.MIN_VALUE;

		/**
		**/
		public var linkCount : int = int.MIN_VALUE;

		/**
		**/
		public var fileRoot : String = null;

		/**
		**/
		public var filePath : String = null;

		/**
		**/
		public var fileSize : Number = Number.NEGATIVE_INFINITY;

		/**
		**/
		public var fileUrl : String = null;

		/**
		**/
		public var fileContent : String = null;

		/**
		**/
		public var fileDiscSize : Number = Number.NEGATIVE_INFINITY;

		/**
		* @see com.borhan.types.borhanBoolean
		**/
		public var isCurrentDc : Boolean;

		/**
		* @see com.borhan.types.borhanBoolean
		**/
		public var isDir : Boolean;

		/**
		**/
		public var originalId : int = int.MIN_VALUE;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('status');
			arr.push('fileRoot');
			arr.push('filePath');
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
