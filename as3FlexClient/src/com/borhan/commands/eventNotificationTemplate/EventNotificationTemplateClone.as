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
	import com.borhan.delegates.eventNotificationTemplate.EventNotificationTemplateCloneDelegate;
	import com.borhan.net.BorhanCall;

	/**
	* This action allows registering to various backend event. Use this action to create notifications that will react to events such as new video was uploaded or metadata field was updated. To see the list of available event types, call the listTemplates action.
	**/
	public class EventNotificationTemplateClone extends BorhanCall
	{
		public var filterFields : String;
		
		/**
		* @param id int
		* @param eventNotificationTemplate BorhanEventNotificationTemplate
		**/
		public function EventNotificationTemplateClone( id : int,eventNotificationTemplate : BorhanEventNotificationTemplate=null )
		{
			service= 'eventnotification_eventnotificationtemplate';
			action= 'clone';

			var keyArr : Array = new Array();
			var valueArr : Array = new Array();
			var keyValArr : Array = new Array();
			keyArr.push('id');
			valueArr.push(id);
			if (eventNotificationTemplate) { 
				keyValArr = borhanObject2Arrays(eventNotificationTemplate, 'eventNotificationTemplate');
				keyArr = keyArr.concat(keyValArr[0]);
				valueArr = valueArr.concat(keyValArr[1]);
			} 
			applySchema(keyArr, valueArr);
		}

		override public function execute() : void
		{
			setRequestArgument('filterFields', filterFields);
			delegate = new EventNotificationTemplateCloneDelegate( this , config );
		}
	}
}