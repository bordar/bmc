package com.borhan.edw.components.fltr.cat.data {
	import com.borhan.edw.components.fltr.cat.events.CategoriesDataManagerEvent;
	import com.borhan.edw.control.CategoriesTreeController;
	import com.borhan.edw.control.events.CategoriesTreeEvent;
	import com.borhan.edw.vo.CategoryVO;

	import flash.events.EventDispatcher;

	public class CompleteDataManager extends EventDispatcher implements ICategoriesDataManger {


		private var _controller:CategoriesTreeController;


		public function get controller():CategoriesTreeController {
			return _controller;
		}


		public function set controller(value:CategoriesTreeController):void {
			_controller = value;
			var cte:CategoriesTreeEvent = new CategoriesTreeEvent(CategoriesTreeEvent.SET_CATEGORIES_DATA_MANAGER_TO_MODEL);
			cte.data = this;
			_controller.dispatch(cte);
		}


		public function CompleteDataManager() {
		}


		public function destroy():void {
			_controller = null;
		}


		/**
		 * load all categories list
		 */
		public function loadInitialData():void {
			reloadAllCategories();
		}


		/**
		 * do nothing, this is the default tree behaviour
		 * @param cat
		 *
		 */
		public function branchClicked(cat:CategoryVO):void {

		}


		/**
		 * load all categories list
		 */
		public function resetData():void {
			reloadAllCategories();
		}


		private function reloadAllCategories():void {
			var cte:CategoriesTreeEvent = new CategoriesTreeEvent(CategoriesTreeEvent.FLUSH_CATEGORIES);
			_controller.dispatch(cte);
			cte = new CategoriesTreeEvent(CategoriesTreeEvent.LIST_ALL_CATEGORIES);
			_controller.dispatch(cte);
		}


		private function reopenBranch(item:CategoryVO):void {
			dispatchEvent(new CategoriesDataManagerEvent(CategoriesDataManagerEvent.REOPEN_BRANCH, item));
		}
	}
}
