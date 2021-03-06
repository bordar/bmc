package com.borhan.bmc.business {
	import com.borhan.bmc.events.BmcModuleEvent;
	
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	
	import mx.events.ModuleEvent;
	import mx.modules.Module;
	import mx.modules.ModuleLoader;
	import mx.modules.ModuleManager;

	/**
	 * BmcModuleLoader is responsible for loading the different modules required by BMC.
	 * It creates a ModuleLoader instance for each module it is asked to load, and saves 
	 * its id so BMC can ask for it later.
	 * The load listeners attached to the diffrerent ModuleLoaders are not removed deliberately, 
	 * because BmcModuleLoader doesn't actually loads modules. The modules are laoded when they
	 * are needed, and the <code>ModuleEvent.READY</code> is dispatched every time the module 
	 * becomes visible and is used then.  
	 */	
	public class BmcModuleLoader extends EventDispatcher {

		// ==============================================================================
		// events
		// ==============================================================================
		/**
		 * Dispatched when a module was loaded.
		 * @eventType BmcModuleEvent.MODULE_LOADED
		 */
		[Event(name="moduleLoaded", type="com.borhan.bmc.events.BmcModuleEvent")]

		/**
		 * Dispatched when a module failed loading.
		 * @eventType BmcModuleEvents.moduleLoaded
		 */
		[Event(name="moduleLoadError", type="com.borhan.bmc.events.BmcModuleEvent")]

		
		// ==============================================================================
		// members
		// ==============================================================================
		

		/**
		 * keeps module urls with module ids
		 */
		private var _urlToId:Object;
		
		
		/**
		 * keeps module urls with the moduleLoader instances which loaded them
		 */
		private var _urlToMl:Object;

		
		// ==============================================================================
		// methods
		// ==============================================================================
		
		/**
		 * Constructor.
		 * Initialize the modules info dictionary. 
		 */		
		public function BmcModuleLoader() {
			_urlToId = new Object();
			_urlToMl = new Object();
		}

		
		/**
		 * Load a BMC module, or return the instance of the module already loaded.
		 * @param url 	the path to the loaded module
		 * @param id	load id for this module, used later to retreive it's uiconf id.
		 * @return	the ModuleLoader instance that will load this module
		 */
		public function loadBmcModule(url:String, id:String):ModuleLoader {
			var moduleLoader:ModuleLoader ;
			if (_urlToMl[url]) {
				moduleLoader = _urlToMl[url]; 
			}
			else {
				
				// set module for load
				moduleLoader = new ModuleLoader();
//				moduleLoader.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
//				moduleLoader.applicationDomain = new ApplicationDomain();
				moduleLoader.applicationDomain = ApplicationDomain.currentDomain;
				moduleLoader.addEventListener(ModuleEvent.READY, onModuleReady);
				moduleLoader.addEventListener(ModuleEvent.PROGRESS, onModuleProgress);
				moduleLoader.addEventListener(ModuleEvent.ERROR, onModuleError);
				moduleLoader.url = url;
				
				// save module info
				_urlToId[url] = id;
				_urlToMl[url] = moduleLoader;
			}
			return moduleLoader;
		}
		
		
		/**
		 * retrieve the load id that was initialy passed for a module. 
		 * NOTE: this is not the module's id in BMC, it is just a name it was loaded with. 
		 * @param ml	the <code>ModuleLoader</code> instance that loaded the module in question.
		 * @return 		id of the module loaded by <code>ml</code>.
		 * -----------------------------------
		 * @test	requires a loaded module
		 */		
		public function getModuleLoadId(ml:ModuleLoader):String {
			return _urlToId[ml.url];
		}

		
		/**
		 * Progress handler.
		 * @param event
		 *
		 */
		protected function onModuleProgress(event:ModuleEvent):void {
			//TODO make useful
//			trace("onModuleProgress: ",Math.round(event.bytesLoaded * 100 /event.bytesTotal), (event.target as ModuleLoader).url);	
//			var ml:ModuleLoader = event.target as ModuleLoader;
//			dispatchEvent(new BmcModuleEvent(BmcModuleEvent.MODULE_LOAD_PROGRESS, ml, _modulesInfo[ml.url]));
		}


		/**
		 * notify listeners that loaded module is ready.
		 * -----------------------------------
		 * @test 	no requirements
		 */
		protected function onModuleReady(event:ModuleEvent):void {
			var ml:ModuleLoader = event.currentTarget as ModuleLoader;
			dispatchEvent(new BmcModuleEvent(BmcModuleEvent.MODULE_LOADED, ml));
		}


		/**
		 * notify listeners that a module has encountered problems while loading. 
		 * -----------------------------------
		 * @test 	no requirements
		 */		
		protected function onModuleError(event:ModuleEvent):void {
			var ml:ModuleLoader = event.currentTarget as ModuleLoader;
			dispatchEvent(new BmcModuleEvent(BmcModuleEvent.MODULE_LOAD_ERROR, ml, event.errorText));
		}
	}
}
