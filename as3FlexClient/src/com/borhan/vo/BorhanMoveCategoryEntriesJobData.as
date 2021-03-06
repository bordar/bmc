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
	import com.borhan.vo.BorhanJobData;

	[Bindable]
	public dynamic class BorhanMoveCategoryEntriesJobData extends BorhanJobData
	{
		/**
		* Source category id
		**/
		public var srcCategoryId : int = int.MIN_VALUE;

		/**
		* Destination category id
		**/
		public var destCategoryId : int = int.MIN_VALUE;

		/**
		* Saves the last category id that its entries moved completely
		* In case of crash the batch will restart from that point
		**/
		public var lastMovedCategoryId : int = int.MIN_VALUE;

		/**
		* Saves the last page index of the child categories filter pager
		* In case of crash the batch will restart from that point
		**/
		public var lastMovedCategoryPageIndex : int = int.MIN_VALUE;

		/**
		* Saves the last page index of the category entries filter pager
		* In case of crash the batch will restart from that point
		**/
		public var lastMovedCategoryEntryPageIndex : int = int.MIN_VALUE;

		/**
		* All entries from all child categories will be moved as well
		* @see com.borhan.types.borhanBoolean
		**/
		public var moveFromChildren : Boolean;

		/**
		* Destination categories fallback ids
		**/
		public var destCategoryFullIds : String = null;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('srcCategoryId');
			arr.push('destCategoryId');
			arr.push('lastMovedCategoryId');
			arr.push('lastMovedCategoryPageIndex');
			arr.push('lastMovedCategoryEntryPageIndex');
			arr.push('moveFromChildren');
			arr.push('destCategoryFullIds');
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
