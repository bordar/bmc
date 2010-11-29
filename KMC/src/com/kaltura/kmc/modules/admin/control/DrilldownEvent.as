package com.kaltura.kmc.modules.admin.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class DrilldownEvent extends CairngormEvent {
		
		public static const SET_STATE:String = "admin_setState";
		
		private var _state:String;
		
		public function DrilldownEvent(type:String, state:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_state = state;
		}

		public function get state():String
		{
			return _state;
		}

	}
}