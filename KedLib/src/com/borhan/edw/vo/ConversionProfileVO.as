package com.borhan.edw.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	import com.borhan.vo.BorhanConversionProfile;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectProxy;
	
	[Bindable]
	public class ConversionProfileVO implements IValueObject
	{
		public static const SELECTED_CHANGED_EVENT : String = "transcodeProfileSelectedChanged";
		
		private var _selected:Boolean = false;
		public var profile:BorhanConversionProfile;
		
		public function ConversionProfileVO()
		{
			profile = new BorhanConversionProfile();
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(selected:Boolean):void
		{
			_selected = selected;
			dispatchEvent(new Event(SELECTED_CHANGED_EVENT));
		}
		
		public function clone():ConversionProfileVO
		{
			var newConversionProfile:ConversionProfileVO = new ConversionProfileVO();
			
			newConversionProfile.selected = this.selected;
			newConversionProfile.profile.createdAt = this.profile.createdAt;
			newConversionProfile.profile.description = this.profile.description
			newConversionProfile.profile.flavorParamsIds = this.profile.flavorParamsIds;
			newConversionProfile.profile.id = this.profile.id;
			newConversionProfile.profile.name = this.profile.name;
			newConversionProfile.profile.partnerId = this.profile.partnerId;
			
			return newConversionProfile;
		} 

	}
}