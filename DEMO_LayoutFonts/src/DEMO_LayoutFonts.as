package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import taptabcontroller.net.controller.TapTabControllerConfigurationVO;
	import taptabcontroller.net.controller.TapTabControllersManager;
	import taptabcontroller.net.controller.TapTabControllersManagerEvent;
	
	public class DEMO_LayoutFonts extends Sprite
	{
		
		
		private const layoutXML : XML =
			<layout name="LayoutFonts" id="LayoutFonts" version="1.0" author="Grégory Lardon" dpi="220">
				<!-- layer landscape -->	
				<portrait>
				
					<bgColor>#000000</bgColor>	
					<bgAlpha>0.3</bgAlpha>		
					
					<optionMenu>
						<align right="10" top="10" />
					</optionMenu>	
				
					<!-- controls -->
					<controls>
						<label id="label_Title" wordwrap="false">
							<text>TapTab fonts available</text>
							<style size="30" color="#FFFFFF" align="left" font="Arial" bold="true" italic="false"/>
							<align left="0" top="20" />
						</label> 			
			
			
						<label id="label_01" wordwrap="false">
							<text>Arial Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Arial" bold="false" italic="false"/>
							<align left="20" top="80" />
						</label> 			
						<label id="label_02" wordwrap="false">
							<text>Arial Bold Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Arial" bold="true" italic="false"/>
							<align left="20" top="120" />
						</label> 			
						<label id="label_03" wordwrap="false">
							<text>Arial Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Arial" bold="false" italic="true"/>
							<align left="20" top="160" />
						</label> 			
						<label id="label_04" wordwrap="false">
							<text>Arial Bold Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Arial" bold="true" italic="true"/>
							<align left="20" top="200" />
						</label> 	
						
						
						
						<label id="label_11" wordwrap="false">
							<text>Arial Black Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="ArialBlack" bold="false" italic="false"/>
							<align left="20" top="240" />
						</label> 			
						
						
						<label id="label_21" wordwrap="false">
							<text>ComicSansMS Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="ComicSansMS" bold="false" italic="false"/>
							<align left="20" top="280" />
						</label> 			
						<label id="label_22" wordwrap="false">
							<text>ComicSansMS Bold Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="ComicSansMS" bold="true" italic="false"/>
							<align left="20" top="320" />
						</label> 		
						
						
						<label id="label_31" wordwrap="false">
							<text>CourierNew Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="CourierNew" bold="false" italic="false"/>
							<align left="20" top="360" />
						</label> 			
						<label id="label_22" wordwrap="false">
							<text>CourierNew Bold Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="CourierNew" bold="true" italic="false"/>
							<align left="20" top="400" />
						</label> 		
						<label id="label_23" wordwrap="false">
							<text>CourierNew Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="CourierNew" bold="false" italic="true"/>
							<align left="20" top="440" />
						</label> 		
						<label id="label_24" wordwrap="false">
							<text>CourierNew Bold Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="CourierNew" bold="true" italic="true"/>
							<align left="20" top="480" />
						</label> 		
						
										
						<label id="label_31" wordwrap="false">
							<text>TimesNewRoman Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="TimesNewRoman" bold="false" italic="false"/>
							<align left="20" top="520" />
						</label> 			
						<label id="label_22" wordwrap="false">
							<text>TimesNewRoman Bold Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="TimesNewRoman" bold="true" italic="false"/>
							<align left="20" top="560" />
						</label> 		
						<label id="label_23" wordwrap="false">
							<text>TimesNewRoman Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="TimesNewRoman" bold="false" italic="true"/>
							<align left="20" top="600" />
						</label> 		
						<label id="label_24" wordwrap="false">
							<text>TimesNewRoman Bold Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="TimesNewRoman" bold="true" italic="true"/>
							<align left="20" top="640" />
						</label> 
			
			
						<label id="label_31" wordwrap="false">
							<text>Verdana Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Verdana" bold="false" italic="false"/>
							<align left="20" top="680" />
						</label> 			
						<label id="label_22" wordwrap="false">
							<text>Verdana Bold Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Verdana" bold="true" italic="false"/>
							<align left="20" top="720" />
						</label> 		
						<label id="label_23" wordwrap="false">
							<text>Verdana Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Verdana" bold="false" italic="true"/>
							<align left="20" top="760" />
						</label> 		
						<label id="label_24" wordwrap="false">
							<text>Verdana Bold Italic Lorem ipsum</text>
							<style size="25" color="#FFFFFF" align="left" font="Verdana" bold="true" italic="true"/>
							<align left="20" top="800" />
						</label> 		
					</controls>							
				</portrait>				
			</layout>;
		
		// APP ICON
		[Embed(source="TapTabIcon.png", mimeType="application/octet-stream")]
		public static const BMP_APP_ICON : Class;
		
		
		private var _taptabManager:TapTabControllersManager;
		
		
		public function DEMO_LayoutFonts()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handler_AddedToStage);
		}
		
		
		
		private function _build():void
		{
			
			var conf : TapTabControllerConfigurationVO = new TapTabControllerConfigurationVO();
			conf.firstLayoutID = "LayoutFonts";
			conf.layouts.push(String(layoutXML));
			
			_taptabManager = new TapTabControllersManager("DEMO_LayoutFonts", conf, new BMP_APP_ICON() as ByteArray);
			_taptabManager.start();
		}
		

		
		
		
		
		
		
		
		
		
		
		
		protected function _handler_AddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _handler_AddedToStage);
			_build();
		}
		
		
		
		
		
	
			
	}
}