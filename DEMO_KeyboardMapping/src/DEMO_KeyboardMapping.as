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
	
	[SWF(width='465', height='465', backgroundColor='#103860', frameRate='30')]
	public class DEMO_KeyboardMapping extends Sprite
	{
 
		  
		
		[Embed (source="../assets/layout1.xml", mimeType="application/octet-stream")]
		public static const LAYOUT_XML:Class;
		
		// APP ICON
		[Embed(source="TapTabIcon.png", mimeType="application/octet-stream")]
		public static const BMP_APP_ICON : Class;
		
		// CAR
		[Embed(source="car.png")]
		public static const CAR_BMP : Class;
		
		private var _tapTabControllersManager : TapTabControllersManager;
		private var _car:Sprite;
		private var _keys:Object;
		
		private var _speed : Number = 0;		
		private const SPEED_OFFSET : Number = .3;
		private const MAX_SPEED : Number = 5;
		
		private var _direction : Number = 0;
		private const ANGULAR_SPEED : Number = .08;
		
		
		public function DEMO_KeyboardMapping() 
		{
						 
			_initGame();
			_initTapTabController();

		}
		
		private function _initGame():void
		{
			var bmp : Bitmap = new CAR_BMP();
			//bmp.scaleX = bmp.scaleY = .4;
			bmp.x = - (bmp.width * bmp.scaleX) / 2;
			bmp.y = - (bmp.height * bmp.scaleY) / 2;
			
			
			_car = new Sprite();
			/*_car.graphics.beginFill(0x00FF00);
			_car.graphics.drawCircle(0, 0, 50);
			_car.graphics.endFill();*/
			_car.x = stage.stageWidth / 2;
			_car.y = stage.stageHeight / 2;
			_car.addChild(bmp);
			addChild(_car);
			
			// keyboard
			_keys = {};
			_keys[Keyboard.LEFT] = false;
			_keys[Keyboard.RIGHT] = false;
			_keys[Keyboard.SPACE] = false;
				
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _handler_Keyboard);
			stage.addEventListener(KeyboardEvent.KEY_UP, _handler_Keyboard);
			
			addEventListener(Event.ENTER_FRAME, _handler_EnterFrame);
		}
		
		protected function _handler_Keyboard(event:KeyboardEvent):void
		{
			switch (event.type)
			{
				case KeyboardEvent.KEY_DOWN:
					_keys[event.keyCode] = true;
					break;
				case KeyboardEvent.KEY_UP:
					_keys[event.keyCode] = false;
					break;
			}
		}
		
		protected function _handler_EnterFrame(event:Event):void
		{
			
			// SPEED
			if(_keys[Keyboard.SPACE])
				_speed += SPEED_OFFSET;
			else
				_speed -= SPEED_OFFSET;
			_speed = Math.max(0, _speed);
			_speed = Math.min(MAX_SPEED, _speed);
			
			// DIRECTION
			if(_speed > 0)
			{
				if(_keys[Keyboard.LEFT])
					_direction -= ANGULAR_SPEED;
				if(_keys[Keyboard.RIGHT])
					_direction += ANGULAR_SPEED;
			}
			
			
			
			_car.rotation = _direction / Math.PI * 180; 
			
			var nextX : Number = Math.cos(_direction) * _speed;
			var nextY : Number = Math.sin(_direction) * _speed;
			
			_car.x += nextX;
			_car.y += nextY;
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
			trace("_handler_TapTabControllersManager", event.type);
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
			__taptabController.addEventListener(TapTabControllerEvent.BOUND, _handler_TapTabController);
			__taptabController.addEventListener(TapTabControllerEvent.DISCONNECTED, _handler_TapTabController);		
			__taptabController.addEventListener(TapTabControllerEvent.QUIT, _handler_TapTabController);					
		}
		private function _handler_TapTabController(event:TapTabControllerEvent):void
		{
			var taptabController : TapTabController = event.currentTarget as TapTabController;
			switch (event.type)
			{
				case TapTabControllerEvent.BOUND:
					taptabController.controlsToKeyboardMapper.init(stage);
					taptabController.controlsToKeyboardMapper.mapStick360("stickMain", Stick360Modes.MODE_4_DIRECTIONS, [Keyboard.RIGHT, Keyboard.UP, Keyboard.LEFT, Keyboard.DOWN]);
					taptabController.controlsToKeyboardMapper.mapButton("buttonA", Keyboard.SPACE);
					break;
				case TapTabControllerEvent.DISCONNECTED:					
	 
					break;
				case TapTabControllerEvent.QUIT:
					
					break;
			}
		}
		
		
		 
	}
}

