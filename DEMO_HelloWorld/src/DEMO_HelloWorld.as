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
	import taptabcontroller.controller.vo.VOFactory;
	import taptabcontroller.net.controller.TapTabControllerConfigurationVO;
	import taptabcontroller.net.controller.TapTabControllerEvent;
	import taptabcontroller.net.controller.TapTabControllersManager;
	import taptabcontroller.net.controller.TapTabControllersManagerEvent;
	
	[SWF(backgroundColor="#333333", width="400", height="300") ]
	public class DEMO_HelloWorld extends Sprite
	{

		
		
		
		
		private const layoutXML : XML =
			<layout name="LayoutHelloWorld" id="LayoutHelloWorld" version="1.0" author="Grégory Lardon" dpi="220">
				<!-- layer landscape -->	
				<portrait>
				
					<bgColor>#000000</bgColor>	
					<bgAlpha>0.7</bgAlpha>		
					
					<optionMenu>
						<align right="10" top="10" />
					</optionMenu>	
				
					<!-- controls -->
					<controls>
						<squareButton id="helloworld">
							<bgWidth>400</bgWidth>
							<bgHeight>150</bgHeight>
							<bgColor>0XFF0000</bgColor>
							<bgAlpha>.6</bgAlpha>
							<buttonWidth>250</buttonWidth>
							<buttonHeight>100</buttonHeight>
							<buttonColor>0XFF0000</buttonColor>							
							<buttonAlpha>1</buttonAlpha>
							<align vcenter="0" hcenter="0" />
							<label id="butLabel">
								<text>Hello World!</text>
								<style size="35" color="#FFFFFF" align="center" font="Arial" bold="true" />
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
		private var _helloworldTF:TextField;
		
		
		
		public function DEMO_HelloWorld()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handler_AddedToStage);
		}
		
		
		
		private function _build():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// text field
			_helloworldTF = new TextField();
			_helloworldTF.autoSize = TextFieldAutoSize.LEFT;			
			
			var tf : TextFormat = new TextFormat();
			tf.bold = true;
			tf.size = 30;
			tf.color = 0xFFFFFF;			
			_helloworldTF.defaultTextFormat = tf;
			
			_helloworldTF.text = "Hello World !!!";
			
			_helloworldTF.visible = false;
			addChild(_helloworldTF);
			
			// taptab controllers
			var conf : TapTabControllerConfigurationVO = new TapTabControllerConfigurationVO();
			conf.firstLayoutID = "LayoutHelloWorld";
			conf.layouts.push(String(layoutXML));			
			_taptabManager = new TapTabControllersManager("DEMO_HelloWorld", conf, new BMP_APP_ICON() as ByteArray);
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
						case "helloworld":
							_helloworldTF.visible = ButtonVO(uivalue).pressed;
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