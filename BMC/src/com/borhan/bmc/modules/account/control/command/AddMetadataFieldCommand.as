package com.borhan.bmc.modules.account.control.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.borhan.bmc.modules.account.control.events.MetadataFieldEvent;
	import com.borhan.bmc.modules.account.control.events.MetadataProfileEvent;
	import com.borhan.bmc.modules.account.model.AccountModelLocator;
	import com.borhan.utils.parsers.MetadataProfileParser;
	import com.borhan.vo.BorhanMetadataProfile;
	import com.borhan.vo.MetadataFieldVO;
	
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	
	/**
	 * This class handles the addition of a new metadata field
	 *  
	 * @author Michal
	 * 
	 */	
	public class AddMetadataFieldCommand implements ICommand
	{	
		private var _model : AccountModelLocator = AccountModelLocator.getInstance();

		/**
		 * Will be triggered when the suitable event will be dispatched.
		 * Then will add the saved field thats on the event to the current metadata profile 
		 * @param event the event that triggered this command
		 * 
		 */	
		public function execute(event:CairngormEvent):void
		{
			var newField:MetadataFieldVO = (event as MetadataFieldEvent).metadataField;
			if (!newField || !_model.selectedMetadataProfile)
				return;
			
			_model.selectedMetadataProfile.metadataFieldVOArray.addItem(newField);
			
			if (!_model.selectedMetadataProfile.xsd) {
				_model.selectedMetadataProfile.xsd = MetadataProfileParser.createNewXSD();
			}
			
			try {
				MetadataProfileParser.addToXSD(newField, _model.selectedMetadataProfile.xsd);	
			}
			catch (e:Error){
				Alert.show(ResourceManager.getInstance().getString('account','metadataMalformedXSDError'), ResourceManager.getInstance().getString('account','error'));
				return;
			}
			_model.selectedMetadataProfile.metadataProfileChanged = true;
		}
		
	}
}