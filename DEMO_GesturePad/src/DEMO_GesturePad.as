package
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	
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
	import taptabcontroller.controller.vo.GesturePadDoubleTapVO;
	import taptabcontroller.controller.vo.GesturePadRotateVO;
	import taptabcontroller.controller.vo.GesturePadScaleVO;
	import taptabcontroller.controller.vo.GesturePadTapVO;
	import taptabcontroller.controller.vo.GesturePadTouchVO;
	import taptabcontroller.controller.vo.VOFactory;
	import taptabcontroller.net.controller.TapTabControllerConfigurationVO;
	import taptabcontroller.net.controller.TapTabControllerEvent;
	import taptabcontroller.net.controller.TapTabControllersManager;
	import taptabcontroller.net.controller.TapTabControllersManagerEvent;
	
	
	[SWF(backgroundColor="#333333", width="400", height="300") ]
	public class DEMO_GesturePad extends Sprite
	{
		
		
		
		private const layoutXML : XML =
			<layout name="LayoutGesturePad" id="LayoutGesturePad" version="1.0" author="Grégory Lardon" dpi="220">
				<!-- layer landscape -->	
				<portrait>
				
					<bgColor>#000000</bgColor>	
					<bgAlpha>0.7</bgAlpha>		
					
					<optionMenu>
						<align right="10" top="10" />
					</optionMenu>	
				
					<!-- controls -->
					<controls>
						<gesturePad id="gesturePad">
							<width>90%</width>
							<height>90%</height>
							<bgColor>0XFF0000</bgColor>
							<bgAlpha>.6</bgAlpha>
							<align vcenter="0" hcenter="0" />
							<label id="gestureLabel">
								<text>Touch here!</text>
								<style size="35" color="#FFFFFF" align="center" font="Arial" bold="true" />
								<align hcenter="0" vcenter="0" />
							</label> 
						</gesturePad>
					</controls>
				</portrait>				
			</layout>;
		
		// APP ICON
		[Embed(source="TapTabIcon.png", mimeType="application/octet-stream")]
		public static const BMP_APP_ICON : Class;		
		
		private var _taptabManager:TapTabControllersManager;
		private var _plane:Sprite;
		private var _touchesSprite:Sprite;
		private var _tapTf:TextField;
		private var _doubleTapTf:TextField;
		private var _touches : Object;		

		public function DEMO_GesturePad()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handler_AddedToStage);
		}
		
		
		
		private function _build():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// touches
			_touches = {};
			
			// plane
			_plane = new Sprite();
			_plane.graphics.beginFill(0xFF0000);
			_plane.graphics.drawRect(-50, -50, 100, 100);
			_plane.graphics.endFill();
			_plane.x = stage.stageWidth / 2;
			_plane.y = stage.stageHeight / 2;
			addChild(_plane);			
			
			// touches sprite
			_touchesSprite = new Sprite();
			addChild(_touchesSprite);
			
			// text field
			var tf : TextFormat = new TextFormat();
			tf.bold = true;
			tf.size = 30;
			tf.color = 0xFFFFFF;			
			
			_tapTf = new TextField();
			_tapTf.autoSize = TextFieldAutoSize.LEFT;			
			_tapTf.defaultTextFormat = tf;			
			_tapTf.text = "TAP!";			
			_tapTf.alpha = 0;
			addChild(_tapTf);
			
			_doubleTapTf = new TextField();
			_doubleTapTf.y = 40;
			_doubleTapTf.autoSize = TextFieldAutoSize.LEFT;			
			_doubleTapTf.defaultTextFormat = tf;			
			_doubleTapTf.text = "DOUBLE TAP!";			
			_doubleTapTf.alpha = 0;
			addChild(_doubleTapTf);
			
			
			
			// taptab controllers
			var conf : TapTabControllerConfigurationVO = new TapTabControllerConfigurationVO();
			conf.firstLayoutID = "LayoutGesturePad";
			conf.layouts.push(String(layoutXML));			
			_taptabManager = new TapTabControllersManager("DEMO_GesturePad", conf, new BMP_APP_ICON() as ByteArray);
			_taptabManager.addEventListener(TapTabControllersManagerEvent.NEW_TAPTABCONTROLLER, _handler_TapTabControllersManager);
			_taptabManager.start();
			
			addEventListener(Event.ENTER_FRAME, _handler_EnterFrame);
			
		}
		
		protected function _handler_EnterFrame(event:Event):void
		{			
			_touchesSprite.graphics.clear();
			for (var i : String in _touches)
			{
				var touchVO : GesturePadTouchVO = _touches[i];
				_touchesSprite.graphics.beginFill(0x00FF00, .6);
				_touchesSprite.graphics.drawCircle(stage.stageWidth / 2 + touchVO.locationX * (stage.stageWidth/2), stage.stageHeight / 2 + touchVO.locationY * (stage.stageHeight / 2), 30);
				_touchesSprite.graphics.endFill();
			}
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
						case "gesturePad":
							var vo : AbstractVO = VOFactory.parseUiValue(event.value);
							switch (vo.type)
							{
								case GesturePadTouchVO.TYPE:
									_updateTouches(GesturePadTouchVO(vo));
									break;
								case GesturePadTapVO.TYPE:
									_tap(GesturePadTapVO(vo));
									break;
								case GesturePadDoubleTapVO.TYPE:
									_doubleTap(GesturePadDoubleTapVO(vo));
									break;
								case GesturePadRotateVO.TYPE:
									_rotate(GesturePadRotateVO(vo));
									break;
								case GesturePadScaleVO.TYPE:
									_scale(GesturePadScaleVO(vo));
									break;
							}
							break;								
					}
					break;
			}
		}		
		
		private function _scale(__vo:GesturePadScaleVO):void
		{
			_plane.scaleX += (__vo.scale);
			_plane.scaleY += (__vo.scale);
		}
		
		private function _rotate(__vo:GesturePadRotateVO):void
		{
			_plane.rotation += (__vo.rotation * 180 / Math.PI);
		}
		
		private function _doubleTap(__vo:GesturePadDoubleTapVO):void
		{
			_doubleTapTf.alpha = 1;
			TweenMax.to(_doubleTapTf, 1, {alpha:0, ease:Cubic.easeIn});
		}
		
		private function _tap(__vo:GesturePadTapVO):void
		{
			_tapTf.alpha = 1;
			TweenMax.to(_tapTf, 1, {alpha:0, ease:Cubic.easeIn});
		}
		
		private function _updateTouches(__vo:GesturePadTouchVO):void
		{
			switch (__vo.phase)
			{
				case GesturePadTouchVO.PHASE_BEGAN:
					_touches[__vo.touchId] = __vo;
					break;
				case GesturePadTouchVO.PHASE_MOVED:
					_touches[__vo.touchId] = __vo;
					break;
				case GesturePadTouchVO.PHASE_ENDED:
					delete _touches[__vo.touchId];
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
