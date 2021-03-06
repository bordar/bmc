package com.borhan.bmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	/**
	 * reset rulebased playlist data on rule playlsit window close 
	 * @author Atar
	 */	
	public class ResetRuleBasedDataCommand extends BorhanCommand implements ICommand {
		
		override public function execute(event:CairngormEvent):void
		{
			_model.playlistModel.ruleBasedDuration = '';
			_model.playlistModel.ruleBasedEntriesAmount = 0;
		}
	}
}