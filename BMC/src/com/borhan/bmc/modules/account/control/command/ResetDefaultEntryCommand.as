package com.borhan.bmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.borhan.bmc.modules.account.model.AccountModelLocator;

	public class ResetDefaultEntryCommand implements ICommand {
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void {
			_model.defaultEntry = null;
		}
	}
}