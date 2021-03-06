package com.borhan.bmc.modules.content.commands {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.borhan.commands.MultiRequest;
	import com.borhan.commands.uiConf.UiConfList;
	import com.borhan.commands.uiConf.UiConfListTemplates;
	import com.borhan.events.BorhanEvent;
	import com.borhan.bmc.modules.content.events.UIConfEvent;
	import com.borhan.vo.BorhanFilterPager;
	import com.borhan.vo.BorhanUiConf;
	import com.borhan.vo.BorhanUiConfFilter;
	import com.borhan.vo.BorhanUiConfListResponse;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListUIConfCommand extends BorhanCommand implements ICommand, IResponder {
		private var players:ArrayCollection;
		private var lastPage:int = 1;
		private var totalCount:int = 0;
		private var filter:BorhanUiConfFilter;
		
		private const CHUNK_SIZE:int = 500;


		override public function execute(event:CairngormEvent):void {
			_model.increaseLoadCounter();

			var mr:MultiRequest = new MultiRequest();

			filter = new BorhanUiConfFilter();
			filter.partnerIdEqual = 0; // we assume the general partner is always 0
			filter.tagsMultiLikeAnd = "autodeploy,bmc_v" + BMC.VERSION + ",bmc_previewembed";

			var getUIConfTemplates:UiConfListTemplates = new UiConfListTemplates(filter);
			mr.addAction(getUIConfTemplates);

			filter = (event as UIConfEvent).uiConfFilter;
			var pager:BorhanFilterPager = new BorhanFilterPager();
			pager.pageSize = CHUNK_SIZE;
			pager.pageIndex = 1;
			var getListUIConfs:UiConfList = new UiConfList(filter, pager);
			mr.addAction(getListUIConfs);

			mr.addEventListener(BorhanEvent.COMPLETE, result);
			mr.addEventListener(BorhanEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}


		override public function result(event:Object):void {
			super.result(event);
			var uiConf:BorhanUiConf;

			if (event.error != null) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'playersListErrorMsg'), ResourceManager.getInstance().getString('cms', 'error'));
			}

			players = new ArrayCollection();
			// process templates
			var response:BorhanUiConfListResponse = event.data[0] as BorhanUiConfListResponse;
			for each (var uiconf:BorhanUiConf in response.objects) {
				if (uiconf.name.toLocaleLowerCase() == "dark player") {
					players.addItemAt(uiconf, 0);
				}
				else {
					players.addItem(uiconf);
				}
			}

			// process partner players
			response = event.data[1] as BorhanUiConfListResponse;
			for each (uiconf in response.objects) {
				uiconf.name = ((uiconf.name == null) || (uiconf.name == '')) ? "Player(" + uiconf.id + ")" : uiconf.name;
				players.addItem(uiconf);
			}
			// see if we have more players:
			if (response.totalCount > CHUNK_SIZE) {
				lastPage ++;
				getPlayersListPage(lastPage);
			}
			else {
				_model.extSynModel.uiConfData = players;
				_model.decreaseLoadCounter();	
			}
		}
		
		
		private function getPlayersListPage(nPage:int):void {
			var pager:BorhanFilterPager = new BorhanFilterPager();
			pager.pageSize = CHUNK_SIZE;
			pager.pageIndex = nPage;
			var listUIConfs:UiConfList = new UiConfList(filter, pager);
			listUIConfs.addEventListener(BorhanEvent.COMPLETE, result2);
			listUIConfs.addEventListener(BorhanEvent.FAILED, fault);
			_model.context.kc.post(listUIConfs);
		}
		
		
		private function result2(event:Object):void {
			super.result(event);
			var uiConf:BorhanUiConf;
			
			if (event.error != null) {
				Alert.show(ResourceManager.getInstance().getString('cms', 'playersListErrorMsg'), ResourceManager.getInstance().getString('cms', 'error'));
			}
			
			// process partner players
			var response:BorhanUiConfListResponse = event.data as BorhanUiConfListResponse;
			for each (var uiconf:BorhanUiConf in response.objects) {
				uiconf.name = ((uiconf.name == null) || (uiconf.name == '')) ? "Player(" + uiconf.id + ")" : uiconf.name;
				players.addItem(uiconf);
			}
			// see if we have more players:
			if (response.totalCount > CHUNK_SIZE * lastPage) {
				lastPage ++;
				getPlayersListPage(lastPage);
			}
			else {
				_model.extSynModel.uiConfData = players;
				_model.decreaseLoadCounter();	
			}
		}



		override public function fault(event:Object):void {
			_model.decreaseLoadCounter();
			Alert.show(event.error.errorMsg, ResourceManager.getInstance().getString('cms', 'error'));
		}

	}
}
