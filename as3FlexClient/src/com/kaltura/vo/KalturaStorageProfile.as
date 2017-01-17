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
	public dynamic class BorhanStorageProfile extends BaseFlexVo
	{
		/**
		**/
		public var id : int = int.MIN_VALUE;

		/**
		**/
		public var createdAt : int = int.MIN_VALUE;

		/**
		**/
		public var updatedAt : int = int.MIN_VALUE;

		/**
		**/
		public var partnerId : int = int.MIN_VALUE;

		/**
		**/
		public var name : String = null;

		/**
		**/
		public var systemName : String = null;

		/**
		**/
		public var desciption : String = null;

		/**
		* @see com.borhan.types.BorhanStorageProfileStatus
		**/
		public var status : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanStorageProfileProtocol
		**/
		public var protocol : String = null;

		/**
		**/
		public var storageUrl : String = null;

		/**
		**/
		public var storageBaseDir : String = null;

		/**
		**/
		public var storageUsername : String = null;

		/**
		**/
		public var storagePassword : String = null;

		/**
		* @see com.borhan.types.borhanBoolean
		**/
		public var storageFtpPassiveMode : Boolean;

		/**
		**/
		public var minFileSize : int = int.MIN_VALUE;

		/**
		**/
		public var maxFileSize : int = int.MIN_VALUE;

		/**
		**/
		public var flavorParamsIds : String = null;

		/**
		**/
		public var maxConcurrentConnections : int = int.MIN_VALUE;

		/**
		**/
		public var pathManagerClass : String = null;

		/**
		**/
		public var pathManagerParams : Array = null;

		/**
		* No need to create enum for temp field
		**/
		public var trigger : int = int.MIN_VALUE;

		/**
		* Delivery Priority
		**/
		public var deliveryPriority : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanStorageProfileDeliveryStatus
		**/
		public var deliveryStatus : int = int.MIN_VALUE;

		/**
		* @see com.borhan.types.BorhanStorageProfileReadyBehavior
		**/
		public var readyBehavior : int = int.MIN_VALUE;

		/**
		* Flag sugnifying that the storage exported content should be deleted when soure entry is deleted
		**/
		public var allowAutoDelete : int = int.MIN_VALUE;

		/**
		* Indicates to the local file transfer manager to create a link to the file instead of copying it
		* @see com.borhan.types.borhanBoolean
		**/
		public var createFileLink : Boolean;

		/**
		* Holds storage profile export rules
		**/
		public var rules : Array = null;

		/**
		* Delivery profile ids
		**/
		public var deliveryProfileIds : Array = null;

		/**
		**/
		public var privateKey : String = null;

		/**
		**/
		public var publicKey : String = null;

		/**
		**/
		public var passPhrase : String = null;

		/**
		* @see com.borhan.types.borhanBoolean
		**/
		public var shouldExportThumbs : Boolean;

		/** 
		* a list of attributes which may be updated on this object 
		**/ 
		public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = new Array();
			arr.push('name');
			arr.push('systemName');
			arr.push('desciption');
			arr.push('status');
			arr.push('protocol');
			arr.push('storageUrl');
			arr.push('storageBaseDir');
			arr.push('storageUsername');
			arr.push('storagePassword');
			arr.push('storageFtpPassiveMode');
			arr.push('minFileSize');
			arr.push('maxFileSize');
			arr.push('flavorParamsIds');
			arr.push('maxConcurrentConnections');
			arr.push('pathManagerClass');
			arr.push('pathManagerParams');
			arr.push('trigger');
			arr.push('deliveryPriority');
			arr.push('deliveryStatus');
			arr.push('readyBehavior');
			arr.push('allowAutoDelete');
			arr.push('createFileLink');
			arr.push('rules');
			arr.push('deliveryProfileIds');
			arr.push('privateKey');
			arr.push('publicKey');
			arr.push('passPhrase');
			arr.push('shouldExportThumbs');
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
				case 'pathManagerParams':
					result = 'BorhanKeyValue';
					break;
				case 'rules':
					result = 'BorhanRule';
					break;
				case 'deliveryProfileIds':
					result = 'BorhanKeyValue';
					break;
			}
			return result;
		}
	}
}
