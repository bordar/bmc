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
package com.borhan.commands.eventNotificationTemplate
{
		import com.borhan.vo.BorhanEventNotificationTemplate;
	import com.borhan.delegates.eventNotificationTemplate.EventNotificationTemplateAddDelegate;
	import com.borhan.net.BorhanCall;

	/**
	* This action allows for the creation of new backend event types in the system. This action requires access to the Borhan server Admin Console. If you're looking to register to existing event types, please use the clone action instead.
	**/
	public class EventNotificationTemplateAdd extends BorhanCall
	{
		public var filterFields : String;
		
		/**
		* @param eventNotificationTemplate BorhanEventNotificationTemplate
		**/
		public function EventNotificationTemplateAdd( eventNotificationTemplate : BorhanEventNotificationTemplate )
		{
			service= 'eventnotification_eventnotificationtemplate';
			action= 'add';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
				keyValArr = borhanObject2Arrays(eventNotificationTemplate, 'eventNotificationTemplate');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new EventNotificationTemplateAddDelegate( this , config );
		}
	}
}
