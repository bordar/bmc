package com.borhan.bmc.modules.content.commands.cat
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.borhan.commands.MultiRequest;
	import com.borhan.commands.category.CategoryGet;
	import com.borhan.commands.categoryUser.CategoryUserAdd;
	import com.borhan.events.BorhanEvent;
	import com.borhan.bmc.modules.content.commands.BorhanCommand;
	import com.borhan.bmc.modules.content.events.CategoryEvent;
	import com.borhan.bmc.modules.content.utils.CategoryUserUtil;
	import com.borhan.vo.BorhanCategory;
	import com.borhan.vo.BorhanCategoryUser;
	import com.borhan.vo.BorhanUser;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;

	public class addCategoryUsersCommand extends BorhanCommand {
		
		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();
			// event.data is [categoryid, permission level, update method, ([BorhanUsers])]
			var catid:int = event.data[0];
			var permLvl:int = event.data[1];
			var mthd:int = event.data[2];
			var usrs:ArrayCollection = event.data[3];
			
			var mr:MultiRequest = new MultiRequest();
			var cu:BorhanCategoryUser;
			
			for (var i:int = 0; i<usrs.length; i++) {
				cu = new BorhanCategoryUser();
				cu.categoryId = catid;
				cu.permissionLevel = permLvl;
				cu.permissionNames = CategoryUserUtil.getPermissionNames(permLvl);
				cu.updateMethod = mthd;
				cu.userId = (usrs[i] as BorhanUser).id;
				mr.addAction(new CategoryUserAdd(cu));
			} 	
			var getCat:CategoryGet = new CategoryGet(catid);
			mr.addAction(getCat);
			mr.addEventListener(BorhanEvent.COMPLETE, result);
			mr.addEventListener(BorhanEvent.FAILED, fault);
			_model.context.kc.post(mr);	   
		}
		
		override public function result(data:Object):void {
			super.result(data);
			
			// this is instead of the standard checkError
			if (data.data.length == 2) {
				// we won't have more than a single "user already exists" error, so handle regularly 
				if (!checkError(data)) {
					
					// set new numbers of members to the category object
					var updatedCat:BorhanCategory = data.data[data.data.length-1] as BorhanCategory;
					_model.categoriesModel.selectedCategory.membersCount = updatedCat.membersCount;
					_model.categoriesModel.selectedCategory.pendingMembersCount = updatedCat.pendingMembersCount;
				}
			}
			else {
				// count CATEGORY_USER_ALREADY_EXISTS errors, only display one.
				// this was a multirequest, we need to check its contents.
				var CATEGORY_USER_ALREADY_EXISTS:Boolean = false;
				for (var i:int = 0; i<data.data.length; i++) {
					var o:Object = data.data[i];
					if (o.error) {
						// in MR errors aren't created
						if (o.error.code != "CATEGORY_USER_ALREADY_EXISTS" || !CATEGORY_USER_ALREADY_EXISTS) {
							if (o.error.code == "CATEGORY_USER_ALREADY_EXISTS") {
								// so we'll only show this once
								CATEGORY_USER_ALREADY_EXISTS = true;
							} 
							var str:String = ResourceManager.getInstance().getString('cms', o.error.code);
							if (!str) {
								str = o.error.message;
							} 
							Alert.show(str, ResourceManager.getInstance().getString('cms', 'error'));
						}
					}
				}
			}
			
			// get updated list of users
			var cg:CategoryEvent = new CategoryEvent(CategoryEvent.LIST_CATEGORY_USERS);
			cg.dispatch();
			
			_model.decreaseLoadCounter();
		}
	}
}