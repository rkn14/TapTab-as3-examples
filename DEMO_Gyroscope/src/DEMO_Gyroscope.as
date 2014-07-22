
package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import taptabcontroller.controller.vo.AbstractVO;
	import taptabcontroller.controller.vo.ButtonVO;
	import taptabcontroller.controller.vo.GyroscopeVO;
	import taptabcontroller.controller.vo.VOFactory;
	import taptabcontroller.net.controller.TapTabControllerConfigurationVO;
	import taptabcontroller.net.controller.TapTabControllerEvent;
	import taptabcontroller.net.controller.TapTabControllersManager;
	import taptabcontroller.net.controller.TapTabControllersManagerEvent;
	
	[SWF(backgroundColor="#333333", width="400", height="300") ]
	public class DEMO_Gyroscope extends Sprite
	{
		
		
		private const layoutXML : XML =
			<layout name="LayoutDEMO_Gyroscope" id="LayoutDEMO_Gyroscope" version="1.0" author="Grégory Lardon" dpi="220">
				<!-- layer landscape -->	
				<portrait>
				
					<bgColor>#000000</bgColor>	
					<bgAlpha>0.7</bgAlpha>		
					
					<optionMenu>
						<align right="10" top="10" />
					</optionMenu>	
				
					<!-- controls -->
					<controls>
						<label id="titleLabel">
							<text>Just turn your device
and see what happens</text>
							<style size="25" color="#FFFFFF" align="center" font="Arial" bold="false" />
							<align hcenter="0" vcenter="0" />
						</label>
						
						<gyroscope id="gyroscope" updateInterval="100"/>
						
						<squareButton id="resetButton">
							<bgWidth>200</bgWidth>
							<bgHeight>80</bgHeight>
							<bgColor>0XFF0000</bgColor>
							<bgAlpha>.6</bgAlpha>
							<buttonWidth>150</buttonWidth>
							<buttonHeight>50</buttonHeight>
							<buttonColor>0XFF0000</buttonColor>							
							<buttonAlpha>1</buttonAlpha>
							<align hcenter="0" top="40" />
							<label id="butLabel">
								<text>reset</text>
								<style size="30" color="#FFFFFF" align="center" font="Arial" bold="false" />
								<align hcenter="0" vcenter="0" />
							</label> 
						</squareButton>			
			
					</controls>
				</portrait>				
			</layout>;
		
		// APP ICON
		[Embed(source="TapTabIcon.png", mimeType="application/octet-stream")]
		public static const BMP_APP_ICON : Class;
		
		
		private var _taptabManager:TapTabControllersManager;
		private var _plane:Sprite;
		
		
		
		public function DEMO_Gyroscope()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handler_AddedToStage);
		}
		
		
		
		private function _build():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// plane
			_plane = new Sprite();
			_plane.graphics.beginFill(0xFF0000);
			_plane.graphics.drawRect(-50,-50,100,100);
			_plane.graphics.endFill();
			_plane.x = stage.stageWidth / 2;
			_plane.y = stage.stageHeight / 2;
			addChild(_plane);
			
			// taptab controllers
			var conf : TapTabControllerConfigurationVO = new TapTabControllerConfigurationVO();
			conf.firstLayoutID = "LayoutDEMO_Gyroscope";
			conf.layouts.push(String(layoutXML));			
			_taptabManager = new TapTabControllersManager("DEMO_Gyroscope", conf, new BMP_APP_ICON() as ByteArray);
			_taptabManager.addEventListener(TapTabControllersManagerEvent.NEW_TAPTABCONTROLLER, _handler_TapTabControllersManager);
			_taptabManager.start();
		}
		
		
		
		
		
		protected function _handler_TapTabControllersManager(event:TapTabControllersManagerEvent):void
		{
			switch (event.type)
			{
				case TapTabControllersManagerEvent.NEW_TAPTABCONTROLLER:
					event.taptabController.addEventListener(TapTabControllerEvent.CONTROL_CHANGE, _handler_TapTabController);
					break;
			}
		}		
		
		protected function _handler_TapTabController(event:TapTabControllerEvent):void
		{
			switch (event.type)
			{
				case TapTabControllerEvent.CONTROL_CHANGE:
					var uivalue : AbstractVO = VOFactory.parseUiValue(event.value);
					switch(uivalue.controlId)
					{
						case "gyroscope":
							var gyroValue : GyroscopeVO = GyroscopeVO(uivalue);
							_plane.rotationX += gyroValue.x * 180 / Math.PI / 10; 
							_plane.rotationY += gyroValue.y * 180 / Math.PI / 10; 
							_plane.rotationZ += gyroValue.z * 180 / Math.PI / 10; 
							break;			
						case "resetButton":
							_plane.rotationX = _plane.rotationY = _plane.rotationZ = 0;
							break;
					}
					break;
			}
		}		
		
		
		
		
		
		protected function _handler_AddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _handler_AddedToStage);
			_build();
		}
		
		
		
		
		
		
		
		
	}		
	
}