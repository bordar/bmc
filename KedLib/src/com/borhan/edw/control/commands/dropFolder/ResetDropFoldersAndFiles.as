package com.borhan.edw.control.commands.dropFolder
{
	import com.borhan.edw.control.commands.KedCommand;
	import com.borhan.edw.model.datapacks.DropFolderDataPack;
	import com.borhan.bmvc.control.BMvCEvent;
	
	public class ResetDropFoldersAndFiles extends KedCommand {
		
		override public function execute(event:BMvCEvent):void {
			var dropFolderData:DropFolderDataPack = _model.getDataPack(DropFolderDataPack) as DropFolderDataPack;
			dropFolderData.dropFolderFiles = null;
			dropFolderData.dropFolders = null;
		}
	}
}