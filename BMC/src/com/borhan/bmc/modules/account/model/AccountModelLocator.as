package com.borhan.bmc.modules.account.model {
	import com.adobe.cairngorm.model.IModelLocator;
	import com.borhan.bmc.modules.account.model.types.ConversionProfileWindowMode;
	import com.borhan.bmc.modules.account.vo.AdminVO;
	import com.borhan.bmc.modules.account.vo.PackagesVO;
	import com.borhan.bmc.modules.account.vo.PartnerVO;
	import com.borhan.types.BorhanAccessControlOrderBy;
	import com.borhan.types.BorhanConversionProfileOrderBy;
	import com.borhan.types.BorhanConversionProfileType;
	import com.borhan.vo.FlavorVO;
	import com.borhan.vo.BMCMetadataProfileVO;
	import com.borhan.vo.BorhanAccessControlFilter;
	import com.borhan.vo.BorhanBaseEntry;
	import com.borhan.vo.BorhanCategory;
	import com.borhan.vo.BorhanConversionProfileFilter;
	import com.borhan.vo.BorhanFilterPager;
	import com.borhan.vo.BorhanStorageProfile;
	import com.borhan.vo.BorhanUser;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class AccountModelLocator extends EventDispatcher implements IModelLocator {

		/**
		 * application context data 
		 */
		public var context:Context = null;
		
		/**
		 * partner info 
		 */		
		public var partnerData:PartnerVO;

		/* ****************************************************
		* account info
		**************************************************** */
		
		[ArrayElementType("BorhanUser")]
		/**
		 * a list of users with administrator role of the current partner
		 */		
		public var usersList:ArrayCollection;
		
		public var adminData:AdminVO = new AdminVO();
		
		/* ****************************************************
		 * integration
		 **************************************************** */
		
		[ArrayElementType("BorhanCategory")]
		/**
		 * list of categorys with a defined privacy context 
		 */		
		public var categoriesWithPrivacyContext:Array;
		
		
		
		/* ****************************************************
		 * metadata
		 **************************************************** */
		public var metadataProfilesArray:ArrayCollection = new ArrayCollection();
		public var selectedMetadataProfile:BMCMetadataProfileVO;
		public var metadataFilterPager:BorhanFilterPager;
		public var metadataProfilesTotalCount:int = 10;

		
		/* ****************************************************
		 * access control
		 **************************************************** */
		public var accessControls:ArrayCollection = new ArrayCollection();
		public var accessControlProfilesTotalCount:int = 10;
		public var filterPager:BorhanFilterPager;
		public var acpFilter:BorhanAccessControlFilter;

		/* ****************************************************
		 * conversion
		 **************************************************** */
		[ArrayElementType("BorhanStorageProfile")]
		/**
		 * a list of remote storages configured for the partner.
		 * <code>BorhanStorageProfile</code> objects 
		 */
		public var storageProfiles:ArrayCollection;
		
		/**
		 * the default entry for the current conversion profile
		 * (only loaded during save for validation) 
		 */
		public var defaultEntry:BorhanBaseEntry;
		
		/**
		 * list of thumbnail flavors 
		 * */
		public var thumbsData:ArrayCollection = new ArrayCollection();
		
		// media conversion profiles
		// -------------------------
		
		[ArrayElementType("ConversionProfileVO")]
		/**
		 * list of media conversion profiles <br>
		 * <code>ConversionProfileVO</code> objects
		 */
		public var mediaConversionProfiles:ArrayCollection = new ArrayCollection();
		
		/**
		 * total number of media conversion profiles 
		 */		
		public var totalMediaConversionProfiles:int;
		
		/**
		 * list of optional media flavors <br>
		 * <code>FlavorVO</code> objects
		 * */
		public var mediaFlavorsData:ArrayCollection = new ArrayCollection();
		
		/**
		 * media conversion-profile-asset-params 
		 */
		public var mediaCPAPs:Array;
		
		/**
		 * default filter for media conversion profiles in BMC 
		 * */
		public var mediaCPFilter:BorhanConversionProfileFilter;
		
		/**
		 * default pager for conversion profiles in BMC
		 * */
		public var mediaCPPager:BorhanFilterPager;
		
		
		// live conversion profiles
		// -------------------------
		
		[ArrayElementType("ConversionProfileVO")]
		/**
		 * list of live conversion profiles <br>
		 * <code>ConversionProfileVO</code> objects
		 */
		public var liveConversionProfiles:ArrayCollection = new ArrayCollection();
		
		/**
		 * total number of live conversion profiles 
		 */		
		public var totalLiveConversionProfiles:int;
		
		/**
		 * live conversion-profile-asset-params 
		 */
		public var liveCPAPs:Array;
		
		/**
		 * list of optional live flavors <br>
		 * <code>FlavorVO</code> objects
		 * */
		public var liveFlavorsData:ArrayCollection = new ArrayCollection();
		
		/**
		 * default filter for live conversion profiles in BMC 
		 * */
		public var liveCPFilter:BorhanConversionProfileFilter;
		
		/**
		 * default pager for live conversion profiles in BMC
		 * */
		public var liveCPPager:BorhanFilterPager;
		
		
		/* ****************************************************
		* upgrade
		**************************************************** */
		
		public var partnerPackage:PackagesVO = null;
		
		public var listPackages:ArrayCollection;
		
		
		//---------------------------------------------------------
		// Flags 
		public var devFlag:Boolean = false;
		
		/**
		 * any pending server requests
		 */
		public var loadingFlag:Boolean = false;
		
		/**
		 * the custom metadata tab is disabled
		 * */
		public var customDataDisabled:Boolean = false;
		
		public var partnerInfoLoaded:Boolean = false;
		public var saveAndExitFlag:Boolean = false;

		//---------------------------------------------------------
		// singleton methods
		private static var _modelLocator:AccountModelLocator;


		public static function getInstance():AccountModelLocator {
			if (_modelLocator == null) {
				_modelLocator = new AccountModelLocator(new Enforcer());
			}

			return _modelLocator;
		}


		public function AccountModelLocator(enforcer:Enforcer) {
			context = new Context();
			acpFilter = new BorhanAccessControlFilter();
			acpFilter.orderBy = BorhanAccessControlOrderBy.CREATED_AT_DESC;

			mediaCPFilter = new BorhanConversionProfileFilter();
			mediaCPFilter.orderBy = BorhanConversionProfileOrderBy.CREATED_AT_DESC;
			mediaCPFilter.typeEqual = BorhanConversionProfileType.MEDIA;

			liveCPFilter = new BorhanConversionProfileFilter();
			liveCPFilter.orderBy = BorhanConversionProfileOrderBy.CREATED_AT_DESC;
			liveCPFilter.typeEqual = BorhanConversionProfileType.LIVE_STREAM;
				
		}
		
		
		public function getAllFlavorParams():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection(this.mediaFlavorsData.toArray());
			result.addAll(this.liveFlavorsData);
			return result;
		}


		/**
		 * clone all flavours and return them 
		 */
		public function cloneFlavorsData(type:String):ArrayCollection {
			var source:ArrayCollection = mediaFlavorsData;
			if (type == ConversionProfileWindowMode.MODE_LIVE) {
				source = liveFlavorsData;
			}
			var arr:ArrayCollection = new ArrayCollection();
			for each (var flavor:FlavorVO in source) {
				arr.addItem(flavor.clone());
			}

			return arr;
		}


		
		/**
		 * clone all flavours, mark them all as unselected and return them 
		 * @param type get live/media flavor params
		 */
		public function cloneFlavorsDataUnselected(type:String):ArrayCollection {
			var source:ArrayCollection = mediaFlavorsData;
			if (type == ConversionProfileWindowMode.MODE_LIVE) {
				source = liveFlavorsData;
			}
			
			var arr:ArrayCollection = new ArrayCollection();
			for each (var flavor:FlavorVO in source) {
				var cloned:FlavorVO = flavor.clone();
				cloned.selected = false;
				arr.addItem(cloned);
			}

			return arr;
		}
		
	}
}

class Enforcer {}