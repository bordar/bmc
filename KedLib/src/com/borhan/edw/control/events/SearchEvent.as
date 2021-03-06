package com.borhan.edw.control.events
{
	import com.borhan.edw.vo.ListableVo;
	import com.borhan.bmvc.control.BMvCEvent;

	public class SearchEvent extends BMvCEvent
	{
		
		
		public static const SEARCH_ENTRIES : String = "content_searchEntries";
		
		
		private var _listableVo : ListableVo;
		
		public function SearchEvent( type:String , 
									 listableVo:ListableVo,
									 bubbles:Boolean=false,
									 cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_listableVo = listableVo;
		}

		public function get listableVo():ListableVo
		{
			return _listableVo;
		}

	}
}