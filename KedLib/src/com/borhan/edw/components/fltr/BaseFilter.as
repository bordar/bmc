package com.borhan.edw.components.fltr
{
	import com.borhan.edw.components.fltr.indicators.IndicatorVo;
	import com.borhan.edw.components.fltr.indicators.Indicators;
	import com.borhan.edw.components.fltr.indicators.IndicatorsEvent;
	import com.borhan.edw.components.fltr.panels.MetadataProfileFilter;
	import com.borhan.edw.model.FilterModel;
	import com.borhan.types.BorhanSearchOperatorType;
	import com.borhan.utils.ObjectUtil;
	import com.borhan.vo.BMCMetadataProfileVO;
	import com.borhan.vo.BorhanContentDistributionSearchItem;
	import com.borhan.vo.BorhanFilter;
	import com.borhan.vo.BorhanMetadataSearchItem;
	import com.borhan.vo.BorhanSearchItem;
	import com.borhan.vo.BorhanSearchOperator;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.containers.VBox;
	import mx.core.Container;
	
	[ResourceBundle("filter")]
	
	/**
	 * dispatched when the contents of the filter have changed 
	 */	
	[Event(name="filterChanged", type="flash.events.Event")]
	
	
	/**
	 * Base class for Filter classes 
	 * @author Atar
	 * 
	 */
	public class BaseFilter extends VBox {
		
		/**
		 * @internal
		 * public because used in different panels
		 * */
		public static const DATE_FIELD_WIDTH:Number = 80;
		
		/**
		 * a flag indicating an update event should be disaptched
		 * @internal
		 * try to accumulate filter updates if a few attributes 
		 * are changes at once, i.e. initial filter is set 
		 */		
		protected var updateRequested:Boolean = false;
		
		protected function dispatchUpdate():void {
			if (updateRequested) {
				updateRequested = false;
				dispatchEvent(new Event("filterChanged"));
			}
		} 
		
		/**
		 * set new value on the changed panel's attribute 
		 * @param event	change event of an IFilterComponent
		 * 
		 */
		protected function updateFilterValue(event:FilterComponentEvent):void {
			
			// update BorhanFilter relevant values
			if (event.target is IMultiAttributeFilterComponent) {
				var atts:Array = (event.target as IMultiAttributeFilterComponent).attributes;
				var fltrs:Array = (event.target as IMultiAttributeFilterComponent).kfilters;
				for (var i:int = 0; i<atts.length; i++) {
					_borhanFilter[atts[i]] = fltrs[i];
				}
			}
			else if (event.target is IAdvancedSearchFilterComponent) {
				handelAdvancedSearchComponent((event.target as IAdvancedSearchFilterComponent).filter as BorhanSearchItem,
					(event.target as IAdvancedSearchFilterComponent).attribute);
			}
			else if (event.target is IFilterComponent) {
				var tgt:IFilterComponent = event.target as IFilterComponent;
				_borhanFilter[tgt.attribute] = tgt.filter;
			}
			
			// show correct indicators
			updateIndicators(event.kind, event.data);
			
			// tell the world
			updateRequested = true;
			setTimeout(dispatchUpdate, 150);
		}
		
		
		/**
		 * add / remove indicator vo to reflect current filtering status
		 * @param action	add / remove / remove all
		 * @param item		the item to act upon
		 */
		protected function updateIndicators(action:String, item:IndicatorVo):void {
			var i:int;
			var ivo:IndicatorVo;
			switch (action) {
				case FilterComponentEvent.EVENT_KIND_UPDATE:
					// add if not found
					for (i = 0; i<indicators.length; i++) {
						ivo = indicators.getItemAt(i) as IndicatorVo;
						if (ivo.attribute == item.attribute) {
							if (ivo.value == item.value) {
								// if found, replace 
								indicators.removeItemAt(i);
								break;
							}
						}
					}
					// if not found, i == indicators.length
					indicators.addItemAt(item, i);
					break;
				
				case FilterComponentEvent.EVENT_KIND_ADD:
					indicators.addItem(item);
					break;
				
				case FilterComponentEvent.EVENT_KIND_REMOVE:
					for (i = 0; i<indicators.length; i++) {
						ivo = indicators.getItemAt(i) as IndicatorVo;
						if (ivo.attribute == item.attribute) {
							if (ivo.value == item.value) {
								indicators.removeItemAt(i);
								break;
							}
						}
					}
					break;
				
				case FilterComponentEvent.EVENT_KIND_REMOVE_ALL:
					for (i = indicators.length-1; i >= 0; i--) {
						ivo = indicators.getItemAt(i) as IndicatorVo;
						if (ivo.attribute == item.attribute) {
							indicators.removeItemAt(i);
						}
					}
					break;
			}
		}
		 
		
		/**
		 * remove relevant searchItem according to filterType, then add the given one 
		 * @param searchItem	search item to add to filter
		 * @param filterType	search item identifier
		 * @param addOnly		if true, existing search item will not be replaced and given item will not be added
		 */
		protected function handelAdvancedSearchComponent(searchItem:BorhanSearchItem, filterId:String, addOnly:Boolean=false):void {
			// create advanced search item if required:
			if (!_borhanFilter.advancedSearch) {
				_borhanFilter.advancedSearch = new BorhanSearchOperator();
				(_borhanFilter.advancedSearch as BorhanSearchOperator).type = BorhanSearchOperatorType.SEARCH_AND;
				(_borhanFilter.advancedSearch as BorhanSearchOperator).items = [];
			}
			var items:Array = (_borhanFilter.advancedSearch as BorhanSearchOperator).items;
			var i:int;
			var found:Boolean;
			if (items) {
			// if distribution filter:
			if (filterId == "distributionProfiles") {
				// find the distribtion search item and remove it.
				// there is only one distribution item, and we recognise it by the contents of its items.
				for (i = 0; i<items.length; i++) {
					var ksi:BorhanSearchOperator = items[i] as BorhanSearchOperator; 
					if (ksi) { // SearchItems which are not SearchOpreators will fall here
						if (ksi.items && ksi.items[0] is BorhanContentDistributionSearchItem) {
							found = true;
							if (!addOnly) {
								(_borhanFilter.advancedSearch as BorhanSearchOperator).items.splice(i, 1);
							}
							break;
						}
					} 
				} 
			}
			else {
				// otherwise, metadataProfiles:
				// remove search item for this profile if exists.
				// there is only one item which matches the profile (filterType is profile id).
				for (i = 0; i<items.length; i++) {
					var msi:BorhanMetadataSearchItem = items[i] as BorhanMetadataSearchItem; 
					if (msi) { // SearchItems which are not BorhanMetadataSearchItem will fall here
						if (msi.metadataProfileId.toString() == filterId) {
							found = true;
							if (!addOnly) {
								(_borhanFilter.advancedSearch as BorhanSearchOperator).items.splice(i, 1);
							}
							break;
						}
					} 
				}
			}
			
			// add new 
			if (searchItem) {
				if (!addOnly || !found) {
					(_borhanFilter.advancedSearch as BorhanSearchOperator).items.push(searchItem);
				}
			}
			}
		}
		
		// --------------------
		// free text search
		// --------------------
		
		private var _freeTextSearch:IFilterComponent;

		public function get freeTextSearch():IFilterComponent {
			return _freeTextSearch;
		}

		public function set freeTextSearch(value:IFilterComponent):void {
			_freeTextSearch = value;
			_freeTextSearch.addEventListener(FilterComponentEvent.VALUE_CHANGE, updateFilterValue, false, 0, true);
		}
		
		
		
		// --------------------
		// additional filters
		// --------------------
		
		/**
		 * @copy #additionalFiltersIds 
		 */		
		protected var _additionalFiltersIds:String;

		
		public function get additionalFiltersIds():String {
			return _additionalFiltersIds;
		}

		/**
		 * list of additional filters to show.
		 * if null, all available panels will be shown.
		 */		
		public function set additionalFiltersIds(value:String):void {
			_additionalFiltersIds = value;
			//TODO implement
		}
		
		
		// --------------------
		// filter indicators
		// --------------------
		

		[Bindable]
		/**
		 * list of vos with data relevant to showing current filtering status.
		 * <code>IndicatorVo</code> objects
		 */
		public var indicators:ArrayCollection = new ArrayCollection();

		
		/**
		 * remove a filter by its representing vo 
		 * @param vo	representation vo
		 * 
		 */
		public function removeFilter(item:IndicatorVo):void {
			// remove from indicators list
			for (var i:int = 0; i<indicators.length; i++) {
				if (indicators.getItemAt(i) == item) {
					indicators.removeItemAt(i);
					break;
				}
			}
			// let filter component remove the relevant attribute
			var comp:IFilterComponent;
			if (_freeTextSearch && _freeTextSearch.attribute == item.attribute) {
				comp = _freeTextSearch;
			}
			else {
				comp = getComponentByAttribute(item.attribute, this);
			}
			comp.removeItem(item);
		}
		
		/**
		 * retreive a filter component that matches a given attribute  
		 * @param attribute	
		 * @param container
		 * @return filter component whose attribute is the same as the given
		 */
		protected function getComponentByAttribute(attribute:String, container:Container):IFilterComponent {
			if (isIt(attribute, container)) {
				return container as IFilterComponent;
			}
			
			var child:DisplayObject;
			var fc:IFilterComponent;
			// scan all direct children
			for (var i:int = 0; i<container.numChildren; i++) {
				child = container.getChildAt(i);
				if (isIt(attribute, child)) {
					return child as IFilterComponent;
				}
				if (child is Container) {
					fc = getComponentByAttribute(attribute, child as Container);
					if (fc) {
						return fc;
					}
				}
			}
			// not found in this container, return null
			return null;
		}
		
		/**
		 * is the given DisplayObject a IFilterComponent whose attribute matches the given one 
		 * @param attribute
		 * @param child
		 * @return true if it is 
		 */
		private function isIt(attribute:String, child:DisplayObject):Boolean {
			if (child is IFilterComponent) {
				if ((child as IFilterComponent).attribute == attribute) {
					return true;
				}
				else if (child is IMultiAttributeFilterComponent) {
					// the vos generated by these hold all attributes concatenated.
					var at:String = (child as IMultiAttributeFilterComponent).attributes.join ("~~");
					if (at == attribute) {
						return true;						
					}
				}
			}
			return false;
		}
		
		// --------------------
		// model
		// --------------------
		
		/**
		 * @copy #filterModel 
		 */		
		protected var _filterModel:FilterModel;

		
		public function get filterModel():FilterModel {
			return _filterModel;
		}

		[Bindable]
		/**
		 * the model on which to store API calls results for reuse 
		 * (possibly by other parts of the application)
		 */		
		public function set filterModel(value:FilterModel):void {
			_filterModel = value;
		}
		
		
		// --------------------
		// BorhanFilter VO
		// --------------------
		/**
		 * @copy #borhanFilter 
		 */		
		protected var _borhanFilter:BorhanFilter;
		
		public function get borhanFilter():BorhanFilter {
			return _borhanFilter;
		}
		
		[Bindable]
		/**
		 * the Borhan API filter object being manipulated by this component 
		 */		
		public function set borhanFilter(value:BorhanFilter):void {
			_borhanFilter = value;
			indicators = new ArrayCollection();
			if (_metadataProfiles) {
				// if we didn't build them when the value was set
				createMetadataFilters(_metadataProfiles);
			}
			setFilterValuesToComponents();
		}
		
		protected function setFilterValuesToComponents():void {
			var comp:IFilterComponent;
			var att:String;
			var keys:Array = ObjectUtil.getObjectAllKeys(_borhanFilter);
			for (var i:int = 0; i<keys.length; i++) {
				comp = null;
				att = keys[i];
				if (_borhanFilter[att] && _borhanFilter[att] != int.MIN_VALUE) { // default value for strings is null, numbers int.MIN_VALUE
					if (att == "advancedSearch") {
						setFilterValuesToAdvancedSearchComponents(_borhanFilter[att]);
					}
					else {
						comp = getComponentByAttribute(att, this);
					}
					
					if (comp) {
						comp.filter = _borhanFilter[att];
					}
					else {
						if (_freeTextSearch && att == _freeTextSearch.attribute) {
							_freeTextSearch.filter = _borhanFilter[att];
						}
						
					}
				}
			}
		}
		
		/**
		 * for each element in advancedSearch, get relevant ui component and set its filter 
		 * @param kse root search item
		 * 
		 */
		protected function setFilterValuesToAdvancedSearchComponents(kse:BorhanSearchItem):void {
			var comp:IFilterComponent;
			for each (var kmsi:BorhanMetadataSearchItem in kse.items) {
				comp = getComponentByAttribute(kmsi.metadataProfileId.toString(), this);
				if (comp) {
					comp.filter = kmsi;
				}
			}
			
		}
		
		// ----------------
		// custom data
		// ----------------
		
		protected var _metadataProfiles:ArrayCollection;
		
		[Bindable]
		/**
		 * metadata profiles to show as filters
		 * */
		public function get metadataProfiles():ArrayCollection {
			return _metadataProfiles;
		}
		
		public function set metadataProfiles(value:ArrayCollection):void {
			_metadataProfiles = value;
			if (_borhanFilter) {
				createMetadataFilters(value);
			}
		}
		
		protected function createMetadataFilters(value:ArrayCollection):void {};
			
		/**
		 * create a MetadataFilter for the given profile on the given accordion tab
		 * @param profileVo 	metadata profile with searchable list fields
		 * */
		protected function buildMetadataProfileFilter(profileVo:BMCMetadataProfileVO):MetadataProfileFilter {
			var metadataTab:MetadataProfileFilter = new MetadataProfileFilter();
			metadataTab.label = profileVo.profile.name;
			metadataTab.id = profileVo.profile.id.toString();
			metadataTab.percentWidth = 100;
			metadataTab.attribute = profileVo.profile.id.toString();
			metadataTab.dataProvider = profileVo.metadataFieldVOArray;
			
			metadataTab.addEventListener(FilterComponentEvent.VALUE_CHANGE, updateFilterValue, false, 0, true);
			
			// update filter data 
			handelAdvancedSearchComponent(metadataTab.filter as BorhanSearchItem, metadataTab.attribute, true);
			
			return metadataTab;
		}
	}
}