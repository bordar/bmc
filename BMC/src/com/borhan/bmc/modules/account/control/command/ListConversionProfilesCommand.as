package com.borhan.bmc.modules.account.control.command {
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.borhan.commands.MultiRequest;
	import com.borhan.commands.conversionProfile.ConversionProfileList;
	import com.borhan.commands.conversionProfileAssetParams.ConversionProfileAssetParamsList;
	import com.borhan.errors.BorhanError;
	import com.borhan.events.BorhanEvent;
	import com.borhan.bmc.modules.account.model.AccountModelLocator;
	import com.borhan.bmc.modules.account.utils.ListConversionProfilesUtil;
	import com.borhan.bmc.modules.account.vo.ConversionProfileVO;
	import com.borhan.vo.BorhanConversionProfile;
	import com.borhan.vo.BorhanConversionProfileAssetParamsFilter;
	import com.borhan.vo.BorhanConversionProfileAssetParamsListResponse;
	import com.borhan.vo.BorhanConversionProfileListResponse;
	import com.borhan.vo.BorhanFilterPager;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.resources.ResourceManager;
	import mx.rpc.IResponder;

	public class ListConversionProfilesCommand implements ICommand, IResponder {
		
		private var _model:AccountModelLocator = AccountModelLocator.getInstance();


		public function execute(event:CairngormEvent):void {
			_model.loadingFlag = true;
			var mr:MultiRequest = new MultiRequest();
			if (_model.mediaCPPager) {
				// here we always want the first page
				_model.mediaCPPager.pageIndex = 1;
			}
			var lcp:ConversionProfileList = new ConversionProfileList(_model.mediaCPFilter, _model.mediaCPPager);
			mr.addAction(lcp);
			
			var p:BorhanFilterPager = new BorhanFilterPager();
			p.pageSize = 1000;	// this is a very large number that should be enough to get all items
			var cpapFilter:BorhanConversionProfileAssetParamsFilter = new BorhanConversionProfileAssetParamsFilter();
			cpapFilter.conversionProfileIdFilter = _model.mediaCPFilter;
			var cpaplist:ConversionProfileAssetParamsList = new ConversionProfileAssetParamsList(cpapFilter, p);
			mr.addAction(cpaplist);
			
			mr.addEventListener(BorhanEvent.COMPLETE, result);
			mr.addEventListener(BorhanEvent.FAILED, fault);
			_model.context.kc.post(mr);
		}


		public function result(event:Object):void {
			var er:BorhanError;
			if (event.data[0].error) {
				er = event.data[0].error as BorhanError;
				if (er) {
					Alert.show(er.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
				}
			}
			else if (event.data[1].error) {
				er = event.data[1].error as BorhanError;
				if (er) {
					Alert.show(er.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
				}
			}
			else {
				var response:BorhanConversionProfileListResponse = event.data[0] as BorhanConversionProfileListResponse;
				var ac:ArrayCollection = ListConversionProfilesUtil.handleConversionProfilesList(response.objects);
				_model.mediaCPAPs = (event.data[1] as BorhanConversionProfileAssetParamsListResponse).objects;
				ListConversionProfilesUtil.addAssetParams(ac, _model.mediaCPAPs);
				_model.mediaConversionProfiles = ac;
				_model.totalMediaConversionProfiles = ac.length; 
			}
			_model.loadingFlag = false;
		}


		public function fault(event:Object):void {
			Alert.show(ResourceManager.getInstance().getString('account', 'notLoadConversionProfiles') + "\n\t" + event.error.errorMsg, ResourceManager.getInstance().getString('account', 'error'));
			_model.loadingFlag = false;
		}
	}
}