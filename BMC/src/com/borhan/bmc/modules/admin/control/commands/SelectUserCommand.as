package com.borhan.bmc.modules.admin.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.borhan.bmc.modules.admin.control.events.UserEvent;

	public class SelectUserCommand extends BaseCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.usersModel.selectedUser = (event as UserEvent).user;
		} 
	}
}