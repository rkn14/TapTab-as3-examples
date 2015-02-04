package
{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	import taptabcontroller.controller.tools.ControlsToKeyboardMapper;
	import taptabcontroller.controller.ui.Stick360Modes;
	import taptabcontroller.net.controller.TapTabController;
	import taptabcontroller.net.controller.TapTabControllerConfigurationVO;
	import taptabcontroller.net.controller.TapTabControllerEvent;
	import taptabcontroller.net.controller.TapTabControllersManager;
	import taptabcontroller.net.controller.TapTabControllersManagerEvent;
	
	[SWF(width='640', height='320', backgroundColor='#103860', frameRate='30')]
	public class DEMO_KeyboardMapping extends Sprite
	{
 
		    
		
		[Embed (source="../assets/layout1.xml", mimeType="application/octet-stream")]
		public static const LAYOUT_XML:Class;
		
		// APP ICON
		[Embed(source="TapTabIcon.png", mimeType="application/octet-stream")]
		public static const BMP_APP_ICON : Class;

		
		private var _tapTabControllersManager : TapTabControllersManager;
		

		private var _keyboardMc : keyboardMC;
		

		
		
		
		public function DEMO_KeyboardMapping() 
		{
						 
			_initGame();
			_initTapTabController();

		}
		
		private function _initGame():void
		{
			stage.align = StageAlign.TOP_LEFT;
			
			// keyboard
			_keyboardMc = new keyboardMC();
			_keyboardMc.left.visible = false;
			_keyboardMc.right.visible = false;
			_keyboardMc.bottom.visible = false;
			_keyboardMc.top.visible = false;
			_keyboardMc.space.visible = false;
			_keyboardMc.enter.visible = false;
			addChild(_keyboardMc);
			
	
			
			
				
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _handler_Keyboard);
			stage.addEventListener(KeyboardEvent.KEY_UP, _handler_Keyboard);
			
		}
		
		protected function _handler_Keyboard(event:KeyboardEvent):void
		{
			var vis : Boolean = event.type == KeyboardEvent.KEY_DOWN;
			
			switch (event.keyCode)
			{
				case Keyboard.SPACE:
					_keyboardMc.space.visible = vis;
					break;
				case Keyboard.ENTER:
					_keyboardMc.enter.visible = vis;
					break;
				case Keyboard.UP:
					_keyboardMc.top.visible = vis;
					break;
				case Keyboard.DOWN:
					_keyboardMc.bottom.visible = vis;
					break;
				case Keyboard.LEFT:
					_keyboardMc.left.visible = vis;
					break;
				case Keyboard.RIGHT:
					_keyboardMc.right.visible = vis;
					break;
			}
		
		}
		

		
		private function _initTapTabController() : void
		{
			var configurationObj : TapTabControllerConfigurationVO = new TapTabControllerConfigurationVO();
			configurationObj.firstLayoutID = "DEMO_KeyboardMapping"; 				
			configurationObj.layouts.push( String( new LAYOUT_XML()) );
			 			
			_tapTabControllersManager = new TapTabControllersManager("DEMO_KeyboardMapping", configurationObj, new BMP_APP_ICON() as ByteArray);
			_tapTabControllersManager.addEventListener(TapTabControllersManagerEvent.CONNECTED, _handler_TapTabControllersManager);
			_tapTabControllersManager.addEventListener(TapTabControllersManagerEvent.DISCONNECTED, _handler_TapTabControllersManager);
			_tapTabControllersManager.addEventListener(TapTabControllersManagerEvent.NEW_TAPTABCONTROLLER, _handler_TapTabControllersManager); 
			_tapTabControllersManager.addEventListener(TapTabControllersManagerEvent.TAPTABCONTROLLER_API_VERSION_NOT_COMPATIBLE, _handler_TapTabControllersManager); 
			_tapTabControllersManager.start();
		}
		 
		
		
		
		private function _handler_TapTabControllersManager(event :  TapTabControllersManagerEvent) : void
		{
			switch (event.type)
			{
				case TapTabControllersManagerEvent.CONNECTED:
					
					break;
				case TapTabControllersManagerEvent.DISCONNECTED:
					
					break; 
				case TapTabControllersManagerEvent.NEW_TAPTABCONTROLLER:						
					_newTapTabController(event.taptabController);
					break;
				case TapTabControllersManagerEvent.TAPTABCONTROLLER_API_VERSION_NOT_COMPATIBLE:						
					trace("A TapTabController has been rejected. Its api version is not compatible");
					break;
			}
		}
		
		private function _newTapTabController(__taptabController:TapTabController):void
		{
			__taptabController.controlsToKeyboardMapper.init(stage);
			__taptabController.controlsToKeyboardMapper.mapStick360("stickMain", Stick360Modes.MODE_4_DIRECTIONS, [Keyboard.RIGHT, Keyboard.UP, Keyboard.LEFT, Keyboard.DOWN]);
			__taptabController.controlsToKeyboardMapper.mapButton("buttonA", Keyboard.SPACE);
			__taptabController.controlsToKeyboardMapper.mapButton("buttonB", Keyboard.ENTER);
			
			//__taptabController.addEventListener(TapTabControllerEvent.BOUND, _handler_TapTabController);
			__taptabController.addEventListener(TapTabControllerEvent.DISCONNECTED, _handler_TapTabController);		
			__taptabController.addEventListener(TapTabControllerEvent.QUIT, _handler_TapTabController);					
		}
		private function _handler_TapTabController(event:TapTabControllerEvent):void
		{
			var taptabController : TapTabController = event.currentTarget as TapTabController;
			switch (event.type)
			{
				case TapTabControllerEvent.BOUND:
					
					break;
				case TapTabControllerEvent.DISCONNECTED:					
	 
					break;
				case TapTabControllerEvent.QUIT:
					
					break;
			}
		}
		
		
		 
	}
}

