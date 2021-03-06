package com.borhan.bmc.modules.analytics.model
{
	import mx.resources.ResourceManager;
	
	[Bindable]
	public class Notifications
	{
		public static const notificationMap : Object = { "1" : {"name":ResourceManager.getInstance().getStringArray('bmc','addEntry') , "clientEnabled":true }, 
														 "2" : {"name":ResourceManager.getInstance().getStringArray('bmc','updateEntryPermissions') , "clientEnabled":false},  
														 "3" : {"name":ResourceManager.getInstance().getStringArray('bmc','deleteEntry'), "clientEnabled":false},
														 "4" : {"name":ResourceManager.getInstance().getStringArray('bmc','blockEntry'), "clientEnabled":false},
														 "5" : {"name":ResourceManager.getInstance().getStringArray('bmc','updateEntry'), "clientEnabled":false},
														 "6" : {"name":ResourceManager.getInstance().getStringArray('bmc','updateEntryThumbnail'), "clientEnabled":false},
														 "7" : {"name":ResourceManager.getInstance().getStringArray('bmc','updateEntryModeration'), "clientEnabled":false},
														 "21": {"name":ResourceManager.getInstance().getStringArray('bmc','addUser'), "clientEnabled":false},
														 "26": {"name":ResourceManager.getInstance().getStringArray('bmc','bannedUser'), "clientEnabled":false}};
	}
}