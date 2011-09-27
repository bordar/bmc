package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.edw.control.commands.KalturaCommand;
	
	/**
	 * reset rulebased playlist data on rule playlsit window close 
	 * @author Atar
	 */	
	public class ResetRuleBasedDataCommand extends KalturaCommand implements ICommand {
		
		public function ResetRuleBasedDataCommand()
		{
			super();
		}
		
		override public function execute(event:CairngormEvent):void
		{
			_model.playlistModel.ruleBasedDuration = '';
			_model.playlistModel.ruleBasedEntriesAmount = 0;
		}
	}
}